# Becomics

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

This is a back end that will help me learn about front end development. Most code generated by Phoenix.
It is possible to insert into the tables with:

curl -H "Content-Type: application/json" -X POST -d '{"comic": {"name":"Megatokyo","url":"http://megatokyo.com"}}' http://localhost:4000/api/comics

curl -H "Content-Type: application/json" -X POST -d '{"publish": {"day":"Mon","comic_id":"ee9515cd-e016-4c98-8818-27997eaef4b9"}}' http://localhost:4000/api/publishes

where comic_id is 'id' in the reply to the first post.

Phoenix made it very easy to add a basic front end so it is possible to visit [`localhost:4000/daily`](http://localhost:4000/daily) to see todays comics.

The development of the 'daily' interface was done using two other interfaces: [`localhost:4000/comics/:day`](http://localhost:4000/comics/Mon) and [`localhost:4000/sample/:date`](http://localhost:4000/sample/1). They can be enabled by uncommenting them in lib/becomics_web/router.ex
