Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/api/inscreve', to: 'inscrito#new'
  delete '/api/desinscreve', to: 'inscrito#delete',  as: 'desinscreve'

  post '/api/auth', to: 'master#authenticate_user'

  get '/api/inscrito/:id', to: 'master#get_inscrito'

  get '/api/list', to: 'master#list'

  delete '/api/remove/:id', to: 'master#remove'

  put '/api/mail', to: 'master#mailer'

end
