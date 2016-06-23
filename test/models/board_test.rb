require 'test_helper'

class BoardTest < ActiveSupport::TestCase

  have_and_belong_to_many(:videos)

  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  def test_scopes
    compare_block = ->(a,b) { a.name <= b.name }
    # this makes sure it's not ordered by chance
    refute Board.all.each_cons(2).all?(&compare_block)
    assert Board.default_order.each_cons(2).all?(&compare_block)
  end

  def test_callbacks
    b = Board.new name: ' fe  esse '
    b.save!
    assert_equal 'Fe Esse', b.name
  end

end
