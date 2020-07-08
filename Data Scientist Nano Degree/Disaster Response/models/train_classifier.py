import sys
import pandas as pd
import numpy as np

from nltk.tokenize import word_tokenize,sent_tokenize
from nltk.stem import WordNetLemmatizer
from nltk.stem.porter import PorterStemmer
from nltk.corpus import stopwords
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier,AdaBoostClassifier
from sklearn.naive_bayes import MultinomialNB
from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer, TfidfVectorizer
from sklearn.multioutput import MultiOutputClassifier
from sklearn.pipeline import Pipeline
from sklearn.metrics import precision_recall_fscore_support,classification_report,make_scorer,accuracy_score,label_ranking_average_precision_score
from sklearn.model_selection  import GridSearchCV


from sqlalchemy import create_engine
import sys
import re
import pickle
import nltk
nltk.download(['punkt','stopwords','wordnet'])
def load_data(database_filepath):
    """
    Func: take the data from database and return X and y as 2 df
    Args:
      database_filepath(str): database file name including the file path
    Return:
      X(DataFrame): messages from datset
      y(DataFrame): labels of a corresponding message in X
      category_names(str):category that a meesage  belongs to
    """
    engine = create_engine('sqlite:///'+database_filepath)
    df = pd.read_sql ('SELECT * FROM message', engine)
    X  = df['message']
    y  = df.iloc[:,4:]
    return X, y,y.columns


def tokenize(text):
    
    """
    Func: tokenize the text, a preprocessing step in NLP
    Args:  the text
    Return:
    tokens(list):  list of tokens
    """
    # Normalize text
    text = re.sub(r"[^a-zA-Z0-9]", " ", text.lower())
    stop_words = stopwords.words("english")

    #tokenize
    words = word_tokenize (text)

    #stemm
    stemmed = [PorterStemmer().stem(w) for w in words]

    #lemmatize
    return [WordNetLemmatizer().lemmatize(w) for w in stemmed if w not in stop_words]


def build_model():
    """
    Function:  building the pipeline for the model
    Args:
      There is not any
    Return
      cv(model): Grid Search model
    """
    pipeline = Pipeline([
    ('vect',TfidfVectorizer(tokenizer=tokenize)),
    ('clf', MultiOutputClassifier(RandomForestClassifier(n_estimators=200,random_state=20)))])
    
    parameters = {
    "vect__ngram_range": [(1,1), (1,2), (1,5)],
    "vect__stop_words": [None, "english"],
    "vect__use_idf": [True, False],
    'clf__estimator__n_estimators': [10, 50, 100,200],
    'clf__estimator__max_features': [0.01, 0.05, 0.1],}
    cv = GridSearchCV(pipeline,
                  param_grid=parameters,
                  n_jobs=-1)
    return cv
    


def evaluate_model(model, X_test, Y_test, category_names):
    
    """
    Function: evaluate model
    Args:
      model,
      X_test: X test dataset
      Y_test: y test dataset
      category_names:category names of y
    Return
      N/A
    """
    Y_pred = pd.DataFrame(model.predict(X_test),
                      index=Y_test.index,
                      columns=Y_test.columns)
    for col in Y_pred.columns:
        print(" For each category “%s”:" % col)
        print(classification_report(Y_test[col], Y_pred[col]))


def save_model(model, model_filepath):
    with open(model_filepath, 'wb') as f:
        pickle.dump(model, f)


def main():
    print(sys.argv)
    if len(sys.argv) == 3:
        database_filepath, model_filepath = sys.argv[1:]
        print('Loading data...\n    DATABASE: {}'.format(database_filepath))
        X, Y, category_names = load_data(database_filepath)
        X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2)
        
        print('Building model...')
        model = build_model()
        
        print('Training model...')
        model.fit(X_train, Y_train)
        
        print('Evaluating model...')
        evaluate_model(model, X_test, Y_test, category_names)

        print('Saving model...\n    MODEL: {}'.format(model_filepath))
        save_model(model, model_filepath)

        print('Trained model saved!')

    else:
        print('Please provide the filepath of the disaster messages database '\
              'as the first argument and the filepath of the pickle file to '\
              'save the model to as the second argument. \n\nExample: python '\
              'train_classifier.py ../data/DisasterResponse.db' )
if __name__ == '__main__':
    main()
