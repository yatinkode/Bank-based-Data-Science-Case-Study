
xbank <- read.xlsx('Data Science Case Study.xlsx',sheetName='X Bank')

xbank <- xbank[,c(1:9)]

xbank$Day <- substr(xbank$Date.Joined,1,2)
xbank$Month <- substr(xbank$Date.Joined,4,6)
xbank$Year <- substr(xbank$Date.Joined,8,9)

#Lets divide Month in quarters
xbank$Quarters <- sapply(xbank$Month,function(x) if (x %in% c('Jan','Feb','Mar')) "Q1"
                         else if(x %in% c('Apr','May','Jun')) "Q2"
                         else if(x %in% c('Jul','Aug','Sep')) "Q3"
                         else "Q4")

ui <- fluidPage(
  
  headerPanel("Customer Profile Viewer"),
  
  mainPanel(
    tabsetPanel(
      
      tabPanel("Basis Region", fluid = TRUE,
               sidebarLayout(
                 sidebarPanel(width="3",
                              selectInput('w','Parameter', choices = c("Gender","Quarter", "Job Type","Age"), selected = "Gender",width = "140px")),
                 mainPanel(
                   plotlyOutput('trendPlotR',width="900px",height="300px"),
                   div(style="padding-top:50px;font-size:15px",textOutput("Reg"))
                 )
               )
      ),
      
      tabPanel("Basis Quarter", fluid = TRUE,
               sidebarLayout(
                 sidebarPanel(width="3",
                              selectInput('x','Parameter', choices = c("Gender", "Region","Job Type","Age"), selected = "Gender",width = "140px")),
                 mainPanel(
                   plotlyOutput('trendPlotQ',width="900px",height="300px"),
                   textOutput("Qua")
                 )
               )
      ),
      
      tabPanel("Basis Gender", fluid = TRUE,
               sidebarLayout(
                 sidebarPanel(width="3",
                              selectInput('y','Parameter', choices = c("Quarter", "Region","Job Type","Age"), selected = "Quarter",width = "140px")),
                 mainPanel(
                   plotlyOutput('trendPlotG',width="900px",height="300px"),
                   textOutput("Gen")
                 )
               )
      ),
      
      tabPanel("Basis Job Type", fluid = TRUE,
               sidebarLayout(
                 sidebarPanel(width="3",
                              selectInput('z','Parameter', choices = c("Gender","Quarter", "Region","Age"), selected = "Gender",width = "140px")),
                 mainPanel(
                   plotlyOutput('trendPlotJ',width="900px",height="300px"),
                   textOutput("Job")
                 )
               )
      ),
      
      tabPanel("Basis Age", fluid = TRUE,
               sidebarLayout(
                 sidebarPanel(width="3",
                              selectInput('a','Parameter', choices = c("Gender","Quarter", "Region","Job Type"), selected = "Gender",width = "140px")),
                 mainPanel(
                   plotlyOutput('trendPlotA',width="900px",height="300px"),
                   textOutput("Age")
                 )
               )
      )
      
      
    )
  )
)

