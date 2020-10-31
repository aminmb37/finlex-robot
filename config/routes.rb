Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace 'api' do
    namespace 'v1' do
      resources :robots do
        put :moveright
        put :moveleft
        put :moveforward
        put :movebackward
        put :turnright
        put :turnleft
        put :turnback
      end
      resources :commands
    end
  end
end
