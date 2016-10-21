#!/usr/bin/ruby

require 'mysql'

def create_db
	begin
		con = Mysql.new 'localhost'
		con.query 'DROP DATABASE IF EXISTS matcha'
		con.query 'CREATE DATABASE matcha'
		puts "db created"
		setup

	rescue Mysql::Error => e
		puts e.errno
		puts e.error

	ensure
		con.close if con
	end
end

def setup
	begin
		con = Mysql.new 'localhost', 'root', 'root', 'matcha'
		tables = {
			:users => 'CREATE TABLE IF NOT EXISTS users (`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, `login` VARCHAR(255) NOT NULL, `email` VARCHAR(255) NOT NULL, `password` VARCHAR(255) NOT NULL, `first_name` VARCHAR(255) NOT NULL, `last_name` VARCHAR(255) NOT NULL, `sex` VARCHAR(255), `intersted_in` VARCHAR(255), `description` TEXT, `role` VARCHAR(10) NOT NULL DEFAULT "member")'
		}
		tables.each do |key, value|
			con.query(value)
			puts "table #{key} created succesfully"
		end

	rescue Mysql::Error => e
		puts e.errno
		puts e.error

	ensure
		con.close if con
	end
end

create_db
