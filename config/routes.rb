# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :tasks, only: :index
  # resources: tasks, param: :identifier_name
  # @task = Task.find_by(identifier_name: params[:identifier_name])
  resources :tasks, except: %i[new edit destroy], param: :slug

  root "home#index"
  get "*path", to: "home#index", via: :all
end
