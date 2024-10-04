select * from netflix;
select count(*) from netflix;

select distinct type from netflix; 

-- 1.Count the number of Movies vs TV Shows
select type, 
count (*) as total_content
from netflix
group by type;


--2. List all movies released in a specific year (e.g., 2020)
select * 
from netflix
where release_year='2020' and type='Movie';


--3. Find the top 5 countries with the most content on Netflix
select
unnest (string_to_array(country,',')) as new_country,
count (show_id) as total_content
from netflix
group by 1
order by 2 desc
limit 5


--4. Identify the longest movie
select * 
from netflix
where type='Movie' 
and 
duration=(select max(duration) from netflix);


--5. Find content added in the last 5 years
select *
from netflix
where  
to_date(date_added,'month dd, yyyy')>= current_date - interval '5 years'


--6. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select * 
from netflix 
where director like '%Rajiv Chilaka%';


--7. List all TV shows with more than 5 seasons
select * 
from netflix
where type='TV Show'
and
split_part(duration,' ',1)::numeric > 5 


--8. Count the number of content items in each genre
select 
unnest (string_to_array(listed_in,',')) as genere,
count(show_id) as total_content
from netflix
group by 1


--9. List all movies that are documentaries
select show_id,type,listed_in 
from netflix
where listed_in like '%Documentaries%';


--10. Find all content without a director
select show_id,type,director
from netflix
where director is null;


--11. Find how many movies actor 'Salman Khan' appeared in last 10 years! 
select * 
from netflix
where casts ilike '%salman khan%'
and release_year > EXTRACT( Year From Current_Date) - 10


--12. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select
unnest(STRING_TO_ARRAY(casts, ',')) as actor,
count(*)
from netflix
where country = 'India'
group by 1
order by 2 desc
limit 10
