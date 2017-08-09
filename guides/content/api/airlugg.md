---
title: Airlugg Flow
description: Spree Commerce API mapping to Airlugg
---

## Introduction

This page consolidates the information contained in the [Checkouts](checkouts), [Orders](orders), and [Authentication](authentication) pages, outlining the Spree API in relation to the Airlugg checkout flow. 

## 1. Order Dates Screen

### Order Create Endpoint

Create a new, empty order, by making this requeset:

    POST /api/orders.json

<pre class="highlight"><code class="language-javascript">{
  "order": {
    "rental_start_date" "2015-02-03",
    "rental_end_date": "2015-02-06",
    "zipcode": "90025"
  }
}
</code></pre>

The `zipcode` maps to the `zipcode` attribute on `serviceable_zipcode`, which is a custom table that has a M:1 association with `stock_location` (i.e. stock location *has many* serviceable zipcodes).

### Response

If the provided zipcode is serviced by one of the available stock locations, it'll return a successful response:

<%= headers 201 %>
<pre class="highlight"><code class="language-javascript">{
  "id": 4,
  "number": "R307128032",
  "item_total": "0.0",
  "total": "0.0",
  "ship_total": "0.0",
  "state": "cart",
  "adjustment_total": "0.0",
  "user_id": 1,
  "created_at": "2014-07-06T18:52:33.724Z",
  "updated_at": "2014-07-06T18:52:33.752Z",
  "completed_at": null,
  "payment_total": "0.0",
  "shipment_state": null,
  "payment_state": null,
  "email": "spree@example.com",
  "special_instructions": null,
  "channel": "spree",
  "included_tax_total": "0.0",
  "additional_tax_total": "0.0",
  "display_included_tax_total": "$0.00",
  "display_additional_tax_total": "$0.00",
  "tax_total": "0.0",
  "currency": "USD",
  "rental_start_date": "2015-02-03T00:00:00.000-08:00",
  "rental_end_date": "2015-02-06T00:00:00.000-08:00",
  "zipcode": "90025",
  "display_item_total": "$0.00",
  "total_quantity": 0,
  "display_total": "$0.00",
  "display_ship_total": "$0.00",
  "display_tax_total": "$0.00",
  "token": "n0kZnXjRfjnhZMY5ijhiOA",
  "checkout_steps": [
    "address",
    "delivery",
    "complete"
  ],
  "permissions": {
    "can_update": true
  },
  "bill_address": null,
  "ship_address": null,
  "line_items": [],
  "payments": [],
  "shipments": [],
  "adjustments": [],
  "credit_cards": [],
  "default_credit_card": {}
}
</code></pre>

Notes:

- Any time you update the order or move a checkout step you'll get
a response similar as above along with the new associated objects. e.g. addresses,
payments, shipments.
- If the `token` (which is the `spree_api_key` that gets returned following signup/login) is passed with the API call, the backend will associate the order with the authenticated user - i.e. in the response, `user_id` and `email` fields will be present. Also if the user has previously purchased, the `bill_address`, `ship_address`, and `default_credit_card` fields will be present, which can be used to prepopulate the user profile for returning customers.

 ```
     POST /api/orders.json?token=6303a093e4dd91936ad2c95d4de8a2a160d8e339c5b075b9
 ```

- The `token` can also be placed inside the body.
- The `state` will always be `cart` at this point.

### Failed Response

If the provided zipcode area is not serviced, the response will be:

<%= headers 422 %>
<%= json \
  error: "Validation failed: Unserviceable area"
%>

### Unserviced Zipcode Endpoint

If the provided zipcode is not serviced, customer can choose to submit their email to the server.

This request will be:

    POST /api/unserviced

<%= json \
  :zipcode => "12345",
  :email => "some@email.com"
%>

### Response
<%= headers 200 %>

## 2. Inventory Screen

### Variant Index Endpoint

This API call will return all *in-stock* variants at a particular stock location.

    GET /api/variants?zipcode=90025

