class Sample
  include ActiveModel::Model
  attr_accessor :id

  def initialize(id)
    self.id = id
  end
end
