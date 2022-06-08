#' Write Meteo.in for use with Hydrus-1D
#'
#' @export
#'
write_meteo_in <- function(meteo_data,
                           hydrus_wd = "",
                           meteo_in_ops = meteo_in_options(MeteoRecords = nrow(meteo_data))){

  meteo_in <- c(
    meteo_options_header(meteo_in_ops),
    meteo_daily_data(meteo_data),
    "end *** END OF INPUT FILE 'METEO.IN' **********************************"
  )

  meteo_file <- file.path(hydrus_wd, "Meteo.in")

  write(meteo_in, file = meteo_file)

  return(invisible(NULL))
}

#' Create options list for Meteo.in
#'
#' @export
#'
#' @param MeteoRecords
#'
meteo_in_options <- function(MeteoRecords,
                             Radiation = 1,
                             Penman_Hargreaves = FALSE,
                             lEnBal = FALSE,
                             lDaily = FALSE,
                             Latitude = 40,
                             Altitude = 110,
                             ShortWaveRadA = 0.25,
                             ShortWaveRadB = 0.5,
                             LongWaveRadA = 0.9,
                             LongWaveRadB = 0.1,
                             LongWaveRadA1 = 0.34,
                             LongWaveRadB1 = -0.139,
                             WindHeight = 200,
                             TempHeight = 200,
                             iCrop = 0,
                             SunShine = 3,
                             RelativeHum = 0,
                             CloudFactAC = 1.35,
                             CloudFactBC = -0.35,
                             Albedo = 0.23){

  options_out <- list(MeteoRecords = MeteoRecords,
                      Radiation = Radiation,
                      Penman_Hargreaves = Penman_Hargreaves,
                      lEnBal = lEnBal,
                      lDaily = lDaily,
                      Latitude = Latitude,
                      Altitude = Altitude,
                      ShortWaveRadA = ShortWaveRadA,
                      ShortWaveRadB = ShortWaveRadB,
                      LongWaveRadA = LongWaveRadA,
                      LongWaveRadB = LongWaveRadB,
                      LongWaveRadA1 = LongWaveRadA1,
                      LongWaveRadB1 = LongWaveRadB1,
                      WindHeight = WindHeight,
                      TempHeight = TempHeight,
                      iCrop = iCrop,
                      SunShine = SunShine,
                      RelativeHum = RelativeHum,
                      CloudFactAC = CloudFactAC,
                      CloudFactBC = CloudFactBC,
                      Albedo = Albedo)

  return(options_out)
}

#'
#' @importFrom dplyr "%>%"
#' @importFrom purrr map
#'
meteo_options_header <- function(meteo_opt){

  meteo_opt <- meteo_opt %>%
      map(~{if(is.logical(.)){if(.){"t"}else{"f"}}else{.}})

  opt_header <- c(
    " MeteoRecords Radiation Penman-Hargreaves",
    sprintf("%13.0f%9.0f%8s",
            meteo_opt[["MeteoRecords"]],
            meteo_opt[["Radiation"]],
            meteo_opt[["Penman_Hargreaves"]]),
    "  lEnBal  lDaily  lDummy  lDummy  lDummy  lDummy  lDummy  lDummy  lDummy  lDummy",
      sprintf("%8s%8s       f       f       f       f       f       f       f       f",
            meteo_opt[["lEnBal"]],
            meteo_opt[["lDaily"]]),
    " Latitude  Altitude",
    sprintf("%9.3f%10.0f",
            meteo_opt[["Latitude"]],
            meteo_opt[["Altitude"]]),
    " ShortWaveRadA ShortWaveRadB",
    sprintf("%14.3f%14.3f",
            meteo_opt[["ShortWaveRadA"]],
            meteo_opt[["ShortWaveRadB"]]),
    "  LongWaveRadA  LongWaveRadB",
    sprintf("%14.3f%14.3f",
            meteo_opt[["LongWaveRadA"]],
            meteo_opt[["LongWaveRadB"]]),
    " LongWaveRadA1 LongWaveRadB1",
    sprintf("%14.3f%14.3f",
            meteo_opt[["LongWaveRadA1"]],
            meteo_opt[["LongWaveRadB1"]]),
    " WindHeight TempHeight",
    sprintf("%11.0f%11.0f",
            meteo_opt[["WindHeight"]],
            meteo_opt[["TempHeight"]]),
    " iCrop (=0: no crop, =1: constant, =2: table, =3: daily)  SunShine  RelativeHum",
    sprintf("%6.0f%60.0f%13.0f",
            meteo_opt[["iCrop"]],
            meteo_opt[["SunShine"]],
            meteo_opt[["RelativeHum"]]),
    "  CloudFactAC  CloudFactBC",
    sprintf("%13.2f%13.2f",
            meteo_opt[["CloudFactAC"]],
            meteo_opt[["CloudFactBC"]]),
    "    Albedo",
    sprintf("%10.2f",
            meteo_opt[["Albedo"]])
  ) %>%
  c("Pcp_File_Version=4",
    "* METEOROLOGICAL PARAMETERS AND INFORMATION |||||||||||||||||||||||||||||||",
    .)

  return(opt_header)
}

#'
#' @importFrom dplyr "%>%" mutate select
#' @importFrom tidyselect any_of
#' @importFrom stringr str_c
#'
meteo_daily_data <- function(daily_tbl){

  daily_data <- daily_tbl %>%
    mutate(across(t,
                  ~sprintf("%10.0f", .)),
           across(c(Rad, TMax, TMin, RHMean, Wind, SunHours),
                  ~sprintf("%11.1f", .)),
           across(any_of(c("CropHeight", "Albedo", "LAI(SCF)", "rRoot")),
                  ~sprintf("%11.2f", .))
           ) %>%
    select(any_of(c("t",
                    "Rad", "TMax", "TMin", "RHMean", "Wind", "SunHours",
                    "CropHeight", "Albedo", "LAI(SCF)", "rRoot"))) %>%
    as.list() %>%
    do.call(str_c, .) %>%
    c("Daily values",
      "         t        Rad       TMax       TMin     RHMean       Wind   SunHours CropHeight     Albedo   LAI(SCF)      rRoot",
      "       [T]  [MJ/m2/d]        [C]        [C]        [%]     [km/d]     [hour]        [L]        [-]        [-]        [L]",
      .)

  return(daily_data)
}
