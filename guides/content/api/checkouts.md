---
title: Checkouts
description: Use the Spree Commerce storefront API to access Checkout data.
---

# Checkouts API

## Introduction

The checkout API functionality can be used to advance an existing order's state. Sending a `PUT` request to `/api/checkouts/:number` will advance an order's state or, failing that, report any errors.

The following sections will walk through creating a new order and advancing an order from its `cart` state to its `complete` state.

## Creating a blank order

To create a new, empty order, make this request:

    POST /api/orders.json

<pre class="highlight"><code class="language-javascript">{
  "order": {
    <b>"rental_start_date" "2015-02-03",</b>
    <b>"rental_end_date": "2015-02-06",</b>
    <b>"zipcode": "90025",</b>
    "line_items": [
      { "variant_id": 1, "quantity": 5 }
    ]
  }
}
</code></pre>

If you wish to create an order with a line item matching to a variant whose ID is \"1\" and quantity is 5, pass in the extra `line_items` parameter. __ADDITION: The `zipcode` will map to the `zipcode` attribute on `serviceable_zipcode`, which is a custom table that has a M:1 association with `stock_location` (i.e. stock location *has many* serviceable zipcodes).

### Response

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
  <b>"rental_start_date": "2015-02-03T00:00:00.000-08:00",</b>
  <b>"rental_end_date": "2015-02-06T00:00:00.000-08:00",</b>
  <b>"zipcode": "90025",</b>
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

Any time you update the order or move a checkout step you'll get
a response similar as above along with the new associated objects. e.g. addresses,
payments, shipments.

## Add line items to an order

__ADDITION: We probably won't be using this endpoint. Instead we can just use the Order Update endpoint and shove all the line items in one API call.__

Pass line item attributes like this.

<pre class="highlight"><code class="language-javascript">{
  "line_item": { "variant_id": 1, "quantity": 5},
  "order_token": "n0kZnXjRfjnhZMY5ijhiOA"
}
</code></pre>

to this api endpoint:

    POST /api/orders/:number/line_items.json

<%= headers 201 %>
<pre class="highlight"><code class="language-javascript">{
  "id": 3,
  "quantity": 5,
  "price": "15.99",
  "variant_id": 1,
  "single_display_amount": "$15.99",
  "display_amount": "$79.95",
  "total": "79.95",
  "variant": {
    "id": 1,
    "name": "Ruby on Rails Tote",
    "sku": "ROR-00011",
    <b>"product_type": "Luggage",</b>
    <b>"is_rentable": true,</b>
    "price": "15.99",
    "weight": "0.0",
    "height": null,
    "width": null,
    "depth": null,
    "is_master": true,
    "cost_price": "17.0",
    "slug": "ruby-on-rails-tote",
    "description": "Nihil et itaque adipisci sed ea dolorum.",
    "track_inventory": true,
    "display_price": "$15.99",
    "options_text": "",
    "in_stock": true,
    "option_values": [],
    "images": [
      {
        "id": 21,
        "position": 1,
        "attachment_content_type": "image/jpeg",
        "attachment_file_name": "ror_tote.jpeg",
        "type": "Spree::Image",
        "attachment_updated_at": "2014-07-06T18:37:34.534Z",
        "attachment_width": 360,
        "attachment_height": 360,
        "alt": null,
        "viewable_type": "Spree::Variant",
        "viewable_id": 1,
        "mini_url": "/spree/products/21/mini/ror_tote.jpeg?1404671854",
        "small_url": "/spree/products/21/small/ror_tote.jpeg?1404671854",
        "product_url": "/spree/products/21/product/ror_tote.jpeg?1404671854",
        "large_url": "/spree/products/21/large/ror_tote.jpeg?1404671854"
      },
      {
        "id": 22,
        "position": 2,
        "attachment_content_type": "image/jpeg",
        "attachment_file_name": "ror_tote_back.jpeg",
        "type": "Spree::Image",
        "attachment_updated_at": "2014-07-06T18:37:34.921Z",
        "attachment_width": 360,
        "attachment_height": 360,
        "alt": null,
        "viewable_type": "Spree::Variant",
        "viewable_id": 1,
        "mini_url": "/spree/products/22/mini/ror_tote_back.jpeg?1404671854",
        "small_url": "/spree/products/22/small/ror_tote_back.jpeg?1404671854",
        "product_url": "/spree/products/22/product/ror_tote_back.jpeg?1404671854",
        "large_url": "/spree/products/22/large/ror_tote_back.jpeg?1404671854"
      }
    ],
    "product_id": 1
  },
  "adjustments": []
}
</code></pre>

