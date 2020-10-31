# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.6.6

* System dependencies
rails 6.0.3.4
mysql2 0.5.3
rswag

* Configuration
gem install mysql2 -v 0.5.3
rails g rswag:install

Note: I used mysql as a database system. Please kindly change username and password
        in the database.yml file to access MySql Database on your system.

* Database creation
create database robot

* Database initialization
rails db:migrate
rails db:seed

* How to run the test suite
1. run the server with rails server command
2. You can test the app either with postman collection in the docs folder
        or through the Swagger UI in this link: http://localhost:3000/api-docs/

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
