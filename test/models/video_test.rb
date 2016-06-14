require 'test_helper'

class VideoTest < ActiveSupport::TestCase

  should have_and_belong_to_many(:boards)

  should validate_presence_of(:url)
  should validate_presence_of(:yt_id)

  def test_scopes
    ordered_videos = Video.default_order
    assert_equal videos(:nooo_daaamn), ordered_videos.first
    assert_equal videos(:macbook), ordered_videos.last
  end

  def test_validations
    # yt_id uniqueness
    vid = Video.new url: 'the url', yt_id: videos(:chocolate).yt_id
    refute vid.valid?
  end

  def test_yt_data
    vid = videos :nooo_daaamn
    # attributes interface
    assert_equal 'The Best Dance In the World;He Killed  I never seen before nooo daaamn', vid.title
    assert_equal 'He Killed  I never seen before nooo daaamn', vid.description
    assert_nil vid.tags
    assert_equal 'https://i.ytimg.com/vi/OIvX8g220Ls/mqdefault.jpg', vid.thumbnail_url

    vid = Video.new
    # if no data available, we fail gracefully
    assert_nothing_raised do

      assert_nil vid.yt_id
      assert_nil vid.title
      assert_nil vid.thumbnail_url
    end
    # faking yt data for this test
    vid.add_yt_data(JSON.parse('{"kind":"youtube#video","etag":"\"etag\"","id":"yt_id","snippet":{"title":"The Best Dance"}}'))
    # we check that the id is properly set when setting the yt data
    assert_equal 'yt_id', vid.yt_id
    assert_equal 'The Best Dance', vid.title
  end

  def test_yt_id
    vid = Video.new url: 'youtu.be/sGE4HMvDe-Q'
    # fallback on url
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
    assert_nil vid.read_attribute(:yt_id)
    assert_equal 'OIvX8g220Ls', vid.yt_id
    # from DB
    vid = videos :chocolate
    assert_nil vid.yt_data
    assert_equal 'EwTZ2xpQwpA', vid.yt_id
  end

  def test_other_methods
    vid = videos :nooo_daaamn

    assert_equal 'http://www.youtube-nocookie.com/embed/OIvX8g220Ls?rel=0', vid.embed_url
  end
end
