archiveDisplayInput <-
  function(id) {
    ns <- NS(id)
    
    tagList(
      fluidRow(
        style = "box-shadow: 0px 0px 10px grey; padding: 35px;",
        column(
          3,
          selectizeInput(
            ns('filter_mouthpiece'),
            'Mouthpiece',
            choices = NULL,
            width = "100%"
          ),
          selectizeInput(
            ns('filter_player'),
            'Player ID',
            choices = NULL,
            width = "100%"
          ),
          selectizeInput(
            ns('filter_pitch'),
            'Pitch',
            choices = NULL,
            width = "100%"
          ),
          uiOutput(ns('audio'))
        ),
        column(
          3,
          rglwidgetOutput(ns('stl'), width = "100%", height = "300px") %>% withSpinner()
        ),
        column(6, plotOutput(
          ns('spectra'), height = "300px", width = "100%"
        ))
      )
    )
  }

archiveDisplayOutput <-
  function(input,
           output,
           session,
           spectra_dir,
           stl_dir,
           spectra_table,
           audio_table,
           stl_table) {
    #-------------------- Update filter inputs --------------------
    
    # Updates mouthpiece input to display mouthpieces with
    # integer IDs greater than 0
    observe({
      names <- spectra_table %>%
        filter(!mouthpiece_id %% 1 & mouthpiece_id != 0) %>%
        select(mouthpiece_name) %>%
        arrange(mouthpiece_name) %>%
        distinct() %>%
        pull()
      
      updateSelectizeInput(session, 'filter_mouthpiece', choices = names)
    })
    
    # Updates player input to display players for selected mouthpiece
    observe({
      players <- spectra_table %>%
        filter(mouthpiece_name == input$filter_mouthpiece) %>%
        select(player_id) %>%
        unique() %>%
        pull()
      
      updateSelectizeInput(session, 'filter_player', choices = players)
    })
    
    # Updates pitch input to display pitches for selected mouthpiece and player
    observe({
      pitches <- spectra_table %>%
        filter(mouthpiece_name == input$filter_mouthpiece,
               player_id == input$filter_player) %>%
        select(pitch) %>%
        unique() %>%
        pull()
      
      updateSelectizeInput(session, 'filter_pitch', choices = pitches)
    })
    
    #-------------------- Validate mouthpiece --------------------
    
    # Given a table and mouthpiece name, validates that the mouthpiece
    # exists and outputs its ID. Otherwise, returns an error message
    
    validate_mouthpiece_id_spectra <- reactive({
      errorMessage <- "Spectrogram doesn't exist for the given mouthpiece"
      
      temp <- spectra_table %>%
        filter(mouthpiece_name == input$filter_mouthpiece) %>%
        select(mouthpiece_id) %>%
        distinct() %>%
        pull()
      
      validate(need(identical(length(temp), length(1)), errorMessage))
      
      temp
    })
    
    validate_mouthpiece_id_stl <- reactive({
      errorMessage <- "Scan doesn't exist for the given mouthpiece"
      
      temp <- stl_table %>%
        filter(mouthpiece_name == input$filter_mouthpiece) %>%
        select(mouthpiece_id) %>%
        distinct() %>%
        pull()
      
      validate(need(identical(length(temp), length(1)), errorMessage))
      
      temp
    })
    
    #-------------------- Output spectra --------------------
    
    spectra_dataset <- reactive({
      paste0(
        spectra_dir,
        input$filter_player,
        "_",
        validate_mouthpiece_id_spectra(),
        "_",
        input$filter_pitch,
        ".csv"
      ) %>%
        read_csv(col_names = FALSE)
    })
    
    output$spectra <- renderPlot({
      spectra_dataset() %>%
        mutate(x = 1:20000) %>%
        rename(y = X1) %>%
        filter(x <= 10000) %>%
        ggplot(aes(x, y)) +
        geom_line() +
        labs(x = "",
             y = "") +
        theme_light() +
        theme(
          axis.title.y = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank()
        )
    })
    
    #-------------------- Output STL --------------------
    
    output$stl <- renderRglwidget({
      rgl.clear("shapes")
      model <- validate_mouthpiece_id_stl() %>%
        paste0(stl_dir, ., ".stl") %>%
        readSTL(col = 'darkgray')
      bg3d(gray(level = 0.95))
      rglwidget()
    })
    
    #-------------------- Output audio --------------------
    
    output$audio <- renderUI(tags$audio(
      src = paste0(
        "wav/",
        input$filter_player,
        "/",
        validate_mouthpiece_id_spectra(),
        "/",
        input$filter_pitch,
        ".wav"
      ),
      type = "audio/wav",
      controls = NA
    ))
  }