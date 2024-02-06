library(forestplot)

#a
univ_plot <- data.frame("Estimate" = c(0.122826548, 0.113470452, 0.123105108), 
                        "SE" = c(0.018522332, 0.021303984, 0.041004425))
univ_plot$mean <- exp(univ_plot$Estimate)
univ_plot$upper <- exp(ci_normal("u", univ_plot$Estimate, univ_plot$SE, .05))
univ_plot$lower <- exp(ci_normal("l", univ_plot$Estimate, univ_plot$SE, .05))

png(filename = "SFig_a.png", height=300, width=500, pointsize=20)
forestplot(rep(NA, 3), univ_plot$mean, univ_plot$lower, univ_plot$upper,
           size=.15, zero=1, txt_gp = fpTxtGp(label=gpar(cex=2)), xticks=(c(.85, 1.0, 1.15, 1.30)), xlab="Odds ratio")
dev.off()

#b
univ_plot <- data.frame("Estimate" = c(0.088879364, 0.036817191, 0.079084406), 
                        "SE" = c(0.027871284, 0.03030841, 0.067914256))
univ_plot$mean <- exp(univ_plot$Estimate)
univ_plot$upper <- exp(ci_normal("u", univ_plot$Estimate, univ_plot$SE, .05))
univ_plot$lower <- exp(ci_normal("l", univ_plot$Estimate, univ_plot$SE, .05))

png(filename = "SFig_b.png", height=300, width=500, pointsize=20)
forestplot(rep(NA, 3), univ_plot$mean, univ_plot$lower, univ_plot$upper,
           size=.15, zero=1, txt_gp = fpTxtGp(label=gpar(cex=2)), xticks=(c(.85, 1.0, 1.15, 1.30)), xlab="Odds ratio")
dev.off()
