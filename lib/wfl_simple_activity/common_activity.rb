require 'public_activity'
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
      self.create_activity key: "#{self.class.name.underscore}.failed", recipient: self
      # 由于这里无法获取controller,需要自行采用其他方式来获取current_user,比如: 在oa-saas中有个Thread.current保存了全局的变量
      # self.create_activity key: "#{self.class.name.underscore}.failed", owner: User.find(Thread.current[:user_id]), recipient: self
    }
  end
end