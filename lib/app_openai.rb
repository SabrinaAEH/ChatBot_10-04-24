# ligne très importante qui appelle les gems.
require 'http'
require 'json'
require 'dotenv'
Dotenv.load

# création de la clé d'api et indication de l'url utilisée.
api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/chat/completions"

# un peu de json pour faire la demande d'autorisation d'utilisation à l'api OpenAI
headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

# un peu de json pour envoyer des informations directement à l'API
data = {
  "messages" => [{"role" => "system", "content" => "Je souhaite connaître les 5 parfums de glace les plus populaires, peux-tu me donner une liste?"}] ,
  "max_tokens" => 50,
  "temperature" => 0.5,
  "model" => "gpt-3.5-turbo"
}

# une partie un peu plus complexe :
# - cela permet d'envoyer les informations en json à ton url
response = HTTP.post(url, headers: headers, body: data.to_json)
response_body = JSON.parse(response.body.to_s)

# - puis de récupérer la réponse puis de séléctionner spécifiquement le texte rendu
response_body.key?('choices') && response_body['choices'][0].key?('message') && response_body['choices'][0]['message'].key?('content')
response_string = response_body['choices'][0]['message']['content'].strip

# résultat:
puts "Voici 5 parfums de glace :"
puts response_string
