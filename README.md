# DocNMock

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

```ruby
DocNMock.define_resource :get, '/users/:user' do
  parameters user: 'The user'
  examples [
    'GET /users/octocat', fixture('get_octocat')
  ]
  ]
end
```

In `fixtures/get_octocat.json`

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

Use Bootstrap to prettify the HTML

## Mocking

DocNMock.mock 'GET /users/octocat'
DocNMock.mock_all

## To-Do

As I said before, this is just an experiment. If I find it useful, here is
a list of improvements that can be done.

* Make it possible to add more information about the parameters (optional, etc)
* API versioning
