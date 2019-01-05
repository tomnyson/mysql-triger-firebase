
const { config } = require('./config.js')
const hostname = '127.0.0.1'
const port = 3000;
var admin = require('firebase-admin');
var MySQLEvents = require('mysql-events')
var mysql = require('mysql');
var http = require('http');
var serviceAccount = require('./google-service.json')
var moment = require('moment');
var CronJob = require('cron').CronJob;
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: 'https://magento-notify.firebaseio.com/'
});
// sample data
var connection = mysql.createConnection({
    host: 'localhost',
    database: 'mydb',
    user: 'root',
    password: '123456',
});
connection.connect(function (err) {
    if (err) {
        console.error('Error connecting: ' + err.stack);
        return;
    }

    console.log('Connected as id ' + connection.threadId);
});
ngaunhien = (min, max) => {
    return (Math.random() * ((max ? max : min) - (max ? min : 0) + 1) + (max ? min : 0)) | 0;
}
var data = {
    trade: 'Buy',
    data_time:   new Date(),
    price: ngaunhien(1000, 10000),
    id: ngaunhien(1, 5)
}
pushEventFirebase = (info) => {
    var db = admin.database();
    var usersRef = db.ref("tracking");
    let exchange = info.EXCHANGE
                    let symbols = info.SYMBOL
                    let datetime = info.DATE_TIME
                    let price = info.PRICE
                    let trade = info.TRADE
                    var currentUnixTime = moment(datetime).format('DD-MM-YYYY')
                    var timeStamp = moment(datetime).format("X")
                    var hour = moment(datetime).format('hh: mm A')
                    var messages = `${hour} - ${exchange}: ${trade} ${symbols} @ ${price}`
                    usersRef.child(`${exchange}/${symbols}/${currentUnixTime}/${timeStamp}`).set(
                         messages
                    );
}
const job = new CronJob('* * * * *', function() {
  //call function cron 
  connection.query('UPDATE multi set TRADE = ?, PRICE = ?, DATE_TIME = ?  where ID = ?',[data.trade, data.price,data.data_time, data.id], function (error, results, fields) {
    if (error) throw error;
   // success 
   connection.query('SELECT * from multi where ID = ?', [data.id], function (error, results, fields) {
    if (error) throw error;
    // call function push firebase
   pushEventFirebase(results[0])
  });
  }),
  //end
  console.log('da call cron job')
}, null, true, 'America/Los_Angeles');
console.log('da ra khoi func')
job.start();



const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello World\n');
});

server.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
});