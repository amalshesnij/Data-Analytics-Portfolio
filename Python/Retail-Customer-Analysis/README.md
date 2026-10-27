# Customer Analysis for Retail (Python)

Analysis of about 23,000 retail transactions from 5,500 customers over 37 months (Jan 2011 to Feb 2014). The goal is to understand who buys what, through which channel, and how returns affect revenue.

**Author:** Amal Shesnij | **Tools:** Python, pandas, NumPy, Matplotlib | **Notebook:** [`Retail_Analysis.ipynb`](Retail_Analysis.ipynb)

## Business problem
A retail store needs to track its customers across cities and analyse their purchases and returns by product category and store channel.

## Data
| File | Rows | Description |
|---|---|---|
| `Customer.csv` | 5,647 | Customer ID, date of birth, gender, city code |
| `Transactions.csv` | 23,053 | Transaction-level sales and returns, with store type |
| `prod_cat_info.csv` | 23 | Product category and sub-category names |

## Approach
1. **Cleaned the data.** Parsed two different date formats (`14-04-2011` and `7/8/2012`, both day-first) and removed 13 exact duplicate rows.
2. **Merged the three tables** into `Customer_Final`, with Transactions as the base so that every transacting customer is kept. Product details were joined on a **composite key** (category + sub-category), because sub-category codes repeat across categories.
3. **Profiled the data:** data types, five-number summaries, frequency tables, histograms and bar charts.
4. **Answered 11 business questions** on gender, city, store channel, category, age group and date range.
5. **Validated the merge:** row count unchanged after both joins, and no unmatched products or customers.

## Key findings
| Question | Result |
|---|---|
| Data period | 25 Jan 2011 to 28 Feb 2014 (1,130 days) |
| Returns (negative-amount transactions) | 2,164 (9.4% of all transactions) |
| Top store type by value and by quantity | **e-Shop**, about 41% of net sales, double any other channel |
| City with the most customers | City 3: 576 customers (10.46%) |
| Category preference by gender | Nearly identical; no category's share differs by more than 1.3 pp |
| Flagship store: Electronics + Clothing | 3,409,559.27 |
| Male customers: Electronics | 5,711,351.62 |
| Customers with more than 10 unique purchases | 6 |
| Ages 25 to 35: Electronics + Books | 11,147,786.98 |
| Ages 25 to 35: 1 Jan to 1 Mar 2014 | 1,080,712.10 |

## Business takeaways
- **e-Shop is the main channel.** It brings in as much net revenue as the Flagship and MBR stores combined, so investment in digital channels has the biggest base to grow from.
- **Gender is a weak segment for product targeting.** Men and women buy the same category mix. Age, city or channel are likely to be more useful ways to segment customers.
- **Returns are material.** About 1 in 10 transactions is a return, so gross sales overstate revenue. Every figure above is net of returns.

## Assumptions
- Amounts are net of returns. Q5 (gender preference) and Q10 (transaction count) use purchases only.
- Age is calculated as of the last transaction date in the data (28 Feb 2014), not today's date.
- Date ranges and age bands are inclusive.

## How to run
```bash
pip install pandas numpy matplotlib jupyter
jupyter notebook Retail_Analysis.ipynb
```
The dataset and case brief belong to AnalytixLabs and are not included in this repository. Place `Customer.csv`, `Transactions.csv` and `prod_cat_info.csv` in the same folder as the notebook to run it.

---
*Case study from the AnalytixLabs Python for Data Science programme.*
