require './User.rb'

class MovieData
  # user_id  movie_id  rating  timestamp
  attr_reader :u_data, :user_list

  def initialize
    data = open('./ml-100k/u.data')

    # store data of the file into an array
    @u_data = []
    data.each do |i|
      @u_data.push(i)
    end
    data.close

    # make new object of each user, and store rating information into these object, store these user object as a hash
    @user_list = {}
    @u_data.each do |j|
      user_id = j.split[0]
      user_data = j.split[1..3]
      if @user_list[user_id].nil?
        # if there are no object of this user in the hash
        @user_list[user_id] = User.new(user_id, user_data)
      else
        @user_list[user_id].movie_list[user_data[0]] = user_data[1]
      end
    end
  end


  def popularity(movie_id)
    # calculate popularity by adding all rating / rated times
    rate_time = 0.0
    rate_sum = 0.0
    u_data.each do |i|
      if i.split[1] == movie_id.to_s
        rate_sum += i.split[2].to_f
        rate_time += 1
      end
    end
    puts "the popularity of movie #{movie_id} is #{rate_sum / rate_time}"
  end


  def popularity_list(row)
    # print the most popular #row mivies
    list = []
    j = 5
    while j > 0
      # puts j
      u_data.each do |i|
        list.push(i) if i.split[2] == j.to_s
      end
      # u_data.seek(0)
      j -= 1
    end
    puts "ID of the most popular #{row} movies are: "
    (0..row).each do |i|
      puts list[i].split[1]
    end
  end


  def similarity(user1, user2)
    # calculate two user's similarity by calculate the absolute rating value of a same movie,
    # add up these value and divide rating times to get the similarity
    user_a = user_list[user1]
    user_b = user_list[user2]
    comm_list = []

    user_a.movie_list.each do |movie_id, rating|
      # ger a list of movies that both user watched
      if !user_b.movie_list[movie_id.to_s].nil?
        comm_list.push(movie_id)
      end
    end

    # calculate similarity
    sim = 0
    comm_list.each do |i|
      sim += (user_a.movie_list[i].to_i - user_b.movie_list[i].to_i).abs / 5.0
    end
    sim = if !comm_list.empty?
            1 - sim / comm_list.length
          else
            0
          end
    # puts "the similarity of user #{user1} and #{user2} is #{sim}"
    sim
  end


  def most_similar(u)
    # compare all users using the similarity() method, get a list of all the similarities and sort the list.
    list = {}
    (1...@user_list.length).each do |i|
      if i.to_s != u
        list[similarity(u.to_s, i.to_s)] = i
      end
    end
    puts "These are similarity list of user#{u}"
    j = 0
      list.sort.reverse_each.each do |sim, id|
        print "\n user #{id} => similarity #{sim}"
      end
  end

end

data = MovieData.new
data.popularity(457)
data.popularity_list(15)
puts data.similarity('222', '333')
data.most_similar('456')
