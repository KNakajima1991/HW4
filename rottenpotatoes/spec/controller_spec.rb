require 'rails_helper'
require 'monkeypath'

RSpec.describe MoviesController, type: :controller do
    # HW4 Part2
    describe "Search by director" do

        it "searches for similar movies" do
            movie1 = Movie.create!(title: 'Software Engineering', director: 'Walker')
            movie2 = Movie.create!(title: 'Cloud Computing', director: 'Tsai')
            movie3 = Movie.create!(title: 'Research', director: 'Walker')
            #context 'director is present' do
            #    it 'has movies by the same director' do
            #        expect(Movie.similar(movie1.title)) ==  (['Software Engineering', 'Cloud Computing'])
            #    end
            #end

            get :similar, {:id => movie1.to_param}
            expect(assigns(:movies)) == [movie1, movie2, movie3]
            expect(assigns(:movie)) == movie1
        end
        
        #it 'has movies by the same director' do
        #    movie1 = Movie.create!(title: 'Software Engineering', director: 'Walker')
        #    movie2 = Movie.create!(title: 'Cloud Computing', director: 'Tsai')
        #    movie3 = Movie.create!(title: 'Research', director: 'Walker')
        #    expect(Movie.similar(movie1.title)) ==  (['Software Engineering', 'Cloud Computing'])
        #end
        
        it "searches for similar movies without directors" do
            movie4 = Movie.create!(title: 'Machine Learning', director: '')
            get :similar, {:id => movie4.to_param}
            expect(assigns(:movie)) == movie4
            expect(flash[:notice]) == "Sorry, no director info is available"
            expect(response).to redirect_to movies_path
        end
    end
    
    # HW4 Part3
    #describe "Search for movies" do
    #    
    #    it "assigns movies" do
    #        movie1 = Movie.create!(title: 'Software Engineering', rating: 'PG')
    #        movie2 = Movie.create!(title: 'Cloud Computing', rating: 'P')
    #        movie3 = Movie.create!(title: 'Research', rating: 'R')
    #        movie4 = Movie.create!(title: 'Machine Learning', rating: 'G')
    #        get :index
    #        expect(assigns(:movies)) == [movie1, movie2, movie3, movie4]
    #    end
    #    
    #    it "sorts by rating" do
    #        get :index, {:sort_by => 'title'}
    #        #expect(assigns(:movies)) == [movie1, movie2, movie3, movie4]
    #        expect(response).to redirect_to :ratings => assigns(:ratings_to_show), :sort_by => 'title'
    #    end
    #end
    
    # Test "C"reate in CRUD
    describe "Create Movies" do
        it "creates a new movie" do
            lists = {movie: {title: 'Deep Learning'}}
            expect {post :create, lists}.to change(Movie, :count).by(1)
            expect(flash[:notice]) == "A new title was created"
        end
    end
    
    # Test "U"pdate in CRUD
    describe "Update Movies" do
        it "updates a movie" do
            movie = Movie.create!(title: 'Sleeping Class')
            put :update, {:id => movie.to_param, :movie => {"title" => "Demanding Class"}}
            expect(assigns(:movie)) == movie
            expect(flash[:notice]) == "A title was updated"
            expect(response).to redirect_to movie
        end
    end
    
    # Test "D"elete in CRUD
    describe "Delete Movies" do
        it "deletes a movie" do
            movie = Movie.create!(title: 'Unpopular Class')
            expect do
                delete :destroy, {:id => movie.to_param}
            end.to change(Movie, :count).by(-1)
            expect(flash[:notice]) == "A movie was deleted"
            expect(response).to redirect_to movies_path
        end
    end
    
end
        
