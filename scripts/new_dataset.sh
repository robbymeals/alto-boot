CORPUS=$1
BASEDIR=$2
## POSTING_JSON_PATH=$3 dedup/data/json/
POSTING_JSON_PATH=/Users/robert.mealey/match.topical/dedup/data/json/
NUMTOPICS=$3
SUBSET=$4

TEXTDATAPATH="$BASEDIR/text_data/$CORPUS"
mkdir $TEXTDATAPATH
mkdir ${BASEDIR}/WebContent/results/${CORPUS}
INPUTPATH="${BASEDIR}/WebContent/results/${CORPUS}/input/"
mkdir $INPUTPATH
mkdir ${BASEDIR}/WebContent/results/${CORPUS}/output/
mkdir ${BASEDIR}/WebContent/results/${CORPUS}/output/T${NUMTOPICS}/
mkdir ${BASEDIR}/WebContent/results/${CORPUS}/output/T${NUMTOPICS}/init/

python scripts/generate_text_data.py --subset $SUBSET ${POSTING_JSON_PATH} ${TEXTDATAPATH}
python scripts/generate_html.py --subset $SUBSET ${POSTING_JSON_PATH} WebContent/data/${CORPUS}.html
python scripts/generate_titles.py --subset $SUBSET ${POSTING_JSON_PATH} WebContent/data/${CORPUS}.titles
python scripts/generate_url.py --subset $SUBSET $CORPUS ${POSTING_JSON_PATH} ${INPUTPATH}/${CORPUS}.url

../tree-tm/bin/mallet import-dir \
    --input $BASEDIR/text_data/$CORPUS \
    --output $BASEDIR/WebContent/results/$CORPUS/input/$CORPUS-topic-input.mallet \
    --remove-stopwords \
    --keep-sequence

../tree-tm/bin/mallet train-topics \
    --input $BASEDIR/WebContent/results/$CORPUS/input/$CORPUS-topic-input.mallet \
    --num-topics $NUMTOPICS \
    --topic-word-weights-file \
    $BASEDIR/WebContent/results/$CORPUS/output/T${NUMTOPICS}/init/model.topics \
    --output-doc-topics \
    $BASEDIR/WebContent/results/$CORPUS/output/T${NUMTOPICS}/init/model.docs
