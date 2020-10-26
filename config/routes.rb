Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/inscreve', to: 'inscrito#new'
  delete '/desinscreve', to: 'inscrito#delete',  as: 'desinscreve'

  post '/petmaster/auth', to: 'master#authenticate_user'

  get '/petmaster/inscrito/:id', to: 'master#get_inscrito'

  get '/petmaster/list', to: 'master#list'
end
