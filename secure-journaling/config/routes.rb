Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/createEntry/', to: 'journal_entries#create'
  delete '/deleteEntry/', to: 'journal_entries#delete'
  post '/updateEntry/', to:  'journal_entries#update'
  get '/getEntries/', to:  'journal_entries#get'

  post '/facialRecognitionSet', to: 'facial_recognition#createLock'
  post '/facialRecognitionAuthenticate', to: 'facial_recognition#authenticate'
  # Defines the root path route ("/")
  # root "articles#index"
end
