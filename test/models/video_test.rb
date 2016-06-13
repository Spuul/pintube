require 'test_helper'

class VideoTest < ActiveSupport::TestCase

  should have_and_belong_to_many(:boards)

  should validate_presence_of(:url)
  should validate_uniqueness_of(:url)


  def test_yt_data
    vid = videos :nooo_daaamn
    # attributes interface
    assert_equal 'The Best Dance In the World;He Killed  I never seen before nooo daaamn', vid.title
    assert_equal 'He Killed  I never seen before nooo daaamn', vid.description
    assert_nil vid.tags
    assert_equal 'https://i.ytimg.com/vi/OIvX8g220Ls/mqdefault.jpg', vid.thumbnail_url

    # if no data available, we fail gracefully
    assert_nothing_raised do
      vid = Video.new

      assert_nil vid.yt_id
      assert_nil vid.title
      assert_nil vid.thumbnail_url
    end
  end

  def test_yt_id
    vid = Video.new url: 'youtu.be/sGE4HMvDe-Q'
    assert_equal 'sGE4HMvDe-Q', vid.yt_id
    # as path (with protocol)
    vid.url = 'https://youtu.be/OIvX8g220Ls?list=FLqqGvuVycgY7ZC3ORaF40rA'
    assert_equal 'OIvX8g220Ls', vid.yt_id
    # as url param (without protocol)
    vid.url = 'www.youtube.com/watch?v=Lp7E973zozc&feature=relmfu'
    assert_equal 'Lp7E973zozc', vid.yt_id
    # malformed url
    vid.url = 'fds fes es fe'
    assert_nil vid.yt_id

    # from yt_data
    vid = videos :nooo_daaamn
    vid.url = nil
    assert_equal 'OIvX8g220Ls', vid.yt_id
  end

  def test_other_methods
    vid = videos :nooo_daaamn

    assert_equal 'http://www.youtube-nocookie.com/embed/OIvX8g220Ls?rel=0', vid.embed_url
  end
end
