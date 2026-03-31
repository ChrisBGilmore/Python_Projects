# Metacritic Game Analysis/Scrape
 ## My Goal
 Scrape metacritic website for game data and then visualizing critic/audience sentiment, release, scoring, and genre trends, and finding the most polarizing game releases for over 4,000 games over a span of 25+ years. 

 ## Tools Used
 * Jupityer Notebooks: all python code for data analysis and ETL was written here
 * Python: libraries used: matplotlib, seaborn, pandas, numpy, adjustText, requests, and BeautifulSoup
 
 
 ## Analysis
 ### Metacritic Scrape for Game Data
 I've done several python projects at this point but I wanted to do something different for this project and that is collect the data myself rather than using an existing csv file like I've done in the past. I ended up using BeautifulSoup to scrape the title, release year, audience score, critic score, genre, dev, platform, and rating. The tricky thing was is from what I could tell that the data wasn't all on one single webpage for all the games where I could easily retrieve it so I had to use multiple loops to cycle through the multiple metacritic sections and inner joining those on the game title so I could have a complete table without a bunch of missing values for either critic/audience as this was a big portion of my motivation for analyzation. I ended up with about 4000+ games and went ahead and just exported these results into a csv and read it in a separate notebook so I didn't have to rerun through the scrape in the future. There's definitely room for improvvement on this front and plan to revisit in the future to see if I can make things more efficient.

 [View My Complete Scrape Script Notebook Here](scrape/scrape.ipynb) 

 ### Median Metacritic Score for top 15 Genres
 I started analysis with a high level overview identifying the median critic sentiment for our top 15 game genres by game title count. Leading the pack was "Auto Racing Sim" and then closely followed by several genres all having the same median score (80). I first started this visual by just grabbing the top 15 by median score but ended up with several game genres where we only had a few games and leading to false conclusions so I instead grabbed our biggest genres and used those. All genres used had over 70+ games. 
#### Visualize Data
```python
sns.barplot(df_genre_sort, x='median_score', y ='genre', hue = 'genre', palette='dark:b', legend=False)
```
 ![Median_genre](images/genre_critic_score.png)
 ### Critical Divide: The Most Polarizing Games
 Since we had both critic/audience scores in our dataset I really wanted to dive into a graphic showing our biggest "Score Diff" games where either critic score was very high but audience low or vice versa. Just looking at the graphic you can tell already that for the majority of games, critics naturally rate higher than the audience does. For this specific graphic I ran into quite a few challenges getting the labels to display/not overlap so I limited to the top 15 with the biggest score differences. 

#### Visualize Data
```python
sns.scatterplot(
    data=df_score_comparison, 
    x='score', y='audience_score_x10', 
    hue='score_diff', palette='vlag', 
    s=120, alpha=0.7, edgecolor='w'
)
```
![Polarizing](images/polarizing_games.png)

### Critic Vs Audience Sentiment Trend 
One thing I was really curious about was how the critic/audience score has trended over the years and if games are possibly getting better or the sample size was changing so I really wanted to include both in this specific graphic. If you take it at face value it looks like the scores peaked in 2000 and have slowly trended downwards over the years and now barely starting to see a little bit of a rise starting around 2015, though not to the scores seen in 2000. I think this might be because a lot of the games from that time period (2000) were logged in metacritic years later so only the "best and highly praised" games would of been listed and scored. 
#### Visualize Data
```python
sns.lineplot(data=line_plot, x='year', y='avg_audience_score', ax=ax1, label='Audience Median', color='blue', marker='o')
sns.lineplot(data=line_plot, x='year', y='avg_critic_score', ax=ax1, label='Critic Median', color='red', marker='s')
```
![score_trend](images/critic_vs_audience_sample.png)


### Game Genre Release Trend from 1996-Present
I kind of had some guesses about how this visual would look but in the end it might be one of my favorite ones as it clearly shows how game releases in regards to genre have trended over the years. Fps games led the pack near the beginnign with a large over a 10 year period starting in 2003 but have slowly fallen behind other more popular genres like action rpg/open world action/action adventure going all the way till 2026. One thing to think about is how far technology has come in regards to pcs/consoles where game developers now have a lot more freedom in what they want to make where in the early 2000's creativity would of been limited which might explain a lot of the trends we're seeing. 
 
