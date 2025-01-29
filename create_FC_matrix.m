

function create_FC_matrix()
    global var1 var2;
	% Combina i componenti del percorso
	base_path = '/media/Neuroinformatica/fMRI_4_NG';
	
	scripts = var1;
    	PROVE_SCRIPTS = var2;
	output_folder = fullfile(base_path, scripts, PROVE_SCRIPTS);

	% Inizializza la matrice delle medie
	matrice_medie = [];

	% Calcola le medie (chiamando la funzione di esempio)
	medie_calcolate = calcolo_medie_CONN_mni(matrice_medie, output_folder);

	% Crea il nome del file CSV
	csv_filename = fullfile(output_folder, 'Mean_FC_matrix.csv');

	% Salva le medie calcolate in un file CSV
	dlmwrite(csv_filename, medie_calcolate, 'delimiter', ',', 'precision', 6);
	disp(['File CSV salvato in: ', csv_filename]);
end



function [aaa] = calcolo_medie_CONN_mni(matrice_medie, output_folder)


mat_file = fullfile(output_folder, 'Results', 'results', 'firstlevel', 'Results', 'resultsROI_Condition001.mat');

load(mat_file);

vettore_medie = zeros(1,36);
header = cell(1,36);

media_DefaultMode = mean([Z(2:4,1); Z(3:4,2); Z(4,3)]);
vettore_medie(1) = media_DefaultMode;
header{1} = 'media_DefaultMode';
media_SensoriMotor = mean([Z(6:7,5); Z(7,6)]);
vettore_medie(2) = media_SensoriMotor;
header{2} = 'media_SensoriMotor'; 
media_Visual = mean([Z(9:11,8); Z(10:11,9); Z(11,10)]);
vettore_medie(3) = media_Visual;
header{3} = 'media_Visual';
media_Salience = mean([Z(13:18,12); Z(14:18,13); Z(15:18,14); Z(16:18,15); Z(17:18,16); Z(18, 17)]);
vettore_medie(4) = media_Salience;
header{4} = 'media_Salience';
media_DorsalAttention = mean([Z(20:22,19); Z(21:22,20); Z(22,21)]);
vettore_medie(5) = media_DorsalAttention;
header{5} =  'media_DorsalAttention';
media_FrontoParietal = mean ([Z(24:26,23); Z(25:26,24); Z(26,25)]);
vettore_medie(6) = media_FrontoParietal;
header{6} = 'media_FrontoParietal';
media_Language = mean([Z(28:30,27); Z(29:30,28); Z(30,29)]);
vettore_medie(7) = media_Language;
header{7} = 'media_Language';
media_Cerebellar = mean(Z(32,31));
vettore_medie(8) = media_Cerebellar;
header{8} = 'media_Cerebellar';

%DefaultMode
media_DefaultMode_SensoriMotor = mean([Z(1:4,5); Z(1:4,6); Z(1:4,7)]);
vettore_medie(9) = media_DefaultMode_SensoriMotor;
header{9} = 'media_DefaultMode_SensoriMotor';
media_DefaultMode_Visual = mean([Z(1:4,8); Z(1:4,9); Z(1:4,10); Z(1:4,11)]);
vettore_medie(10) = media_DefaultMode_Visual;
header{10} = 'media_DefaultMode_Visual';
media_DefaultMode_Salience = mean([Z(1:4,12); Z(1:4,13); Z(1:4,14); Z(1:4,15); Z(1:4,16); Z(1:4,17); Z(1:4,18)]);
vettore_medie(11) = media_DefaultMode_Salience;
header{11} = 'media_DefaultMode_Salience';
media_DefaultMode_DorsalAttention = mean([Z(1:4,19); Z(1:4,20); Z(1:4,21); Z(1:4,22)]);
vettore_medie(12) = media_DefaultMode_DorsalAttention;
header{12} = 'media_DefaultMode_DorsalAttention';
media_DefaultMode_FrontoParietal = mean([Z(1:4,23); Z(1:4,24); Z(1:4,25); Z(1:4,26)]);
vettore_medie(13) = media_DefaultMode_FrontoParietal;
header{13} = 'media_DefaultMode_FrontoParietal';
media_DefaultMode_Language = mean([Z(1:4,27); Z(1:4,28); Z(1:4,29); Z(1:4,30)]);
vettore_medie(14) = media_DefaultMode_Language;
header{14} = 'media_DefaultMode_Language';
media_DefaultMode_Cerebellar = mean([Z(1:4,31); Z(1:4,32)]);
vettore_medie(15) = media_DefaultMode_Cerebellar;
header{15} = 'media_DefaultMode_Cerebellar';

