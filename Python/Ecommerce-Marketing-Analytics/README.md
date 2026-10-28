# E-Commerce Marketing Analytics (Python Capstone)

End-to-end analysis of an online marketplace: about 98,000 orders from 95,000 customers across 8 related tables (Sep 2016 to Sep 2018). The goal is to understand customer, seller, product and payment behaviour, and to turn the findings into business recommendations.

**Author:** Amal Shesnij | **Tools:** Python, pandas, NumPy, Matplotlib | **Notebook:** [`Ecommerce_Analysis.ipynb`](Ecommerce_Analysis.ipynb)

## Business problem
A leading online marketplace wants to measure and understand its business performance: how customers are acquired and retained, what sells where and when, which sellers and customers matter most, how people pay, and what drives customer satisfaction.

## Data
| Table | Rows | One row = |
|---|---|---|
| Customers | 99,441 | a customer ID per order |
| Orders | 99,441 | an order |
| Order_Items | 112,650 | a product line in an order |
| Order_Payments | 103,886 | a payment (orders can be split) |
| Order_Review_Ratings | 100,000 | a review |
| Products | 32,951 | a product |
| Sellers | 3,095 | a seller |
| Geo_Location | 19,015 | a zip code location |

## Approach
1. **Checked the grain of each table.** One order can have several items (9,803 orders) and several payments (2,961), so payments were totalled per order **before** joining, to avoid double-counting revenue.
2. **Identified real customers.** `customer_id` is created per order; `customer_unique_id` identifies the person (96,096 people). All customer analysis uses `customer_unique_id`.
3. **Cleaned the data.** Converted dates, filled 623 missing product categories as "Unknown", and excluded 1,234 canceled or unavailable orders from revenue.
4. **Validated totals.** Revenue per order summed back exactly to total payments (15,739,137.01), confirming no duplication.
5. **Answered 5 business areas:** exploratory analysis, segmentation, cross-selling, payment behaviour and customer satisfaction.

## Key findings
| Area | Finding |
|---|---|
| Scale | 98,207 valid orders, 94,990 customers, 13.49M product revenue, 15.74M total payments |
| Growth | Revenue grew through 2017, peaked in Nov 2017 (Black Friday, 1.0M), then levelled off at 0.85–1.0M a month |
| Retention | Only **3.04%** of customers ordered more than once; existing customers bring in just 2–3% of monthly revenue |
| Geography | Andhra Pradesh accounts for about **59%** of revenue, 8 times the next state |
| Categories | Health_Beauty leads revenue; Bed_Bath_Table leads volume and is the top category in most states |
| Timing | Sales peak on Mondays and around 2 PM; weekends are lowest |
| Segmentation | Top 25% of customers bring in 59% of revenue; top 25% of sellers bring in **87%** of sales |
| Cross-selling | Only about 3% of orders contain more than one product; home categories are most often bought together |
| Payments | Credit cards make up 78.5% of payment value; about 67% of card payments use instalments |
| Satisfaction | Average rating 4.1; **late deliveries (8.1% of orders) score 2.55 against 4.28** for on-time orders |

## Recommendations
- **Fix delivery reliability first.** Late orders are rated about 1.7 stars lower, which likely contributes to the low repeat rate.
- **Build retention:** second-order discounts, follow-up emails and loyalty offers for the top 25% of customers.
- **Grow outside Andhra Pradesh** to reduce dependence on one state.
- **Add "frequently bought together" bundles** for home and baby categories.
- **Protect top sellers** with dedicated support, and review sellers rated below 3.
- **Offer no-cost instalments** on high-price categories.

## Assumptions and limitations
- Canceled and unavailable orders are excluded from revenue.
- Products have no names in the data, so they are shown by ID and category.
- Ratings are averaged per order; categories need at least 30 reviews, products 20 and sellers 50.
- The late-delivery link to retention is a pattern in the data, not a proven cause.

## How to run
```bash
pip install pandas numpy matplotlib jupyter
jupyter notebook Ecommerce_Analysis.ipynb
```
The dataset and case brief belong to AnalytixLabs and are not included in this repository. Place the 8 CSV files in the same folder as the notebook to run it.

---
*Capstone project from the AnalytixLabs Python for Data Science programme.*
