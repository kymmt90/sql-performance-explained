# sql-performance-explained

This repository includes following files to help reading ["SQL Performance Explained"](https://sql-performance-explained.com/):

- SQL files to construct database schema introduced in each chapter of the book
- a Ruby script to generate massive amount of data for the schema

## Usage

```
$ ruby population.rb
$ docker-compose up
$ cat ch2.sql | psql -h localhost -p 5432 -U postgres
Password for user postgres: postgres
You are now connected to database "postgres" as user "postgres".
CREATE TABLE
CREATE INDEX
CREATE INDEX
CREATE INDEX
COPY 100000
$ psql -h localhost -p 5432 -U postgres
Password for user postgres: postgres

psql (12.1, server 12.3 (Debian 12.3-1.pgdg100+1))
Type "help" for help.

postgres=#
```
