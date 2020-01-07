module WflActivity
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
    enum status: [:success, :failed]

    # 如果不需要删除记录
    # has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
    
    after_rollback proc {
      # 由于after_rollback是ActiveRecord自带的回调,并不支持获取controller,所以需要借助PublicActivity
      controller = PublicActivity.get_controller
      if self.id.blank?
        PublicActivity::Activity.create key: "#{self.class.name.underscore}.failed", owner: controller&.current_user, parameters: controller&.params&.to_h, model_changes: self.changes
      else
        self.create_activity key: "#{self.class.name.underscore}.failed", owner: User.find(Thread.current[:user_id]), recipient: self
      end
    }
  end
end