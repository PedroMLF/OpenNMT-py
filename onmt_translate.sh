# Generic things
SOURCE=de
TARGET=en
LANGPAIR=${SOURCE}-${TARGET}
DATA=extra_data

# Specific things to translation
MODEL_NAME=preprocessed_softmax_cattn-0_acc_43.02_ppl_69.09_e9.pt
SRC_FILE=newstest2016.bpe.sink.de

# Call the OpenNMT-py script
python3 translate.py \
	    -model ${DATA}/${MODEL_NAME} \
		-src ${DATA}/${SRC_FILE} \
		-output ${DATA}/${SRC_FILE}.pred \
		-beam_size 10 \
   		-replace_unk

# Copy the predictions to the right folders
#HOME_PATH=/home/ubuntu/NMT-Code/attention_comparison/thesis/guided_nmt
HOME_PATH=/home/pmlf/Documents/github/NMT-Code/attention_comparison/thesis/guided_nmt
PRED_PATH=${HOME_PATH}/generate_results_de_en/preds
MT_PATH=${HOME_PATH}/generate_results_de_en/mt_predictions

cp ${DATA}/${SRC_FILE}.pred ${PRED_PATH}/
sed -r 's/(@@ )|(@@ ?$)//g' ${PRED_PATH}/${SRC_FILE}.pred > \
	                                     ${MT_PATH}/${SRC_FILE}.pred.merged
