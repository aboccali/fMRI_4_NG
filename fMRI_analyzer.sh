#$ -S /bin/bash
#$ -e /media/NG/sge_logs/
#$ -o /media/NG/sge_logs/

: <<'COMMENT'
export FSLDIR=/usr/share/fsl/6.0
. /usr/share/fsl/6.0/etc/fslconf/fsl.sh

export PATH=$PATH:/opt/Shared_Software/R2016b/bin

export SPMDIR="/media/NG/spm_mcr/spm_exec_v84"
export MCRROOT="/media/NG/MCR/v84"
export PATH="$PATH:/usr/lib64"
export SPM_LST=/opt/Shared_Software/R2016b/toolbox/spm12/toolbox/LST


# variabili di input
USER_NAME_ID=${1}
FileName_t13d=${2} # (zipped folder containig dicoms) OR (nii.gz)
FileName_fmri=${3} # (only zipped folder with json)
method=${4}
user_email=${5}
Age=${6}

fileBaseName="${FileName_t13d%%.*}"
WORK_ID=$fileBaseName

# Usa la funzione `sed` per rimuovere i trattini e gli underscore
WORK_ID=$(echo "$WORK_ID" | sed 's/[-_]//g')

# Create Unique ID for Job
# Merge toghether date, time and 2 random numbers (YYYYMMDDhhmmssrr)
date_string=$(date '+%Y-%m-%d %H:%M:%S')
day=$(echo "${date_string}" | cut -d' ' -f1 | sed 's/-//g')
hour=$(echo "${date_string}" |cut -d' ' -f2 | sed 's/://g')
rnd=$(echo $RANDOM)
rnd=${rnd:0:2}

cd /media/NG/sandbox


if [ ! -e ${USER_NAME_ID} ]; then
        mkdir ${USER_NAME_ID}
fi
cd ${USER_NAME_ID}
job_folder="${day}${hour}${rnd}"
#mkdir $job_folder
#cd $job_folder
#job_home=$(pwd)

NG_PATH=/media/NG

mkdir /media/NG/sandbox/${USER_NAME_ID}/${job_folder}/

		                                            ######################################## T13D ##############################################

#Controlla il tipo di file caricato T13D
if [ "${FileName_t13d##*.}" == "nii" ]; then
	mv /media/NG/uploads/${FileName_t13d} ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_${WORK_ID}.nii
	gzip ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_${WORK_ID}.nii
elif [ "${FileName_t13d##*.}" == "gz" ]; then
	cp /media/NG/uploads/${FileName_t13d} ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_${WORK_ID}.nii.gz 
elif [ "${FileName_t13d##*.}" == "zip" ]; then
	echo "T13D in ingresso come DICOM"
	mkdir ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_o
	unzip -j /media/NG/uploads/${FileName_t13d} -d ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_o
	if [ $(find "${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_o" -type f \( -name "*.dcm" -o ! -name "*.*" \) | wc -l) -eq 0 ]; then
		echo "ERROR: La T13D caricata come DICOM è incorretta, controlla il file caricato"
		exit
	fi

