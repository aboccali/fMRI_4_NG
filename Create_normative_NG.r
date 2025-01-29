#!/usr/bin/Rscript

library(gamlss)

df <- read.csv("Total_mean_FC_matrix.csv")
df_newsubj <- read.csv("Mean_FC_matrix_final.csv")

head(df)

if (FALSE) {
									######## FIND PERFECT MODEL #######

##################### DefaultMode #######################

# Confronta distribuzioni per i tuoi dati
fit <- fitDist(df$media_DefaultMode, type = c("realline"), k = 2, try.gamlss = FALSE, control = list(maxit = 10000), trace = TRUE) 
print("###### DEFAULT MODE ######")
summary(fit)
warnings()



##################### SensoriMotor #######################

# Confronta distribuzioni per i tuoi dati
fit <- fitDist(df$media_SensoriMotor, type = c("realline"), k = 2, try.gamlss = FALSE, control = list(maxit = 10000), trace = TRUE) 
print("###### SENSORI MOTOR ######")
summary(fit)
warnings()



##################### Visual #######################

# Confronta distribuzioni per i tuoi dati
fit <- fitDist(df$media_Visual, type = c("realline"), k = 2, try.gamlss = FALSE, control = list(maxit = 10000), trace = TRUE) 
print("###### VISUAL ######")
summary(fit)
warnings()



##################### Salience #######################

# Confronta distribuzioni per i tuoi dati
fit <- fitDist(df$media_Salience, type = c("realline"), k = 2, try.gamlss = FALSE, control = list(maxit = 10000), trace = TRUE) 
print("###### SALIENCE ######")
summary(fit)
warnings()



##################### DorsalAttention #######################

# Confronta distribuzioni per i tuoi dati
fit <- fitDist(df$media_DorsalAttention, type = c("realline"), k = 2, try.gamlss = FALSE, control = list(maxit = 10000), trace = TRUE) 
print("###### DORSAL ATTENTION ######")
summary(fit)
warnings()



##################### FrontoParietal #######################

# Confronta distribuzioni per i tuoi dati
fit <- fitDist(df$media_FrontoParietal, type = c("realline"), k = 2, try.gamlss = FALSE, control = list(maxit = 10000), trace = TRUE) 
print("###### FRONTO PARIETAL ######")
summary(fit)
warnings()



##################### Language #######################

# Confronta distribuzioni per i tuoi dati
fit <- fitDist(df$media_Language, type = c("realline"), k = 2, try.gamlss = FALSE, control = list(maxit = 10000), trace = TRUE) 
print("###### LANGUAGE ######")
summary(fit)
warnings()



##################### Cerebellar #######################

# Confronta distribuzioni per i tuoi dati
fit <- fitDist(df$media_Cerebellar, type = c("realline"), k = 2, try.gamlss = FALSE, control = list(maxit = 10000), trace = TRUE) 
print("###### CEREBELLAR ######")
summary(fit)
warnings()

}
									######## CREATE PERCENTILES AND PLOT #######

##################### DefaultMode #######################

Ghippleft<-gamlss(media_DefaultMode~pb(Age),sigma.fo=~pb(Age),data=df,method=mixed(1,3000),family=SN2())
#plot(Ghippleft)


# Salva il grafico come file PNG
png("DefaultMode.png", width = 800, height = 600, res = 150)

centiles(Ghippleft,xvar=df$Age,cent=c(25,50,75),legend=FALSE,points=TRUE,main='Default Mode Network',col.centiles=c("red","blue","green"),lty.centiles=c(1,1,1),xlab='Age',ylab='Mean Z-score',xlim= c(50,100), ylim= c(-0.5,1.5))

legend(
  "topright", 
  legend = c("25%","50%","75%"), 
  col = c("red", "blue", "green"),  # Colori delle linee
  lty = c(1, 1, 1),  # Stili delle linee corrispondenti
  #title = "Centiles",  # Titolo opzionale della legenda
  cex = 0.8  # Dimensione del testo della legenda
)

# Aggiungi il punto del nuovo soggetto
points(df_newsubj$Age, df_newsubj$media_DefaultMode, col = "red", pch = 19, cex = 1)

##################### SensoriMotor #######################

Ghippleft<-gamlss(media_SensoriMotor~pb(Age),sigma.fo=~pb(Age),data=df,method=mixed(1,3000),family=SN2())
#plot(Ghippleft)


# Salva il grafico come file PNG
png("SensoriMotor.png", width = 800, height = 600, res = 150)

centiles(Ghippleft,xvar=df$Age,cent=c(25,50,75),legend=FALSE,points=TRUE,main='Sensori Motor Network',col.centiles=c("red","blue","green"),lty.centiles=c(1,1,1),xlab='Age',ylab='Mean Z-score',xlim= c(50,100), ylim= c(-0.5,1.5))

