# Add seed data here. Seed your database with `rake db:seed`
Artist.destroy_all
Genre.destroy_all
Song.destroy_all

Genre.create(:name =>"Pop")
Genre.create(:name =>"Rap")
Genre.create(:name =>"Country")

Artist.create(:name =>"Taylor Swift")
Artist.create(:name =>"Neffex")
Artist.create(:name =>"Mumford & Sons")

Song.create(:name => "Dust Bowl Dances")
Song.create(:name =>"Shake It Off")
Song.create(:name =>"Best Of Me")


