library(tidyverse)
library(shiny)

ui <- navbarPage("Crime and Policing in Minnesota",
                 tabPanel("Arrests",
                          sidebarLayout(
                              sidebarPanel(
                                  varSelectInput("var", "Variable",arr[,4:5]),
                                  varSelectInput("var2","Variable",arr[,7:9])
                              ),
                              mainPanel(
                                  tabsetPanel(
                                      tabPanel("Tab 1",plotOutput("plot1",inline=TRUE),
                                               h5("Sex codes:"),
                                               p("M=male, F=female"),
                                               h5("Race codes:"),
                                               p("W=white, B=Black, I=American Indian or Alaska Native, 
                                               A=Asian,AP=Asian, Native Hawaiian, or Other Pacific Islander,
                                               C=Chinese, J=Japanese, 
                                               Native Hawaiian or Other Pacific Islander, O=other,
                                               M=multiple, U=unknown, NS=not specified"),
                                               h5("Ethnicity codes:"),
                                               p("M=multiple, H=Hispanic or Latino, 
                                                 N=Not Hispanic or Latino, U=unknown")
                                      ),
                                      tabPanel("Tab 2",plotOutput("plot2",inline=TRUE),
                                               h5("Sex codes:"),
                                               p("M=male, F=female"),
                                               h5("Race codes:"),
                                               p("W=white, B=Black, I=American Indian or Alaska Native, 
                                               A=Asian,AP=Asian, Native Hawaiian, or Other Pacific Islander,
                                               C=Chinese, J=Japanese, 
                                               Native Hawaiian or Other Pacific Islander, O=other,
                                               M=multiple, U=unknown, NS=not specified"),
                                               h5("Ethnicity codes:"),
                                               p("M=multiple, H=Hispanic or Latino, 
                                                 N=Not Hispanic or Latino, U=unknown"))
                                      )
                                      
                                  )
                              )
                          ),
                 tabPanel("Arrests cont.",
                          sidebarLayout(
                              sidebarPanel(
                                  selectInput("var3","Offense category (Tab 1)",
                                              c("Animal Cruelty"="Animal Cruelty",
                                                "Arson"="Arson",
                                                "Assault Offenses"="Assault Offenses",
                                                "Bad Checks"="Bad Checks",
                                                "Bribery"="Bribery",
                                                "Burglary/Breaking & Entering"="Burglary/Breaking & Entering",
                                                "Counterfeiting/Forgery"="Counterfeiting/Forgery",
                                                "Curfew/Loitering/Vagrancy Violations"="Curfew/Loitering/Vagrancy Violations",
                                                "Destruction/Damage/Vandalism of Property"="Destruction/Damage/Vandalism of Property",
                                                "Disorderly Conduct"="Disorderly Conduct",
                                                "Driving Under the Influence"="Driving Under the Influence",
                                                "Drug/Narcotic Offenses"="Drug/Narcotic Offenses",
                                                "Drunkenness"="Drunkenness",
                                                "Embezzlement"="Embezzlement",
                                                "Extortion/Blackmail"="Extortion/Blackmail",
                                                "Family Offenses, Nonviolent"="Family Offenses, Nonviolent",
                                                "Fraud Offenses"="Fraud Offenses",
                                                "Gambling Offenses"="Gambling Offenses",
                                                "Homicide Offenses"="Homicide Offenses",
                                                "Human Trafficking"="Human Trafficking",
                                                "Kidnapping/Abduction"="Kidnapping/Abduction",
                                                "Liquor Law Violations"="Liquor Law Violations",
                                                "Motor Vehicle Theft"="Motor Vehicle Theft",
                                                "Other Offenses"="Other Offenses",
                                                "Peeping Tom"="Peeping Tom",
                                                "Pornography/Obscene Material"="Pornography/Obscene Material",
                                                "Prostitution Offenses"="Prostitution Offenses",
                                                "Robbery"="Robbery","Sex Offenses"="Sex Offenses",
                                                "Sex Offenses, Non-forcible"="Sex Offenses, Non-forcible",
                                                "Stolen Property Offenses"="Stolen Property Offenses",
                                                "Weapon Law Violations")),
                                  sliderInput("bins",
                                              "Number of bins:",
                                              min = 1,
                                              max = 50,
                                              value = 30)
                              ),
                              mainPanel(
                                  tabsetPanel(
                                      tabPanel("Tab 1",plotOutput("plot3",inline=TRUE),
                                               h5("Sex codes:"),
                                               p("M=male, F=female"),
                                               h5("Race codes:"),
                                               p("W=white, B=Black, I=American Indian or Alaska Native,
                                               A=Asian,AP=Asian, Native Hawaiian, or Other Pacific Islander,
                                               C=Chinese, J=Japanese,
                                               Native Hawaiian or Other Pacific Islander, O=other, 
                                               M=multiple, U=unknown,
                                                 NS=not specified"),
                                               h5("Ethnicity codes:"),
                                               p("M=multiple, H=Hispanic or Latino, 
                                                 N=Not Hispanic or Latino, U=unknown")),
                                      tabPanel("Tab 2",plotOutput("plot4",inline=TRUE))
                                  )
                              )
                          )),
                          tabPanel("Offenders",
                                   sidebarLayout(
                                       sidebarPanel(
                                           selectInput("var5","Offense category (Tab 1,2)",
                                                                c("Animal Cruelty"="Animal Cruelty",
                                                                  "Arson"="Arson",
                                                                  "Assault Offenses"="Assault Offenses",
                                                                  "Bad Checks"="Bad Checks",
                                                                  "Bribery"="Bribery",
                                                                  "Burglary/Breaking & Entering"="Burglary/Breaking & Entering",
                                                                  "Counterfeiting/Forgery"="Counterfeiting/Forgery",
                                                                  "Curfew/Loitering/Vagrancy Violations"="Curfew/Loitering/Vagrancy Violations",
                                                                  "Destruction/Damage/Vandalism of Property"="Destruction/Damage/Vandalism of Property",
                                                                  "Disorderly Conduct"="Disorderly Conduct",
                                                                  "Driving Under the Influence"="Driving Under the Influence",
                                                                  "Drug/Narcotic Offenses"="Drug/Narcotic Offenses",
                                                                  "Drunkenness"="Drunkenness",
                                                                  "Embezzlement"="Embezzlement",
                                                                  "Extortion/Blackmail"="Extortion/Blackmail",
                                                                  "Family Offenses, Nonviolent"="Family Offenses, Nonviolent",
                                                                  "Fraud Offenses"="Fraud Offenses",
                                                                  "Gambling Offenses"="Gambling Offenses",
                                                                  "Homicide Offenses"="Homicide Offenses",
                                                                  "Human Trafficking"="Human Trafficking",
                                                                  "Kidnapping/Abduction"="Kidnapping/Abduction",
                                                                  "Liquor Law Violations"="Liquor Law Violations",
                                                                  "Motor Vehicle Theft"="Motor Vehicle Theft",
                                                                  "Other Offenses"="Other Offenses",
                                                                  "Peeping Tom"="Peeping Tom",
                                                                  "Pornography/Obscene Material"="Pornography/Obscene Material",
                                                                  "Prostitution Offenses"="Prostitution Offenses",
                                                                  "Robbery"="Robbery","Sex Offenses"="Sex Offenses",
                                                                  "Sex Offenses, Non-forcible"="Sex Offenses, Non-forcible",
                                                                  "Stolen Property Offenses"="Stolen Property Offenses",
                                                                  "Weapon Law Violations"))

                                       ),
                                       
                                       mainPanel(
                                           tabsetPanel(
                                               tabPanel("Tab 1",plotOutput("plot5",inline=TRUE),
                                                        h5("Sex codes:"),
                                                        p("M=male, F=female"),
                                                        h5("Race codes:"),
                                                        p("W=white, B=Black, I=American Indian or Alaska Native,
                                               A=Asian,AP=Asian, Native Hawaiian, or Other Pacific Islander,
                                               C=Chinese, J=Japanese,
                                               Native Hawaiian or Other Pacific Islander, O=other, 
                                               M=multiple, U=unknown,
                                                 NS=not specified"),
                                                        h5("Ethnicity codes:"),
                                                        p("M=multiple, H=Hispanic or Latino, 
                                                 N=Not Hispanic or Latino, U=unknown")),
                                               tabPanel("tab")
                                           )
                                       ))),
                                   
                 tabPanel("Table",
                          DT::dataTableOutput("table"))
)
                                     
# Define server logic required to draw a histogram
server <- function(input, output, session) {
    output$plot1 <- renderPlot({
        
        arr %>%
            ggplot()+geom_bar(aes(!!input$var,fill=!!input$var2))+
            coord_flip()+
            theme_bw()+
            theme(legend.position = "bottom")
    },width=500,height=700)
    
    output$plot2 <- renderPlot({
        arr %>%
            ggplot()+geom_histogram(aes(x=AGE_NUM,fill=!!input$var2))+
            theme_bw()+
            theme(legend.position = "bottom")
    },width=500,height=700)
    
    output$plot3<- renderPlot({
        arr_sum_race %>%
            filter(OFFENSE_CATEGORY_NAME==input$var3) %>%
            ggplot()+geom_col(aes(x=RACE_CODE,y=n,fill=RACE_CODE))+
            theme_bw()+
            theme(legend.position = "bottom")
    },width=500,height=700)
    
    output$plot4<-renderPlot({
        arr %>%
            filter(OFFENSE_CATEGORY_NAME==input$var3) %>%
            ggplot() + geom_histogram(aes(x=AGE_NUM),bins = input$bins)
    },width=500,height=700)
    
    output$plot5 <- renderPlot({
            arr_off_sum %>%
                filter(OFFENSE_CATEGORY_NAME==!!input$var5) %>%
                ggplot()+geom_col(aes(x=Dataset,y=n))+
                theme_bw()+
                theme(legend.position = "bottom")
            },width=500,height=700)
    
    output$plot6 <- renderPlot({
        
    })
    
    
    output$table <- DT::renderDataTable({
        DT::datatable(cars)
    })
}


shinyApp(ui = ui, server = server)
