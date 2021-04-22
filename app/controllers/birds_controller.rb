class BirdsController < ApplicationController
  def index
    birds = Bird.all
    # render json: birds, only: [:id, :name, :species]
    # in this case slice wont work with an array of bird objects, only on a singular one 
    # so we can add the only option and pass it the keys

    # we could also use the except option as well to not have to type every key that we want rendered 
    # render json: birds, except: [:created_at, :updated_at]

    # this method will produce the same result but is explicitly telling us what is happening
    render json: birds.to_json(except: [:created_at, :updated_at])

  end

  def show 
    bird = Bird.find_by(id: params[:id])
    # render json: bird -- whole object 

    # render json: {id: bird.id, name: bird.name, species: bird.species}
    # object with specfic details that we created form the table
   
      # render json: bird.slice(:id, :name, :species)
    # This achieves the same result but in a slightly different way. 
    # Rather than having to spell out each key, the Hash slice method (Links to an external site.) returns a new hash 
    # with only the keys that are passed into slice. In this case, :id, :name, and :species were passed in, 
    # so created_at and updated_at get left out, just like before.
    if bird
      render json: {id: bird.id, name: bird.name, species: bird.species} 
    else 
      render json: {message: "Bird not found, sorry :( "}
    end
  end
end