legend(
  "topright", 
  legend = c("25%","50%","75%"), 
  col = c("red", "blue", "green"),  # Colori delle linee
  lty = c(1, 1, 1),  # Stili delle linee corrispondenti
  #title = "Centiles",  # Titolo opzionale della legenda
  cex = 0.8  # Dimensione del testo della legenda
)

# Aggiungi il punto del nuovo soggetto
points(df_newsubj$Age, df_newsubj$media_SensoriMotor, col = "red", pch = 19, cex = 1)

##################### Visual #######################

Ghippleft<-gamlss(media_Visual~pb(Age),sigma.fo=~pb(Age),data=df,method=mixed(1,3000),family=SEP1())
#plot(Ghippleft)


# Salva il grafico come file PNG
png("Visual.png", width = 800, height = 600, res = 150)

centiles(Ghippleft,xvar=df$Age,cent=c(25,50,75),legend=FALSE,points=TRUE,main='Visual Network',col.centiles=c("red","blue","green"),lty.centiles=c(1,1,1),xlab='Age',ylab='Mean Z-score',xlim= c(50,100), ylim= c(-0.5,1.5))

legend(
  "topright", 
  legend = c("25%","50%","75%"), 
  col = c("red", "blue", "green"),  # Colori delle linee
  lty = c(1, 1, 1),  # Stili delle linee corrispondenti
  #title = "Centiles",  # Titolo opzionale della legenda
  cex = 0.8  # Dimensione del testo della legenda
)

# Aggiungi il punto del nuovo soggetto
points(df_newsubj$Age, df_newsubj$media_Visual, col = "red", pch = 19, cex = 1)

##################### Salience #######################

Ghippleft<-gamlss(media_Salience~pb(Age),sigma.fo=~pb(Age),data=df,method=mixed(1,3000),family=SN2())
#plot(Ghippleft)


# Salva il grafico come file PNG
png("Salience.png", width = 800, height = 600, res = 150)

centiles(Ghippleft,xvar=df$Age,cent=c(25,50,75),legend=FALSE,points=TRUE,main='Salience Network',col.centiles=c("red","blue","green"),lty.centiles=c(1,1,1),xlab='Age',ylab='Mean Z-score',xlim= c(50,100), ylim= c(-0.5,1.5))

legend(
  "topright", 
  legend = c("25%","50%","75%"), 
  col = c("red", "blue", "green"),  # Colori delle linee
  lty = c(1, 1, 1),  # Stili delle linee corrispondenti
  #title = "Centiles",  # Titolo opzionale della legenda
  cex = 0.8  # Dimensione del testo della legenda
)

# Aggiungi il punto del nuovo soggetto
points(df_newsubj$Age, df_newsubj$media_Salience, col = "red", pch = 19, cex = 1)

##################### DorsalAttention #######################

Ghippleft<-gamlss(media_DorsalAttention~pb(Age),sigma.fo=~pb(Age),data=df,method=mixed(1,3000),family=SN2())
#plot(Ghippleft)


# Salva il grafico come file PNG
png("DorsalAttention.png", width = 800, height = 600, res = 150)

centiles(Ghippleft,xvar=df$Age,cent=c(25,50,75),legend=FALSE,points=TRUE,main='Dorsal Attention Network',col.centiles=c("red","blue","green"),lty.centiles=c(1,1,1),xlab='Age',ylab='Mean Z-score',xlim= c(50,100), ylim= c(-0.5,1.5))

legend(
  "topright", 
  legend = c("25%","50%","75%"), 
  col = c("red", "blue", "green"),  # Colori delle linee
  lty = c(1, 1, 1),  # Stili delle linee corrispondenti
  #title = "Centiles",  # Titolo opzionale della legenda
  cex = 0.8  # Dimensione del testo della legenda
)

# Aggiungi il punto del nuovo soggetto
points(df_newsubj$Age, df_newsubj$media_DorsalAttention, col = "red", pch = 19, cex = 1)

##################### FrontoParietal #######################

Ghippleft<-gamlss(media_FrontoParietal~pb(Age),sigma.fo=~pb(Age),data=df,method=mixed(1,3000),family=NO())
#plot(Ghippleft)


# Salva il grafico come file PNG
png("FrontoParietal.png", width = 800, height = 600, res = 150)

centiles(Ghippleft,xvar=df$Age,cent=c(25,50,75),legend=FALSE,points=TRUE,main='Fronto Parietal Network',col.centiles=c("red","blue","green"),lty.centiles=c(1,1,1),xlab='Age',ylab='Mean Z-score',xlim= c(50,100), ylim= c(-0.5,1.5))

