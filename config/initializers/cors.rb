# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://192.168.0.11:3001'

    resource '/posts',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
