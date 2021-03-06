context("Stata (.dta) imports/exports")
require("datasets")

test_that("Export to Stata", {
    expect_true(export(mtcars, "mtcars.dta") %in% dir())
    mtcars3 <- mtcars
    names(mtcars3)[1] <- "foo.bar"
    expect_error(export(mtcars3, "mtcars3.dta"), label = "Export fails on invalid Stata names")
})

test_that("Import from Stata (read_dta)", {
    expect_true(is.data.frame(import("mtcars.dta", haven = TRUE)))
    # arguments ignored
    expect_warning(import("mtcars.dta", haven = TRUE, extraneous.argument = TRUE))
    # tell arg_reconcile() to not show warnings
    expect_silent(import("mtcars.dta", haven = TRUE,
                         extraneous.argument = TRUE, .warn = FALSE))
})

test_that("Import from Stata with extended Haven features (read_dta)", {
  expect_true(is.data.frame(mtcars_wtam <- import("mtcars.dta", haven = TRUE,
                                                  col_select = c('wt', 'am'),
                                                  n_max = 10)))
  expect_identical(c(10L,2L), dim(mtcars_wtam))
  expect_identical(c('wt', 'am'), names(mtcars_wtam))
})

test_that("Import from Stata (read.dta)", {
    test1 <- try(import("http://www.stata-press.com/data/r12/auto.dta", haven = FALSE))
    if (!inherits(test1, "try-error")) {
        expect_true(inherits(test1, "data.frame"))
    }
    expect_error(
        is.data.frame(import("mtcars.dta", haven = FALSE)), 
        label = "foreign::read.dta cannot read newer Stata files"
    )
})

unlink("mtcars.dta")