<pre class="highlight"><code class="language-javascript">{
    "variants": [
        {
            "id": 1,
            "name": "Tumi Alpha 2",
            "sku": "ROR-001",
            <b>"product_type": "Luggage",</b>
            <b>"is_rentable": true,</b>
            "price": "10.99",
            "weight": "0.0",
            "height": null,
            "width": null,
            "depth": null,
            "is_master": true,
            "slug": "tumi-alpha-2",
            "description": "Some description.",
            "track_inventory": true,
            "option_values": [],
            "product_properties": [
              {
                "id": 1,
                "product_id": 1,
                "property_id": 1,
                "value": "Luggage",
                "property_name": "Type"
              }
            ],
            "taxons": [
              {
                "pretty_name": "Categories -> Luggage -> Luxury",
                "ancestors": [
                  "Luggage",
                  "Luxury"
                ],
                "taxonomy_name": "Categories"
              }
            ],
            "images": [
                {
                    "id": 4,
                    "position": 1,
                    "attachment_content_type": "image/jpeg",
                    "attachment_file_name": "tumi_alpha2.jpg",
                    "type": "Spree::Image",
                    "attachment_updated_at": "2016-03-08T01:59:35.892Z",
                    "attachment_width": 480,
                    "attachment_height": 480,
                    "alt": null,
                    "viewable_type": "Spree::Variant",
                    "viewable_id": 1,
                    "mini_url": "/spree/products/4/mini/tumi_alpha2.jpg?1457402375",
                    "small_url": "/spree/products/4/small/tumi_alpha2.jpg?1457402375",
                    "product_url": "/spree/products/4/product/tumi_alpha2.jpg?1457402375",
                    "large_url": "/spree/products/4/large/tumi_alpha2.jpg?1457402375"
                }
            ],
            "display_price": "$10.99",
            "options_text": "",
            "in_stock": true,
            "is_backorderable": false,
            "total_on_hand": 10,
            "is_destroyed": false,
            "stock_items": [
                {
                    "id": 15,
                    "count_on_hand": 10,
                    "stock_location_id": 3,
                    "backorderable": false,
                    "available": true,
                    <b>"stock_location_name": "Los Angeles"</b>
                }
            ]
        },
        {
            "id": 3,
            "name": "Beats Headphones",
            "sku": "ROR-003",
            <b>"product_type": "Extras",</b>
            <b>"is_rentable": true,</b>
            "price": "9.99",
            "weight": "0.0",
            "height": null,
            "width": null,
            "depth": null,
            "is_master": true,
            "slug": "beats-headphones",
            "description": "Some description.",
            "track_inventory": true,
            "option_values": [],
            "product_properties": [
              {
                "id": 3,
                "product_id": 3,
                "property_id": 1,
                "value": "Electronics",
                "property_name": "Type"
              }
            ],
            "taxons": [
              {
                "pretty_name": "Categories -> Extras -> Electronics",
                "ancestors": [
                  "Extras",
                  "Electronics"
                ],
                "taxonomy_name": "Categories"
              }
            ],
            "images": [
                {
                    "id": 6,
                    "position": 1,
                    "attachment_content_type": "image/jpeg",
                    "attachment_file_name": "beats_headphones.jpeg",
                    "type": "Spree::Image",
                    "attachment_updated_at": "2016-03-08T01:59:36.914Z",
                    "attachment_width": 480,
                    "attachment_height": 480,
                    "alt": null,
                    "viewable_type": "Spree::Variant",
                    "viewable_id": 3,
                    "mini_url": "/spree/products/6/mini/beats_headphones.jpeg?1457402376",
                    "small_url": "/spree/products/6/small/beats_headphones.jpeg?1457402376",
                    "product_url": "/spree/products/6/product/beats_headphones.jpeg?1457402376",
                    "large_url": "/spree/products/6/large/beats_headphones.jpeg?1457402376"
                }
            ],
            "display_price": "$9.99",
            "options_text": "",
            "in_stock": true,
            "is_backorderable": false,
            "total_on_hand": 10,
            "is_destroyed": false,
            "stock_items": [
                {
                    "id": 17,
                    "count_on_hand": 10,
                    "stock_location_id": 3,
                    "backorderable": false,
                    "available": true,
                    <b>"stock_location_name": "Los Angeles"</b>
                }
            ]
        }
    ],
    "count": 2,
    "total_count": 7,
    "current_page": 1,
    "pages": 1
}
</code></pre>

Notes:

