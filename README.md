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

1. [論文の結果の再現用の解析 Jupyter notebook](LDA-mixed-terms.ipynb)
2. [分野混合用語データの解析  Jupyter notebook](LDA-mixed-terms-standalone.ipynb)

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
