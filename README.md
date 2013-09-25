[![Code
Climate](https://codeclimate.com/github/antonio/docnmock.png)](https://codeclimate.com/github/antonio/docnmock)
[![Build Status](https://travis-ci.org/antonio/docnmock.png?branch=master)](https://travis-ci.org/antonio/docnmock)

# Docnmock

## Disclaimer

This is a work in progress. I first wrote this document and then started
implementing the functionality, so don't expect things to work if you can still
read this message :)

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

## Why not reuse an existing solution? (aka why are you reinventing the wheel?)

There are excellent alternatives out there, like
[apipie-rails](https://github.com/Pajk/apipie-rails://github.com/Pajk/apipie-rails)
and [grape](https://github.com/intridea/grape). Oh, and also
[swagger](https://developers.helloreverb.com/swagger), which is language
agnostic and great.

But none of them was exactly what I was looking for.

I don't want it to be coupled to a specific web framework.

Adding a lot of documentation to the code using a DSL makes it more difficult to
read both the documentation and the code to me.

I want the documentation to be distributed as an independent project so that the
gems can be required from the application that wants to use the mocks.

So in the end I preferred to roll my own implementation of the wheel :)

## Documenting

`Docnmock` allows you to document your API using a simple syntax. To define your
API, all you need is its url. See example below

```ruby

Docnmock.api 'http://myawesomeservice.com/api' do

  resource_group 'Users' do

    description <<-EOD
      Many of the resources on the users API provide a shortcut for
      getting information about the currently authenticated user. If a request URL
      does not include a :user parameter then the response will be for the logged in
      user (and you must pass authentication information with your request).
    EOD

    resource :get, '/users/:user' do
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

Everything can be mocked

```ruby
Docnmock.api('http://api.github.com').mock
Docnmock.api('http://api.github.com').resource_group('Users').mock
Docnmock.api('http://api.github.com').resource_group('Users').resource(:get, '/users/:user').mock
```

## To-Do

As I said before, this is just an experiment. If I find it useful, here is
a list of improvements that can be done.

* API versions
* Description of resources written in markdown
* Tomdoc
* Rails integration?
* Create Error classes instead of using the standard one
* Pass headers to example
* Resource validation and rake tasks to validate the API (say you are missing parameters in your
  resources, for instance)
* Refactor specs, I am pretty sure that there are some shared examples hidden
  there.
* Allow using a port other than 80
