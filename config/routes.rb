Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/inscricao', to: 'inscrito#new'
  delete '/desinscreve', to: 'inscrito#delete',  as: 'desinscreve'
end
