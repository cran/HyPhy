\name{recon.score}
\alias{recon.score}
\title{Duplications and losses for gene tree in a species tree}
\description{Calculates the minimum number of gene duplications and gene losses necessary to reconcile a gene tree with a species tree}
\usage{recon.score(phy, phy.sub, reconcile = NULL)}
\arguments{
	\item{phy}{The species tree to be reconciled of class \dQuote{\link{phylo}}}
 	\item{phy.sub}{The gene tree(s) to be reconciled in class \dQuote{\link{phylo}} or \dQuote{\link[=multiphylo]{multiPhylo}} }
  	\item{reconcile}{A description of the relationship between the gene tree and the species tree: 
		either \code{NULL}; a vector of positive integers of length \code{length(phy.sub$tip.label)}; 
		or a vector of integers and NA of length \code{max(phy.sub$edge)}. (See details)}
}
\details{
\code{reconcile} is a vector in which the \emph{ith} element of the vector gives the position on \code{phy} of the node of the gene tree labeled \emph{i} in  \code{phy$sub.edge}.
A positive \emph{n} value places the \emph{ith} \code{ph.sub} node on the node of the species tree labeled \emph{n} in \code{phy$edge},
a negative \emph{n} value places the \emph{ith} \code{ph.sub} node on the branch of the species tree defined by the \emph{nth} row in \code{phy$edge},
and a 0 places the \emph{ith} \code{ph.sub} node on the root of the species tree.
Elements for which \code{is.na(reconcile[i])} or \code{length(reconcile)<i} are undefined, so
if \code{reconcile=NULL}, then all elements are undefined.
The first \code{length(phy.sub$tip.label)} elements of \code{reconcile} refer to the tips of \code{phy.sub};
if the \emph{ith} element is undefined, then the function will place the \emph{ith} tip of \code{phy.sub} in a tip of \code{phy}, such that \code{phy$tip.label==phy.sub$tip.label[i]}.
The remaining elements of \code{reconcile} refer to the internal nodes of \code{phy.sub};
if the \emph{ith} element is undefined, then the function will place the \emph{ith} node of \code{phy.sub} at its maximum parsimony position given the position of the two nodes above it.

To make a long story short, if the labels in \code{phy.sub$tip.label} match the labels in \code{phy$tip.label}, as they would for trees produced by \code{\link{rgenetree}},
and you want a maximum parsimony reconciliation, then set \code{reconcile=NULL}.
On the other hand, if the labels do not match and you want a maximum parsimony reconciliation, then \code{reconcile} should be a vector of positive integers
assigning the tips of \code{phy.sub} to the tips of \code{phy}.
Finally, if you want a non maximum parsimony reconciliation, then \code{reconcile} should be of length \code{max(phy$edge)}, 
and the nodes of \code{sub.phy} should be assigned to branches of \code{phy} as described above.
Be warned that any internal node of \code{sub.phy} can only be assigned to certain nodes and branches of \code{phy}, and there is no mechanism to check the logical consistancy of \code{reconcile},
so make sure that you assign nodes to appropriate branches.  You can always leave a node as \code{NA}, and it will end up in its maximum parsimony position.
}
\value{
	If \code{class(phy.sub)=="phylo"}, the output is a vector with two elements, the number of duplications and the number of losses.
	If \code{class(phy.sub)=="multiPhylo",} the output is a matrix with two colums, the number of duplications and the number of losses, and every row representing a different tree in \code{phy.sub}..
}
\references{
M. Goodman, J. Czelusniak, G. Moore, A. Romero-Herrera, G. Matsuda,
Fitting the gene lineage into its species lineage, a parsimony strategy illustrated by cladograms constructed from globin sequences, Syst. Zool.
28 (1979) 132-163.
}
\author{Nathaniel Malachi Hallinan}

\seealso{
\code{\link{rgenetree}},\code{plot.recon}(coming soon)
}
\examples{
##First we need a simple species tree
spec<-read.tree(text="((A:0.5,B:0.5):0.5,C:1);")
##Now let's simulate a bunch of gene family trees
genes<-rgenetree(10,spec,0.5,0.5,3,10,TRUE)
##Let's look at those trees
##Note that all their tips are labeled A, B or C, just like spec
plot(genes)
##Therefore we can calculate the counts for all trees without any other info
recon.score(spec,genes)
##On the other hand, if we make our own gene tree with different labels 
gene<-read.tree(text="((A1,(A2,B1)),(B2,(C1,C2)));")
##We must generate a reconcile vector
##to do so we must know the positions of the tip labels in both phylogenies
spec$tip.label
gene$tip.label
reconcile<-c(1,1,2,2,3,3)
recon.score(spec,gene,reconcile)
##To force the node at the base of A2 and B1 down to the branch below A and B
##we must look at both edge matrices to learn how each node and branch are labeled
spec$edge
gene$edge
reconcile<-c(1,1,2,2,3,3,NA,NA,-1,NA,NA)
recon.score(spec,gene,reconcile)
}

