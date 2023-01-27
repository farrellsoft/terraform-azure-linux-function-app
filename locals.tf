locals {
  app_names_map = {
    for k, v in var.function_apps : k =>
      "func-${v["application"]}${v["purpose"] == "" ? "" : "-${v["purpose"]}"}-${v["environment"]}-${module.regioncodes.region_codes[lower(replace(v["location"], " ", ""))]}${v["instance"] == "" ? "" : "-${v["instance"]}"}"
  }
}