%SensoriMotor
media_SensoriMotor_Visual = mean([Z(5:7,8); Z(5:7,9); Z(5:7,10); Z(5:7,11)]);
vettore_medie(16) = media_SensoriMotor_Visual;
header{16} = 'media_SensoriMotor_Visual';
media_SensoriMotor_Salience = mean([Z(5:7,12); Z(5:7,13); Z(5:7,14); Z(5:7,15); Z(5:7,16); Z(5:7,17); Z(5:7,18)]);
vettore_medie(17) = media_SensoriMotor_Salience;
header{17} = 'media_SensoriMotor_Salience';
media_SensoriMotor_DorsalAttention = mean([Z(5:7,19); Z(5:7,20); Z(5:7,21); Z(5:7,22)]);
vettore_medie(18) = media_SensoriMotor_DorsalAttention;
header{18} = 'media_SensoriMotor_DorsalAttention';
media_SensoriMotor_FrontoParietal = mean([Z(5:7,23); Z(5:7,24); Z(5:7,25); Z(5:7,26)]);
vettore_medie(19) = media_SensoriMotor_FrontoParietal;
header{19} = 'media_SensoriMotor_FrontoParietal';
media_SensoriMotor_Language = mean([Z(5:7,27); Z(5:7,28); Z(5:7,29); Z(5:7,30)]);
vettore_medie(20) = media_SensoriMotor_Language;
header{20} = 'media_SensoriMotor_Language';
media_SensoriMotor_Cerebellar = mean([Z(5:7,31); Z(5:7,32)]);
vettore_medie(21) = media_SensoriMotor_Cerebellar;
header{21} = 'media_SensoriMotor_Cerebellar';

%Visual
media_Visual_Salience = mean([Z(8:11,12); Z(8:11,13); Z(8:11,14); Z(8:11,15); Z(8:11,16); Z(8:11,17); Z(8:11,18)]);
vettore_medie(22) = media_Visual_Salience;
header{22} = 'media_Visual_Salience';
media_Visual_DorsalAttention = mean([Z(8:11,19); Z(8:11,20); Z(8:11,21); Z(8:11,22)]);
vettore_medie(23) = media_Visual_DorsalAttention;
header{23} = 'media_Visual_DorsalAttention';
media_Visual_FrontoParietal=mean([Z(8:11,23); Z(8:11,24); Z(8:11,25); Z(8:11,26)]);
vettore_medie(24) = media_Visual_FrontoParietal;
header{24} = 'media_Visual_FrontoParietal';
media_Visual_Language = mean([Z(8:11,27); Z(8:11,28); Z(8:11,29); Z(8:11,30)]);
vettore_medie(25) = media_Visual_Language;
header{25} = 'media_Visual_Language';
media_Visual_Cerebellar = mean([Z(8:11,31); Z(8:11,32)]);
vettore_medie(26) = media_Visual_Cerebellar;
header{26} = 'media_Visual_Cerebellar';

%Salience
media_Salience_DorsalAttention = mean([Z(12:18,19); Z(12:18,20); Z(12:18,21); Z(12:18,22)]);
vettore_medie(27) = media_Salience_DorsalAttention;
header{27} = 'media_Salience_DorsalAttention';
media_Salience_FrontoParietal=mean([Z(12:18,23); Z(12:18,24); Z(12:18,25); Z(12:18,26)]);
vettore_medie(28) = media_Salience_FrontoParietal;
header{28} = 'media_Salience_FrontoParietal';
media_Salience_Language=mean([Z(12:18,27); Z(12:18,28); Z(12:18,29); Z(12:18,30)]);
vettore_medie(29) = media_Salience_Language;
header{29} = 'media_Salience_Language';
media_Salience_Cerebellar = mean([Z(12:18,31); Z(12:18,32)]);
vettore_medie(30) = media_Salience_Cerebellar;
header{30} = 'media_Salience_Cerebellar';

%DorsalAttention
media_DorsalAttention_FrontoParietal=mean([Z(19:22,23); Z(19:22,24); Z(19:22,25); Z(19:22,26)]);
vettore_medie(31) = media_DorsalAttention_FrontoParietal;
header{31} = 'media_DorsalAttention_FrontoParietal';
media_DorsalAttention_Language=mean([Z(19:22,27); Z(19:22,28); Z(19:22,29); Z(19:22,30)]);
vettore_medie(32) = media_DorsalAttention_Language;
header{32} = 'media_DorsalAttention_Language';
media_DorsalAttention_Cerebellar = mean([Z(19:22,31); Z(19:22,32)]);
vettore_medie(33) = media_DorsalAttention_Cerebellar;
header{33} = 'media_DorsalAttention_Cerebellar';

%FrontoParietal
media_FrontoParietal_Language=mean([Z(23:26,27); Z(23:26,28); Z(23:26,29); Z(23:26,30)]);
vettore_medie(34) = media_FrontoParietal_Language;
header{34} = 'media_FrontoParietal_Language';
media_FrontoParietal_Cerebellar = mean([Z(23:26,31); Z(23:26,32)]);
vettore_medie(35) = media_FrontoParietal_Cerebellar;
header{35} = 'media_FrontoParietal_Cerebellar';

%Language
media_Language_Cerebellar = mean([Z(27:30,31); Z(27:30,32)]);
vettore_medie(36) = media_Language_Cerebellar;
header{36} = 'media_Language_Cerebellar';


%creo header con nomi medie
%header_csv = cell2table(header');
%filename1 = 'header.csv';
%writetable(header_csv, filename1);

aaa = [matrice_medie; vettore_medie];

end