- Use this response to construct the "Luggage" and "Extras". The `product_type` and the `taxons` can be used to filter the different products.
  - The `taxonomy_name` is the heading of the taxonomy tree (the "root"). The `ancestors` are the taxons or the child branches of the particular taxonomy.
  - For now the taxonomy tree will look like this:

```
      Categories
        - Luggage
          - Luxury
          - Premium
          - Sport
        - Extras
          - Electronics
          - Beauty Products
          - Travel Comfort
```

- The `is_rentable` boolean can be used to determine the transaction type of a given variant. For now, a variant is either rentable or purchasable, but cannot be both.
- If the `zipcode` parameter is not passed, it'll return all variants at all stock locations (which is the default API behavior that Spree provides)

## 3. Finalizing the Cart

### Order Update Endpoint

To update an order (adding line items, changing rental start/end dates, etc) make this request:

    PUT /api/orders/:number.json

<pre class="highlight"><code class="language-javascript">{
  "order": { 
    "line_items": {
      "0": { "id": 26, "quantity": 1 },
      "1": { "variant_id": 6, "quantity": 20 }
    }
  },
  "order_token": "n0kZnXjRfjnhZMY5ijhiOA"
}
</code></pre>

Notes:

- If updating the line_item use the first syntax in the `line_items` hash
- If creating new line_item use the second syntax in the `line_items` hash

When the customer is ready to finalize the cart and proceed to the address/payment section, make this request:

    PUT /api/checkouts/:number/next.json

The order will now be in the `address` state.

### Alternative

You can also merge together the two requests from above into one by passing in an extra `finalize_cart=true` parameter:

    PUT /api/orders/:number.json?finalize_cart=true

### Response

The response will be the same as the one from Step 1. Again, if you pass in a `token` (i.e. the api key not the order token) parameter along with the request, it will associate the order with the user and return the `bill_addresss`, `ship_address`, and `default_credit_card` if those have been previously saved. Use these attributes to prepopulate the user info page for returning customers.

### Failed Response

If you exceed the inventory amount when adding line items to the cart:

<%= headers 422 %>
<pre class="highlight"><code class="language-javascript">{
  "error": "Invalid resource. Please fix errors and try again.",
  "errors": {
    "line_items.quantity": [
      "selected quantity of \"Tumi Alpha 2\" is not available."
    ]
  }
}
</code></pre>

If you make the order update request with the `finalize_cart` parameter (or the checkout next request) but don't supply any line items:

<%= headers 422 %>
<pre class="highlight"><code class="language-javascript">{
  "error": "The order could not be transitioned. Please fix the errors and try again.",
  "errors": {
    "base": [
      "There are no items for this order. Please add an item to the order to continue."
    ]
  }
}
</code></pre>

## 4. Promo Code

### Order Apply Coupon Code Endpoint

To apply a promo code, make this request:

    PUT /api/orders/:number/apply_coupon_code.json

<pre class="highlight"><code class="language-javascript">{
  "order_token": "n0kZnXjRfjnhZMY5ijhiOA",
  "coupon_code": "10OFF"
}
</code></pre>

### Response

<%= headers 200 %>
<pre class="highlight"><code class="language-javascript">{
  "success": "The coupon code was successfully applied to your order.",
  "error": null,
  "successful": true,
  "status_code": "coupon_code_applied"
}
</code></pre>

### Failed Response

<%= headers 422 %>
<pre class="highlight"><code class="language-javascript">{
  "success": null,
  "error": "The coupon code you entered doesn't exist. Please try again.",
  "successful": false,
  "status_code": "coupon_code_not_found"
}
</code></pre>

## 5. Signup and Login

### Signup Endpoint

To register a new user, make this request:

    POST /signup.json

<pre class="highlight"><code class="language-javascript">{
  "spree_user": {
    "email": "spree@example.com",
    "password": "spree123", 
    "password_confirmation": "spree123"
  }
}
</code></pre>

### Response 

<%= headers 200 %>
<pre class="highlight"><code class="language-javascript">{
  "id": 1,
  "email": "spree@example.com",
  "persistence_token": null,
  "perishable_token": null,
  "last_request_at": null,
  "login": "spree@example.com",
  "ship_address_id": null,
  "bill_address_id": null,
  "authentication_token": null,
  "created_at": "2016-03-14T17:33:26.098Z",
  "updated_at": "2016-03-14T17:33:26.123Z",
  "spree_api_key": "fcdb4291a7d699fcc7a2c6e6d8cf11344a16572b751e384e",
  "deleted_at": null
}
</code></pre>

