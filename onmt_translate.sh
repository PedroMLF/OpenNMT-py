# Generic things
SOURCE=de
TARGET=en
LANGPAIR=${SOURCE}-${TARGET}
DATA=extra_data

# Specific things to translation
MODEL_NAME=de-en-md-base_acc_79.50_ppl_2.67_e15.pt
#MODEL_NAME=preprocessed_softmax_cattn-0_acc_43.02_ppl_69.09_e9.pt
SRC_FILE=test.de

# Call the OpenNMT-py script
python3 translate.py \
	    -model ${DATA}/${MODEL_NAME} \
		-src ${DATA}/${SRC_FILE} \
		-output ${DATA}/${SRC_FILE}.pred \
		-beam_size 10 \
        -replace_unk \
        -log_file "extra_data/log"

# Copy the predictions to the right folders
#HOME_PATH=/home/pmlf/Documents/github/NMT-Code/attention_comparison/thesis/guided_nmt
HOME_PATH=/home/ubuntu/NMT-Code/attention_comparison/thesis/guided_nmt
PRED_PATH=${HOME_PATH}/generate_results_de_en_domain/preds
MT_PATH=${HOME_PATH}/generate_results_de_en_domain/mt_predictions

#POS=guided_10-th0pt5-true
POS=guided_10-th0pt5-corrected-true
cp ${DATA}/${SRC_FILE}.pred ${PRED_PATH}/${SRC_FILE}.pred.${POS}
sed -r 's/(@@ )|(@@ ?$)//g' ${PRED_PATH}/${SRC_FILE}.pred.${POS} > \
	                                     ${MT_PATH}/${SRC_FILE}.pred.${POS}.merged