## Updating an order

To update an order you must be authenticated as the order's user, and perform a request like this:

    PUT /api/orders/:number.json

__ADDITION: The request body will look something like this:__

<pre class="highlight"><code class="language-javascript">{
  "order": { 
    "line_items": {
      "0": { "id": 26, "quantity": 1 },
      "1": { "variant_id": 6, "quantity": 20 }
    },
    "rental_start_date": "2015-01-03T21:05:51.309Z",
    "rental_end_date": "2015-02-06T21:05:51.309Z"
  },
  "order_token": "n0kZnXjRfjnhZMY5ijhiOA"
}
</code></pre>

__Notes: (Some Quirky Spree Syntax)__

  - __if updating the line_item use the first syntax in the `line_items` hash__
  - __if creating new line_item use the second syntax in the `line_items` hash__


## Address

To transition an order to its next step, make a request like this:

    PUT /api/checkouts/:number/next.json

If the request is successfull you'll get a 200 response using the same order
template shown when creating the order with the state updated. __At this point, if the cart has at least one line item, the `state` key should now read `address`__. See example of failed response below.

### Failed Response

<%= headers 422 %>
<%= json(:order_failed_transition) %>

## Delivery

__ADDITION: This request will probably be consolidated with the payment request. See below for more details.__

To advance to the next state, `delivery`, the order will first need both a shipping and billing address.

In order to update the addresses, make this request with the necessary parameters:

    PUT /api/checkouts/:number.json

As an example, here are the required address attributes and how they should be formatted.

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
    }
  }
%>

__Notes:__

  - __The `state_id` and `country_id` are the primary keys of the `spree_state` and `spree_country` models, respectively__
  - __Additional Customizations__
    - __If customer chooses to "Use Shipping Address" for billing, pass in `"use_shipping": "1"`__
    - __If customer chooses to save the billing and shipping addresses (so that we can prepopulate these fields when they return to the site), pass in `"save_user_address": "1"`__
      - __We probably want to make this the default behavior__
    - __The request body enabling these two features will look like this:__


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

### Response

Once valid address information has been submitted, the shipments and shipping rates
available for this order will be returned inside a `shipments` key inside the order,
as seen below:

