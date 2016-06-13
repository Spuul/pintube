require 'test_helper'

class RetrieveYoutubeDataTest < ActiveSupport::TestCase

  #@todo
  # To avoid hitting Youtube during testing,
  # be at the mercy of data changing
  # and test when the api is down, we can use:
  # https://github.com/bblimke/webmock

  CACHE_THRESHOLD_TIME = 0.01

  def test_service
    Rails.cache.clear

    # Normal flow
    vid = videos(:macbook)
    # First time we hit the API
    time = Benchmark.realtime do
      vid.yt_data = RetrieveYoutubeData.new(vid.yt_id).call
    end
    assert_operator time, :>, CACHE_THRESHOLD_TIME


    # A second time, we should hit the cache
    time = Benchmark.realtime do
      RetrieveYoutubeData.new(vid.yt_id).call
    end
    assert_operator time, :<, CACHE_THRESHOLD_TIME


    # did we get the correct data?
    assert_equal "Apple Engineer Talks about the New 2015 Macbook", vid.title

    # make sure the cache expires
    travel 1.hour do
      assert_nil Rails.cache.read(vid.yt_id, namespace: RetrieveYoutubeData::CACHE_NAMESPACE)
    end

    # we get an exception with wrong ID
    assert_raises(Exception) { RetrieveYoutubeData.new('invalid id').call}

  end
end

# Sample response (6.6.16)
# {
# "kind" => "youtube#videoListResponse",
#     "etag" => "\"mie-I9wWQF7ndS7wC10DLBkzLlg/1Hhkdan3ZM2Rx5TU8rKV8ibQZIw\"",
#     "pageInfo" => {
#     "totalResults" => 1,
#     "resultsPerPage" => 1
# },
#     "items" => [
#     [0] {
#     "kind" => "youtube#video",
#     "etag" => "\"mie-I9wWQF7ndS7wC10DLBkzLlg/okaVZsQkDgSsvBMGF35JjIlutsI\"",
#     "id" => "KHZ8ek-6ccc",
#     "snippet" => {
#         "publishedAt" => "2015-03-11T17:29:20.000Z",
#         "channelId" => "UCXzySgo3V9KysSfELFLMAeA",
#         "title" => "Apple Engineer Talks about the New 2015 Macbook",
#         "description" => "an Apple engineer explains how they developed the new 2015 Macbook and the day Tim Cook saw it for the first time.\n\nOriginal Source: Risitas y las paelleras: https://youtu.be/cDphUib5iG4\n\n-----------------\n\nTo get the latest on my work follow me on G+ Instagram or Twitter\n\nGoogle+ - http://gplus.to/wicked4u2c\nInstagram - http://instagram.com/mobileg33k\nFollow me on Twitter - http://twitter.com/Wicked4u2c",
#         "thumbnails" => {
#             "default" => {
#                 "url" => "https://i.ytimg.com/vi/KHZ8ek-6ccc/default.jpg",
#                 "width" => 120,
#                 "height" => 90
#             },
#             "medium" => {
#                 "url" => "https://i.ytimg.com/vi/KHZ8ek-6ccc/mqdefault.jpg",
#                 "width" => 320,
#                 "height" => 180
#             },
#             "high" => {
#                 "url" => "https://i.ytimg.com/vi/KHZ8ek-6ccc/hqdefault.jpg",
#                 "width" => 480,
#                 "height" => 360
#             },
#             "standard" => {
#                 "url" => "https://i.ytimg.com/vi/KHZ8ek-6ccc/sddefault.jpg",
#                 "width" => 640,
#                 "height" => 480
#             },
#             "maxres" => {
#                 "url" => "https://i.ytimg.com/vi/KHZ8ek-6ccc/maxresdefault.jpg",
#                 "width" => 1280,
#                 "height" => 720
#             }
#         },
#         "channelTitle" => "Armando Ferreira",
#         "tags" => [
#             [ 0] "Apple",
#     [ 1] "2015 Macbook",
#     [ 2] "Macbook",
#     [ 3] "Apple Inc. (Publisher)",
#     [ 4] "Tim Cook",
#     [ 5] "Steve Jobs",
#     [ 6] "MacBook Pro (Computer)",
#     [ 7] "Retina",
#     [ 8] "Risitas",
#     [ 9] "Engineer",
#     [10] "Apple Engineer",
#     [11] "Comedy",
#     [12] "Viral",
#     [13] "Funny"
# ],
#     "categoryId" => "28",
#     "liveBroadcastContent" => "none",
#     "localized" => {
#     "title" => "Apple Engineer Talks about the New 2015 Macbook",
#     "description" => "an Apple engineer explains how they developed the new 2015 Macbook and the day Tim Cook saw it for the first time.\n\nOriginal Source: Risitas y las paelleras: https://youtu.be/cDphUib5iG4\n\n-----------------\n\nTo get the latest on my work follow me on G+ Instagram or Twitter\n\nGoogle+ - http://gplus.to/wicked4u2c\nInstagram - http://instagram.com/mobileg33k\nFollow me on Twitter - http://twitter.com/Wicked4u2c"
# }
# }
# }
# ]
# }