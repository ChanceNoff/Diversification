plan.continuous <- drake_plan(
  tree = read.tree("data/Russula_mega_ML.tre"),
  mytree = ape::plot.phylo(tree, type="fan", cex=0.2),
  taxon = tree$tip.label,
  substr(taxon, 14, nchar(taxon)), ## removes everything from the 14th character to the end to the string, this worked for lots of the names but not all
  str_detect(taxon, "Russula") ## finds all the strings containing Russula
  
  
  #continuous.data <- read.csv(file="____PATH_TO_DATA_OR_SOME_OTHER_WAY_OF_GETTING_TRAITS____", stringsAsFactors=FALSE) #death to factors.
  
  
)