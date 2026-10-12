# sales_summary.R
#
# Purpose: Summarize a month of synthetic retail orders -- total revenue,
# revenue by product category, and revenue by region -- and save both a
# summary table (CSV) and a bar chart (PNG) to the output/ folder.
#
# Input:  data/retail_orders.csv
#         Columns: order_id, order_date, category, quantity, unit_price, region
# Output: output/category_summary.csv
#         output/revenue_by_category.png
#
# Dependencies: base R only (no external packages required).

orders <- read.csv("data/retail_orders.csv", stringsAsFactors = FALSE)
orders$order_date <- as.Date(orders$order_date)
orders$line_total <- orders$quantity * orders$unit_price

total_revenue <- sum(orders$line_total)
cat(sprintf("Total revenue (Sept 2026): $%.2f across %d orders\n",
            total_revenue, nrow(orders)))

# Revenue and order count by category
category_summary <- aggregate(
  line_total ~ category, data = orders,
  FUN = function(x) c(revenue = sum(x), orders = length(x), avg_order = mean(x))
)
category_summary <- do.call(data.frame, category_summary)
names(category_summary) <- c("category", "revenue", "orders", "avg_order_value")
category_summary$revenue <- round(category_summary$revenue, 2)
category_summary$avg_order_value <- round(category_summary$avg_order_value, 2)
category_summary <- category_summary[order(-category_summary$revenue), ]

cat("\nRevenue by category:\n")
print(category_summary, row.names = FALSE)

top_category <- category_summary$category[1]
cat(sprintf("\nTop-performing category: %s ($%.2f)\n",
            top_category, category_summary$revenue[1]))

write.csv(category_summary, "output/category_summary.csv", row.names = FALSE)

png("output/revenue_by_category.png", width = 800, height = 500, res = 120)
bp <- barplot(
  category_summary$revenue,
  names.arg = category_summary$category,
  col = "#1F4E78", border = NA,
  main = "September 2026 Revenue by Category",
  ylab = "Revenue ($)",
  ylim = c(0, max(category_summary$revenue) * 1.15)
)
text(bp, category_summary$revenue,
     labels = sprintf("$%.0f", category_summary$revenue),
     pos = 3, cex = 0.9)
dev.off()

cat("\nSaved output/category_summary.csv and output/revenue_by_category.png\n")