Notes

  - The `spree_api_key` should be stored locally and passed on subsequent api calls with a `token` key. This key will associate the order with the authenticated user on `order#create`, `order#update`, and `checkout#update` calls.

### Signup with Order Endpoint

If the user has already created an order prior to this step, pass in the order parameters along with the signup credentials to associate the order with the newly created user.

<pre class="highlight"><code class="language-javascript">{
  "spree_user": {
    "email": "spree@example.com",
    "password": "spree123", 
    "password_confirmation": "spree123"
  },
  "order_token": "n0kZnXjRfjnhZMY5ijhiOA",
  "id": "R307128032"
}
</code></pre>

### Failed Response

<%= headers 422 %>
<pre class="highlight"><code class="language-javascript">{
  "error": [
    "Email has already been taken"
  ]
}
</code></pre>

### Login Endpoint

To login a user, make this request:

    POST /login.json

<pre class="highlight"><code class="language-javascript">{
  "spree_user": {
    "email": "spree@example.com", 
    "password": "spree123"
  }
}
</code></pre>

### Login with Order Endpoint

Similar to signup, optionally pass in the `order_token` and `id` to link the order with the authenticated user.

### Response

The response will contain the generic user information along with the `ship_address`, `bill_address`, and `default_credit_card` if those have been saved previously. Again, these fields can be used to prepopulate the user info page for returning customers. 

<%= headers 200 %>
<pre class="highlight"><code class="language-javascript">{
  "user": {
    "id": 1,
    "email": "spree@example.com",
    "persistence_token": null,
    "perishable_token": null,
    "last_request_at": null,
    "login": "spree@example.com",
    "ship_address_id": 10,
    "bill_address_id": 9,
    "authentication_token": null,
    "created_at": "2016-03-14T17:33:26.098Z",
    "updated_at": "2016-03-14T17:33:26.123Z",
    "spree_api_key": "fcdb4291a7d699fcc7a2c6e6d8cf11344a16572b751e384e",
    "deleted_at": null
  },
  "ship_address": {
    "id": 1,
    "firstname": "Spree",
    "lastname": "User",
    "address1": "111 Spree Street",
    "address2": "",
    "city": "Spree City",
    "zipcode": "90035",
    "phone": "1111111111",
    "state_name": null,
    "alternative_phone": null,
    "company": null,
    "state_id": 3581,
    "country_id": 232,
    "created_at": "2016-03-10T23:23:54.042Z",
    "updated_at": "2016-03-11T00:01:14.294Z"
  },
  "bill_address": {
    "id": 2,
    "firstname": "Spree",
    "lastname": "User",
    "address1": "111 Spree Street",
    "address2": "",
    "city": "Spree City",
    "zipcode": "90035",
    "phone": "1111111111",
    "state_name": null,
    "alternative_phone": null,
    "company": null,
    "state_id": 3581,
    "country_id": 232,
    "created_at": "2016-03-10T23:23:54.009Z",
    "updated_at": "2016-03-11T00:01:14.268Z"
  },
  "default_credit_card": {
    "id": 69,
    "month": 1,
    "year": 2017,
    "cc_type": null,
    "last_digits": "1",
    "address_id": null,
    "gateway_customer_profile_id": "BGS-302334",
    "gateway_payment_profile_id": null,
    "created_at": "2016-03-15T18:31:40.311Z",
    "updated_at": "2016-03-15T18:32:00.431Z",
    "name": "John Smith",
    "user_id": 1,
    "payment_method_id": 1,
    "default": true
  }
}
</code></pre>

### Failed Response

<%= headers 422 %>
<pre class="highlight"><code class="language-javascript">{
  "error": "Invalid email or password."
}
</code></pre>

## 6. Address / Payment Page

### Checkouts Update Endpoint

To submit the shipping, billing, and payment info, make this request:

    PUT /api/checkouts/:number.json

