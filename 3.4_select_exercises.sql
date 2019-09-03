-- #2
use albums_db;

-- #3
describe albums;

-- #4

select * FROM albums where artist = 'Pink Floyd';

select * FROM albums where name LIKE '%Lonely Hearts%';

select release_date FROM albums where name LIKE '%Lonely Hearts%';

select * FROM albums WHERE name = 'Nevermind';

select genre FROM albums WHERE name = 'Nevermind';

select * FROM albums WHERE release_date >= 1990 AND release_date <=1999 ORDER BY release_date;

select * FROM albums WHERE genre = 'Rock';

-- option to show all genres of rock
select * FROM albums WHERE genre LIKE '%Rock%';
