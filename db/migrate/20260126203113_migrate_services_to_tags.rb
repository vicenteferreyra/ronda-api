class MigrateServicesToTags < ActiveRecord::Migration[8.0]
  def up
    return unless table_exists?(:services) && table_exists?(:venue_services)

    service_class = Class.new(ActiveRecord::Base) do
      self.table_name = "services"
    end

    venue_service_class = Class.new(ActiveRecord::Base) do
      self.table_name = "venue_services"
    end

    tag_class = Class.new(ActiveRecord::Base) do
      self.table_name = "tags"
    end

    venue_tag_class = Class.new(ActiveRecord::Base) do
      self.table_name = "venue_tags"
    end

    service_class.find_each do |service|
      tag = tag_class.find_or_initialize_by(name: service.name)
      tag.tag_type = 1 # service enum value
      tag.display_name = service.name.humanize
      tag.save!

      venue_service_class.where(service_id: service.id).find_each do |venue_service|
        venue_tag_class.find_or_create_by!(
          venue_id: venue_service.venue_id,
          tag_id: tag.id
        )
      end
    end
  end

  def down
    # This migration is not reversible
  end
end
