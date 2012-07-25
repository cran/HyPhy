\name{Internal R functions}
\alias{get.recon.1}
\title{Internal Functions}
\description{These functions are used by other functions in the \code{HyPhy} package and not by users }
\usage{get.recon.1(phy, phy.sub, reconcile)}
\arguments{
	\item{phy}{The species tree to be reconciled of class \dQuote{\link{phylo}}}
 	\item{phy.sub}{The gene tree(s) to be reconciled in class \dQuote{\link{phylo}} or \dQuote{\link[=multiphylo]{multiPhylo}} }
  	\item{reconcile}{A description of the relationship between the gene tree and the species tree: 
		either \code{NULL}; a vector of positive integers of length \code{length(phy.sub$tip.label)}; 
		or a vector of integers and NA of length \code{max(phy.sub$edge)}. (See details)}
}
\author{Nathaniel Malachi Hallinan}