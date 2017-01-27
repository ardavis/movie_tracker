puts 'Creating the user'
user = User.create(
               email: 'test@test.com',
               password: 'password',
               password_confirmation: 'password'
)

puts 'Adding Movies'
imdb_id_list = %w(0076759 0080684 0086190 2488496 0120915 0121766 0266543 0317219 0133093 0234215 0242653)
imdb_id_list.map{|e| "tt#{e}"}.each do |imdb_id|
  user.movies << Movie.add(imdb_id)
end