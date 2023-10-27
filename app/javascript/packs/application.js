// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
//= require bootstrap
//= require bootstrap-sprockets

$.ajax({
  url: '/order_menus',
  type: 'POST',
  data: {
    order_menu: {
      menu_id: menuId,
      order_id: orderId,
      quantity: quantity
    }
  },
  success: function(response) {
    alert('Order placed successfully!');
    // Reset or clear the form (assuming your form has the id 'order-form')
    $('#order-form')[0].reset();  // This resets the form
    // You can do additional actions here if needed
  },
  error: function(error) {
    alert('Failed to place order.');
  }
});

success: function(response) {
  // Display the success message
  $('#success-message').show();
  // Reset or clear the form
  $('#order-form')[0].reset();  // This resets the form
  // You can do additional actions here if needed
},
