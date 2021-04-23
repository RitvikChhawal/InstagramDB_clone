# mysql-ctl cli;

# 5 Oldest users
SELECT * FROM users
ORDER BY created_at
limit 5;

# Most popular registration date

SELECT 
  DAYNAME(created_at) as day,
  COUNT(*) as total
  FROM users 
  GROUP BY day
  ORDER BY total DESC;
  
# Innactive users  

SELECT username FROM users
LEFT JOIN photos
ON 
users.id = photos.user_id
WHERE photos.id IS NULL;

# Most liked photo
SELECT 
username ,
photos.id,
photos.image_url,
COUNT(*) AS total
FROM photos
INNER JOIN likes
ON likes.photo_id = photos.id
INNER JOIN users
ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

# Avg photos per user

SELECT 
(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS Avg;

# 5 most used hashtag

SELECT 
tags.tag_name,
COUNT(*) AS total
FROM photo_tags
JOIN tags
ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC
limit 5;

# finding bots : those who like all photos

SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*)  FROM   photos);