#Anonymization DICOMS
	if [ "${FileName_t13d##*.}" == "zip" ]; then
		#rm /media/NG/uploads/${FileName_t13d}
		find ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_o -type f -follow -print > ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/list_dcm
		sed -i '/^$/d' ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/list_dcm

		chmod 777 -R ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/

		while read dcm_spect; do
			tipo=`dcmdump ${dcm_spect} | grep '(0002,0010)'`
			if [[ "$tipo" == *JPEG* ]]; then
				dcmdjpeg $dcm_spect  $dcm_spect
			fi
			dcmodify --no-backup -m "(0010,0010)= " ${dcm_spect}
			dcmodify --no-backup -m "(0010,0020)= " ${dcm_spect}
			dcmodify --no-backup -m "(0010,0030)= " ${dcm_spect}
			dcmodify --no-backup -m "(0010,0032)= " ${dcm_spect}
			dcmodify --no-backup -m "(0010,0050)= " ${dcm_spect}
			dcmodify --no-backup -m "(0010,1001)= " ${dcm_spect}
			dcmodify --no-backup -m "(0010,1040)= " ${dcm_spect}
			dcmodify --no-backup -m "(0010,1060)= " ${dcm_spect}
			dcmodify --no-backup -m "(0010,2154)= " ${dcm_spect}
			dcmodify --no-backup -m "(0038,0400)= " ${dcm_spect}
			dcmodify --no-backup -m "(0008,0020)= " ${dcm_spect}
			dcmodify --no-backup -m "(0008,0021)= " ${dcm_spect}
			dcmodify --no-backup -m "(0008,0022)= " ${dcm_spect}
			dcmodify --no-backup -m "(0008,0023)= " ${dcm_spect}
			dcmodify --no-backup -m "(0008,0030)= " ${dcm_spect}
			dcmodify --no-backup -m "(0008,0031)= " ${dcm_spect}
			dcmodify --no-backup -m "(0008,0032)= " ${dcm_spect}
			dcmodify --no-backup -m "(0008,0033)= " ${dcm_spect}
			dcmodify --no-backup -m "(0008,0050)= " ${dcm_spect}
			dcmodify --no-backup -m "(0008,0080)= " ${dcm_spect}
			dcmodify --no-backup -m "(0008,0081)= " ${dcm_spect}
			dcmodify --no-backup -m "(0008,0090)= " ${dcm_spect}
			dcmodify --no-backup -m "(0010,21b0)= " ${dcm_spect}
			dcmodify --no-backup -m "(0010,21c0)= " ${dcm_spect}
			dcmodify --no-backup -m "(0032,1032)= " ${dcm_spect}
			dcmodify --no-backup -m "(0032,1033)= " ${dcm_spect}
		done < ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/list_dcm
		rm ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/list_dcm
	fi

	cd ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_o
	mmv '* *' '#1#2'
	mmv '*(*' '#1#2'
	mmv '*)*' '#1#2'
	files=(*)
	tipo=`dcmdump ${files[0]} | grep '(0002,0010)'`
	if [[ "$tipo" == *JPEG* ]]; then

		ls > sub
		while read sub; do
			dcmdjpeg $sub  $sub
		done < sub
		rm sub

	fi
	
	#dcm2niix
	export PATH=/opt/Shared_Software/dcm2niix/build/bin:$PATH
	dcm2niix ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_o
	
	img_t13d=$(ls ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_o/*.nii | head -1)
	mv ${img_t13d} ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_${WORK_ID}.nii
	gzip ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_${WORK_ID}.nii
else
	echo "ERROR: Il file T13D non è stato caricato correttamente, controlla il file caricato"
	exit
fi

echo "Check Input T13D completed correctly"

		                                            ######################################## rsfMRI ##############################################

# check input
if [ "${FileName_fmri##*.}" == "zip" ]; then

	mkdir ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/fMRI_o
	unzip -j ${NG_PATH}/uploads/${FileName_fmri} -d ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/fMRI_o

	if [ $(find "${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/fMRI_o" -type f \( -name "*.nii" -o -name "*.nii.gz" -o -name "*.dcm" -o ! -name "*.*" \) | wc -l) -eq 0 ]; then
			echo "ERROR: Nessun file .nii, .nii.gz o DICOM trovato nella .zip della rsfMRI, controlla il file caricato."
			exit
	fi

	cd ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/fMRI_o
	ifexnii1c=$(find . -maxdepth 3 -type f -name "*.nii.gz" | head -1)
	gunzip $ifexnii1c
	ifexniic=$(find . -maxdepth 3 -type f -name "*.nii" | head -1)

	if [ "$ifexniic" ]; then
		ifexjson=$(find . -maxdepth 3 -type f -name "*.json")
		
		if [ -z "$ifexjson" ]; then
			JSON=0
			echo "ERROR: File .json non presente!"
			exit
		fi
	fi
		

else
	echo "ERROR: Il file rsfMRI deve essere caricato come .zip, controlla il file caricato"
	exit
fi

# se DCM: anonimizza
if [ $(find "${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/fMRI_o" -type f \( -name "*.nii" -o -name "*.nii.gz"\) | wc -l) -eq 0 ]; then

	# anonymization DICOMS
	echo -e  "\nAnonimizza DICOM della rsfMRI:\n"
	
	find ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/fMRI_o -type f -follow -print > ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/list_dcm
	sed -i '/^$/d' ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/list_dcm
	while read dcm_spect; do
    		tipo=`dcmdump ${dcm_spect} | grep '(0002,0010)'`
    		if [[ "$tipo" == *JPEG* ]]; then
			dcmdjpeg $dcm_spect $dcm_spect
    		fi
    		dcmodify --no-backup -m "(0010,0010)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0010,0020)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0010,0030)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0010,0032)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0010,0050)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0010,1001)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0010,1040)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0010,1060)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0010,2154)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0038,0400)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0008,0020)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0008,0021)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0008,0022)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0008,0023)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0008,0030)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0008,0031)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0008,0032)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0008,0033)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0008,0050)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0008,0080)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0008,0081)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0008,0090)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0010,21b0)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0010,21c0)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0032,1032)= " ${dcm_spect}
    		dcmodify --no-backup -m "(0032,1033)= " ${dcm_spect}
	done < ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/list_dcm
fi

# se NIFTI...
cd ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/fMRI_o
chmod 777 -R ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder
ifexnii1=$(find . -maxdepth 3 -type f -name "*.nii.gz" | head -1)
gunzip $ifexnii1
ifexnii=$(find . -maxdepth 3 -type f -name "*.nii" | head -1)
echo -e "\nfile Nifti rsfMRI:\n"
echo $ifexnii

mv ${ifexnii} ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}.nii.gz

# trova json per sliceorder
ifexjson=$(find . -maxdepth 3 -type f -name "*.json")
mv ${ifexjson} ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}_VR_reor.json

mmv '* *' '#1#2'
mmv '*(*' '#1#2'
mmv '*)*' '#1#2'

# se DICOM...
if [ -z "$ifexnii" ]; then
	echo -e "\nIn ingresso DICOM\n"
	

	files=$(find . -type f -follow -print | head -1)
	echo "file dicom:"
	echo $files
	tipo=`dcmdump ${files} | grep '(0002,0010)'`
	if [[ "$tipo" == *JPEG* ]]; then
		ls > sub
		while read sub; do
			dcmdjpeg $sub $sub
		done < sub
		rm sub
	fi
	
	dcm2niix ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/fMRI_o
	
	img_fmri=$(ls ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/fMRI_o/*.nii | head -1)
	gzip ${img_fmri}
	
	img_fmri=$(ls ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/fMRI_o/*.nii.gz | head -1)
	
	# trova json per sliceorder
	ifexjson=$(find . -maxdepth 3 -type f -name "*.json")
	
	if [ -z "$img_fmri" ]; then
		cd ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/fMRI_o
		img_fmri=$(ls *.nii.gz | head -1)
		echo "IMMAGINI rsfMRI"
		echo $img_fmri
		mv ${img_fmri} ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}.nii.gz 
		mv ${ifexjson} ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}_VR_reor.json     
	else
		mv ${img_fmri} ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}.nii.gz  
		mv ${ifexjson} ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}_VR_reor.json    
	fi
fi

	

# Ottieni il numero totale di volumi (dim4)
dim4=$(fslval ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}.nii.gz dim4)

# Calcola il numero di volumi rimanenti (dim4 - 5)
remaining_volumes=$((dim4 - 5))

# Usa fslroi per rimuovere i primi 5 volumi
fslroi ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}.nii.gz ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}_VR.nii.gz 5 $remaining_volumes

fslreorient2std ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_${WORK_ID}.nii.gz ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_${WORK_ID}_reor.nii.gz
fslreorient2std ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}_VR.nii.gz ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}_VR_reor.nii.gz

echo "
addpath(genpath('/opt/Shared_Software/R2016b/toolbox/conn21a'));
% SETUP
clear CONN_x;
conn_file = ['${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/Results.mat'];
CONN_x.filename = conn_file;
CONN_x.Setup.isnew = 1;
CONN_x.Setup.functionals{1}{1}=['${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}_VR_reor.nii.gz'];
CONN_x.Setup.structurals{1}=['${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_${WORK_ID}_reor.nii.gz'];
CONN_x.Setup.nsubjects=1;
CONN_x.Setup.preprocessing.steps='default_mni';
CONN_x.Setup.preprocessing.sliceorder='${method}';
CONN_x.Setup.done = 1;

CONN_x.Denoising.done = 1;

CONN_x.Analysis.done = 1;
CONN_x.Analysis.type = 1; %ROI-to-ROI
CONN_x.Analysis.name='Results';
CONN_x.Analysis.sources={'networks.DefaultMode','networks.SensoriMotor','networks.Visual','networks.Salience','networks.DorsalAttention','networks.FrontoParietal','networks.Language','networks.Cerebellar'}

CONN_x.QA.plots = {'QA_NORM structural', 'QA_NORM functional', 'QA_NORM rois', 'QA_REG functional', 'QA_REG structural', 'QA_REG mni', 'QA_COREG functional', 'QA_TIME functional', 'QA_TIMEART functional', 'QA_DENOISE histogram', 'QA_DENOISE timeseries', 'QA_DENOISE FC-QC', 'QA_DENOISE scatterplot', 'QA_SPM design', 'QA_SPM contrasts' ,'QA_SPM results', 'QA_COV'}

% Running the batch
conn_batch(CONN_x);
" > CONN_job.m


# Lancia CONN
/opt/Shared_Software/R2016b/bin/matlab -nodesktop -nosplash -r "CONN_job" -softwareopengl
COMMENT

cd /media/Neuroinformatica/fMRI_4_NG/scripts/PROVE_SCRIPTS

# Crea la matrice delle medie delle FC
cp /media/Neuroinformatica/fMRI_4_NG/scripts/NG/create_FC_matrix.m /media/Neuroinformatica/fMRI_4_NG/scripts/PROVE_SCRIPTS/create_FC_matrix.m

/opt/Shared_Software/R2016b/bin/matlab -nodisplay -nosplash -r "global var1 var2; var1='scripts'; var2='PROVE_SCRIPTS'; create_FC_matrix; exit;"

echo "analisi CONN in MATLAB completata!"

# Crea CSV
cp /media/Neuroinformatica/fMRI_4_NG/scripts/NG/header.csv /media/Neuroinformatica/fMRI_4_NG/scripts/PROVE_SCRIPTS/header.csv

# Aggiungi l'età del soggetto al CSV
echo "$(cat Mean_FC_matrix.csv),80" > Mean_FC_matrix.csv


cat header.csv Mean_FC_matrix.csv > Mean_FC_matrix_final.csv


cp /media/Neuroinformatica/fMRI_4_NG/scripts/NG/Total_mean_FC_matrix.csv /media/Neuroinformatica/fMRI_4_NG/scripts/PROVE_SCRIPTS/Total_mean_FC_matrix.csv
cp /media/Neuroinformatica/fMRI_4_NG/scripts/NG/Create_normative_NG.r /media/Neuroinformatica/fMRI_4_NG/scripts/PROVE_SCRIPTS/Create_normative_NG.r

# Crea normativa 
chmod +x Create_normative_NG.r
./Create_normative_NG.r



# Crea report
cp /media/Neuroinformatica/fMRI_4_NG/scripts/NG/template.tex /media/Neuroinformatica/fMRI_4_NG/scripts/PROVE_SCRIPTS/REPORT.tex

sed -i "s#@@ID@@#sub#" REPORT.tex
sed -i "s#@@AGE@@#80#" REPORT.tex

pdflatex REPORT.tex
mv REPORT.pdf sub_REPORT.pdf


################### SENDING REPORT ########################

#cd /media/Neuroinformatica/fMRI_4_NG/scripts/PROVE_SCRIPTS
#mkdir Output


# Create file for download output
#mv Output ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/Output_ng2

#cp ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/Mean_FC_matrix_final.csv ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/Output_ng2
#cp ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/rsfMRI_${WORK_ID}_VR_reor.nii.gz ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/Output_ng2
#cp ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/T13D_${WORK_ID}_reor.nii.gz ${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/Output_ng2

#zip -r Output_ng2.zip Output_ng2
#rm -rf Output_ng2

# Sending report through Mail
#cp /media/NG/scripts/mail.sh ./mail.sh
#chmod +x ./mail.sh

#./mail.sh "fMRI_analyzer" "${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder/${WORK_ID}_REPORT.pdf" "${user_email}" "${NG_PATH}/sandbox/${USER_NAME_ID}/$job_folder"



