legend(
  "topright", 
  legend = c("25%","50%","75%"), 
  col = c("red", "blue", "green"),  # Colori delle linee
  lty = c(1, 1, 1),  # Stili delle linee corrispondenti
  #title = "Centiles",  # Titolo opzionale della legenda
  cex = 0.8  # Dimensione del testo della legenda
)

# Aggiungi il punto del nuovo soggetto
points(df_newsubj$Age, df_newsubj$media_FrontoParietal, col = "red", pch = 19, cex = 1)

##################### Language #######################

Ghippleft<-gamlss(media_Language~pb(Age),sigma.fo=~pb(Age),data=df,method=mixed(1,3000),family=SN2())
#plot(Ghippleft)


# Salva il grafico come file PNG
png("Language.png", width = 800, height = 600, res = 150)

centiles(Ghippleft,xvar=df$Age,cent=c(25,50,75),legend=FALSE,points=TRUE,main='Language Network',col.centiles=c("red","blue","green"),lty.centiles=c(1,1,1),xlab='Age',ylab='Mean Z-score',xlim= c(50,100), ylim= c(-0.5,1.5))

legend(
  "topright", 
  legend = c("25%","50%","75%"), 
  col = c("red", "blue", "green"),  # Colori delle linee
  lty = c(1, 1, 1),  # Stili delle linee corrispondenti
  #title = "Centiles",  # Titolo opzionale della legenda
  cex = 0.8  # Dimensione del testo della legenda
)

# Aggiungi il punto del nuovo soggetto
points(df_newsubj$Age, df_newsubj$media_Language, col = "red", pch = 19, cex = 1)

##################### Cerebellar #######################

Ghippleft<-gamlss(media_Cerebellar~pb(Age),sigma.fo=~pb(Age),data=df,method=mixed(1,3000),family=SN2())
#plot(Ghippleft)


# Salva il grafico come file PNG
png("Cerebellar.png", width = 800, height = 600, res = 150)

centiles(Ghippleft,xvar=df$Age,cent=c(25,50,75),legend=FALSE,points=TRUE,main='Cerebellar Network',col.centiles=c("red","blue","green"),lty.centiles=c(1,1,1),xlab='Age',ylab='Mean Z-score',xlim= c(50,100), ylim= c(-0.5,1.5))

legend(
  "topright", 
  legend = c("25%","50%","75%"), 
  col = c("red", "blue", "green"),  # Colori delle linee
  lty = c(1, 1, 1),  # Stili delle linee corrispondenti
  #title = "Centiles",  # Titolo opzionale della legenda
  cex = 0.8  # Dimensione del testo della legenda
)

# Aggiungi il punto del nuovo soggetto
points(df_newsubj$Age, df_newsubj$media_Cerebellar, col = "red", pch = 19, cex = 1)

#}


                                                                          ################## BOXPLOT ##################


png("Boxplot_Cerebellar_age.png", width = 800, height = 600, res = 150)

boxplot(media_Cerebellar ~ Age, data = df, 
        main = "Mean Z-score of Cerebellar FC",
        xlab = "Età", 
        ylab = "Mean Z-score", 
        col = rainbow(length(unique(df$Age))))
        
# Determina la posizione sull'asse X corrispondente all'età del nuovo soggetto
# Usa `which()` per trovare l'indice corrispondente al livello del fattore Age
age_levels <- sort(unique(df$Age))  # Ordina i livelli di età
x_pos <- which(age_levels == df_newsubj$Age)  # Trova la posizione corretta

# Aggiungi il punto del nuovo soggetto
points(x_pos, df_newsubj$media_Cerebellar, 
       col = "red", pch = 19, cex = 1.5)

#if (FALSE) {      
png("Boxplot_DM.png", width = 800, height = 600, res = 150)
      
boxplot(df$media_DefaultMode,
        main = "Mean Z-score of Default Mode FC",
        ylab = "Mean Z-score",
        #col = "skyblue",
        #border = "skyblue",
        #medcol = "darkblue",  # Colore della mediana
        #whiskcol = "green",  # Colore dei baffi
        #staplecol = "orange", # Colore delle graffette
        outpch = 19,  # Forma dei punti outlier (19 = cerchio pieno)
        outcol = "black", # Colore dei punti outlier
        cex = 0.5
)

# Aggiungi il punto del nuovo soggetto
points(1, df_newsubj$media_DefaultMode, col = "red", pch = 19, cex = 1)

png("Boxplot_Sensori.png", width = 800, height = 600, res = 150)
      
boxplot(df$media_SensoriMotor,
        main = "Mean Z-score of SensoriMotor FC",
        ylab = "Mean Z-score",
        #col = "skyblue",
        #border = "skyblue",
        #medcol = "darkblue",  # Colore della mediana
        #whiskcol = "green",  # Colore dei baffi
        #staplecol = "orange", # Colore delle graffette
        outpch = 19,  # Forma dei punti outlier (19 = cerchio pieno)
        outcol = "black", # Colore dei punti outlier
        cex = 0.5
)

