# Rails Engine
> Rails engine was a 6-day project for Mod 3 of [Turing School](turing.edu)'s Back-End Engineering Program.

This project is intended to replicate an E-Commerce Application that uses service-oriented architecture. The purpose of this application is to expose data through an API that will be consumed by the front end.

## Table of Contents

- [Features](#features)
- [Database Schema](#database-schema)
- [Contributors](#contributors)
- [How to Contribute](#how-to-contribute)

## Features

* A user can retrieve lists of resources in the database via a collection of endpoints associated with those particular resources.
* It is possible to view all records associated with a particular resource by using one of the "relationship endpoints"
e.g. `GET /api/v1/merchants/:id/items`, or `GET /api/v1/items/:id/merchant`

## Database Schema

[![Database Schema](https://i.postimg.cc/66nrJp7G/Screen-Shot-2021-09-04-at-3-53-46-PM.png)](https://postimg.cc/CdMBbYsF)

## Contributors

👤  **Matt Kragen**
- [GitHub](https://github.com/matt-kragen)
- [LinkedIn](https://www.linkedin.com/in/mattkragen/)

## How to Contribute

1. Fork it (<https://github.com/InOmn1aParatus/rails-engine/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request
