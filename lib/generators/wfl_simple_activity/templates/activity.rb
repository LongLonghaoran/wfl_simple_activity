require "public_activity/orm/active_record/activity.rb"
PublicActivity::ORM::ActiveRecord::Activity.table_name = "wfl_activities"
module PublicActivity
  class Activity
    serialize :parameters, Hash
    serialize :model_changes, Hash
  end
end