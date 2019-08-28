# require 'dotenv-rails'
require 'rest_client'
require 'json'
require 'byebug'
require 'unirest'
require 'mechanize'
# This function takes user input and puts it in an array to be passed into our get_aud_string_of_lyrics_from_multiple_artists function. To search with multiple artists the input needs to be seperated by a ","
def user_input(user_input_as_string)
  output_array = user_input_as_string.split(",")
  output_array.each do |artist|
    artist.strip!
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

      parsed_response["results"].each do |result|
        # name of song
        track = result["trackName"]

        # scrape the first result of a google search
        mechanize = Mechanize.new

        page = mechanize.get('http://google.com/')

        puts page.title

        lyrics += parsed_track_response["results"]["lyrics"]
      end

    end
    if lyrics.length != 0
      lyrics
    else
      lyrics = "No lyrics found for artists: #{artist_array.join(", ")} "
    end
  else
    p 'Please enter 1 to 3 artists seperated by a ","'
  end
end
p lyrics_by_artist(user_input("cage the elephant"))





# response = RestClient::Request.execute(
#   method: :get,
#   url: "https://api.audd.io/findLyrics/?api_token=#{ENV["AUD_TOKEN"]}&q=#{artist}",
# )
# response = Unirest.get "https://audd.p.rapidapi.com/findLyrics/?q=#{artist}",
# headers:{
#   "X-RapidAPI-Key" => "cc18bab80cmshf7200a4db77b274p177d1cjsncd3ac6352036",
#   "Content-Type" => "application/x-www-form-urlencoded"
# },
# parameters:{
#   "parameter" => "#{artist}"
#   } do |response|
#     response.code # Status code
#     response.headers # Response headers
#     response.body # Parsed body
#     response.raw_body # Unparsed body
#     byebug
#   end