server <- function(input, output) {
  
  #################################### Data prep
  
  
  
  
  
  ########################################## For Region TabPanel #################################### 
  output$trendPlotR <- renderPlotly({
    
    if(input$w=="Gender"){
      wplot <- ggplot(xbank, aes(Region, ..count..)) + geom_bar(aes(fill = Gender), position = "dodge",col="black") + ggtitle("Gender customers in different Regions")
    }
    else if(input$w=="Quarter"){
      wplot <- ggplot(xbank, aes(Region, ..count..)) + geom_bar(aes(fill = Quarters), position = "dodge",col="black") + ggtitle("Quarterwise joining of customers in different Regions")
    }
    else if(input$w=="Age"){
      wplot <- ggplot(data=xbank, aes(Age,fill = Region)) + 
        geom_histogram(breaks=seq(min(xbank$Age), max(xbank$Age), by =5), col="black")+labs(x="Age",title="Agewise Distribution of customers in different Regions")
    }
    else{
      wplot <- ggplot(xbank, aes(Region, ..count..)) + geom_bar(aes(fill = Job.Classification), position = "dodge",col="black") + ggtitle("Job-Type wise customers in different Regions")
    }
    
    ggplotly(wplot)
    
    
  })
  
  
  output$Reg <- renderText({ 
    
    if(input$w=="Gender"){
      "Higher Female customers are present from Northern Ireland. Higher Male customers are present from  Scotland, England and Wales show almost equal proportion of Male/Female customers"
    }
    else if(input$w=="Quarter"){
      "Generally number of customers joining increase every quarter over the year,In case of Northern Ireland number of Customers are higher in mid-quarters, compared of the start and end ones"
    }
    else if(input$w=="Age"){
      "Higher proportion of mid age customers are present in mostly all regions, except Scotland where higher proportion of old customers are present"
    }
    else{
      "Higher proportion on White Collar Job professions are present in England and Wales, compared to Scotland where higher proportion of Blue collar job professions are present"
    }
    
  })
  
  
  
  ############################################ For Quarters Tab Panel ########################################################
  output$trendPlotQ <- renderPlotly({
    
    if(input$x=="Gender"){
      qplot <- ggplot(xbank, aes(Quarters, ..count..)) + geom_bar(aes(fill = Gender), position = "dodge",col="black") + ggtitle("Genderwise customers joined in different Quarters")
    }
    else if(input$x=="Region"){
      qplot <- ggplot(xbank, aes(Quarters, ..count..)) + geom_bar(aes(fill = Region), position = "dodge",col="black") + ggtitle("Regionwise customers joined in different Quarters")
    }
    else if(input$x=="Age"){
      qplot <- ggplot(data=xbank, aes(Age,fill = Quarters)) + 
        geom_histogram(breaks=seq(min(xbank$Age), max(xbank$Age), by =5), 
                       col="black")+labs(x="Age",title="Agewise Distribution of customers in different Quarters")
    }
    else{
      qplot <- ggplot(xbank, aes(Quarters, ..count..)) + geom_bar(aes(fill = Job.Classification), position = "dodge",col="black") + ggtitle("Job-Type wise customers joined in different Quarters")
    }
    
    ggplotly(qplot)
    
  })
  
  
  output$Qua <- renderText({ 
    
    if(input$x=="Gender"){
      "Gradual increase visible as the quarters of the year goes by for both males and females"
    }
    else if(input$x=="Region"){
      "Gradual increase visible as the quarters of the year goes by for all regions"
    }
    else if(input$x=="Age"){
      "Gradual increase visible as the quarters of the year goes by for all ages"
    }
    else{
      "Gradual increase visible as the quarters of the year goes by for all job-types"
    }
    
  })
  
  
  ############################################ For Gender Tab Panel #################################################################3
  output$trendPlotG <- renderPlotly({
    
    if(input$y=="Region"){
      gplot <- ggplot(xbank, aes(Gender, ..count..)) + geom_bar(aes(fill = Region), position = "dodge",col="black") + ggtitle("Regionwise customers of different Genders")
    }
    else if(input$y=="Quarter"){
      gplot <- ggplot(xbank, aes(Gender, ..count..)) + geom_bar(aes(fill = Quarters), position = "dodge",col="black") + ggtitle("Quarterwise customers joined of different Genders")
    }
    else if(input$w=="Age"){
      gplot <- ggplot(data=xbank, aes(Age,fill = Gender)) + 
        geom_histogram(breaks=seq(min(xbank$Age), max(xbank$Age), by =5), 
                       col="black")+labs(x="Age",title="Agewise Distribution of customers for different Genders")
    }
    else{
      gplot <- ggplot(xbank, aes(Gender, ..count..)) + geom_bar(aes(fill = Job.Classification), position = "dodge",col="black") + ggtitle("Job-Type wise customers of different Genders")
    }
    
    ggplotly(gplot)
    
  })
  
  
  output$Gen <- renderText({ 
    
    if(input$y=="Region"){
      "Higher proportion of females present England, Wales  and Northern Ireland, higher proportion of Male customers are present in Scotland"
    }
    else if(input$y=="Quarter"){
      "Males joining each quarter are higher than those of females joining"
    }
    else if(input$y=="Age"){
      "Mid aged males as well as females are higher than other ages"
    }
    else{
      "There are more Blue collar Males then Females. There are more Whitecollar Females than males"
    }
    
  })
  
  ######################################################## For Job-Type Tab Panel #####################################################
  output$trendPlotJ <- renderPlotly({
    
    if(input$z=="Region"){
      jplot <- ggplot(xbank, aes(Job.Classification, ..count..)) + geom_bar(aes(fill = Region), position = "dodge",col="black") + ggtitle("Regionwise customers of different Job-Types")
    }
    else if(input$z=="Gender"){
      jplot <- ggplot(xbank, aes(Job.Classification, ..count..)) + geom_bar(aes(fill = Gender), position = "dodge",col="black") + ggtitle("Genderwise customers joined of different Job-Types")
    }
    else if(input$z=="Age"){
      jplot <- ggplot(data=xbank, aes(Age,fill = Job.Classification)) + 
        geom_histogram(breaks=seq(min(xbank$Age), max(xbank$Age), by =5), 
                       col="black")+labs(x="Age",title="Agewise Distribution of customers in different Job-Types")
    }
    else{
      jplot <- ggplot(xbank, aes(Job.Classification, ..count..)) + geom_bar(aes(fill = Quarters), position = "dodge",col="black") + ggtitle("Quarterwise customers of different Job-Types")
    }
    
    ggplotly(jplot)
    
  })
  
  output$Job <- renderText({ 
    
    if(input$z=="Region"){
      "Higher proportion of White-collar employees are from England, Wales  and Northern Ireland. Higher proportion of Blue-Collar and Other job type customers are from Scotland"
    }
    else if(input$z=="Gender"){
      "Higher proportion of White-Collar,Other jobs are represented by females and Higher proportion of Blue collar jobs are represented by males"
    }
    else if(input$z=="Age"){
      "Higher amount of Jobs of any type are by Mid-aged customers as expected"
    }
    else{
      "Highest proportion of customers of every job type join in Quarter 4"
    }
    
  })
  
  
  #For Age Tab Panel
  output$trendPlotA <- renderPlotly({
    
    if(input$a=="Region"){
      aplot <- ggplot(data=xbank, aes(Age,fill = Region)) + 
        geom_histogram(breaks=seq(min(xbank$Age), max(xbank$Age), by =5), 
                       col="black")+labs(x="Age",title="Regionwise Distribution of customers in different Ages")
    }
    else if(input$a=="Quarter"){
      aplot <- ggplot(data=xbank, aes(Age,fill = Quarters)) + 
        geom_histogram(breaks=seq(min(xbank$Age), max(xbank$Age), by =5), 
                       col="black")+labs(x="Age",title="Quarterwise Distribution of customers in different Ages")
    }
    else if(input$a=="Gender"){
      aplot <- ggplot(data=xbank, aes(Age,fill = Gender)) + 
        geom_histogram(breaks=seq(min(xbank$Age), max(xbank$Age), by =5), 
                       col="black")+labs(x="Age",title="Gender wise Distribution of customers in different Ages")
    }
    else{
      aplot <- ggplot(data=xbank, aes(Age,fill = Job.Classification)) + 
        geom_histogram(breaks=seq(min(xbank$Age), max(xbank$Age), by =5), 
                       col="black")+labs(x="Age",title="Job-Type wise Distribution of customers in different Ages")
    }
    
    ggplotly(aplot)
    
  })
  
  output$Age <- renderText({ 
    
    if(input$a=="Region"){
      "Higher proportion of mid age customers are present in mostly all regions, except Scotland where higher proportion of old customers are present"
    }
    else if(input$z=="Gender"){
      "Mid aged males as well as females are higher than other ages"
    }
    else if(input$z=="Quarter"){
      "Gradual increase visible as the quarters of the year goes by for all ages"
    }
    else{
      "Higher amount of Jobs of any type are by Mid-aged customers as expected"
    }
    
  })
  
  
}