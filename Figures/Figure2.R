##figure 2
data <- read.table("Figure2_data.txt", head=T, sep="\t")

data[1,2] <- data[1,2]*-1
data[2,2] <- data[2,2]*-1
data[3,2] <- data[3,2]*-1
data[6,2] <- data[6,2]*-1
data[7,2] <- data[7,2]*-1
data[8,2] <- data[8,2]*-1
data[11,2] <- data[11,2]*-1
data[13,2] <- data[13,2]*-1
data[15,2] <- data[15,2]/5
data[15,3] <- data[15,3]/5

data$OR <- exp(data$Estimate)
data$upper95CI <- exp(ci_normal("u", data$Estimate, data$SE, .05))
data$lower95CI <- exp(ci_normal("l", data$Estimate, data$SE, .05))


mvmr_plot <-
  as.data.frame(structure(list(
    mean  = data$OR, 
    lower = data$lower95CI,
    upper = data$upper95CI)))
mvmr_plot

png(filename = "Fig2.png", height=600, width=600, pointsize=30)
forestplot(rep(NA, 18), mvmr_plot$mean, mvmr_plot$lower, mvmr_plot$upper,
           size=.20, zero=1, xticks=(c(.9, 1.0, 1.10, 1.20, 1.30, 1.40)), xlab="Odds ratio")
dev.off()
