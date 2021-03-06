#! /usr/bin/lua

-- depends on http://lua.sqlite.org/

-- this isn't strictly necessary but it lets us run the app from a different dir
require( "lfs" )

lfs.chdir( arg[ 0 ]:match( "^(.-)[^/]*$" ) )

-- this is so you can run the examples just by cloning the repo
-- you shouldn't include this in anything you write
package.path = package.path .. ";../../src/?.lua"
package.cpath = package.cpath .. ";../../src/?.so"

require( "flea" )
local sqlite = require( "include.sqlite" )

DB = sqlite.new( "data/posts.sq3" )
DB( "CREATE TABLE IF NOT EXISTS posts ( id INTEGER PRIMARY KEY, title STRING, body STRING, postedAt INTEGER )" )()

flea.route( "", "index" )
flea.route( "new", "addPost" )
flea.route( "(%d+)", "viewPost" )

flea.run()