<%= json \
  :order_token => "n0kZnXjRfjnhZMY5ijhiOA",
  :order => {
    :bill_address_attributes => {
      :firstname  => 'John',
      :lastname   => 'Doe',
      :address1   => '7735 Old Georgetown Road',
      :city       => 'Bethesda',
      :phone      => '3014445002',
      :zipcode    => '20814',
      :state_id   => 48,
      :country_id => 49
    },
    :ship_address_attributes => {
      :firstname  => 'John',
      :lastname   => 'Doe',
      :address1   => '7735 Old Georgetown Road',
      :city       => 'Bethesda',
      :phone      => '3014445002',
      :zipcode    => '20814',
      :state_id   => 48,
      :country_id => 49
    },
    :payments_attributes => [{
      :payment_method_id => "1"
    }]
  },

  :payment_source => {
    "1" => {
      number: "1",
      month: "1",
      year: "2017",
      verification_value: "123",
      name: "John Smith"
    }
  }
%>

Notes:

- The `state_id` and `country_id` are the primary keys of the `spree_state` and `spree_country` models, respectively
- The numbered key in the `payment_source` hash directly corresponds to the
`payment_method_id` attribute within the `payment_attributes` key

### Use Shipping Address for Billing and Saving Addresses

- If customer chooses to "Use Shipping Address" for billing, pass in `"use_shipping": "1"`. 
- If customer chooses to save the billing and shipping addresses upon checkout, pass in `"save_user_address": "1"`
  - We probably want to make this the default behavior
- The request body enabling these two features will look like this:

<pre class="highlight"><code class="language-javascript">{
  "order_token": "n0kZnXjRfjnhZMY5ijhiOA",
  <b>"save_user_address": "1",</b>
  "order": {
    "ship_address_attributes": {
      "firstname": "John",
      "lastname": "Doe",
      "address1": "7735 Old Georgetown Road",
      "city": "Bethesda",
      "phone": "3014445002",
      "zipcode": "20814",
      "state_id": 48,
      "country_id": 49
    },
    <b>use_shipping: "1"</b>
  }
}
</code></pre>

### Returning Customers

If the user is a returning customer (i.e. has a prior purchase), we want to auto-populate the address and payment fields. As noted in the steps above, these will be accessible in the json response after user login or after cart finalization (if the user has authenticated prior to this step).

If the customer chooses to use the credit card stored in the vault for the next purchase, instead of submitting `payment_attributes` and `payment_source`, submit an `existing_card` parameter with the credit card id. Below is an example request:

<%= json \
  :order => {
    :existing_card => "1"
  }
%>

### Response

<%= headers 200 %>

The response will be the same as the ones from Steps 1 and 3, but will now contain all required fields and the `state` will be `confirm`.

### Failed Response

If the credit card is invalid, the transition will fail, resulting in an error response like this:

<%= headers 422 %>
<pre class="highlight"><code class="language-javascript">{
  "error": "Invalid resource. Please fix errors and try again.",
  "errors": {
    "base": [
      "Your card was declined."
    ]
  }
}
</code></pre>

## 7. Confirmation Page

__NOTE: If we don't have a "confirmation" page ignore this step. The `confirm` step will be bypassed and transition directly to `complete`.__

Now the order is ready to be advanced to the final state, `complete`. To accomplish this, make this request:

    PUT /api/checkouts/:number/next.json

You should get a 200 response with all the order info.

## 8. User Account Page

### Order Mine Endpoint

Retrieve a list of the current user's orders, sorted reverse chronologically (i.e. newest orders first), by making this request where `token` is the `spree_api_key` that is returned following a signup / login call:

    GET /api/orders/mine?token=6303a093e4dd91936ad2c95d4de8a2a160d8e339c5b075b9

Orders are paginated and can be iterated through by passing along a `page` parameter:

    GET /api/orders/mine?page=2

By default, this endpoint only returns orders that have been marked complete - i.e. having a `completed_at` timestamp.

### Parameters

page
: The page number of orders to display.

per_page
: The number of shipments to return per page.

show_incomplete
: Default `false`. Send `true` to show every order associated with the user.

### Response

<%= headers 200 %>
<%= json(:order) do |o|
{ count: 25,
  current_page: 1,
  pages: 5,
  orders: [o] }
end %>

### Failed Response

If user is not authenticated:

