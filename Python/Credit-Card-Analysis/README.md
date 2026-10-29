# Credit Card Spend & Repayment Analysis (Python)

Exploratory analysis of credit card data for a bank: 100 customers, 1,500 spend transactions and 1,500 repayments (2004–2006). The goal is to understand customer spend and repayment behaviour, estimate the bank's monthly interest profit, and identify the most valuable customers.

**Author:** Amal Shesnij | **Tools:** Python, pandas, NumPy, Matplotlib | **Notebook:** [`Credit_Card_Analysis.ipynb`](Credit_Card_Analysis.ipynb)

## Business problem
The CEO of PSPD Bank wants to understand customer spend and repayment behaviour to support decisions on collections, risk and proactive customer offers.

## Data
| Sheet | Rows | Contents |
|---|---|---|
| Customer Acquisition | 100 | Age, city, card product, credit limit, company, segment |
| Spend | 1,500 | Transaction date, spend category, amount |
| Repayment | 1,500 | Repayment date and amount |

## Approach
1. **Applied the case's business rules:** replaced under-18 ages with the mean age, set spend above the card limit to 50% of the limit, and capped repayments at the limit.
2. **Built monthly summaries** of spend and repayment, and calculated bank profit as 2.9% interest on positive net monthly repayment.
3. **Analysed spend** by category, city, card product, age group and calendar month.
4. **Wrote a reusable function**, `top10_customers(product, period)`, that returns the top 10 customers by repayment in each city for any card product, by year or by month.

## Key findings
| Area | Finding |
|---|---|
| Data quality | 25 customers under 18; 591 spend rows and 604 repayments above the card limit (corrected per the case rules) |
| Scale | Average monthly spend 7.62M; average monthly repayment 8.28M |
| Bank profit | **929,363** at 2.9% monthly interest (21 of 30 months profitable) |
| Top categories | Petrol, Camera, Food, Air tickets, Train tickets |
| Top city | **Cochin** has the highest spend |
| Card products | Gold holders dominate spend in most cities; Platinum leads in Chennai |
| Seasonality | Spend is highest from January to May; petrol spikes in November |
| Top customer | A61, with 9.67M in total repayments |

## Assumptions and limitations
- The Excel workbook was used as the official source; the CSV files contain different values.
- "Platimum" was corrected to "Platinum".
- Monthly averages cover the 30 months that have transactions.
- Replacing under-18 ages with the mean age (37.46) places those customers in the 30–39 band, which inflates that group's spend.
- The case defines profit as interest on positive net repayment; in practice, card issuers earn interest on unpaid balances.

## How to run
```bash
pip install pandas numpy matplotlib openpyxl jupyter
jupyter notebook Credit_Card_Analysis.ipynb
```
The dataset and case brief belong to AnalytixLabs and are not included in this repository. Place `Credit Card Data.xlsx` in the same folder as the notebook to run it.

---
*Case study from the AnalytixLabs Python for Data Science programme.*
