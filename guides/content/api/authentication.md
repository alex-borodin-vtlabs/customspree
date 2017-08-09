---
title: Authentication
description: Use the Spree Commerce storefront API to authenticate users
---

# Authentication API

## Introduction

The authentication API uses the routes exposed in the `spree_auth_devise` to signup, login, and logout users.

## Registration

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
  - The `spree_api_key` should be stored locally and passed in subsequent api calls. This key will associate the order with the authenticated user on `order#create`, `order#update`, and `checkout#update` calls.

### Failed Response

<%= headers 422 %>
<pre class="highlight"><code class="language-javascript">{
  "error": [
    "Email has already been taken"
  ]
}
</code></pre>

## Login

To login a user, make this request:

    POST /login.json

<pre class="highlight"><code class="language-javascript">{
  "spree_user": {
    "email": "spree@example.com", 
    "password": "spree123"
  }
}
</code></pre>

### Response

The response will contain the generic user information along with the shipping, billing, and default credit card if those have been saved previously. 

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
</code></pre>

### Failed Response

<%= headers 422 %>
<pre class="highlight"><code class="language-javascript">{
  "error": "Invalid email or password."
}
</code></pre>

## Logout

To logout a user, make this request:

    GET /logout

### Response

<%= headers 204 %>

