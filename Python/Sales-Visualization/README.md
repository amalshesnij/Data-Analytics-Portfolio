# Pharma Sales Visualization: 2015 vs 2016 (Python)

Visual analysis of two years of sales for a pharmaceutical company: 3,709 records across 3 regions, 44 states, 26 divisions and 4 customer tiers. The goal is to compare 2015 and 2016 performance and show where growth and decline happened.

**Author:** Amal Shesnij | **Tools:** Python, pandas, NumPy, Matplotlib | **Notebook:** [`Sales_Visualization.ipynb`](Sales_Visualization.ipynb)

## Business problem
The client wants a clear visual picture of sales trends at national, regional and territory level, to see what is working and what is not.

## Approach
1. Aggregated sales and units with `groupby`, and reshaped the data between wide and long formats with `pivot_table`.
2. Built bar charts to compare years, a pie chart for regional share, and four pie charts for the tier mix in each quarter.
3. Created a quarter column by mapping each month to Q1–Q4.

## Key findings
| Question | Finding |
|---|---|
| Sales by region | All three regions grew in 2016. East is the largest (42.7% of 2016 sales); **West grew fastest (+34.8%)** |
| Region and tier | The High tier is the largest in every region and grew in all three |
| East-region declines | Only **New York** declined, slightly (1.73M to 1.70M) |
| High-tier unit declines | **None**: every High-tier division sold more units in 2016 |
| Quarterly sales | 2016 is higher than 2015 in every quarter; Q3 is the strongest quarter in both years |
| Tier mix by quarter (2016) | The High tier's share rises every quarter, from 55% in Q1 to 63% in Q4 |

## Assumptions and limitations
- Quarters were created with a month-to-quarter mapping (`.map()`), which is clearer than nested `np.where` for four categories.
- The "Out" tier was excluded from the quarterly pie charts: it is close to zero and slightly negative, and a pie chart cannot show negative values.
- Unit figures contain decimals, which suggests the data was averaged or simulated.

## How to run
```bash
pip install pandas numpy matplotlib jupyter
jupyter notebook Sales_Visualization.ipynb
```
The dataset and case brief belong to AnalytixLabs and are not included in this repository. Place `SalesData.csv` in the same folder as the notebook to run it.

---
*Case study from the AnalytixLabs Python for Data Science programme.*
