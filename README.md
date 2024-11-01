# LDA-mixed-terms
NLP30/2024の発表論文「LDA を使った専門用語の教師なしクラスタリング」の元になった解析データと解析スクリプト

## 解析データ
Excel 作業本

1. [医学用語集 (.xslx データ)](terms-source/terms-medical-v1b.xlsx)
2. [医療縮約表現集 (.xslx データ)](terms-source/terms-mce-v2b.xlsx)
3. [政治経済用語集 (.xslx データ)](terms-source/terms-economic-v1b.xlsx)
4. [法律用語集 (.xslx データ)](terms-source/terms-juridical-v1a2.xlsx)
5. [法律用語集 (.xslx データ)](terms-source/terms-juridical-v1b2.xlsx)
6. [出版用語集 (.xslx データ)](terms-source/terms-publishing-v1b.xlsx)
7. [料理用語集 (.xslx データ)](terms-source/terms-cooking-v1a.xlsx)

## 解析スクリプト
Jupyter Notebook

1. [分野混合用語データの別解析用の Jupyter notebook (FastText の処理を追加済み)](LDA-mixed-terms-base.ipynb)
2. [論文の解析結果の再現用の Jupyter notebook (FastText の処理は未追加)](LDA-mixed-terms-validator.ipynb)

Python 3.9, 3.10, and 3.11 (Anaconda 3上) での作動を確認済み

重要な実行パラメター:

0a **use_LDA**: LDA をエンコーディングで（FastText と併用して）実行するかどうか
0b **use_FastText**: FastText を（LDA と併用して）エンコーディングで実行するかどうか
0c **use_UMAP**: t-SNE の代わりに UMAP を使うかどうか
1. **n_topics** [integer]: LDAのtopic数
2. **term_type** [string]: LDA 用のterm のタイプで "1gram", "2gram", "3gram", "skippy2gram", "skippy3gram"のどれか
3. **max_doc_length** [integer]: 語 (= doc) の最大文字数
4. **ngram_is_inclusive** [boolean]: LDA 用のterm に使う n-gram を包括的にするかどうか
5. **max_gap_val** [int, depending on max_doc_size]: LDA 用のterm に使う 不連続 n-gram の連結距離
6. **minfreq_val_** [integer]: 有効 term 最低頻度 (gensim のminfreq に渡す値)
7. **abuse_threshold** [float: 0~1.0]: 頻出 term の濾過指数 (gensim のabuse_therehold に渡す値)

他のパラメターを変更するのはお勧めできない．やっても良いが，自分でコードが読めない場合には，対処不能になる可能性大．

2 の使い方:

まず 1 を実行し，saves/ に新たに保存された .p ファイルを 2 で読み込む．

## Prerequisites
実行に必要な Python packages

1. pyLDAvis [最初に導入すると良い. gensim を道入してくれる]
2. WordCloud
3. plotly
4. adjustText

## 結果
実行結果の .html ファイル

1. [分野混合の用語クラスタリング結果 (#topics: 5)](results/ntop5)
2. [分野混合の用語クラスタリング結果 (#topics: 10)](results/ntop10)
3. [分野混合の用語クラスタリング結果 (#topics: 20)](results/ntop20)
