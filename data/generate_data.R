# generate_data.R
# Creates the synthetic retail orders dataset used by scripts/sales_summary.R.
# Synthetic data only (course privacy rule) -- no real business records.

set.seed(42)

n <- 60
categories <- c("Coffee", "Tea", "Pastries", "Merchandise")
regions <- c("East", "West", "North", "South")

dates <- seq(as.Date("2026-09-01"), as.Date("2026-09-30"), by = "day")

orders <- data.frame(
  order_id   = sprintf("ORD-%04d", 1:n),
  order_date = sample(dates, n, replace = TRUE),
  category   = sample(categories, n, replace = TRUE, prob = c(0.45, 0.2, 0.25, 0.1)),
  quantity   = sample(1:5, n, replace = TRUE),
  unit_price = NA_real_,
  region     = sample(regions, n, replace = TRUE)
)

price_lookup <- c(Coffee = 4.25, Tea = 3.75, Pastries = 3.25, Merchandise = 14.00)
orders$unit_price <- round(price_lookup[orders$category] + runif(n, -0.25, 0.25), 2)

orders <- orders[order(orders$order_date), ]
write.csv(orders, "data/retail_orders.csv", row.names = FALSE)
cat("Wrote data/retail_orders.csv with", nrow(orders), "rows\n")
