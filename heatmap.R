count_data <- read.delim("/groups/ma/sradata/featurecounts_output/13.12.24/normalised_counts.txt", row.names = 1)
metadata <- read.csv("/groups/ma/sradata/featurecounts_output/13.12.24/metadata.csv", header = TRUE, sep = ";")
rownames(metadata) <- metadata$SampleID
colnames(count_data)
colnames(count_data) <- gsub("^X", "", colnames(count_data))
rownames(metadata)
library(pheatmap)
genes_of_interest <- c("LOC116340197", "LOC116340110", "LOC116340305", "LOC116345993", "LOC116347824", "LOC116340233", "LOC116345342", "LOC116352487", "LOC116351608", "LOC116340111", "LOC116349363", "LOC116342930", "LOC116341699", "LOC116350332", "LOC116350370") 
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
write.csv(logcountdata, "/groups/ma/sradata/featurecounts_output/13.12.24/subset_data.csv", sep = "\t", row.names = TRUE, quote = FALSE)
subsetdata <- read.delim("/groups/ma/sradata/featurecounts_output/13.12.24/subset_data.csv", header = TRUE, sep = ";")
colnames(count_data) <- gsub("^X", "", colnames(count_data))
logsubsetdata <- log2(subsetdata + 1)
count_data <- read.delim("/groups/ma/sradata/featurecounts_output/13.12.24/subsetdata.txt", row.names = 1)
