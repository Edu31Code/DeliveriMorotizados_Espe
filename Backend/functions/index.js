const functions = require("firebase-functions");
const express = require("express");
const http = require("http");
const admin = require("firebase-admin");

var app = express();
require("dotenv").config();

const hostname = "127.0.0.1";
const port = 3000;
const serviceAccount = require("./prowess-bike-firebase-adminsdk-78001-50faf9d382.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: process.env.DATABASE_URL,
});

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader("Content-Type", "text/plain");
  res.end("Hola Mundo\n");
});

app.post("/savePedido", (req, res) => {
  console.log("ingresando pedido");
  const pedido = req.body;
  var detail = [];
  const lat = pedido.meta_data.find(element => element.key == "_shipping_address_latitude");
  const long = pedido.meta_data.find(element => element.key == "_shipping_address_longitude");
  pedido.line_items.forEach(el => {
    detail.push({
      nombre: el.name,
      precio: el.price,
      cantidad: el.quantity,
      subtotal: el.subtotal,
      taxes: el.total_tax,
      total: el.total,
    });
  });
  const detalle = detail;

  admin
  .firestore()
  .collection('WoocomerceBody')
  .add({
    body: pedido
  });

  admin
  .firestore()
  .collection('pedidos')
  .add({
    estado: 'libre',
    fecha: admin.firestore.Timestamp.fromDate(new Date()),
    num_pedido: pedido.number,
    comprador: {
      nombre: pedido.shipping.first_name+' '+pedido.shipping.last_name,
      pais: pedido.shipping.country,
      ciudad: pedido.shipping.city,
      dir_1: pedido.shipping.address_1,
      dir_2: pedido.shipping.address_2,
      phone: pedido.shipping.phone,
      lat: lat.value,
      long: long.value,
    },
    vendedor: {
      nombre: pedido.store.name,
      nombre_tienda: pedido.store.shop_name,
      url: pedido.store.url,
      pais: pedido.store.address.country,
      ciudad: pedido.store.address.city,
      estado: pedido.store.address.state,
      calle_1: pedido.store.address.street_1,
      calle_2: pedido.store.address.street_2,
      zip: pedido.store.address.zip,
      phone: "0967900572",
      lat: "-0.2508130180903265",
      long: "-78.52213846112458",
    },
    detalle: detalle,
    pago: {
      tipo_de_pago: pedido.payment_method_title,
      moneda: pedido.currency,
      moneda_symbol: pedido.currency_symbol,
      envio: pedido.shipping_total,
      envio_tax: pedido.shipping_tax,
      total: pedido.total,
      total_tax: pedido.total_tax
    },
  });
  res.send("Listo");
});

app.get("/listPedidos", (req, res) => {
  const listPedidos = (nextPageToken) => {
    admin
      .firestore()
      .collection('pedidos')
      .where('estado', '==', 'libre')
      .get()
      .then((docs) => {
        console.log("enviando pedidos");
        res.send(docs.docs);
      })
      .catch((error) => {
        console.log("Error listing users:", error);
      });
  };
  
  listPedidos();
});

app.post("/updateStatePedido", (req, res) => {
  console.log("PruebaServidor");
  console.log(req.body);
  res.send("En Contrucción");
});

app.post("/deleteUser", (req, res) => {
  var uid = req.body.UID;
  console.log(uid);
  admin
    .auth()
    .deleteUser(uid)
    .then(() => {
      console.log("Successfully deleted user");
      res.send("Successfully deleted user");
    })
    .catch((error) => {
      console.log("Error deleting user:", error);
    });
});

app.get("/listAllUsers", (req, res) => {
  const listAllUsers = (nextPageToken) => {
    // List batch of users, 1000 at a time.
    admin
      .auth()
      .listUsers(1000, nextPageToken)
      .then((listUsersResult) => {
        listUsersResult.users.forEach((userRecord) => {
          console.log(userRecord.toJSON());
        });
        res.send(listUsersResult.users);
        if (listUsersResult.pageToken) {
          // List next batch of users.
          listAllUsers(listUsersResult.pageToken);
        }
      })
      .catch((error) => {
        console.log("Error listing users:", error);
      });
  };
  // Start listing users from the beginning, 1000 at a time.
  listAllUsers();
});

exports.app = functions.https.onRequest(app);
