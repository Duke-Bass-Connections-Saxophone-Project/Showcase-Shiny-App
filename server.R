shinyServer(function(input, output, session) {
    
    #-------------------- Read Data --------------------
    
    stl_dir <- "www/stl/"
    fit_dir <- "www/csv/fit"
    other_dir <- "www/csv/other/"
    spectra_dir <- "www/csv/spectra/"
    
    mouthpiece <- paste0(other_dir, "mouthpiece.csv") %>%
        read_csv()
    survey <- paste0(other_dir, "survey.csv") %>%
        read_csv()
    audio <- paste0(other_dir, "audio.csv") %>%
        read_csv()
    
    spectra_filenames <-
        list.files(spectra_dir, full.names = TRUE)
    
    stl_filenames <- list.files(stl_dir, full.names = TRUE)
    
    wav_filenames <-
        list.files("www/wav",
                   full.names = TRUE,
                   recursive = TRUE)
    
    fit_filenames <- list.files(fit_dir,
                               full.names = TRUE,
                               recursive = TRUE)
    
    #-------------------- Create Tables --------------------
    
    spectra_table <- list.files(spectra_dir) %>%
        str_split("_", simplify = TRUE) %>%
        as_tibble() %>%
        rename(player_id = V1,
               mouthpiece_id = V2,
               pitch = V3) %>%
        mutate_at(c("player_id", "mouthpiece_id"), as.numeric) %>%
        left_join(mouthpiece, by = "mouthpiece_id") %>%
        mutate(mouthpiece_name = paste(make, model),
               pitch = str_replace(pitch, ".csv", "")) %>%
        select(player_id, mouthpiece_name, mouthpiece_id, pitch)
    
    stl_table <- stl_filenames %>%
        str_extract_all("\\d+", simplify = TRUE) %>%
        unlist() %>%
        as_tibble() %>%
        rename(mouthpiece_id = V1) %>%
        mutate(mouthpiece_id = as.numeric(mouthpiece_id)) %>%
        left_join(mouthpiece, by = "mouthpiece_id") %>%
        mutate(mouthpiece_name = paste(make, model)) %>%
        select(mouthpiece_id, mouthpiece_name)
    
    analysis_table <- survey %>%
        right_join(audio, by = c("player_id", "mouthpiece_id")) %>%
        left_join(mouthpiece, by = c("mouthpiece_id")) %>%
        select(-date, -make, -model, -type, -refacing, -material, -baffle_shape, -chamber) %>%
        mutate(player_group = case_when(
            player_id %in% c(6, 7) ~ "professional",
            player_id %in% c(4, 5) ~ "classical",
            player_id %in% c(0, 2) ~ "similar mouthpieces",
            TRUE ~ "other"
        ))
    
    callModule(
        archiveDisplayOutput,
        archive_module_names[1],
        spectra_dir,
        stl_dir,
        spectra_table,
        audio_table,
        stl_table
    )
    
    callModule(
        archiveDisplayOutput,
        archive_module_names[2],
        spectra_dir,
        stl_dir,
        spectra_table,
        audio_table,
        stl_table
    )
    
    callModule(analysisDisplayOutput,
               analysis_module_names[1],
               analysis_table)
    
    callModule(analysisDisplayOutput,
               analysis_module_names[2],
               analysis_table)
})