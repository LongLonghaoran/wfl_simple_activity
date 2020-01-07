PublicActivity::Config.set do
  table_name "wfl_activities"
end
module PublicActivity
  class Activity
    serialize :parameters, Hash
    serialize :model_changes, Hash
    enum status: {success: 100, failed: 0}
  end
end