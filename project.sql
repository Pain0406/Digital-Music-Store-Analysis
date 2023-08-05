-- Q1: Who is the senior most employee based on job titile?
SELECT * 
FROM employee
ORDER BY levels desc
limit 1

-- Q2: Which countries have the most number of Invoices?
SELECT COUNT(*) as c,billing_country  
FROM invoice
group by billing_country
order by c desc

-- Q3: What are the top three values of total invoice?

select total 
from invoice
order by total desc
limit 3

-- Q4: Which city has the best ? Wcustomerse would like to throw a music festival in the city we made most money. Write a qu
-- ery that returns one city that has highest sum of invoice totals. Return both the city name and sum of all invoice totals
select SUM(total) as invoice_total , billing_city
from invoice
group by billing_city
order by invoice_total desc
limit 10

-- Q5: which customer spend most of the money on us? write a query to return the person who spent the most moeny on us
select customer.customer_id, customer.first_name, customer.last_name,SUM(invoice.total) as total
from customer
JOIN invoice On customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total DESC
limit 1

-- Q6: write query to return the email,first name,last name and
-- gener of all rock music listner. RETUR YOUR LIST BY EMIAL SATRTING WITH A

select DISTINCT email,first_name,last_name
from customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	select track_id from track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIke 'Rock'
)
ORDER BY email;

-- Q7: Let's invite the artist who have written the mot number 
-- of rock music in our dataset. wrtie a query to written the artist
-- name and total trakc count of all top 10 rock bands

select artist.artist_id, artist.name, COUNT(artist.artist_id) as songs
from track
JOIN album on album.album_id = track.album_id
join artist on artist.artist_id = album.album_id
join genre on genre.genre_id = track.genre_id
where genre.name = 'Rock'
group by artist.artist_id
order by songs desc
limit 10

-- Q9: Return the song length which has the longer song length
-- then the average onr. Return the Name and millisecond for each
-- track. Order by the song length with the longest song listed
-- in list

select name,milliseconds
from track
where milliseconds>(
	select avg(milliseconds) as average_playback
	from track
)
order by milliseconds desc

select * 
from track