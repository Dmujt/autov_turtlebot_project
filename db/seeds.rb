u = User.find_by_email(ENV["ADMIN_EMAIL"])

if u.nil?
  #create the user
  User.create(
          :email=>ENV["ADMIN_EMAIL"],
          :password=>ENV["ADMIN_PASSWORD"]
  )
end
