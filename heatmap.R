count_data <- read.delim("normalised_counts.txt", row.names = 1)
metadata <- read.csv("metadata.csv", header = TRUE, sep = ";")
rownames(metadata) <- metadata$SampleID
colnames(count_data)
colnames(count_data) <- gsub("^X", "", colnames(count_data))
rownames(metadata)
library(pheatmap)
genes_of_interest <- c("list_of_genes") 
subset_data <- count_data[rownames(count_data) %in% genes_of_interest, ]
pheatmap(count_data, 
         
         scale = "row",
         cluster_cols = FALSE,
         cluster_rows = FALSE,
         clustering_distance_rows = "correlation", 
         clustering_distance_cols = "euclidean",
         show_rownames = TRUE, 
         show_colnames = TRUE,
         fontsize_row = 8
)
colnames(subset_data) <- rownames(metadata)
metadata <- metadata[match(colnames(subset_data), metadata$SampleID), ]
all(colnames(subset_data) == metadata$SampleID)
table(metadata$LifeStage)
head(annotation_row)
metadata$LifeStage <- factor(metadata$LifeStage, levels = c(
  "eggs", "pupae","1st_instar_larvae", "2nd_instar_larvae", 
  "3rd_instar_larvae",  "adult_female", "adult_male"
))
logcountdata <- log2(subset_data + 1)
write.csv(logcountdata, "subset_data.csv", sep = "\t", row.names = TRUE, quote = FALSE)
subsetdata <- read.delim("subset_data.csv", header = TRUE, sep = ";")
colnames(count_data) <- gsub("^X", "", colnames(count_data))
logsubsetdata <- log2(subsetdata + 1)
count_data <- read.delim("subsetdata.txt", row.names = 1)
