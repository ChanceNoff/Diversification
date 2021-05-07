doubling <- function(x) {
  return(x*2)
}

is_even <- function(phy) {
  number_of_tips <- ape::Ntip(phy)
  even <- FALSE
  if(number_of_tips%%2==0) {
    even <- TRUE
  }
  return(even)
}

plot_tree <- function(phy, file) {
  pdf(file=file, width = 20, height = 20)
  plot(phy)
  plot(phy, type='fan')
  plot(phy, type = 'fan', show.tip.label = FALSE, edge.width = .1)
  dev.off()
}

CleanData <- function(phy, data) {
  treedata(phy, data, warnings = TRUE)
  #treedata() in Geiger is probably my favorite function in R.
}

VisualizeData <- function(phy, data) {
  #Important here is to LOOK at your data before running it. Any weird values? Does it all make sense? What about your tree? Polytomies?
  
  # Now write the code to use VisualizeData() to actually look at your data
  plot(phy ,no.margin=TRUE,edge.width=2)
}

GetTreeWithNameProcessing <- function(treefile) {
  raw <- readLines(treefile)
  raw <- gsub(" CSM", "", raw)
  raw <- gsub(" ", "_", raw)
  phy <- ape::read.tree(text=raw)
}

GetSingleGenusSpecies <- function(x) {
  return(paste(strsplit(x, " |_")[[1]][1:2], collapse=" "))
}

GetAllGenusSpecies <- function(x) {
  sapply(x, GetSingleGenusSpecies)
}
