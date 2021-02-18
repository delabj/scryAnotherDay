scryfallR: R Interface to the Scryfall API
================
Joshua de la Bruere

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.com/delabj/scryAnotherDay.svg?branch=master)](https://travis-ci.com/delabj/scryAnotherDay)
[![R-CMD-check](https://github.com/delabj/scryAnotherDay/workflows/R-CMD-check/badge.svg)](https://github.com/delabj/scryAnotherDay/actions)
<!-- badges: end -->

{scryfalleR} (name likely to change) is an R package that wraps the
[scryfall API](https://scryfall.com/docs/api/cards/mtgo). Scryfall is
the leading 3rd party database for finding Magic the Gathering card
data, such as printings, prices, previews, and rulings.

## Installing The Package

{scryAnotherDay} is currently in development and is very experimental.
You can install this alpha version using devtools or remotes from this
repository.

``` r
devtools::install_github("delabj/scryAnotherDay")
remotes::install_github("delabj/scryAnotherDay")
```

This package is very much in the alpha stages, the API may change and
breaking changes could be introduced. This package is not maintained nor
endorsed by scryfall.com, but is build according to the rules provided
in their licence.

## Rate Limits & Good Citizenship

In general Scryfall asks that you make no more than 10 requests per
second, in addition they reccomend that you chache the data from
scryfall once every 25 hours, in general though small updates are made
per day, prices are only updated every 24 hours, and gameplay
information like card names, Oracle text, and mana costs, are made on a
significantly less frequent basis. If only looking at elements that are
unlikely to update, it is encouraged that you process the data locally
in your own database, and update far less frequently.

## Use of Scryfall data

Taken from the Scryfall docs:

> As part of the [Wizards of the Coast Fan Content
> Policy](https://company.wizards.com/fancontentpolicy), Scryfall
> provides our card data and image database free of charge for the
> primary purpose of creating additional Magic software, performing
> research, or creating community content (such as videos, set reviews,
> etc) about Magic and related products.

> When using Scryfall data, you must adhere to the following guidelines:

>   - You may not use Scryfall logos or use the Scryfall name in a way
>     that implies Scryfall has endorsed you, your work, or your
>     product.
>   - You may not require anyone to make payments, take surveys, agree
>     to subscriptions, rate your content, or create accounts in
>     exchange for access to Scryfall data.
>   - You may not use Scryfall data to create new games, or to imply the
>     information and images are from any other game besides Magic: The
>     Gathering.
>   - If you wish to use card images, please also review our [image
>     guidelines](https://scryfall.com/docs/api/images).
