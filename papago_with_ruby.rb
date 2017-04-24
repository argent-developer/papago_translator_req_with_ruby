# If you need a documentation, please visit
# https://github.com/argent-developer/papago_translator_req_with_ruby

require 'uri'
require 'json'
require 'net/http'
require 'net/https'

req_uri = URI.parse("https://openapi.naver.com/v1/language/translate")
https = Net::HTTP.new(req_uri.host, req_uri.port)
https.use_ssl = true
req = Net::HTTP::Post.new(req_uri.path, initheader = {
	'Content-Type' =>'application/json',
	'X-Naver-Client-Id' => ENV["NAVER_API_ID"], # environmental variable for safety
	'X-Naver-Client-Secret' => ENV["NAVER_API_PW"] # environmental variable for safety
})

req.body = {
	"source" => "ko", # source language; options => ko:korean, en:english, ja:japanese, zh-CN:chinese(simplified), zh-TW:chinese(traditional)
	"target" => "en", # target language; options => ko:korean, en:english, ja:japanese, zh-CN:chinese(simplified), zh-TW:chinese(traditional)
	"text" => ARGV[0] # read text from ARGV[0]
}.to_json

res = https.request(req)
puts "Response #{res.code} #{res.message}: #{res.body}"

# if you want to print only 'translated text', un-conmment below one.
# puts (JSON.parse(res.body))["message"]["result"]["translatedText"]
