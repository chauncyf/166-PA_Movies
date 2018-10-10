
class Rating
  attr_reader :u_data

  def initialize
    # read the training data

    user_data_temp = open('./ml-100k/u1.base')

    # store data of the file into an array
    @u_data = []
    user_data_temp.each do |i|
      @u_data.push(i)
    end
    user_data_temp.close
  end


  def popularity()
    # calculate popularity of all movies by adding all rating / rated times, return the popularity list of movies

    popularity_list = {}

    @u_data.each do |i|
      id = i.split[1]
      rank = i.split[2]

      if popularity_list[id].nil?
        popularity_list[id] = [rank.to_f, 1]
      else
        popularity_list[id][0] += rank.to_f
        popularity_list[id][1] += 1
      end
    end

    popularity_list.each do |id, rank|
      popularity_list[id] = rank[0] / rank[1]
    end

    popularity_list
  end
end


class Validator
  # test and rank the predict algorithm

  def initialize
    test_data_temp = open('./ml-100k/u1.test')

    # store test data into an array
    @u_data = []
    test_data_temp.each do |i|
      @u_data.push(i)
    end
    test_data_temp.close
  end


  def validate
    # calculate how good the prediction model is with exact_value, mean and stdev

    rate = Rating.new
    # store the rating data into a array to reduce running time
    popularity_list = {}
    rate.popularity.each do |id, rank|
      popularity_list[id] = rank
    end

    # manually rank a movie as 4 if it does not have a rank
    (0..1682).each do |i|
      popularity_list[i.to_s] = 4 if popularity_list[i.to_s].nil?
    end

    # exact_vali: 1-exact, 0-not exact
    exact_vali = []
    mean = 0
    stdev = 0
    counter = 0

    # calculate the mean and sum of exact
    @u_data.each do |i|
      movie_id = i.split[1]
      rank = i.split[2]

      absolute_value = (rank.to_f - popularity_list[movie_id]).abs
      mean += absolute_value

      # see prediction result as exact when the absolute value of rank minus prediction smaller than 1
      if absolute_value < 1
        exact_vali[counter] = 1
      else
        exact_vali[counter] = 0
      end

      counter += 1
    end

    mean /= counter
    exact_sum = 0
    exact_vali.each do |i|
      exact_sum += 1 if i == 1
    end

    # have to go through the u_data again to get the stdev
    @u_data.each do |i|
      movie_id = i.split[1]
      rank = i.split[2]
      stdev += (rank.to_f - popularity_list[movie_id])**2
    end
    stdev = Math.sqrt(stdev / (@u_data.length - 1))

    [exact_sum, mean, stdev]
  end
end


class Control
  # control the Rating and Validator class

  attr_accessor :validator

  def initialize
    @validator = Validator.new
  end

  def getExact
    @validator.validate[0]
  end

  def getMean
    @validator.validate[1]
  end

  def getStdev
    @validator.validate[2]
  end
end

start_time = Time.now
test = Control.new
puts "The number of exact predict is: #{test.getExact} \nThe mean of difference is #{test.getMean} \nThe stdev of difference is: #{test.getStdev}"
end_time = Time.now
time_cost = end_time - start_time
puts "It cost about #{time_cost} sec to run a prediction"

# The number of exact predict is: 13033
# The mean of difference is 0.8279457232889976
# The stdev of difference is: 1.0345423580061612
# It cost about 0.592965 sec to run a prediction
