# Readme

##Algorithm
My prediction use u1.base as train data, and get the popularity of each movie.
when a movie is not ranked, give the movie a 4 ranking, 4 works really well I
think it's because that people are not always very picky, and 4 is the rank that
people are trend to give.

##Analysis
I use the validate method to determine the accuracy of my method. I got nearly 
13000 correct predict out of 20000, which is about 65% precision.  

##Benchmarking
It cost about 0.536607 sec to run a prediction. I think the time will increased
by 10 or 100 if I increase the size of training set by a factor of 10 or 100.   
Because I think the complexity of my algorithm is O(n).

##Reflection
Since I did not learnt machine learning before, I spent a lot of
time to figure out how to use machine learning to solve this problem.

I tried to write the prediction algorithm by predict a user's ranking by 
calculate the genre of a movie, but since a movie can have multiple genre, 
it's really hard to link the genre with ranking.

Finally I just calculate the average ranking of each movie, and use this 
average ranking as prediction, surprisingly this work really well. 
It's reasonable because the mean can always reflect the truth. 
It's also unreasonable because the prediction do not based on a 
specific user at all, everyone will get the same prediction.
