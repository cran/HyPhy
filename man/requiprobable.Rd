\name{requiprobable}
\alias{requiprobable}
\title{Sample trees from an equiprobable labeled, semi-labeled or unlabeled distribution}
\description{An equiprobable distribution assumes that all tree topologies are equally likely.  The degree of tip labeling affects the number of possible tree topologies.
	In labeled trees all the tips are different, in unlabeled trees all the tips are the same and in semi-labeled trees the tips fall into groups in which any individual tip may or may not be the same as any other.
}
\usage{requiprobable(n, labels, label.counts = rep(1, length(labels)))}
\arguments{
  \item{n}{An integer. The number of trees to sample.}
  \item{labels}{A character vector. The different labels for the tips of the trees.}
  \item{label.counts}{An integer vector of length \code{length(labels)}.  The number of tips using each label.}
}
\details{
	To sample from labeled trees, use the default for \code{label.counts}, where every value is 1.  
	To sample from unlabeled trees use a \code{labels} of length 1 and set \code{label.counts} as a single integer equal to the number of tips in the tree.
	To sample semilabeled trees \code{label.counts} should be the number of tips of the tree for each tip label from \code{labels}.
}
\value{
If \code{n=1}, a tree of class \dQuote{\link{phylo}}.  Otherwise, multiple trees in a list of class \dQuote{\link[=multiphylo]{multiPhylo}}.
}
\references{
For labeled trees:

 G. Furnas, The generation of random, binary unordered trees, J. Classif.
1 (1984) 187-233.

For unlabeled trees:

 L. Cavalli-Sforza, A. Edwards, Phylogenetic analysis:  Models and esti-
mation procedures, Am. J. Hum. Genet. 19 (1967) 233-257.

For semi-labeled trees:

N. Hallinan. Null models for gene family trees, Math. Biosci. (In review).
}
\author{Nathaniel Malachi Hallinan}
\seealso{\code{\link{plot.phylo}}, \code{\link{recon.score}}}
\examples{
##We are going to sample 10 labeled 10 unlabeled and 10 semi labeled 10 tip trees
labeled<-requiprobable(10,c("A1","A2","B1","B2","B3","C1","C2","C3","C4","C5"))
plot(labeled)

unlabeled<-requiprobable(10,"?",10)
plot(unlabeled)
##If you want to add tip labels to these trees
for (i in 1:10) unlabeled[[i]]$tip.label<-sample(c("A1","A2","B1","B2","B3","C1","C2","C3","C4","C5"))

semilabeled<-requiprobable(10,c("A","B","C"),c(2,3,5))
plot(semilabeled)
}
