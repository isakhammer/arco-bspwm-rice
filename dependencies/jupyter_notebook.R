#!/usr/bin/env Rscript

install.packages('IRkernel')
IRkernel::installspec()  # to register the kernel in the current R installation
jupyter labextension install @techrah/text-shortcuts  # for RStudio’s shortcuts
