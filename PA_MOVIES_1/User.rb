# require './MovieData.rb'

class User
  def initialize(id, data)
    @id = id
    @movie_list = {}

    @movie_list[data[0]] = data[1]
    # data = open('./ml-100k/u.data')
    # data.each do |i|
    #   @movie_list[i.split[1]] = i.split[2] if i.split[0] == @id
    # end
    # data.close
  end
  attr_accessor :id, :movie_list


  # def add_row(data)
  #   movie_list[data[0]] = data[1]
  # end


  def rate_list(rate)
    # return list of movies that the rating of rate
    list = {}
    movie_list.each do |id, rating|
      # puts id, rating
      list[id] = rating if rating == rate.to_s
    end
    list
  end

end
