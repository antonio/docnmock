[![Code
Climate](https://codeclimate.com/github/antonio/docnmock.png)](https://codeclimate.com/github/antonio/docnmock)
[![Build Status](https://travis-ci.org/antonio/docnmock.png?branch=master)](https://travis-ci.org/antonio/docnmock)

# Docnmock

## Rationale

APIs are cool.

But documenting them sucks. And mocking them sucks. I want to see if double suck
can be cool, or at the very least get all the boring parts in the same place.

This is an *experiment* and it will probably go nowhere. You have been warned.

## The experiment

I want to be able to automatically mock an API from its documentation. Using
`docnmock` you will create the documentation for your API using `Ruby` and
generate an HTML site from it.

Also, `docnmock` will let you mock your API using the examples included in your
documentation. The idea is to have a small, self contained package that you can
require from a client application that needs to integrate against your API.

I am going to describe the possible operations using the [GitHub users
API](http://developer.github.com/v3/users/)

## Documenting

`Docnmock` allows you to document your API using a simple syntax

```ruby

Docnmock.resource_group 'Users' do
  description <<-EOD
  Many of the resources on the users API provide a shortcut for
  getting information about the currently authenticated user. If a request URL
  does not include a :user parameter then the response will be for the logged in
  user (and you must pass authentication information with your request).
  EOD

  Docnmock.resource :get, '/users/:user' do
    description 'Get a single user'
    parameter name: :user, description: 'The user', required: false
    example path: '/users/octocat', response: response('get_users_octocat.json')
  end
end

```

`parameter` accepts a hash with the following attributes:

* name

  The name of the parameter. In the resource path, it is preceded by a colon.

* description

  Freestyle description of the parameter.

* required

  Either true or false, defaults to false.

* type

  Type of the parameter. There are no boundaries for this, but try to use well
  known primitives as a guideline (string, int, boolean, etc)

`example` accepts two arguments. The first one is the request path, including
whatever parameters are needed. The second one is the response that will be
returned (as a string). As you can see in the example above, you can (and
should!) use a helper to load the response from a file bundled with your gem.
`docnmock` assumes your fixtures will be under a folder named `responses`. For
more information, please have a look at the
[docnmock-github](https://github.com/antonio/docnmock-github) project.

The contents of `responses/get_users_octocat.json` would be something similar to

```json
{
  "login": "octocat",
  "id": 1,
  "avatar_url": "https://github.com/images/error/octocat_happy.gif",
  "gravatar_id": "somehexcode",
  "url": "https://api.github.com/users/octocat",
  "name": "monalisa octocat",
  "company": "GitHub",
  "blog": "https://github.com/blog",
  "location": "San Francisco",
  "email": "octocat@github.com",
  "hireable": false,
  "bio": "There once was...",
  "public_repos": 2,
  "public_gists": 1,
  "followers": 20,
  "following": 0,
  "html_url": "https://github.com/octocat",
  "created_at": "2008-01-14T04:33:35Z",
  "type": "User"
}
```

## Generate documentation

## Mocking

```ruby
Docnmock.mock 'GET /users/octocat'
Docnmock.mock_all
```

## To-Do

As I said before, this is just an experiment. If I find it useful, here is
a list of improvements that can be done.

* API versions
* Tomdoc
* Make it possible to mock more than one API
* Rails integration?
* Create Error classes instead of using the standard one
* Pass headers to example
* Rake tasks to validate the API (say you are missing parameters in your
  resources, for instance)
