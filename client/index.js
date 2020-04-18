var twit = require('twit');
var config = require('./config.js');
var Twitter = new twit(config);
global.fetch = require("node-fetch");


async function list_unpublished_tweets() 
{
  let response = await fetch('http://localhost:3000/puns.json?filter=not+published',{method: 'GET'});
  let data = await response.json()
  return data;
}

function update_database(db_data)
{
    fetch('http://localhost:3000/publish/'+ db_data.id + ".json",{
        method: 'PATCH',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(db_data)
    })
    .then((response) => {return response.json()})
    .then((response_data) => {
        console.log("updated the db, the tweet was:")
        console.log(response_data)})
}


function publish_tweet (tweet_data){
    Twitter.post('statuses/update', { status: tweet_data["tweet"] }, function(err, response_data, response) {
        if (!err){
            const db_data = Object.assign(tweet_data, {tweet_id: response_data.id})
            console.log('Twitted the following')
            console.log(db_data)
            console.log('Updating database')
            update_database(db_data)
        }else{
            console.log("Couldn't tweet'... Maybe a duplicate?")
            console.log(db_data)
        }
    })
}

list_unpublished_tweets()
  .then(data => publish_tweet(data[0])); 


// function runProgram(){
//     tweet_list = list_unpublished_tweets()
//     console.log(tweet_list)
//     // publish_tweet(tweet[0])
// }

// runProgram()