# Module 3 Customizing ggplots2

# Default theme
ggplot(data=college) + geom_point(size=3) + aes(x=tuition, y=sat_avg)

# Change the plot background color
ggplot(data=college) + geom_bar() + aes(x=region, fill=control) +
  theme(plot.background=element_rect(fill='purple'))

# Change the panel background color
ggplot(data=college) + geom_bar() + aes(x=region, fill=control) +
  theme(panel.background=element_rect(fill='purple'))

# Let's be minimalist and make both backgrounds disappear
ggplot(data=college) + geom_bar() + aes(x=region, fill=control) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank())

# Add grey gridlines
ggplot(data=college) +
  geom_bar() + aes(x=region, fill=control) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  theme(panel.grid.major=element_line(color="grey"))

# Only show the y-axis gridlines
ggplot(data=college) +
  geom_bar() + aes(x=region, fill=control) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  theme(panel.grid.major.y=element_line(color="grey"))

# Rename the axes
ggplot(data=college) +
  geom_bar()+ aes(x=region, fill=control) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  xlab("Region") +
  ylab("Number of Schools")

# Ex: Resize the y-axis
ggplot(data=college) +
  geom_bar() + aes(x=region, fill=control) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  xlab("Region") +
  ylab("Number of Schools") +
  ylim(0,500)

# Change the fill colors
ggplot(data=college) +
  geom_bar() + aes(x=region, fill=control) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  scale_x_discrete(name="Region") +
  scale_y_continuous(name="Number of Schools", limits=c(0,500)) +
  scale_fill_manual(values=c("orange","blue"))


# Add Legend
ggplot(data=college) +
  geom_bar()+ aes(x=region, fill=control) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  scale_x_discrete(name="Region") +
  scale_y_continuous(name="Number of Schools", limits=c(0,500)) +
  scale_fill_manual(values=c("orange","blue"), guide=guide_legend(title="Institution Type", label.position="bottom", nrow=1, keywidth=2.5)) +
  theme(legend.position="top")

# Add a text annotation
ggplot(data=college) +
  geom_point(alpha=1/2) + aes(x=tuition, y=sat_avg, color=control, size=undergrads) +
  annotate("text", label="Elite Privates", x=35000,y=1500)

# Add a line for the mean SAT score
ggplot(data=college) +
  geom_point(alpha=1/2) + aes(x=tuition, y=sat_avg, color=control, size=undergrads) +
  annotate("text", label="Elite Privates", x=45000,y=1500) +
  geom_hline(yintercept=mean(college$sat_avg))

# Add label
ggplot(data=college) +
  geom_point(alpha=1/2) + aes(x=tuition, y=sat_avg, color=control, size=undergrads) +
  annotate("text", label="Elite Privates", x=45000,y=1500) +
  geom_hline(yintercept=mean(college$sat_avg)) +
  annotate("text", label="Mean SAT", x=47500, y=mean(college$sat_avg)-15)

# Add Vertical line 
ggplot(data=college) +
  geom_point(alpha=1/2) + aes(x=tuition, y=sat_avg, color=control, size=undergrads) +
  annotate("text", label="Elite Privates", x=45000,y=1500) +
  geom_hline(yintercept=mean(college$sat_avg)) +
  annotate("text", label="Mean SAT", x=47500, y=mean(college$sat_avg)-15) + 
  geom_vline(xintercept=mean(college$tuition)) +
  annotate("text", label="Mean Tuition", x=mean(college$tuition)+7500, y=700)

# Add a title
ggplot(data=college) +
  geom_bar() + aes(x=region, fill=control) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  scale_x_discrete(name="Region") +
  scale_y_continuous(name="Number of Schools", limits=c(0,500)) +
  scale_fill_manual(values=c("orange","blue"), guide=guide_legend(title="Institution Type", label.position="bottom", nrow=1, keywidth=2.5)) +
  theme(legend.position="bottom") +
  ggtitle("More colleges are in the southern U.S. than any other region.")

# Add a subtitle
ggplot(data=college) +
  geom_bar() + aes(x=region, fill=control) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  scale_x_discrete(name="Region") +
  scale_y_continuous(name="Number of Schools", limits=c(0,500)) +
  scale_fill_manual(values=c("orange","blue"), guide=guide_legend(title="Institution Type", label.position="bottom", nrow=1, keywidth=2.5)) +
  theme(legend.position="bottom") +
  ggtitle("More colleges are in the southern U.S. than any other region.", subtitle="Source: U.S. Department of Education")

# Pre-built thhemes
ggplot(data=college) + geom_bar()+ aes(x=region, fill=control) +
  theme_bw()

ggplot(data=college) + geom_bar()+ aes(x=region, fill=control) +
  theme_minimal()

ggplot(data=college) + geom_bar()+ aes(x=region, fill=control) +
  theme_void()

ggplot(data=college) + geom_bar()+ aes(x=region, fill=control) +
  theme_dark()

# Check out ggthemes
install.packages("ggthemes")
library(ggthemes)

ggplot(data=college) + geom_bar()+ aes(x=region, fill=control) +
  theme_solarized()

ggplot(data=college) + geom_bar()+ aes(x=region, fill=control) +
  theme_excel()

ggplot(data=college) + geom_bar()+ aes(x=region, fill=control) +
  theme_wsj()

ggplot(data=college) + geom_bar()+ aes(x=region, fill=control) +
  theme_economist()

ggplot(data=college) + geom_bar()+ aes(x=region, fill=control) +
  theme_fivethirtyeight()
