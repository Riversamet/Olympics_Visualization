# Olympics Data Visualization

This project is based around obtaining, querying, analyzing, and visualizing data on all Olympic Games from 1896-2016 using Python, a Neon PostgreSQL database, and Tableau. Python was used to obtain the original dataset for this project from Kaggle and load it into a Neon PostgreSQL database for subsequent querying. Final `.csv` files from queries were uploaded to Tableau Public, which was used to visualize the data and display findings from visualization.

## Objectives

- Prepare, preprocess, and load a dataset from Kaggle into a cloud database
- Run a variety of SQL queries to build tables that specifically help to answer various overarching questions about the dataset (questions shown below)
- Upload tables to Tableau Public for visualization and analysis
- Visualize data using Tableau dashboards to clearly illustrate and explain findings
- Build experience with a variety of Tableau tools and functions, such as filters, calculated fields, parameters, and navigation buttons

## Tools and Libraries

- Python
- SQLAlchemy
- Kagglehub
- python-dotenv
- Psycopg 2

## Description

### 1. Download, configure, and load the dataset into Neon

`Load_Olympics_Dataset.ipynb` displays the code used to download the dataset for this project from Kaggle and load it properly into a Neon PostgreSQL database for subsequent SQL querying.

#### Downloading the dataset

The `kagglehub` API was used to directly download the dataset used for this project to disk. In total, two different `.csv` files comprise the dataset: one used as a key to map three-letter abbreviations (National Olympic Committee (NOC) codes) of nations to current nation names (230 entries), and the other containing athlete- and event-specific data for every Olympic event from the inaugural Olympic Games in 1896 to the 2016 Rio de Janeiro Olympics (271,116 entries). Event names, athlete names and IDs, sports categories, medals won, and a variety of other features are present for each entry.

Please note that this dataset does not contain the most recent decade's Olympic Games data. When "last" is used to describe an Olympic Games in this repository, it refers to the most recent Olympic Games with data included in this dataset (for either summer or winter); for summer, this means the Rio de Janeiro 2016 Summer Olympic Games. So, the "last five games" for the summer season refers to the 2016 Olympic Games and the four games preceding it. Analogous reasoning can be used for the winter season. 

Findings and conclusions presented below are based solely on the data from this dataset, and do not reflect results of the Olympics up to the present day.

#### Load dataset into Neon

SQLAlchemy was used to create a connection to a Neon PostgreSQL database used for this project, and tables were loaded using PostgreSQL's `COPY` command within a raw cursor. One row in the `noc_regions` table was missing, and was added manually to the table in Neon.

### 2. Creating final tables using SQL queries

Neon's own SQL editor was used to query the data and return tables to give information on four different overarching questions regarding this dataset:

1. Broadly, how have the Olympic Games expanded since their inauguration?

2. How has the gender distribution of athletes and events changed over time?

3. How do the overall Olympic medal counts for different nations compare with each other? What about specific distributions of gold vs. silver vs. bronze medals?

4. Broadly, how do the first five Olympic Games compare with the last five (capped at 2016) in terms of athlete characteristics and expansion of the games?

Either one or two SQL queries are used to build tables that help to answer each question above. The specific queries used are displayed in `.sql` files located in the `sql_queries/` folder, one file per query. Complexity ranges from simple `WHERE` and `GROUP BY` clauses to window functions, subqueries, common table expressions, and `CASE` statements used to build alternative arrangements of the data and calculate new metrics that are specifically helpful for answering the questions above.

For example, no column in the original dataset displays information about nation-specific cumulative medal totals. SQL querying was used to provide this information, which was of high interest for my exploration of the data.

Following table creation in Neon, each table was saved to disk (located in `data/neon_data/` in this repository) and uploaded to Tableau Public for visualization and analysis.

### 3. Visualizing the data using Tableau

Tableau is a great tool for visualizing complex data using professional and presentable dashboards. Tableau Public was specifically used for this project so that the associated Tableau workbook is readily accessible online (link included below).

One important caveat is that Tableau Public cannot maintain a live connection to a data source, and all data must be manually uploaded to the Tableau Public application for subsequent visualization. This is a large hindrance for projects that may require periodic updates to datasets, but for the static, historical data used here, this is not an issue.

A variety of Tableau-specific tools and techniques were used to create the informative and user-friendly visuals for this project. These include filters, calculated fields, parameters, navigation buttons, among others. A final set of dashboards is included to help answer each overarching question I had about this dataset, with navigation buttons that allow a user to seamlessly switch between dashboards. Visual types include line graphs, pie charts, stacked bar charts, tables, as well as others. Multiple visuals have interactive filters. Accompanying written analysis is provided on each dashboard, providing viewers with key findings from the visuals presented.

## Tableau project access

Please use the following link to access the Tableau Public workbook for this project:

[Tableau Public workbook link](https://public.tableau.com/app/profile/river.samet/viz/PortfolioProjectTableau_17869074800600/First5Gamesvs_Last5Games)

The `tableau_project_media/` directory in this repository also contains images of each Tableau dashboard created for this project.

## Principal findings

### Overarching question/dashboard 1

- A steady increase in athlete, nation, sport, and event counts over time shows vast growth of the Olympic Games as a whole since their inauguration in 1896.
    - As ease of worldwide travel and global connection has improved steadily over time, global competitions such as the Olympics have become more accessible for athletes and viewers alike, increasing their popularity and athletes' general desire and ability to participate.
- Sudden, brief dips in these metrics' consistent upward trends are typically the result of wars, such as World Wars I and II, as well as the Cold War.

### Overarching question/dashboard 2

- Not only have the numbers of Olympic athletes and events steadily increased over time, but the ratios of female to male athletes and events have increased substantially as well.
- The first Olympic Games consisted of only men competing, while the most recent Olympic Games had a nearly even ratio of men to women competing.
    - Worldwide societal focus of women's rights in more recent history has led to greater inclusion of women in professional athletic events, such as the Olympics.
- No obvious trend is apparent for the number of mixed events included in the Olympics over time.

### Overarching question/dashboard 3

- The USA clearly dominates in the Summer Olympics, while Germany is historically best in Winter Olympics, but by a small margin.
- Only the USA, Russia, and Germany hold top five spots in both the Summer and Winter Olympic Games in terms of total medals earned.
    - Generally, first-world countries have better access to things like education, sports programs, and healthcare, which often yields better athletes with access to professional sports opportunities. 
    - This results in first-world nations typically earning more Olympic medals.
- Medal-type distributions (gold, silver, bronze) are roughly even for each nation, and similarly shaped across different nations and seasons.

### Overarching question/dashboard 4

- The distribution of athlete gender in the first five Olympic Games vs. the last five Olympic Games is vastly different for both the Summer and Winter Olympics.
- On the other hand, the distribution of athlete age in the first five vs. last five Olympic Games has seen virtually no alteration; few athletes are able to compete past the age of 35, while there is a near even ratio between athletes under 25 and athletes 25 to 35.
    - The age range for peak athletic ability is heavily sport-dependent, but is anywhere from late teens to mid-thirties. This aligns well with the above findings.
- However, ~37% of athletes who participated in the first five Summer Olympic Games and ~7% who participated in the first five Winter Olympic Games have no recorded age, so the age-distribution comparison above should be interpreted with some caution.
    - Also, only three bins were included to categorize athletes by age; it's possible that differences in age distributions may be visible using smaller bin sizes, but this was not tested.