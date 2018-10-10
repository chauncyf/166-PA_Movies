
I made two classes, MovieData is used to process data form the u.data file.
MovieData provide 5 methods:
    initialize()
    popularity(movie_id)
    popularity_list(row)
    similarity(user1, user2)
    most_similar(u)

initialize() open the u.data file, create User objects of each user,
store their own rating data into each object

popularity(movie_id) print the average rate of movie_id.

popularity_list(row) print row line movies that rated 5.

similarity(user1, user2) calculate the similarity between user1 and user2.
It find the common list of the two user, and calculate the absolute value of rating
of every movies, divide these value by 5, then up these values and divide it by the sum of movies
that both of them watched.

most_similar(u) return the list of all users' similarity with u by decreased sort,
get this list by using method similarity(user1, user2) for @user_list.length times.


The User class is used to store every users' movie list.
