library(tidyverse)
library(shiny)
library(EnvStats)

ui <- navbarPage("Crime and Policing in Minnesota",
                 tabPanel("Arrests",
                          sidebarLayout(
                              sidebarPanel(
                                  varSelectInput("var", "Variable (Tab 1)",arr[,4:5]),
                                  varSelectInput("var2","Variable",arr[,7:9])
                              ),
                              mainPanel(
                                  h2("Arrestees"),
                                  tabsetPanel(
                                      tabPanel("Tab 1",plotOutput("plot1",inline=TRUE),
                                               h5("Sex codes:"),
                                               p("M=male, F=female"),
                                               h5("Race codes:"),
                                               p("W=white, B=Black, I=American Indian or Alaska Native, 
                                               A=Asian, AP=Asian, Native Hawaiian, or Other Pacific Islander,
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
                                               A=Asian, AP=Asian, Native Hawaiian, or Other Pacific Islander,
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
                                  selectInput("var3","Offense category",
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
                                              "Number of bins (Tab 2):",
                                              min = 1,
                                              max = 50,
                                              value = 30)
                              ),
                              mainPanel(
                                  h2("Arrestees"),
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
                                           varSelectInput("var6","Variable",off[,11:13]),
                                           selectInput("var7","Offense category (Tab 2)",
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
                                           
                                           sliderInput("bins2",
                                                       "Number of bins (tab 2):",
                                                       min = 1,
                                                       max = 50,
                                                       value = 30)

                                       ),
                                       
                                       mainPanel(
                                           h2("Offenders"),
                                           tabsetPanel(
                                               tabPanel("Tab 1",plotOutput("plot5",inline=TRUE),
                                                        h5("Sex codes:"),
                                                        p("M=male, F=female"),
                                                        h5("Race codes:"),
                                                        p("W=white, B=Black, I=American Indian or Alaska Native,
                                               A=Asian, AP=Asian, Native Hawaiian, or Other Pacific Islander,
                                               C=Chinese, J=Japanese,
                                               Native Hawaiian or Other Pacific Islander, O=other, 
                                               M=multiple, U=unknown,
                                                 NS=not specified"),
                                                        h5("Ethnicity codes:"),
                                                        p("M=multiple, H=Hispanic or Latino, 
                                                 N=Not Hispanic or Latino, U=unknown")),
                                               tabPanel("Tab 2",plotOutput("plot6",inline=TRUE),
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
                                                 N=Not Hispanic or Latino, U=unknown"))
                                               
                                           )
                                       )
                                   )
                          ),
                 tabPanel("Offenders, cont.",
                          sidebarLayout(
                              sidebarPanel(
                                  selectInput("var8","Offense category",
                                              c("Animal Cruelty",
                                                "Arson",
                                                "Assault Offenses",
                                                "Bad Checks",
                                                "Bribery",
                                                "Burglary/Breaking & Entering",
                                                "Counterfeiting/Forgery",
                                                "Curfew/Loitering/Vagrancy Violations",
                                                "Destruction/Damage/Vandalism of Property",
                                                "Disorderly Conduct",
                                                "Driving Under the Influence",
                                                "Drug/Narcotic Offenses",
                                                "Drunkenness",
                                                "Embezzlement",
                                                "Extortion/Blackmail",
                                                "Family Offenses, Nonviolent",
                                                "Fraud Offenses",
                                                "Gambling Offenses",
                                                "Homicide Offenses",
                                                "Human Trafficking",
                                                "Kidnapping/Abduction",
                                                "Liquor Law Violations",
                                                "Motor Vehicle Theft",
                                                "Other Offenses",
                                                "Peeping Tom",
                                                "Pornography/Obscene Material",
                                                "Prostitution Offenses",
                                                "Robbery","Sex Offenses",
                                                "Sex Offenses, Non-forcible",
                                                "Stolen Property Offenses",
                                                "Weapon Law Violations"
                                                )),
                                  actionButton("update", "Update view")
                                  
                          ),
                          mainPanel(
                              h2("Offenders"),
                              tabPanel("Table",
                                       tableOutput("table2"))
                          )
                 )
                 ),
            navbarMenu("More",
                 tabPanel("Offenders, cont.",
                          sidebarLayout(
                              sidebarPanel(
                                  selectInput("var9","Offense category",
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
                                  
                                  varSelectInput("var10","Variable (tab 2)", off[,24:26])
                              ),
                                  
                              mainPanel(
                                  h2("Offenders"),
                                  tabsetPanel(
                                  tabPanel("Tab 1",plotOutput("plot7")),
                                  tabPanel("Tab 2",plotOutput("plot8"))
                                  
                              )
                              )
                          )
                 ),
                 tabPanel("Victims",
                          sidebarLayout(
                              sidebarPanel(
                                  selectInput("var11", "Offense category", 
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
                                  varSelectInput("var12","Variable (tab 2)",
                                                 off %>% select(SEX_CODE,RACE_CODE,ETHNICITY_CODE)),
                                  varSelectInput("var13","Variable (tab 2)",
                                                 off %>% select(VIC_SEX_CODE,VIC_RACE_CODE,
                                                                VIC_ETHNICITY_CODE))
                              ),
                              mainPanel(
                                  h2("Victims"),
                                  tabsetPanel(
                                  tabPanel("Tab 1",plotOutput("plot9"),
                                           p("n="),verbatimTextOutput("n"),
                                           plotOutput("plot10"),inline=TRUE),
                                  tabPanel("Tab 2",plotOutput("plot11"),inline=TRUE,
                                           h5("Sex codes:"),
                                           p("M=male, F=female"),
                                           h5("Race codes:"),
                                           p("W=white, B=Black, I=American Indian or Alaska Native,
                                               A=Asian, AP=Asian, Native Hawaiian, or Other Pacific Islander,
                                               C=Chinese, J=Japanese,
                                               Native Hawaiian or Other Pacific Islander, O=other, 
                                               M=multiple, U=unknown,
                                                 NS=not specified"),
                                           h5("Ethnicity codes:"),
                                           p("M=multiple, H=Hispanic or Latino, 
                                                 N=Not Hispanic or Latino, U=unknown"))))
                              )
                          ),
                 tabPanel("Fatal police shootings",
                          sidebarLayout(
                              sidebarPanel(
                                  selectInput("var14","Year",
                                              c("2015","2016","2017","2018","2019","2020")),
                                  varSelectInput("var15","Variable (tabs 2, 3)",
                                                 shootings_mn %>% 
                                                     select(manner_of_death,armed,gender,
                                                            race,signs_of_mental_illness,threat_level,
                                                            flee,body_camera))
                              ),
                              mainPanel(
                                  h2("Fatal police shootings"),
                                  tabsetPanel(
                                  tabPanel("Tab 1",dataTableOutput("table3"),inline=TRUE),
                                  tabPanel("Tab 2",plotOutput("plot12"),inline=TRUE),
                                  tabPanel("Tab 3",plotOutput("plot13"),inline=TRUE)
                              )
                              )
                          )
                 ),
                 tabPanel("About",
                          h2("About"),
                          p("This shiny app was created by Sam Carlen (github.com/samcarlen). The data primarily comes from the FBI's National Incident-Based Reporting System (https://www.fbi.gov/services/cjis/ucr/nibrs). The data on fatal police shootings comes from the Washington Post's police shootings database (https://www.washingtonpost.com/graphics/investigations/police-shootings-database/).")
                          )
                 )
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
        arr %>%
            filter(OFFENSE_CATEGORY_NAME==input$var3) %>%
            ggplot()+geom_bar(aes(x=RACE_CODE,fill=RACE_CODE))+
            theme_bw()+
            theme(legend.position = "bottom")
    },width=500,height=700)
    
    output$plot4<-renderPlot({
        arr %>%
            filter(OFFENSE_CATEGORY_NAME==input$var3) %>%
            ggplot() + geom_histogram(aes(x=AGE_NUM),bins = input$bins)+
            theme_bw()
        
    },width=500,height=700)
    
    output$plot5 <- renderPlot({
        off %>%
            ggplot()+geom_bar(aes(OFFENSE_CATEGORY_NAME,fill=!!input$var6))+
            coord_flip()+
            theme_bw()+
            theme(legend.position = "bottom")
    },width=500,height=700)
    
    output$plot6<-renderPlot({
        off %>%
            filter(OFFENSE_CATEGORY_NAME==input$var7) %>%
            ggplot() + geom_histogram(aes(x=AGE_NUM,fill=!!input$var6),bins=input$bins2)
    },width=500,height=700)
    
    
    datasetInput <- eventReactive(input$update, {
        switch(input$var8,
               "Animal Cruelty"=animal_cruelty,
               "Arson"=arson,
               "Assault Offenses"=assault,
               "Bad Checks"=bad_checks,
               "Bribery"=bribery,
               "Burglary/Breaking & Entering"=burglary,
               "Counterfeiting/Forgery"=counterfeiting,
               "Curfew/Loitering/Vagrancy Violations"=loitering,
               "Destruction/Damage/Vandalism of Property"=vandalism,
               "Disorderly Conduct"=disorderly_conduct,
               "Driving Under the Influence"=DUI,
               "Drug/Narcotic Offenses"=drug_offenses,
               "Drunkenness"=drunkenness,
               "Embezzlement"=embezzlement,
               "Extortion/Blackmail"=extortion,
               "Family Offenses, Nonviolent"=nonviolent_family_offenses,
               "Fraud Offenses"=fraud,
               "Gambling Offenses"=gambling_offenses,
               "Homicide Offenses"=homicide,
               "Human Trafficking"=human_trafficking,
               "Kidnapping/Abduction"=kidnapping,
               "Liquor Law Violations"=liquor_law_violations,
               "Motor Vehicle Theft"=vehicle_theft,
               "Other Offenses"=other_offenses,
               "Peeping Tom"=peeping_tom,
               "Pornography/Obscene Material"=obscene_material,
               "Prostitution Offenses"=prostitution,
               "Robbery"=robbery,"Sex Offenses"=sex_offenses,
               "Sex Offenses, Non-forcible"=sex_offenses_nonforcible,
               "Stolen Property Offenses"=stolen_property,
               "Weapon Law Violations"=weapon_law_violations)}, ignoreNULL = FALSE)

    output$table2 <- renderTable({
        head(datasetInput(), n = 10)
    })
    
    output$plot7 <- renderPlot({
        off %>%
            filter(OFFENSE_CATEGORY_NAME==input$var9) %>%
            ggplot()+geom_bar(aes(LOCATION_NAME))+
            coord_flip()+
            theme_bw()+
            theme(legend.position = "bottom")
            
    })
    
    output$plot8 <- renderPlot({
        off %>%
            filter(OFFENSE_CATEGORY_NAME==input$var9) %>%
            ggplot()+geom_bar(aes(x=!!input$var10))+
            coord_flip()+
            theme_bw()+
            theme(legend.position = "bottom")
    })
    
    output$plot9 <- renderPlot({
        off %>%
            filter(OFFENSE_CATEGORY_NAME==input$var11) %>%
            ggplot()+
            geom_density(aes(x=AGE_NUM,color="red"),stat="density")+
            geom_density(aes(x=VIC_AGE_NUM,color="blue"),stat="density")+
            theme_bw() +
            theme(legend.position = "bottom")+
            scale_color_discrete(labels = c("Offender age", "Victim age"))
    })
    
    output$plot10 <- renderPlot({
        off %>%
            filter(OFFENSE_CATEGORY_NAME==input$var11) %>%
            ggplot()+
            geom_bar(aes(x=RELATIONSHIP_NAME)) +
            coord_flip()+
            theme_bw()+
            theme(legend.position = "bottom")
    })
    output$n <- renderPrint({
        o<-off %>%
            filter(OFFENSE_CATEGORY_NAME==input$var11)
        nrow(o)
    })

    output$plot11 <- renderPlot({
        off %>%
            filter(OFFENSE_CATEGORY_NAME==!!input$var11) %>%
            ggplot(aes(x=!!input$var12,y=!!input$var13)) +
            geom_count()+
            theme_bw()+
            theme(legend.position = "bottom")
    })
    
    output$table3 <- renderDataTable(
        shootings_mn %>%
            filter(Year==!!input$var14)
    )
    
    output$plot12 <- renderPlot({
        shootings_mn %>%
            ggplot() + geom_bar(aes(x=Year,fill=!!input$var15))+
            theme_bw()+
            theme(legend.position = "bottom")
            
    })
    
    output$plot13 <- renderPlot({
        shootings_mn %>%
            ggplot() + geom_boxplot(aes(x=!!input$var15,y=age))+
            theme_bw()+
            theme(legend.position = "bottom")
    })
    
}

shinyApp(ui = ui, server = server)