<%= headers 200 %>
<pre class="highlight"><code class="language-javascript">{
  ...
  "shipments": [
    {
      "id": 4,
      "tracking": null,
      "number": "H22035832422",
      "cost": "15.0",
      "shipped_at": null,
      "state": "pending",
      "order_id": "R181010551",
      "stock_location_name": "default",
      "shipping_rates": [
        {
          "id": 10,
          "name": "UPS Ground (USD)",
          "cost": "5.0",
          "selected": false,
          "shipping_method_id": 1,
          "display_cost": "$5.00"
        },
        {
          "id": 11,
          "name": "UPS Two Day (USD)",
          "cost": "10.0",
          "selected": false,
          "shipping_method_id": 2,
          "display_cost": "$10.00"
        },
        {
          "id": 12,
          "name": "UPS One Day (USD)",
          "cost": "15.0",
          "selected": true,
          "shipping_method_id": 3,
          "display_cost": "$15.00"
        }
      ],
      "selected_shipping_rate": {
        "id": 12,
        "name": "UPS One Day (USD)",
        "cost": "15.0",
        "selected": true,
        "shipping_method_id": 3,
        "display_cost": "$15.00"
      },
      "shipping_methods": [
        {
          "id": 1,
          "name": "UPS Ground (USD)",
          "zones": [
            {
              "id": 2,
              "name": "North America",
              "description": "USA + Canada"
            }
          ],
          "shipping_categories": [
            {
              "id": 1,
              "name": "Default"
            }
          ]
        },
        {
          "id": 2,
          "name": "UPS Two Day (USD)",
          "zones": [
            {
              "id": 2,
              "name": "North America",
              "description": "USA + Canada"
            }
          ],
          "shipping_categories": [
            {
              "id": 1,
              "name": "Default"
            }
          ]
        },
        {
          "id": 3,
          "name": "UPS One Day (USD)",
          "zones": [
            {
              "id": 2,
              "name": "North America",
              "description": "USA + Canada"
            }
          ],
          "shipping_categories": [
            {
              "id": 1,
              "name": "Default"
            }
          ]
        }
      ],
      "manifest": [
        {
          "quantity": 3,
          "states": {
            "on_hand": 3
          },
          "variant_id": 1
        }
      ]
    }
  ],
  ...
</code></pre>

## Payment

__ADDITION: This step can be skipped because we only have one shipping method. Therefore, when billing and shpping addresses are submitted, the `state` will automatically transition from `address` to `payment`, bypassing the `delivery` step.__

To advance to the next state, `payment`, you will need to select a shipping rate
for each shipment for the order. These were returned when transitioning to the
`delivery` step. If you need want to see them again, make the following request:

    GET /api/orders/:number.json

Spree will select a shipping rate by default so you can advance to the `payment`
state by making this request:

    PUT /api/checkouts/:number/next.json

If the order doesn't have an assigned shipping rate, or you want to choose a different
shipping rate make the following request to select one and advance the order's state:

    PUT /api/checkouts/:number.json

With parameters such as these:

<%= json (
  {
    order: {
      shipments_attributes: {
        "0" => {
          selected_shipping_rate_id: 1,
          id: 1
        }
      }
    }
  }) %>

***
Please ensure you select a shipping rate for each shipment in the order. In the request
above, the `selected_shipping_rate_id` should be the id of the shipping rate you want to
use and the `id` should be the id of the shipment you are choosing this shipping rate for.
***

## Confirm

__ADDITION: If you pass in the payment information along with the addresses, the `state` will automatically transition to `confirm` - i.e. the `delivery` and `payment` states will be bypassed. So ideally in our integration, the state will go straight from `address` to `confirm` with the request below.__

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

==================================================

To advance to the next state, `confirm`, the order will need to have a payment.
You can create a payment by passing in parameters such as this:

<%= json \
  :order => {
    :payments_attributes => [{
      :payment_method_id => "1"
    }]
  },
  :payment_source => {
    "1" => {
      "number" => "4111111111111111",
      "month" => "1",
      "year" => "2017",
      "verification_value" => "123",
      "name" => "John Smith"
    }
  }
%>

***
The numbered key in the `payment_source` hash directly corresponds to the
`payment_method_id` attribute within the `payment_attributes` key.
***

You can also use an existing card for the order by submitting the credit card
id. See an example request:

<%= json \
  :order => {
    :existing_card => "1"
  }
%>

_Please note that for 2-2-stable checkout api the request body to submit a payment
via api/checkouts is slight different. See example:_

<%= json \
  :order => {
    :payments_attributes => {
      :payment_method_id => "1"
    },
    :payment_source => {
      "1" => {
        "number" => "4111111111111111",
        "month" => "1",
        "year" => "2017",
        "verification_value" => "123",
        "name" => "John Smith"
      }
    }
  }
%>

If the order already has a payment, you can advance it to the `confirm` state by making this request:

    PUT /api/checkouts/:number.json

For more information on payments, view the [payments documentation](payments).

### Response

<%= headers 200 %>
<pre class="highlight"><code class="language-javascript">{
  ...
  "state": "confirm",
  ...
  "payments": [
    {
      "id": 3,
      "source_type": "Spree::CreditCard",
      "source_id": 2,
      "amount": "65.37",
      "display_amount": "$65.37",
      "payment_method_id": 1,
      "response_code": null,
      "state": "checkout",
      "avs_response": null,
      "created_at": "2014-07-06T19:55:08.308Z",
      "updated_at": "2014-07-06T19:55:08.308Z",
      "payment_method": {
        "id": 1,
        "name": "Credit Card"
      },
      "source": {
        "id": 2,
        "month": "1",
        "year": "2017",
        "cc_type": null,
        "last_digits": "1111",
        "name": "John Smith"
      }
    }
  ],
  ...
</code></pre>

## Complete

Now the order is ready to be advanced to the final state, `complete`. To accomplish this, make this request:

    PUT /api/checkouts/:number/next.json

You should get a 200 response with all the order info.
