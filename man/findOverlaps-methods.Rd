\name{findOverlaps-methods}

\alias{findOverlaps-methods}

\alias{findOverlaps}
\alias{findOverlaps,RangedSummarizedExperiment,Vector-method}
\alias{findOverlaps,Vector,RangedSummarizedExperiment-method}
\alias{findOverlaps,RangedSummarizedExperiment,RangedSummarizedExperiment-method}

\alias{countOverlaps}
\alias{countOverlaps,RangedSummarizedExperiment,Vector-method}
\alias{countOverlaps,Vector,RangedSummarizedExperiment-method}
\alias{countOverlaps,RangedSummarizedExperiment,RangedSummarizedExperiment-method}

\alias{overlapsAny}
\alias{overlapsAny,RangedSummarizedExperiment,Vector-method}
\alias{overlapsAny,Vector,RangedSummarizedExperiment-method}
\alias{overlapsAny,RangedSummarizedExperiment,RangedSummarizedExperiment-method}

\alias{subsetByOverlaps}
\alias{subsetByOverlaps,RangedSummarizedExperiment,Vector-method}
\alias{subsetByOverlaps,Vector,RangedSummarizedExperiment-method}
\alias{subsetByOverlaps,RangedSummarizedExperiment,RangedSummarizedExperiment-method}


\title{Finding overlapping ranges in RangedSummarizedExperiment objects}

\description{
  This man page documents the \code{findOverlaps} methods and family
  (i.e. \code{countOverlaps}, \code{overlapsAny}, and \code{subsetByOverlaps}
  methods) for \link{RangedSummarizedExperiment} objects.
}

\usage{
\S4method{findOverlaps}{RangedSummarizedExperiment,Vector}(query, subject,
    maxgap=0L, minoverlap=1L,
    type=c("any", "start", "end", "within", "equal"),
    select=c("all", "first", "last", "arbitrary"),
    algorithm=c("nclist", "intervaltree"),
    ignore.strand=FALSE)
\S4method{findOverlaps}{Vector,RangedSummarizedExperiment}(query, subject,
    maxgap=0L, minoverlap=1L,
    type=c("any", "start", "end", "within", "equal"),
    select=c("all", "first", "last", "arbitrary"),
    algorithm=c("nclist", "intervaltree"),
    ignore.strand=FALSE)

\S4method{countOverlaps}{RangedSummarizedExperiment,Vector}(query, subject,
    maxgap=0L, minoverlap=1L,
    type=c("any", "start", "end", "within", "equal"),
    algorithm=c("nclist", "intervaltree"),
    ignore.strand=FALSE)
\S4method{countOverlaps}{Vector,RangedSummarizedExperiment}(query, subject,
    maxgap=0L, minoverlap=1L,
    type=c("any", "start", "end", "within", "equal"),
    algorithm=c("nclist", "intervaltree"),
    ignore.strand=FALSE)

\S4method{overlapsAny}{RangedSummarizedExperiment,Vector}(query, subject,
    maxgap=0L, minoverlap=1L,
    type=c("any", "start", "end", "within", "equal"),
    algorithm=c("nclist", "intervaltree"),
    ignore.strand=FALSE)
\S4method{overlapsAny}{Vector,RangedSummarizedExperiment}(query, subject,
    maxgap=0L, minoverlap=1L,
    type=c("any", "start", "end", "within", "equal"),
    algorithm=c("nclist", "intervaltree"),
    ignore.strand=FALSE)

\S4method{subsetByOverlaps}{RangedSummarizedExperiment,Vector}(query, subject,
    maxgap=0L, minoverlap=1L,
    type=c("any", "start", "end", "within", "equal"),
    algorithm=c("nclist", "intervaltree"),
    ignore.strand=FALSE)
\S4method{subsetByOverlaps}{Vector,RangedSummarizedExperiment}(query, subject,
    maxgap=0L, minoverlap=1L,
    type=c("any", "start", "end", "within", "equal"),
    algorithm=c("nclist", "intervaltree"),
    ignore.strand=FALSE)
}

\arguments{
  \item{query, subject}{
    One of these two arguments must be a \link{RangedSummarizedExperiment}
    object.
  }
  \item{maxgap, minoverlap, type}{
    See \code{?\link[GenomicRanges]{findOverlaps}} in the \pkg{GenomicRanges}
    package.
  }
  \item{select, algorithm, ignore.strand}{
    See \code{?\link[GenomicRanges]{findOverlaps}} in the \pkg{GenomicRanges}
    package.
  }
}

\details{
  These methods operate on the \code{rowRanges} component of the
  \link{RangedSummarizedExperiment} object, which can be a
  \link[GenomicRanges]{GenomicRanges} or \link[GenomicRanges]{GRangesList}
  object.

  More precisely, if any of the above functions is passed a
  \link{RangedSummarizedExperiment} object thru the \code{query} and/or
  \code{subject} argument, then it behaves as if \code{rowRanges(query)}
  and/or \code{rowRanges(subject)} had been passed instead.

  See \code{?\link[GenomicRanges]{findOverlaps}} in the \pkg{GenomicRanges}
  package for the details of how \code{findOverlaps} and family operate on
  \link[GenomicRanges]{GenomicRanges} and \link[GenomicRanges]{GRangesList}
  objects.
}

\value{
  See \code{?\link[GenomicRanges]{findOverlaps}} in the \pkg{GenomicRanges}
  package.
}

\seealso{
  \itemize{
    \item \link{RangedSummarizedExperiment} objects.

    \item The \link[GenomicRanges]{findOverlaps} man page in the
          \pkg{GenomicRanges} package where the \code{findOverlaps} family
          of methods for \link[GenomicRanges]{GenomicRanges} and
          \link[GenomicRanges]{GRangesList} objects is documented.
  }
}

\examples{
nrows <- 20; ncols <- 6
counts <- matrix(runif(nrows * ncols, 1, 1e4), nrows)
rowRanges <- GRanges(rep(c("chr1", "chr2"), c(5, 15)),
                     IRanges(sample(1000L, 20), width=100),
                     strand=Rle(c("+", "-"), c(12, 8)))
colData <- DataFrame(Treatment=rep(c("ChIP", "Input"), 3),
                     row.names=LETTERS[1:6])
se0 <- SummarizedExperiment(assays=SimpleList(counts=counts),
                            rowRanges=rowRanges, colData=colData)
se1 <- shift(se0, 100)

hits <- findOverlaps(se0, se1)
hits
stopifnot(identical(hits, findOverlaps(rowRanges(se0), rowRanges(se1))))
stopifnot(identical(hits, findOverlaps(se0, rowRanges(se1))))
stopifnot(identical(hits, findOverlaps(rowRanges(se0), se1)))
}

\keyword{methods}
\keyword{utilities}
