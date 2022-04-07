#' Read OBS_NODE.OUT
#'
#' @export
#'
#' @importFrom dplyr "%>%" rename_with select
#' @importFrom tidyr pivot_longer pivot_wider separate
#' @importFrom readr read_table
#' @importFrom stringr str_which str_extract str_remove str_c
#'
read_obs_node <- function(hydrus_wd){

  obs_node_path <- file.path(hydrus_wd, "OBS_NODE.OUT")

  raw_lines <- readLines(obs_node_path)

  # node_line <- str_which(raw_lines, "Node")
  header_line <- str_which(raw_lines, "time")

  obs_node_out <- read_table(I(raw_lines), skip = header_line - 1) %>%
    rename_with(function(x){

      suffixes <- str_extract(x, "(?<=_)[0-9]*$") %>%
        as.integer() %>%
        replace_na(0) %>%
        {. + 1}

      new_names <- str_remove(x, "_[0-9]*$") %>%
        str_c("_", suffixes)

      names_out <- ifelse(x == "time",
                          x,
                          new_names)

      return(names_out)
    }) %>%
    select(matches("(time)|(h)|(theta)|(Temp)")) %>%
    pivot_longer(cols = -time) %>%
    separate(col = name,
             into = c("variable","layer"),
             sep = "_") %>%
    pivot_wider(names_from = "variable",
                values_from = "value")

  return(obs_node_out)
}
