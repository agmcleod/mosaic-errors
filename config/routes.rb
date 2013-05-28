Mosaic::Errors::Engine.routes.draw do
  match "/404", :to => "errors#not_found"
  match "/422", :to => "errors#unprocessable_entity"
  match "/500", :to => "errors#internal_server_error"
end