# Aggiungi il punto del nuovo soggetto
points(1, df_newsubj$media_SensoriMotor, col = "red", pch = 19, cex = 1)

png("Boxplot_Visual.png", width = 800, height = 600, res = 150)
      
boxplot(df$media_Visual,
        main = "Mean Z-score of Visual FC",
        ylab = "Mean Z-score",
        #col = "skyblue",
        #border = "skyblue",
        #medcol = "darkblue",  # Colore della mediana
        #whiskcol = "green",  # Colore dei baffi
        #staplecol = "orange", # Colore delle graffette
        outpch = 19,  # Forma dei punti outlier (19 = cerchio pieno)
        outcol = "black", # Colore dei punti outlier
        cex = 0.5
)

# Aggiungi il punto del nuovo soggetto
points(1, df_newsubj$media_Visual, col = "red", pch = 19, cex = 1)

png("Boxplot_Salience.png", width = 800, height = 600, res = 150)
      
boxplot(df$media_Salience,
        main = "Mean Z-score of Salience FC",
        ylab = "Mean Z-score",
        #col = "skyblue",
        #border = "skyblue",
        #medcol = "darkblue",  # Colore della mediana
        #whiskcol = "green",  # Colore dei baffi
        #staplecol = "orange", # Colore delle graffette
        outpch = 19,  # Forma dei punti outlier (19 = cerchio pieno)
        outcol = "black", # Colore dei punti outlier
        cex = 0.5
)   
 
# Aggiungi il punto del nuovo soggetto
points(1, df_newsubj$media_Salience, col = "red", pch = 19, cex = 1)
  
png("Boxplot_DorsalAttention.png", width = 800, height = 600, res = 150)
      
boxplot(df$media_DorsalAttention,
        main = "Mean Z-score of Dorsal Attention FC",
        ylab = "Mean Z-score",
        #col = "skyblue",
        #border = "skyblue",
        #medcol = "darkblue",  # Colore della mediana
        #whiskcol = "green",  # Colore dei baffi
        #staplecol = "orange", # Colore delle graffette
        outpch = 19,  # Forma dei punti outlier (19 = cerchio pieno)
        outcol = "black", # Colore dei punti outlier
        cex = 0.5
)

# Aggiungi il punto del nuovo soggetto
points(1, df_newsubj$media_DorsalAttention, col = "red", pch = 19, cex = 1)

png("Boxplot_FrontoParietal.png", width = 800, height = 600, res = 150)
      
boxplot(df$media_FrontoParietal,
        main = "Mean Z-score of Fronto Parietal FC",
        ylab = "Mean Z-score",
        #col = "skyblue",
        #border = "skyblue",
        #medcol = "darkblue",  # Colore della mediana
        #whiskcol = "green",  # Colore dei baffi
        #staplecol = "orange", # Colore delle graffette
        outpch = 19,  # Forma dei punti outlier (19 = cerchio pieno)
        outcol = "black", # Colore dei punti outlier
        cex = 0.5
)

# Aggiungi il punto del nuovo soggetto
points(1, df_newsubj$media_FrontoParietal, col = "red", pch = 19, cex = 1)

png("Boxplot_Language.png", width = 800, height = 600, res = 150)
      
boxplot(df$media_Language,
        main = "Mean Z-score of Language FC",
        ylab = "Mean Z-score",
        #col = "skyblue",
        #border = "skyblue",
        #medcol = "darkblue",  # Colore della mediana
        #whiskcol = "green",  # Colore dei baffi
        #staplecol = "orange", # Colore delle graffette
        outpch = 19,  # Forma dei punti outlier (19 = cerchio pieno)
        outcol = "black", # Colore dei punti outlier
        cex = 0.5
)

# Aggiungi il punto del nuovo soggetto
points(1, df_newsubj$media_Language, col = "red", pch = 19, cex = 1)

png("Boxplot_Cerebellar.png", width = 800, height = 600, res = 150)
      
boxplot(df$media_Cerebellar,
        main = "Mean Z-score of Cerebellar FC",
        ylab = "Mean Z-score",
        #col = "skyblue",
        #border = "skyblue",
        #medcol = "darkblue",  # Colore della mediana
        #whiskcol = "green",  # Colore dei baffi
        #staplecol = "orange", # Colore delle graffette
        outpch = 19,  # Forma dei punti outlier (19 = cerchio pieno)
        outcol = "black", # Colore dei punti outlier
        cex = 0.5
)

# Aggiungi il punto del nuovo soggetto
points(1, df_newsubj$media_Cerebellar, col = "red", pch = 19, cex = 1)

#}



