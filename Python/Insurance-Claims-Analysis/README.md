# Insurance Claims: Exploratory Analysis & Hypothesis Testing (Python)

End-to-end analysis of 1,100 insurance claims joined with customer demographics: data cleaning, exploratory analysis, fraud patterns and five hypothesis tests on what drives claim amounts.

**Author:** Amal Shesnij | **Tools:** Python, pandas, NumPy, SciPy, Matplotlib | **Notebook:** [`Insurance_Claims_Analysis.ipynb`](Insurance_Claims_Analysis.ipynb)

## Business problem
An insurer wants a 360-degree view of its customers and claims: who claims, how much, for what causes, where fraud occurs, and whether claim amounts differ by gender, age, segment or claim history.

## Data
| File | Rows | Contents |
|---|---|---|
| `claims.csv` | 1,100 | Claim date, cause, area, type, police report, amount, policy claims, fraud flag |
| `cust_demographics.csv` | 1,085 | Gender, date of birth, state, segment |

## Data cleaning
- Inner-joined claims and customers (1,085 rows); 15 claims had no customer record.
- Converted `claim_amount` from text (`"$2980"`) to numbers.
- **Fixed two-digit birth years:** pandas read `"68"` as 2068, which put 245 birth dates in the future; these were moved back 100 years.
- Flagged 297 injury claims not reported to the police.
- Removed 7 duplicate customers, keeping each customer's most recent claim (1,078 rows).
- Filled 65 missing claim amounts (mean) and 10 missing policy-claim counts (mode).
- Built age groups; all customers are aged 18–58, so only Youth and Adult groups exist.

## Key findings
| Area | Finding |
|---|---|
| Segments | Average claims are almost identical across Gold, Platinum and Silver (about 12,300–12,850) |
| Incident cause | "Other causes" and driver-related causes carry the highest claim totals |
| Driver-related claims | Men claimed more: about 3.98M across 281 claims vs 3.14M across 221 for women |
| Fraud | Adults made 177 of 245 fraudulent claims; fraudulent claims by adult men have the highest average (about 16,500) |

## Hypothesis tests (α = 0.05)
| Question | Test | Result |
|---|---|---|
| Do men and women claim similar amounts? | Welch's t-test | p = 0.34: **no significant difference** |
| Is age group related to segment? | Chi-square | p = 0.45: **no relationship** |
| Are 2018 claims above the 2016–17 average of $10,000? | One-sample t-test | Mean 12,743, p < 0.001: **significantly higher** |
| Do age groups claim different amounts? | Welch's t-test | p = 0.35: **no significant difference** |
| Is the number of past claims related to claim amount? | Pearson correlation | r = −0.02, p = 0.46: **no relationship** |

## Business implications
- Claim amounts have risen significantly (about 27% above the 2016–17 average), which should be reflected in reserves and premiums.
- Gender, age group and segment do not predict claim size, so pricing on these factors alone is not supported by this data.
- High-value claims from adult men, and injury claims without a police report, are sensible priorities for fraud review.

## How to run
```bash
pip install pandas numpy scipy matplotlib jupyter
jupyter notebook Insurance_Claims_Analysis.ipynb
```
The datasets and case brief belong to AnalytixLabs and are not included in this repository. Place `claims.csv` and `cust_demographics.csv` in the same folder as the notebook to run it.

---
*Case study from the AnalytixLabs Python for Data Science programme.*
