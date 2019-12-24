module PublicActivity
  class Activity
    self.table_name = "wfl_activities"
    serialize :parameters, Hash
    serialize :model_changes, Hash
  end
end