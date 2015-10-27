def log_in(user)
  if integration_test?
    visit login_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  else
    session[:user_id] = user.id
  end
end

def integration_test?
  defined?(post_via_redirect)
end