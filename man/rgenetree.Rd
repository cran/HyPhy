\name{rgenetree}
\alias{rgenetree}
\title{Samples gene family trees that evolved on a species tree with various conditions.}
\description{Samples gene family trees that evolved on the branches of a species tree under the birth-death process.  
	Trees may be conditioned on various priors for the number of reconstructed gene lineages at the root of the species tree,
	on the total number of genes in the gene tree, on the number of genes in each tip of the species tree, 
	on at least one gene in each tip of the species tree or some combination of those conditions. 
}
\usage{rgenetree(n, spec.phy, lams, mus, root = NULL, genetips = NULL, alltips = FALSE)}
\arguments{
  \item{n}{An integer.  The number of trees to sample.}
  \item{spec.phy}{The species tree on which to evolve the gene trees of class \dQuote{\link{phylo}} with branch lengths.}
  \item{lams}{The gene duplication rate in units of duplications per \code{spec.phy} branch lengths.  Either a single numeric for the whole tree or a vector of length \code{dim(spec.phy$edge)[1]} for each branch of the species tree.}
  \item{mus}{The gene loss rate in units of losses per  \code{spec.phy} branch lengths.  Either a single numeric for the whole tree or a vector of length \code{dim(spec.phy$edge)[1]} for each branch of the species tree.}
  \item{root}{The prior distribution of reconstructed gene lieages at the root of the species tree.  Either \code{NULL}, a single positive integer, or a positive numeric vector summing to 1.  See details.}
  \item{genetips}{The number of genes at the tips of the species tree.  Either \code{NULL}, a single positive integer or a vector of positive integers of length \code{length(spec.phy$tip.label)}.  See details.}
  \item{alltips}{A logical.  Should the sample only include gene trees with at least one gene in each species.  Ignored if \code{length(genetips}==length(spec.phy$tip.label)}.}
\details{
	\code{root} sets the prior distribution of the number of reconstructed gene lineages at the root node of the species tree.  
	If \code{is.null(root)}, then the prior on the number of lineages is flat, but if \code{is.null(genetips)} then \code{root} must have some value.
	If \code{root} is a single positive integer, then all gene trees will start with \code{root} reconstructed gene lineages at the root.
	To establish a more complex prior \code{root} should be a numerical vector for which the \emph{ith} element represents the prior probability that there are \emph{i} gene lineages at the root, so that \code{sum(root)==1}.
	In that case \code{root} can be of any length and the prior probability of any number of lineages greater than \code{length(root)} will be 0.
	It should be noted that this is the prior probability assuming \code{is.null(genetips) & !alltips}, changes to those values will affect the probabilities (Hallinan 2012?).

	\code{genetips} sets the conditions on the number of genes in the tips of the \code{spec.phy}.  If \code{is.null(genetips)} then there are no conditions.
	If \code{genetips} is a single integer, then that value will be the total number of genes in each sampled gene tree, although the number of genes in each species may vary from sample to sample.
	One can set the number of genes in each tip of the \code{spec.phy} with a \code{genetips} of length \code{length(spec.phy$tip.label)}, where the \emph{ith} member of \code{genetips} will be the number of genes in \code{spec.phy$tip.label[i]}.  
}
\value{
If \code{n==1}, a tree of class \dQuote{\link{phylo}}.  Otherwise, multiple trees in a list of class \dQuote{\link[=multiphylo]{multiPhylo}}.
}
\references{N. Hallinan. Null models for gene family trees, Math. Biosci. (In review).}
\author{Nathaniel Malachi Hallinan}
\seealso{\code{\link{recon.score}},\code{\link{plot.phylo}},\code{plot.recon}(coming soon)}
\examples{
##First we need a simple species tree
spec<-read.tree(text="((A:0.5,B:0.5):0.5,C:1);")
##Now we sample ten gene trees starting with 3 reconstructed gene lineages
phy.all<-rgenetree(10,spec,0.5,0.5,3)
plot(phy.all)

##Now let's make sure that every tip has at least one gene and set an exponential prior on the root
phy.full<-rgenetree(10,spec,0.5,0.5,exp(-(1:20))/sum(exp(-(1:20))),NULL,TRUE)
plot(phy.full)

##Now lets force the whole gene tree to end in 10 genes and set a flat prior for the root
phy.10<-rgenetree(10,spec,0.5,0.5,NULL,10)
plot(phy.10)

##Now lets start with 3 genes, set the number of genes at each tip of spec and vary mu between the branches of spec 
phy.253<-rgenetree(10,spec,0.5,c(0,1,0.2,0.5),3,c(2,5,3))
plot(phy.253)
}