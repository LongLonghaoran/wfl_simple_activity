module PublicActivity
  class Activity
    serialize :parameters, Hash
    serialize :model_changes, Hash
  end
end