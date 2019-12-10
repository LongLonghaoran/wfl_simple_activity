module CommonActivity
  extend ActiveSupport::Concern
  included do |base|
    include ::PublicActivity::Model
    tracked(
      owner: proc { |controller, model| controller&.current_user }, 
      model_changes: proc {|controller, model|  model.changes},
      recipient: proc { |controller, model| model }, 
      params: {
        request_params: proc {|controller, model| controller&.params&.to_h}
      }
    )
  end
end