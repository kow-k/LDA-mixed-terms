# LDA-mixed-terms
NLP30/2024の発表論文「LDA を使った専門用語の教師なしクラスタリング」の元になった解析データと解析スクリプト

## 解析データ
Excel 作業本

1. [医学用語集 (.xslx データ)](terms-source/terms-medical-v1.xlsx)
2. [医療縮約表現集 (.xslx データ)](terms-source/terms-mce-v1.xlsx)
3. [政治経済用語集 (.xslx データ)](terms-source/terms-economic-v1.xlsx)
4. [法律用語集 (.xslx データ)](terms-source/terms-juridical-v1.xlsx)
5. [出版用語集 (.xslx データ)](terms-source/terms-publishing-v1.xlsx)

## 解析スクリプト
Jupyter Notebook

1. [分野混合用語データの別解析用の Jupyter notebook](LDA-mixed-terms-standalone.ipynb)
2. [論文の解析結果の再現用の Jupyter notebook](LDA-mixed-terms.ipynb)

Python 3.9, 3.10, and 3.11 (Anaconda 3上) での作動を確認済み

重要な実行パラメター:

1. **n_topics** [integer]: LDAのtopic数
2. **max_doc_length** [integer]: 語 (= doc) の最大文字数
4. **term_type** [string]: term のタイプで "1gram", "2gram", "3gram", "skippy2gram", "skippy3gram"のどれか
5. **ngram_is_inclusive** [boolean]: n-gram を包括的にするかどうか
6. **max_distance_val** [int, depending on max_doc_size]: 不連続 n-gram の連結距離
7. **minfreq_val_** [integer]: 有効 term 最低頻度 (gensim のminfreq に渡す値)
8. **abuse_threshold** [float: 0~1.0]: 頻出 term の濾過指数 (gensim のabuse_therehold に渡す値)

他のパラメターを変更するのはお勧めできない．やっても良いが，自分でコードが読めない場合には，対処不能になる可能性大．

2 の使い方:

まず 1 を実行し，saves/ に新たに保存された .p ファイルを 2 で読み込む．


## Prerequisites
実行に必要な Python packages

1. pyLDAvis [最初に導入すると良い]
2. WordCloud
3. plotly
4. adjustText

## 結果
実行結果の .html ファイル

1. [分野混合の用語クラスタリング結果 (#topics: 5)](results/ntop5)
2. [分野混合の用語クラスタリング結果 (#topics: 10)](results/ntop10)
3. [分野混合の用語クラスタリング結果 (#topics: 20)](results/ntop20)
