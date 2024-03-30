# 载入必要的库
pub_211 <- read.csv("~/learngit/a7-dashboard-tongt1213/pub_211.csv")
library(ggplot2)
library(plotly)
library(DT)

# 绘制时间趋势散点图观察发表数量变化
ggplot(data = pub_211, aes(x = pubyear, y = pubnum_wos)) +
  geom_point(size = 5, color = "#0073C2FF") +  # 调整散点大小及颜色
  geom_line(color = "#EFC000FF", size = 1) +  # 使用直线连接散点，提高趋势可读性
  ggtitle("WOS 发表数量年度趋势") +  # 图表标题
  xlab("年份") + ylab("发表数量") +  # 横纵轴标签
  theme_light() +  # 使用更清晰的主题
  theme(plot.background = element_rect(fill = "#F0F0F0"))  # 调整背景色

# 制作交互式图表展示年度发表趋势
plot_ly(data = pub_211, x = ~pubyear, y = ~pubnum_wos, type = "scatter", mode = "markers+lines",
        marker = list(color = 'rgba(0, 200, 100, 0.95)'), line = list(color = 'rgba(0, 100, 80, 0.95)')) %>%
  layout(title = "年度发表数量交互图",
         xaxis = list(title = "年份"),
         yaxis = list(title = "WOS发表数量"),
         plot_bgcolor='rgba(245,245,245,1)')  # 调整图表背景色

# 展示简洁版数据表格
datatable(pub_211, options = list(pageLength = 10, searchHighlight = TRUE))  # 每页显示10行，启用搜索高亮

# 交互式图表增加注解文本
scatter_plot_annotated <- plot_ly(data = pub_211, x = ~pubyear, y = ~pubnum_wos, type = "scatter", mode = "markers",
                                  marker = list(size = 12, color = 'rgba(255, 0, 0, 0.8)')) %>%
  layout(title = "WOS年度发表趋势",
         xaxis = list(title = "年份"),
         yaxis = list(title = "发表数量"))

# 新增注解文本内容及样式
annotations_content <- list(
  x = c(2010, 2011, 2012, 2013, 2014),
  y = c(1000, 1500, 2000, 2500, 3000),
  text = c("起点", "发展", "增长", "稳定", "高峰"),
  showarrow = FALSE,
  font = list(family = "Arial, sans-serif", size = 14, color = "darkblue")
)

# 将注解文本添加至图表中
scatter_plot_annotated <- scatter_plot_annotated %>% add_trace(type = "scatter", mode = "text", text = annotations_content)
scatter_plot_annotated
