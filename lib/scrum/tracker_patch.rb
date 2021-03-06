require_dependency "tracker"

module Scrum
  module TrackerPatch
    def self.included(base)
      base.class_eval do

        def self.pbi_trackers_ids
          Scrum::Setting.pbi_tracker_ids
        end

        def self.pbi_trackers
          Tracker.all(:conditions => {:id => pbi_trackers_ids})
        end

        def is_pbi?
          Scrum::Setting.pbi_tracker_ids.include?(id)
        end

        def self.task_trackers_ids
          Scrum::Setting.task_tracker_ids
        end

        def self.task_trackers
          Tracker.all(:conditions => {:id => task_trackers_ids})
        end

        def is_task?
          Scrum::Setting.task_tracker_ids.include?(id)
        end

        def post_it_css_class
          Scrum::Setting.tracker_id_color(id)
        end

        def field?(field)
          Scrum::Setting.tracker_field?(self.id, field)
        end

        def custom_field?(custom_field)
          Scrum::Setting.tracker_field?(self.id, custom_field, Scrum::Setting::TrackerFields::CUSTOM_FIELDS) or custom_field.is_required
        end

      end
    end
  end
end
