import sys
import sqlite3
import pandas as pd
import numpy as np
import sqlite3
from sqlalchemy import create_engine

def load_data(messages_filepath, categories_filepath):
    """
    Func: load data from message and categories csv files and merge them while doing a bit of preprocessing 
    Args：
      messages_filepath(str): file path of messages 
      categories_filepath(str): files path of categories 
    Return：
       df： dataframe of merged messages and categories df
    """
    # load messages dataset
    messages = pd.read_csv (messages_filepath)

    # load categories dataset
    categories = pd.read_csv (categories_filepath)
    df=messages.merge(categories, on='id')
    
    # create a dataframe of the 36 individual category columns
    categories = df['categories'].str.split(";", expand=True)
    
    # select the first row of the categories dataframe
    row = row = categories.iloc [0]

    # use this row to extract a list of new column names for categories.
    # one way is to apply a lambda function that takes everything 
    # up to the second to last character of each string with slicing
    category_colnames = row.apply (lambda x: x.rstrip ('- 0 1'))
    
    # rename the columns of `categories
    categories.columns = category_colnames
    
    for column in categories:
        
        # set each value to be the last character of the string
        categories[column] = categories[column].str [-1]
        
        # convert column from string to numeric
        categories[column] = pd.to_numeric (categories[column], errors = 'coerce')
        
    # drop the original categories column from `df`
    df.drop('categories',axis=1, inplace=True)
        
    # concatenate the original dataframe with the new `categories` dataframe
    df = pd.concat([df,categories], axis=1)
    return df


def clean_data(df):
    
    """
    Func:dropping the duplicate data 
    Args:
        df(dataframe):raw data with duplicate values
    Return:
        df(dataframe):clean dataset without duplicate values
    """
    # drop duplicates
    df.drop_duplicates(inplace=True)
    return df


def save_data(df, database_filename):
    
    """
    Func: saving  the cleaned data for further use
    Args:
        df(dataframe):cleaned data to save for further use 
    Return:
        There is no return for this function
    """
    engine = create_engine('sqlite:///'+ 'data/'+str (database_filename))
    df.to_sql('Message', engine, index=False, if_exists = 'replace')
    


def main():
    if len(sys.argv) == 4:

        messages_filepath, categories_filepath, database_filepath = sys.argv[1:]

        print('Loading data...\n    MESSAGES: {}\n    CATEGORIES: {}'
              .format(messages_filepath, categories_filepath))
        df = load_data(messages_filepath, categories_filepath)

        print('Cleaning data...')
        df = clean_data(df)
        
        print('Saving data...\n    DATABASE: {}'.format(database_filepath))
        save_data(df, database_filepath)
        
        print('Cleaned data saved to database!')
    
    else:
        print('Please provide the filepaths of the messages and categories '\
              'datasets as the first and second argument respectively, as '\
              'well as the filepath of the database to save the cleaned data '\
              'to as the third argument. \n\nExample: python process_data.py '\
              'disaster_messages.csv disaster_categories.csv '\
              'DisasterResponse.db')


if __name__ == '__main__':
    main()