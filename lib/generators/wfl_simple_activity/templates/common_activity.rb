module CommonActivity
  extend ActiveSupport::Concern
  included do |base|
    include PublicActivity::Model
    tracked(
      owner: proc { |controller, model| controller&.current_user }, 
      model_changes: proc {|controller, model|  model.changes},
      recipient: proc { |controller, model| model }, 
      params: {
        request_params: proc {|controller, model| controller&.params&.to_h}
      }
    )

    has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

    after_rollback proc {
      self.create_activity key: "#{self.class.name.underscore}.failed", owner: User.find(Thread.current[:user_id]), recipient: self
    }
  end
end