## ----plot_margins,echo=F-------------------------------------------------
par(mai=c(1,0.5,0,0))

## ----read_life_expectancy------------------------------------------------
download.file(destfile="life_expectancy.txt",
  url="https://ionides.github.io/401w18/01/life_expectancy.txt")

## ----read_e0-------------------------------------------------------------
L <- read.table(file="life_expectancy.txt",header=TRUE)

## ----LE_rows-------------------------------------------------------------
L[1:3,]

## ----dim-----------------------------------------------------------------
dim(L)

## ----row+col-------------------------------------------------------------
cat("number of rows = ", nrow(L), 
  "; number of columns = ", ncol(L))

## ----vec-----------------------------------------------------------------
y <- L[,4]
y[1:3]

## ----dim_for_vec---------------------------------------------------------
dim(y)

## ----length_for_vec------------------------------------------------------
length(y)

## ----e0_gain-------------------------------------------------------------
g <- y[2:length(y)] - y[1:(length(y)-1)] 

## ----e0_gain_with_na-----------------------------------------------------
g <- c(NA,g)
g[1:8]

## ----numeric_vec---------------------------------------------------------
g[1:4]

## ----logical_vec---------------------------------------------------------
L_up_logical <- g>0
L_up_logical[1:4]

## ----character_vec-------------------------------------------------------
L_up_qualitative <- ifelse(g>0,"increased","decreased")
L_up_qualitative[1:4]

## ------------------------------------------------------------------------
class(g)

## ------------------------------------------------------------------------
class(L_up_logical)

## ------------------------------------------------------------------------
class(L_up_qualitative)

## ------------------------------------------------------------------------
class(L)

## ------------------------------------------------------------------------
L_matrix <- as.matrix(L)
class(L_matrix)

## ----rownames------------------------------------------------------------
colnames(L)

## ------------------------------------------------------------------------
rownames(L)[1:8]

## ----subsetting_using_logical--------------------------------------------
L[g<0,"Year"]

## ------------------------------------------------------------------------
u <- c(1,2) 
u

## ------------------------------------------------------------------------
v <- c(3,4) 
v

## ------------------------------------------------------------------------
w <- c(u,v) 
w

## ------------------------------------------------------------------------
A <- matrix(1:6,nrow=2)
A

## ------------------------------------------------------------------------
B <- rbind(u,v) 
B

## ------------------------------------------------------------------------
C <- cbind(u,v) 
C

## ----read_u--------------------------------------------------------------
U <- read.table(file="unemployment.csv",sep=",",header=TRUE)
U[1:2,]

## ------------------------------------------------------------------------
u <- apply(U[,2:13],1,mean)
u[1:6]

## ------------------------------------------------------------------------
dim(U)

## ------------------------------------------------------------------------
length(apply(U,1,mean))

## ------------------------------------------------------------------------
length(apply(U,2,mean))

## ----fig_L,eval=F,echo=T-------------------------------------------------
## plot(L$Year,y,type="line",
##   xlab="Year",
##   ylab="Life expectancy")

## ----fig_L_eval,fig.width=5,fig.height=4,echo=F--------------------------
plot(L$Year,y,type="line",
  xlab="Year",
  ylab="Life expectancy")

## ----fig_U,eval=F,echo=T-------------------------------------------------
## plot(U$Year,u,
##   xlab="Year",
##   ylab="Unemployment")

## ----fig_U_eval,fig.width=5,fig.height=4,echo=F--------------------------
plot(U$Year,u,
  xlab="Year",
  ylab="Unemployment")

## ----lm------------------------------------------------------------------
L_fit <- lm(Total~Year,data=L)

## ----fig_L_code,eval=F,echo=T--------------------------------------------
## plot(Total~Year,L,type="l")
## lines(L$Year,L_fit$fitted.values,
##   lty="dotted")

## ----fig_L_plot,echo=F,fig.width=3.5,fig.height=3.5----------------------
par(mai=c(0.9,0.9,0.1,0.1))
plot(Total~Year,L,type="l")
lines(L$Year,L_fit$fitted.values,
  lty="dotted")

## ------------------------------------------------------------------------
class(L_fit)

## ------------------------------------------------------------------------
names(L_fit)

## ----detrended_variables-------------------------------------------------
L_detrended <- L_fit$residuals
U_detrended <- lm(u~U$Year)$residuals
L_detrended <- subset(L_detrended,L$Year %in% U$Year)

## ----detrended_lm--------------------------------------------------------
lm1 <- lm(L_detrended~U_detrended)
coef(lm1)
