require 'rest_client'
require 'json'
require 'byebug'

require 'mechanize'

# This function takes user input and puts it in an array to be passed into our get_aud_string_of_lyrics_from_multiple_artists function. To search with multiple artists the input needs to be seperated by a ","
def user_input(user_input_as_string)
  output_array = user_input_as_string.split(",")
  output_array.each do |artist|
    artist.strip!
    artist.tr!(" ", " ")
  end
end

#This function takes an array of strings as an argument
def lyrics_by_artist(artist_array)
  lyrics = ""
  if artist_array.any? && artist_array.length <= 1
    artist_array.each do |artist|

      response = RestClient::Request.execute(
        method: :get,
        url: "https://itunes.apple.com/search?term=#{artist}",
      )
      parsed_response = JSON.parse(response)
      # if parsed_response["status"] == "success"




      p "first"
      parsed_response["results"].each do |result|
        # name of song
        track = result["trackName"].tr(" ", "")
        p "second"
        # scrape the first result of a google search

        p track


        mechanize = Mechanize.new

        page = mechanize.get("https://www.azlyrics.com/lyrics/#{artist.tr(" ", "")}/#{track.downcase}")



        puts page.uri
        # working up to this point

        # puts page.at('YS01Ge')
        byebug



        p "fifth"

      end

    end
    # if lyrics.length != 0
    #   lyrics
    # else
    #   lyrics = "No lyrics found for artists: #{artist_array.join(", ")} "
    # end
    # else
    #   p 'Please enter 1 to 3 artists seperated by a ","'
  end
end
p lyrics_by_artist(user_input("cage the elephant"))

# puts page.search('div.bkWMgd.').each do |result|
#   p result
# end

# page.search('.bkWMgd').each do |result|
#   p "fourth"
#   puts result.text.strip
# end

# .Oh5wg
# lyrics += parsed_track_response["results"]["lyrics"]

# stuff
# form = page.forms.first
#
# form['q'] = "#{artist} #{track} lyrics"
