# Hypothesis Testing: 5 Business Problems (Python)

Applied statistics case study: five real business questions answered with hypothesis tests, from loan pricing to pricing consistency, program evaluation, job prioritisation and customer surveys.

**Author:** Amal Shesnij | **Tools:** Python, pandas, SciPy, Matplotlib | **Notebook:** [`Statistics_Case_Study.ipynb`](Statistics_Case_Study.ipynb)

## Approach
Each question follows the same steps: state H₀ and H₁, choose the test that fits the data, run it, and decide at a 0.05 significance level. The test was chosen by the structure of the data:

| Situation | Test used |
|---|---|
| Two numeric variables | Pearson correlation |
| Two independent groups | Welch's t-test |
| Same items measured twice | Paired t-test |
| Three or more groups | One-way ANOVA |
| Skewed data, 3+ groups | Kruskal-Wallis |
| Ranked survey ratings | Spearman correlation |

## Data cleaning
- Converted text columns to numbers: interest rate and debt ratio (`"8.90%"`), loan length (`"36 months"`) and FICO range (`"735-739"`).
- Standardised inconsistent survey codes (`"Male"` / `"1"`, `"Single"` / `"2"` / the typo `"Slngle"`).
- Split multi-answer survey responses (`"4,5"`) so that each channel is counted once.

## Key findings
| Problem | Question | Result |
|---|---|---|
| 1a. Loans | Do larger loans get lower rates? | **No.** Larger loans carry higher rates (r = 0.33, p < 0.05) |
| 1b. Loans | Does loan length affect the rate? | Yes. 60-month loans average 16.41% vs 12.13% for 36-month loans |
| 1c. Loans | Does the rate vary by purpose? | Yes (ANOVA p < 0.05) |
| 1d. Loans | Do homeowners have higher FICO scores? | Partly. Mortgage holders score highest (711.7), then owners (706.6), then renters (700.1) |
| 2. Price quotes | Do two pricing experts quote differently? | Yes. Barry quotes about 9.6 higher on the same orders (paired t-test, p = 0.028) |
| 3. Treatment facility | Did the reengineering program work? | Critical incidents fell from 53.9% to 23.4% and removals from 20.5% to 9.2%; staff turnover did not improve |
| 4. Job priority | Are high-priority jobs completed faster? | **No.** High-priority jobs are not faster than medium-priority jobs |
| 5. Film survey | Satisfaction, drivers, profile, channels | 95% satisfied; parking is the strongest driver (r = 0.54); patrons are mostly young, single women; 72% heard through word of mouth |

## Assumptions
- A significance level of 0.05 was used throughout.
- Rows with missing values were excluded from each test.
- Home-ownership groups OTHER and NONE (6 loans) were excluded as too small.
- Columns VAR4 and VAR5 were taken as TRFF and CI, following the order in the case brief.

## How to run
```bash
pip install pandas numpy scipy matplotlib jupyter
jupyter notebook Statistics_Case_Study.ipynb
```
The datasets and case brief belong to AnalytixLabs and are not included in this repository. Place the 5 CSV files in the same folder as the notebook to run it.

---
*Case study from the AnalytixLabs Python for Data Science programme.*