#### Visualize Data
```python
sns.heatmap(
    genre_stacked, 
    annot=True,              
    fmt='g',                
    cmap='mako_r',             
    linewidths=.5,          
    cbar_kws={'label': 'Number of Games Released'}
)
```
![Genre_trend](images/genre_releaseyear.png)

### Critic Vs Audience Sentiment for Top Developers 
 I was able to scrape the developer for all games that had it included in our dataset so thought it might be important to dive into median scores for the top developers by game titles. Some of the names on this graphic are expected and well known but the scores suprised me as I expected a lot higher median scores across the board. Leading the pack was konami with a low 80's which wasn't entirely surprising given they have several successful franchises that are still getting positive released to this day. Other top mentions are Nintendo and Capcom in regards to the critic score. For our dataset Nintendo was the only dev of the top 10 to have the exact same median score for both critic/audience. One other thing to note is sega was our only developer to have a higher median audience score than critic which contradicts a lot of our earlier findings where critic typically score higher than audience. 

#### Visualize Data
```python
sns.barplot(data=dev_melted, x='dev', y='Score Value', hue='Score Type', 
            palette={'critic_median': 'darkblue', 'audience_median': 'blue'})

```
![Dev_scores](images/dev.png)

### Distribution of Game Titles Across the Top 10 Platforms
This might be my least insightful graphic as I didn't learn anything new but I was able to scrape the platform list for each game so just wanted to see the platform percentage for my dataset. Pc being so much higher was a given with how many games are made exclusively for it and nearly all AAA titles will include PC or release at a later date. My only other though would be I suspect in a few years Playstation 5 will climb the rankings to be behind PC in a few years. As far as challenges getting the "blob of text" list situated where it could be properly exploded out was a challenge and took me quite a while but I was finally able to get it into a list where it could be counted correctly.

#### Visualize Data
```python
ax=sns.barplot(df_platform_plot, x='platform_list', y ='platform_count', hue='platform_list', palette='dark:b')
```
![platforms](images/platform_distribution.png)

### Critic Vs Audience Sentiment for ESRB Ratings
I had the rating column so I wanted to do as I with some of the other graphs and get down into the scores differ across the various ESRB ratings. Once again as we saw with a lot of the others is critics are typically scoring games higher and you can immediately tell with all of our rating box's being on the right side of 0. With both E and T the score difference gets quite a big higher on the  critic side, but for the M games you have the widest spread on both ends with some games well past the -40 for audience and +60 on the critics side showing this seem to be the most polazring category though there are some outliers for the other categories as well. 

#### Visualize Data
```python
rating_order = ['E', 'E10+', 'T', 'M']
sns.boxplot(df_rating, x='score_dif', y = 'rating', order = rating_order, palette='vlag')
```
![Rating box Plot](images/rating_boxplot.png)

## Insights and Conclusion
The "Golden Age" is a Data Illusion:
Older games in Metacritic are primarily "the greats" that were worth archiving years later. As my dataset grows toward 2026, it captures the "middle class" of gaming—average titles that pull the median score down, creating a more realistic (but lower) industry average.

The Professional vs. Personal Divide:
My analysis confirms a systematic gap between how critics and fans evaluate products. Professional reviewers rarely drop below a 60 for functional AAA games, creating a safer, tighter scoring distribution. Though fans are far more likely to use the extremes (0 or 100), especially in the Mature (M) category, which showed the highest polarization due to risky narrative or technical choices.

Genre Evolution: From Loops to Worlds
The heatmap reveals a fundamental shift in game design driven by hardware capabilities.
The FPS Era (2003–2013) when technical constraints limited scope. The Open-World Pivot (2015–2026). As RAM and processing power increased, "Action RPG" and "Open World" became the dominant genres, trading linear intensity for immersion.

Brand Trust and Outliers:
Developer medians highlight the rare instances where expectations meet reality. Nintendo stands alone with a near-perfect 1:1 ratio between critic and audience sentiment, suggesting the highest level of predictable quality. 
Sega was the only major outlier where fans consistently rated games higher than critics, indicating a "soul" or nostalgia factor that professional rubrics might overlook.

Platform Dominance:
PC remains the baseline for the dataset due to its role as the primary home for both indie titles and late-lifecycle AAA ports. While older platforms hold the volume now, the PS5 shows the steepest trajectory for future growth in my dataset.

[View My Complete Jupyiter Notebook Here](analysis/analysis.ipynb)