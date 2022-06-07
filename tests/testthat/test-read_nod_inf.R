test_that("nod_inf_col_names() works", {

  expect_identical(nod_inf_col_names(
    " Node      Depth      Head Moisture       K          C         Flux        Sink         Kappa   v/KsTop   Temp",
    11),
    c("Node", "Depth", "Head", "Moisture", "K", "C",
      "Flux", "Sink", "Kappa", "v/KsTop", "Temp")
  )

  expect_identical(nod_inf_col_names(
    " Node      Depth      Head Moisture    WTrans    Im.Moist.     Flux       STrans        Kappa   v/KsTop   Temp",
    11),
    c("Node", "Depth", "Head", "Moisture", "WTrans", "Im.Moist.",
      "Flux", "STrans", "Kappa", "v/KsTop", "Temp")
  )

  expect_identical(nod_inf_col_names(
    " Node      Depth      Head Moisture       K          C         Flux        Sink         Kappa   v/KsTop   Temp   Conc(1..NS) Sorb(1...NS)",
    13),
    c("Node", "Depth", "Head", "Moisture", "K", "C",
      "Flux", "Sink", "Kappa", "v/KsTop", "Temp", "Conc_1", "Sorb_1")
  )

  expect_identical(nod_inf_col_names(
    " Node      Depth      Head Moisture       K          C         Flux        Sink         Kappa   v/KsTop   Temp   Conc(1..NS) Sorb(1...NS)",
    17),
    c("Node", "Depth", "Head", "Moisture", "K", "C",
      "Flux", "Sink", "Kappa", "v/KsTop", "Temp",
      "Conc_1", "Conc_2", "Conc_3", "Sorb_1", "Sorb_2","Sorb_3")
  )

  expect_identical(nod_inf_col_names(
    " Node      Depth      Head Moisture    WTrans    Im.Moist.     Flux       STrans        Kappa   v/KsTop   Temp   Conc(1..NS) Sorb(1...NS)",
    13),
    c("Node", "Depth", "Head", "Moisture", "WTrans", "Im.Moist.",
      "Flux", "STrans", "Kappa", "v/KsTop", "Temp",
      "Conc_1", "Sorb_1")
  )

  expect_identical(nod_inf_col_names(
    " Node      Depth      Head Moisture    WTrans    Im.Moist.     Flux       STrans        Kappa   v/KsTop   Temp   Conc(1..NS) Sorb(1...NS)",
    17),
    c("Node", "Depth", "Head", "Moisture", "WTrans", "Im.Moist.",
      "Flux", "STrans", "Kappa", "v/KsTop", "Temp",
      "Conc_1", "Conc_2", "Conc_3", "Sorb_1", "Sorb_2","Sorb_3")
  )
})
