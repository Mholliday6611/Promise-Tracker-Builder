class Input < ActiveRecord::Base
  belongs_to :survey
  serialize :options, JSON

  validates :input_type, presence: true, allow_blank: false
  validates :survey_id, presence: true
  validates :label, presence: true

  default_scope { order(:order) }

  before_save :make_options_uniq

  def make_options_uniq
    if self.input_type == 'select' || self.input_type == 'select1'
      self.options = self.options.reject(&:empty?).uniq
    else
      self.options = []
    end
  end
end
