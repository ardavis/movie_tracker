imdb_id_list = ['0076759','0080684','0086190','2488496','0120915','0121766','0266543','0317219','0133093','0234215','0242653']
prefix = 'tt'
imdb_id_list.each do |id|
  Movie.add(prefix+id).save
end