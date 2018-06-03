# Generic things
SOURCE=de
TARGET=en
LANGPAIR=${SOURCE}-${TARGET}
DATA=extra_data

# Specific things to translation
MODEL_NAME=${DATA}/preprocessed_softmax_cattn-0_acc_43.02_ppl_69.09_e9.pt
SRC_FILE=newstest2016.bpe.sink.de

# Call the OpenNMT-py script
python3 ${ONMT}/translate.py \
	-model ${MODEL_NAME} \
	-src ${SRC_FILE} \
	-output ${SRC_FILE}.pred \
	-beam_size 10 \
	-replace_unk \
	-gpu 0

# Copy the predictions to the right folders
HOME_PATH=/home/ubuntu/NMT-code/attention_comparison/thesis
PRED_PATH=${HOME_PATH}/generate_results_de_en/preds
MT_PATH=${HOME_PATH}/generate_results_de_en/mt_predictions
cp ${SRC_FILE}.pred ${PRED_PATH}
sed -r 's/(@@ )|(@@ ?$)//g' ${PRED_PATH}/${SRC_FILE}.pred > \
	                                     ${MT_PATH}/${SRC_FILE}.pred.merged