<%= headers 401 %>
<%= json \
  :error => "Invalid API key specified."
%>

## 9. User Account Page Cont'd - Update Default Billing / Shipping Addresses

To update the default billing and shipping addresses for a given user:

    PUT /api/users/:user_id.json?token=6303a093e4dd91936ad2c95d4de8a2a160d8e339c5b075b9

<pre class="highlight"><code class="language-javascript">{
  "user": {
    "bill_address_attributes": {
      "firstname": "New First Name",
      "lastname": "New Last Name",
      "address1": "New Address 1",
      "city": "New City",
      "phone": "3014445002",
      "zipcode": "20814",
      "state_id": 3529,
      "country_id": 232
    },
    "ship_address_attributes": {
      "firstname": "New First Name",
      "lastname": "New Last Name",
      "address1": "New Address 1",
      "city": "New City",
      "phone": "3014445002",
      "zipcode": "20814",
      "state_id": 3529,
      "country_id": 232
    }
  }
}
</code></pre>

Note:

- The `user_id` in the url is the `id` that gets returned after user login / signup.
- The `token` is the `spree_api_token` that gets returned after user login / signup.

### Response

<%= headers 200 %>

<pre class="highlight"><code class="language-javascript">{
  "id": 5,
  "email": "hello@gmail.com",
  "created_at": "2016-03-31T18:36:28.247-07:00",
  "updated_at": "2016-04-15T17:21:21.026-07:00",
  "bill_address": {
    "id": 49,
    "firstname": "New First Name",
    "lastname": "New Last Name",
    "full_name": "New First Name New Last Name",
    "address1": "New Address 1",
    "address2": null,
    "city": "New City",
    "zipcode": "20814",
    "phone": "3014445002",
    "company": null,
    "alternative_phone": null,
    "country_id": 232,
    "state_id": 3529,
    "state_name": null,
    "state_text": "CA",
    "country": {
      "id": 232,
      "iso_name": "UNITED STATES",
      "iso": "US",
      "iso3": "USA",
      "name": "United States",
      "numcode": 840
    },
    "state": {
      "id": 3529,
      "name": "California",
      "abbr": "CA",
      "country_id": 232
    }
  },
  "ship_address": {
    "id": 48,
    "firstname": "New First Name",
    "lastname": "New Last Name",
    "full_name": "New First Name New Last Name",
    "address1": "New Address 1",
    "address2": null,
    "city": "New City",
    "zipcode": "20814",
    "phone": "3014445002",
    "company": null,
    "alternative_phone": null,
    "country_id": 232,
    "state_id": 3529,
    "state_name": null,
    "state_text": "CA",
    "country": {
      "id": 232,
      "iso_name": "UNITED STATES",
      "iso": "US",
      "iso3": "USA",
      "name": "United States",
      "numcode": 840
    },
    "state": {
      "id": 3529,
      "name": "California",
      "abbr": "CA",
      "country_id": 232
    }
  }
}
</code></pre>

### Failed Response

If the user corresponding to the `token` does not match the user given by the `user_id`, the system will throw the following error:

<%= headers 404 %>
<%= json \
  error: "The resource you were looking for could not be found."
%>

## 10. Return Request

### Order Request Endpoint

When the customer is ready to return their luggage, make this request:

    PUT /api/orders/:number/return.json

<%= json \
  :order_token => "n0kZnXjRfjnhZMY5ijhiOA"
%>

### Response

If the `shipment` is returnable - i.e. the `state` is `order_delivered` or `order_in_transit` / `shipped`

<%= headers 200 %>

The response will be the same as the ones from Steps 1 and 3, but the `shipment_state` will now be `return_pending`:

### Failed Response

If the `shipment` is not returnable - i.e. it doesn't exist or if the `state` is not `order_delivered` or `order_in_transit` / `shipped`, the response will be something like this:

<%= headers 422 %>

<%= json \
  :error => "Cannot transition state via :return from :pending (Reason(s): State cannot transition via \"return\")"
%>

## 11. Contact Concierge Endpoint

Customers can submit their email and a message to the contacts endpoint:

    POST /api/contact

<%= json \
  :email => "some@email.com",
  :message => "This is a message"
%>

### Response
<%= headers 200 %>
    
