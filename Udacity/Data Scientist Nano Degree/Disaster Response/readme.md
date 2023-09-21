# Disaster Response Project

## 1. Libraries
Python 3.6 has been used to create this project and the vital libraries that were used:
- sikit-learn ==0.19.1
- jsonschema==2.6.0
- nltk == 3.2.5
- gunicorn==19.9.0
- numpy==1.15.0
- pandas==0.23.4
- plotly==3.3.0
- sqlalchemy==1.2.12
- Flask==1.0.2
- pandas==0.24.2
- numpy==1.16.1
- matplotlib==3.0.3
- seaborn==0.9.0

## 2. Project Motivation

This project is part of Udacity Data Scientist Nanodegree program. 

In this project, disaster data, containing real messages that were sent during disaster events from Figure Eight, has been analyzed to build a ML model. Later, this model has been deployed as web application for ready to use purpose through an API that classifies disaster messages into 36 different categories.
In the building process of a ML model,  machine learning pipeline was being in use to categorize the message during disaster events to  send the message to appropriate disaster relief agency. NLTK has been used for message processing purpose as well as scikit-learn's Pipeline followed by a GridSearchCV find the best parameters for the final model. Final model is converted to a pickle file for the web application to use.In the web application portion, bootstap and Flask is used so that an emergency worker can input a new message and get classification results in several categories.



## 3. File Descriptions
- \
	- README.md
- \app
	- run.py
  
- \data
	- DisasterResponse.db
	- disaster_categories.csv
	- disaster_messages.csv
	- process_data.py
- \models
	- train_classifier.py

## 4.Instructions:

     1. Run the following commands in the project's root directory to set up your database and model.

         - To run ETL pipeline that cleans data and stores in database
             `python data/process_data.py data/disaster_messages.csv data/disaster_categories.csv data/DisasterResponse.db`
         - To run ML pipeline that trains classifier and saves
             `python models/train_classifier.py data/DisasterResponse.db models/classifier.pkl`

     2. Run the following command in the app's directory to run your web app.
         `python app/run.py`

     3. Go to http://0.0.0.0:3001/


## 6. Licensing, Author, Acknowledgements
 Please refer to [Udacity Terms of Service](https://www.udacity.com/legal) for further information.
