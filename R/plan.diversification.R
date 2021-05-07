plan.diversification <- drake_plan(
  my.tree = TreeSim::sim.bd.taxa(n=300, numbsim=1, lambda=0.1, mu=0)[[1]],
  tree_print = plot_tree(my.tree, file = "results/simulated_tree.pdf"),
  ape::ltt.plot(my.tree),
  ape::ltt.plot(my.tree, log="y"),
  yule.trees = TreeSim::sim.bd.taxa(n=300, numbsim=10, lambda=0.1, mu=0, complete=FALSE),
  #stop("How to do a multiple ltt plot?")
  mltt.plot(yule.trees, dcol = TRUE, dlty = FALSE, legend = TRUE,
            xlab = "Time", ylab = "N", log = "", backward = TRUE,
            tol = 1e-6), ##multiple ltt plot
  bd.trees = TreeSim::sim.bd.taxa(n=300, numbsim=10, lambda=1, mu=.9, complete=FALSE),
  ape::mltt.plot(bd.trees, log="y", legend=FALSE),
  depth.range = range(unlist(lapply(yule.trees,ape::branching.times)), unlist(lapply(bd.trees,ape::branching.times))),
  max.depth = sum(abs(depth.range)), #ape rescales depths
  plot(x=c(0, -1*max.depth), y=c(1, ape::Ntip(yule.trees[[1]])), log="y", type="n", bty="n", xlab="Time", ylab="N"),
  colors=c(rgb(1,0,0,0.5), rgb(0, 0, 0, 0.5)),
  list.of.both = list(bd.trees, yule.trees),
  for (i in sequence(2)) {
    tree.list <- list.of.both[[i]]
    for (j in sequence(length(tree.list))) {
      ape::ltt.lines(tree.list[[j]], col=colors[[i]])
    }
  },
  legend("topleft", legend=c("Birth Death", "Yule"), fill=colors),
  
  ## zooming in on the final part of the previous plot
  depth.range2 = range(unlist(lapply(yule.trees,ape::branching.times)), unlist(lapply(bd.trees,ape::branching.times))),
  max.depth2 = sum(abs(depth.range2)), #ape rescales depths
  plot(x=c(0, -5), y=c(200, ape::Ntip(yule.trees[[1]])), log="y", type="n", bty="n", xlab="Time", ylab="N"),
  colors2 = c(rgb(1,0,0,0.5), rgb(0, 0, 0, 0.5)),
  list.of.both2 = list(bd.trees, yule.trees),
  for (i in sequence(2)) {
    tree.list <- list.of.both[[i]]
    for (j in sequence(length(tree.list))) {
      ape::ltt.lines(tree.list[[j]], col=colors2[[i]])
    }
  },
  legend("topleft", legend=c("Birth Death", "Yule"), fill=colors2),
  
  #ploting trees with different diversification paramaters
  my.trees2 = TreeSim::sim.bd.taxa(n=300, numbsim=10, lambda=0.5, mu=0.6, complete=FALSE),
# ape::mltt.plot(my.trees2, log="y", legend=FALSE),
  
#   depth.range3 = range(unlist(lapply(my.trees2,ape::branching.times)), unlist(lapply(bd.trees,ape::branching.times))),
#   max.depth3 = sum(abs(depth.range2)), #ape rescales depths
#   plot(x=c(0, -1*max.depth), y=c(1, ape::Ntip(bd.trees5[[1]])), log="y", type="n", bty="n", xlab="Time", ylab="N"),
#   colors=c(rgb(1,0,0,0.5), rgb(0, 0, 0, 0.5)),
#   list.of.both3 = list(bd.trees, bd.trees5),
#   for (i in sequence(2)) {
#     tree.list <- list.of.both[[i]]
#     for (j in sequence(length(tree.list))) {
#       ape::ltt.lines(tree.list[[j]], col=colors[[i]])
#     }
#   },
#   legend("topleft", legend=c("Birth Death", "Birth Death variable parameters"), fill=colors),

#   ##What happens if speciation rate is much higher than extinction rate?
#   my.trees3 = TreeSim::sim.bd.taxa(n=300, numbsim=10, lambda=0.9, mu=0.1, complete=FALSE),
#   
#   ##How does the simulation change with different values, but keeping their difference constant?
#   my.trees4 = TreeSim::sim.bd.taxa(n=300, numbsim=10, lambda=1.2, mu=1.3, complete=FALSE),
#   
#   ##if their sum is constant? [remember to change to eval=TRUE to run]
#   my.trees2 = TreeSim::sim.bd.taxa(n=300, numbsim=10, lambda=0.5, mu=0.6, complete=FALSE),
#   
#   
#   #ape::mltt.plot(my.trees2, log="y", legend=FALSE), ## potentially don't need
#   
#   ## Tree plus trait model
#   
#   speciation.rates = c(0.1, 0.1, 0.1, 0.2), #0A, 1A, 0B, 1B
#   extinction.rates = rep(0.03, 4),
#   transition.rates = c(0.01,0.01,0, 0.01, 0, 0.01, 0.01,0,0.01, 0,0.01,0.01),
#   pars = c(speciation.rates, extinction.rates, transition.rates),
#   phy = tree.musse(pars, max.taxa=50, x0=1, include.extinct=FALSE),
#   sim.dat.true = data.frame(names(phy$tip.state), phy$tip.state),
#   sim.dat = sim.dat.true,
#   # Now to hide the "hidden" state
#   hidden1 = (sim.dat[sim.dat[,2]==3,2] = 1),
#   hidden2 = (sim.dat[sim.dat[,2]==4,2] = 2),
#   # and convert states 1,2 to 0,1
#   covertstates = (sim.dat[,2] = sim.dat[,2] - 1),
#   
#   #visualize data
#   plot(phy),
#   knitr::kable(cbind(sim.dat, true.char=sim.dat.true$phy.tip.state)),
#   
#   turnover.anc = c(1,1,0,0),
#   eps.anc = c(1,1,0,0),
#   turnover.anc2 = c(1,2,0,0),
#   turnover.anc3 = c(1,2,3,4),
#   eps.anc2 = c(0,0,0,0),
#   
#   ## Setting up the transition rate matrix
#   
#   trans.rates = TransMatMaker.old(hidden.states=TRUE),
#   trans.rates.nodual = ParDrop(trans.rates, c(3,5,8,10)),
#   trans.rates.nodual.equal16 = ParEqual(trans.rates.nodual, c(1,6)),
#   trans.rates.nodual.allequal = ParEqual(trans.rates.nodual, c(1,2,1,3,1,4,1,5,1,6,1,7,1,8)),
#   trans.rates.nodual.allequal1 = trans.rates.nodual,
#   transrateNAs = (trans.rates.nodual.allequal1[!is.na(trans.rates.nodual.allequal1) & !trans.rates.nodual.allequal1 == 0] = 1),
#   trans.rates.bisse = TransMatMaker.old(hidden.states=FALSE),
#   
#   pp = hisse.old(phy, sim.dat, f=c(1,1), hidden.states=TRUE, turnover.anc=turnover.anc3,
#                  eps.anc=eps.anc3, trans.rate=transrateNAs),
#   
#  ## A common mistake
#  turnover.anc4 = c(1,2,0,3),
#  eps.anc3 = c(1,2,0,3),
#  
#   ##Changing the output
#  pp = hisse.old(phy, sim.dat, f=c(1,1), hidden.states=TRUE, turnover.anc=turnover.anc3,
#                 eps.anc=eps.anc3, trans.rate=transrateNAs, output.type="net.div")
#  
# #Setting up the 2-state character-independent (CID-2) model

# turnover.anc = c(1,1,2,2),
# eps.anc = c(1,1,2,2),


#   
 )