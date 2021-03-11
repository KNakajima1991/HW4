require 'rails_helper'

# Testing Database
 RSpec.describe Movie, type: :model do
     it "returns similar movie" do
         movie1 = Movie.create(title: 'Software Engineering', director: 'Walker')
         movie2 = Movie.create(title: 'Cloud Computing', director: 'Tsai')
         movie3 = Movie.create(title: 'Research', director: 'Walker')
         movie4 = Movie.create(title: 'Football')
         #expect(Movie.same_directors(movie1.director)) == [movie1,movie3]
         expect(Movie.same_directors(movie1.director)) == (['Software Engineering','Research'])
         expect(Movie.same_directors(movie1.director)).to_not include(['Cloud Computing','Football'])
     end
     
     it "returns similar movie" do
         movie1 = Movie.create(title: 'Software Engineering', director: 'Walker')
         movie2 = Movie.create(title: 'Cloud Computing', director: 'Tsai')
         movie3 = Movie.create(title: 'Research', director: 'Walker')
         movie4 = Movie.create(title: 'Football')
         expect(Movie.same_directors(movie4.director)) == nil
     end
  end

