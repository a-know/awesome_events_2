Rails.application.config.middleware.use OmniAuth::builder do
    if Rails.env.development? || Rails.env.test?
        provider :github, 
          Rails.application.credentials.github[:client_id],
          Rails.application.credentials.github[:client_secret]
    else
        provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
    end
end