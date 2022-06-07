#' Read NOD_INF.OUT
#'
#' @export
#'
#' @importFrom dplyr "%>%" mutate filter pull bind_cols select rename_with
#' @importFrom tibble tibble
#' @importFrom tidyr fill
#' @importFrom readr read_table
#' @importFrom stringr str_extract str_detect
#'
read_nod_inf <- function(hydrus_wd){

  nod_inf_path <- file.path(hydrus_wd, "NOD_INF.OUT")

  raw_input <- readLines(nod_inf_path) %>%
    tibble(raw_lines = .) %>%
    # Extract times
    mutate(Time = str_extract(raw_lines, "^ *Time:.*") %>%
             str_extract("[0-9.eE+-]+$") %>%
             as.numeric()) %>%
    # Propogate times downward
    fill(Time, .direction = "down")

  header_line <- raw_input %>%
    filter(str_detect(raw_lines, "^ *Node")) %>%
    pull(raw_lines) %>%
    head(1)

  raw_data <- raw_input %>%
    filter(str_detect(raw_lines, "^ +[0-9]"))

  nod_inf_data <- raw_data %>%
    # Read raw data
    pull(raw_lines) %>%
    I(.) %>%
    read_table(col_names = FALSE)

  # Generate column names according to number of columns and header
  col_names <- nod_inf_col_names(header_line, ncol(nod_inf_data))

  # Add proper column names
  nod_inf_out <- nod_inf_data %>%
    rename_with(~{col_names}) %>%
    bind_cols(raw_data, .) %>%
    select(-raw_lines)

  return(nod_inf_out)
}

#'
#' @importFrom dplyr "%>%" pull
#' @importFrom tidyr expand_grid
#' @importFrom stringr str_c
#'
nod_inf_col_names <- function(header_line, n_col){

  if(str_detect(header_line, "WTrans", negate = TRUE)){
    col_names <- c("Node", "Depth", "Head", "Moisture", "K", "C",
                   "Flux", "Sink", "Kappa", "v/KsTop", "Temp")
  }else{
    col_names <- c("Node", "Depth", "Head", "Moisture", "WTrans",
                   "Im.Moist.", "Flux", "STrans", "Kappa", "v/KsTop",
                   "Temp")
  }

  if(n_col > 11){
    col_names <- (n_col - 11) %/% 2 %>%
      {1:.} %>%
      expand_grid(name = c("Conc", "Sorb"),
                  lev = .) %>%
      mutate(names = str_c(name, lev, sep = "_")) %>%
      pull(names) %>%
      c(col_names, .)
  }

  return(col_names)
}
