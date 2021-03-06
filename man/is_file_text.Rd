% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_file_text.R
\name{is_file_text}
\alias{is_file_text}
\title{Determine whether a file is \dQuote{plain-text} or some sort of binary format}
\usage{
is_file_text(file, maxsize = Inf, text_bytes = as.raw(c(7:16, 18, 19, 32:255)))
}
\arguments{
\item{file}{Path to the file}

\item{maxsize}{Maximum number of bytes to read}

\item{text_bytes}{Which characters are used by normal text (though not 
necessarily just ASCII). To detect just ASCII, the 
following value can be used: 
\code{as.raw(c(7:16, 18, 19, 32:127))}}
}
\value{
A logical
}
\description{
Determine whether a file is \dQuote{plain-text} or some sort of binary format
}
\examples{
library(datasets)
export(iris, "iris.yml")
is_file_text("iris.yml") # TRUE

export(iris, "iris.sav")
is_file_text("iris.sav") # FALSE

# cleanup
unlink("iris.yml")
unlink("iris.sav")

}
