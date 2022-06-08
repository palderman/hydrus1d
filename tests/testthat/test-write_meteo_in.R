test_that("meteo_options_header() works", {
  expect_identical(
    meteo_options_header(
      meteo_in_options(MeteoRecords = 30)
      ),
    c("Pcp_File_Version=4",
      "* METEOROLOGICAL PARAMETERS AND INFORMATION |||||||||||||||||||||||||||||||",
      " MeteoRecords Radiation Penman-Hargreaves",
      "           30        1       f",
      "  lEnBal  lDaily  lDummy  lDummy  lDummy  lDummy  lDummy  lDummy  lDummy  lDummy",
      "       f       f       f       f       f       f       f       f       f       f",
      " Latitude  Altitude",
      "   40.000       110",
      " ShortWaveRadA ShortWaveRadB",
      "         0.250         0.500",
      "  LongWaveRadA  LongWaveRadB",
      "         0.900         0.100",
      " LongWaveRadA1 LongWaveRadB1",
      "         0.340        -0.139",
      " WindHeight TempHeight",
      "        200        200",
      " iCrop (=0: no crop, =1: constant, =2: table, =3: daily)  SunShine  RelativeHum",
      "     0                                                           3            0",
      "  CloudFactAC  CloudFactBC",
      "         1.35        -0.35",
      "    Albedo",
      "      0.23"
    )
  )
})

test_that("meteo_daily_data() works", {
  expect_identical(
    meteo_daily_data(
      readRDS(system.file("testdata", "meteo_no_crop.rds", package = "hydrus1d"))
    ),
    c("Daily values",
      "         t        Rad       TMax       TMin     RHMean       Wind   SunHours CropHeight     Albedo   LAI(SCF)      rRoot",
      "       [T]  [MJ/m2/d]        [C]        [C]        [%]     [km/d]     [hour]        [L]        [-]        [-]        [L]",
      "         1       19.1       31.2       17.1       66.3      196.2        4.0",
      "         2       19.4       31.3       16.6       66.8      191.3        4.0",
      "         3       20.1       31.3       16.3       66.0      215.6        4.0",
      "         4       17.9       30.8       16.3       67.4      221.3        4.0",
      "         5       17.6       29.9       15.8       65.5      206.2        4.0",
      "         6       17.6       28.9       15.2       67.2      207.7        4.0",
      "         7       18.6       29.8       14.7       67.1      190.6        4.0",
      "         8       18.4       30.0       14.0       66.4      213.9        4.0",
      "         9       16.3       28.0       14.3       70.3      225.6        4.0",
      "        10       17.9       26.9       13.0       69.0      208.0        4.0"
    )
  )
})
