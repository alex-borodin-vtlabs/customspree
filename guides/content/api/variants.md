---
title: Variants
description: Use the Spree Commerce storefront API to access Variant data.
---

## Index

To return a paginated list of all variants within the store, make this request:

```text
GET /api/variants```

You can limit this to showing the variants for a particular product by passing through a product's permalink:

```text
GET /api/products/ruby-on-rails-tote/variants```

or

```text
GET /api/variants?product_id=ruby-on-rails-tote```


__You can also limit this to showing the variants for a particular stock location by passing through a `zipcode` parameter. Please note that out-of-stock variants will not be returned if you specify a `zipcode`.__

```text
GET /api/variants?zipcode=90025```

__The value of this parameter (in this case "90025") maps to the `zipcode` attribute on `serviceable_zipcode`, which is a custom table that has a M:1 association with `stock_location` (i.e. stock location *has many* serviceable zipcodes).__


### Parameters

show_deleted
: **boolean** - `true` to show deleted variants, `false` to hide them. Default: `false`. Only available to users with an admin role.

page
: The page number of variants to display.

per_page
: The number of variants to return per page

__zipcode__
: __The order `zipcode`. If this parameter is used, it'll only return *in-stock* variants at a particular stock location__

### Response

<%= headers 200 %>

<pre class="highlight"><code class="language-javascript">
{
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
            <b>"product_type": "Electronics",</b>
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

## Search

To search for a particular variant, make a request like this:

```text
GET /api/variants?q[sku_cont]=foo```

You can limit this to showing the variants for a particular product by passing through a product id:

```text
GET /api/products/ruby-on-rails-tote/variants?q[sku_cont]=foo```

or

```text
GET /api/variants?product_id=ruby-on-rails-tote&q[sku_cont]=foo```


The searching API is provided through the Ransack gem which Spree depends on. The `sku_cont` here is called a predicate, and you can learn more about them by reading about [Predicates on the Ransack wiki](https://github.com/ernie/ransack/wiki/Basic-Searching).

The search results are paginated.

### Response

<%= headers 200 %>
<%= json(:variant) do |h|
 { :variants => [h],
   :count => 25,
   :pages => 5,
   :current_page => 1 }
end %>

### Sorting results

Results can be returned in a specific order by specifying which field to sort by when making a request.

```text
GET /api/variants?q[s]=price%20asc```

It is also possible to sort results using an associated object's field.

```text
GET /api/variants?q[s]=product_name%20asc```

## Show

To view the details for a single variant, make a request using that variant\'s id, along with the product's permalink as its `product_id`:

```text
GET /api/products/ruby-on-rails-tote/variants/1```

Or:

```text
GET /api/variants/1?product_id=ruby-on-rails-tote```

### Successful Response

<%= headers 200 %>
<%= json :variant %>

### Not Found Response

<%= not_found %>

## New

You can learn about the potential attributes (required and non-required) for a variant by making this request:

```text
GET /api/products/ruby-on-rails-tote/variants/new```

### Response

<%= headers 200 %>
<%= json \
  :attributes => [
    :id, :name, :count_on_hand, :sku, :price, :weight, :height,
    :width, :depth, :is_master, :cost_price, :permalink
  ],
  :required_attributes => []
 %>

## Create

<%= admin_only %>

To create a new variant for a product, make this request with the necessary parameters:

```text
POST /api/products/ruby-on-rails-tote/variants```

For instance, a request to create a new variant with a SKU of 12345 and a price of 19.99 would look like this::

```text
POST /api/products/ruby-on-rails-tote/variants/?variant[sku]=12345&variant[price]=19.99```

### Successful response

<%= headers 201 %>

### Failed response

<%= headers 422 %>
<%= json \
  :error => "Invalid resource. Please fix errors and try again.",
  :errors => {
  }
%>

## Update

<%= admin_only %>

To update a variant\'s details, make this request with the necessary parameters:

```text
PUT /api/products/ruby-on-rails-tote/variants/2```

For instance, to update a variant\'s SKU, send it through like this:

```text
PUT /api/products/ruby-on-rails-tote/variants/2?variant[sku]=12345```

### Successful response

<%= headers 201 %>

### Failed response

<%= headers 422 %>
<%= json \
  :error => "Invalid resource. Please fix errors and try again.",
  :errors => {
  }
%>

## Delete

<%= admin_only %>

To delete a variant, make this request:

```text
DELETE /api/products/ruby-on-rails-tote/variants/2```

This request, much like a typical variant \"deletion\" through the admin interface, will not actually remove the record from the database. It simply sets the `deleted_at` field to the current time on the variant.

<%= headers 204 %>

