import pandas as pd

#ny_url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv"
#jh_url = "https://raw.githubusercontent.com/datasets/covid-19/master/data/time-series-19-covid-combined.csv?opt_id=oeu1603289369465r0.029250972293521915"


def extract_transform(ny_url, jh_url):
    try:
        #------Load---------------------------
        df_ny = pd.read_csv(ny_url)
        df_jh = pd.read_csv(jh_url)

        #-----Transform-----------------------
        df_ny = df_ny.astype({'date': 'datetime64[ns]', 'cases': 'int64', 'deaths': 'int64'})
        #print(df_ny.tail(5))
        df_jh = df_jh[df_jh['Country/Region'] == 'US']
        df_jh = df_jh.astype({'Date': 'datetime64[ns]', 'Recovered': 'int64'})
        df_jh = df_jh[['Date', 'Recovered']]
        df_jh.rename(columns={'Date': 'date', 'Recovered': 'recovered'}, inplace=True)
        #print(df_jh.tail(5))
        df_final = pd.merge(df_ny, df_jh, on='date')
        return df_final
    except Exception as e:
        print(e)
        exit(1)

#extract_transform(ny_url, jh_url)

