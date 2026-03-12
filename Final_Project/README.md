# The Analysis

## What are the most demanded skills for the top 3 most popular data roles?

To find the most demanded skills for the top 3 most popular data roles. I filtered out those positions by which ones were the most popular, and got the top 5 skills for those 3 roles. This query highlights the skills I should pay attention to depending on the role I'm pursuing.  


View my notebook here: 
[skill_count.ipynb](Final_Project\Skills_Count.ipynb)

### Visualize Data

```python
fig,ax= plt.subplots(len(job_titles), 1)
for i, job_title in enumerate(job_titles):
    df_plot= df_skills_perc[df_skills_perc['job_title_short'] == job_title].head(5)
    sns.barplot(data=df_plot, x='skill_percent', y='job_skills', ax=ax[i], hue='skill_count', palette='dark:b_r')
```
#### Results

![Visualization of Top Skills](images\Top_Skills_Data_Jobs.png)

#### Insights
SQL is the Universal Language: Regardless of the specific title, SQL remains a top-two requirement across the board. Its lowest likelihood is still 51% (Data Analyst/Scientist), proving it is the foundational skill for the entire field.

Python is King for Scientists: While SQL is essential for everyone, Python reaches its highest demand in Data Scientist roles at 72%. It is the only role where Python significantly outperforms SQL.

The Data Analyst "Entry" Stack: Data Analyst positions are unique in their reliance on Excel (41%) and Tableau (28%). This suggests a heavy focus on spreadsheet management and business intelligence reporting compared to the other roles.

Infrastructure for Engineers: Data Engineers have a distinct technical profile. They are the only group where Cloud (AWS at 43%, Azure at 32%) and Big Data (Spark at 32%) tools break into the top five, highlighting the shift from data analysis to data architecture.

## 2. How are In-Demand Skills Trending for Data Analysts?

### Visualize Data
```python
df_plot=df_da_us_percent.iloc[:, :5]
sns.lineplot(data=df_plot, dashes=False, palette='tab10')
ax=plt.gca()
ax.yaxis.set_major_formatter(PercentFormatter(decimals=0))
plt.show()
```
#### Results

![Trend of Top Skills](images\Skill_Trend.png)

#### Insights
SQL is the undisputed king: Throughout the entire year, SQL remained the most requested skill, appearing in approximately 50% to 54% of job postings.

Excel’s "U-Shaped" Year: Excel held a steady second place around 42% for the first half of the year, saw a noticeable dip in the fall (hitting a low in November), but began a sharp recovery in December.

The "Mid-Tier" Battle
Tableau vs. Python: These two skills were in a tight race all year, generally hovering between 25% and 30%.

Python's August Peak: Python briefly overtook Tableau in August, reaching its highest point of the year (just over 30%) before trending downward toward the end of the year.

Year-End Convergence: By December, Tableau, Python, and SAS all showed an upward trend, with Tableau and Python ending the year at nearly the same percentage (approx. 27%).


## 3. How well do Jobs and Skills Pay for Data Analysts?

### Salary Analysis

#### Visualize Data
```python
sns.boxplot(data=df_us_top6, x='salary_year_avg', y='job_title_short', order=job_order)
ax = plt.gca()
ax.xaxis.set_major_formatter(plt.FuncFormatter(lambda x, pos: f'${int(x/1000)}K'))
```

#### Results
![Salary Distribution of Data Jobs in the US](images\Salary_distribution.png)

#### Insights
The "Senior" Premium
Clear Career Ladder: In every category (Analyst, Engineer, Scientist), the Senior version of the role shows a higher median salary and a higher floor than the entry/mid-level counterpart.

Senior Data Scientists and Senior Data Engineers have nearly identical median salaries (around $150K), making them the highest-earning roles on average in this dataset.

Salary Ranges & Variability
Data Scientists have the highest ceiling: While the medians for Scientists and Engineers are similar, the Data Scientist roles show the most extreme outliers, with some individual salaries reaching as high as $600K.

Data Analysts have the lowest floor: Entry-level Data Analysts have the tightest "box" (Interquartile Range) at the lower end of the scale, with medians sitting just under $100K.

### Highest Paid and Most Demanded Skills in Data Analysts

#### Visualize Data
```python
fig, ax = plt.subplots(2,1)
sns.barplot(data=df_da_top_pay, x='median', y=df_da_top_pay.index, ax=ax[0], hue='median', palette='dark:b_r')

sns.barplot(data=df_da_skills, x='median', y=df_da_skills.index, ax=ax[1], hue='median', palette='light:b')
```
#### Results
![Highest Paid and Most Demanded Skills in Data Analysts](images\Highest_Paid_In_Demand_Skills.png)

#### Insights
The "Niche" Premium (Top Chart):
Specialization Pays Off: The highest-paid skills are niche, technical, and often related to specialized fields.

Top Earners: dplyr (an R package) and version control tools like Bitbucket/GitLab command the highest median salaries, nearing or exceeding $175K–$200K.

High Barrier to Entry: Most of these top-paying skills require significant software engineering or infrastructure knowledge, which is likely why they command such a high premium compared to standard analyst tools.

The "Bread and Butter" Skills (Bottom Chart):
Market Standardized Pay: The most in-demand skills (Python, Tableau, SQL) have much more uniform median salaries, largely hovering around the $90K–$100K mark.

The "Baseline" Skillset: Python leads the pack for in-demand skills in terms of both popularity and pay (approaching $100K), while legacy office tools like Word, Excel, and PowerPoint sit at the bottom of the top 10, closer to $80K.

Consistency: There is very little salary variance between the top 7 "In-Demand" skills. If you know SQL, SAS, or Power BI, the market treats your value relatively similarly.

## What is the most optimal skill to learn for Data Analysts?

#### Visualize Data
```python
sns.scatterplot(data=df_plot, x='skill_percent', y='median_salary', hue='technology')
```

#### Results
![Most optimal skills for Data Analysts](images\optimal_skill.png)

#### Insights

These are the most "optimal" skills because they offer both a high pay ceiling and a significant volume of job opportunities. Python: This is the clear winner on the graph. It commands the highest median salary (approx. $97.5K) while maintaining a strong market presence (over 30% of job postings).Tableau:  it sits in a sweet spot of high demand and a salary around $93K.

These skills are the "bread and butter" of the industry. SQL: This is the most demanded skill on the entire chart, appearing in nearly 60% of job postings. Excel: While it has high market share (over 40%), it has one of the lower median salaries (~$84.5K). It’s a foundational tool, but rarely a primary driver of high pay on its own.

Word & PowerPoint: These occupy the bottom-left quadrant. They are mentioned in roughly 10% of postings and are associated with the lowest median salaries on the chart ($81K - $85K).