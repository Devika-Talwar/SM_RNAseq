library(DESeq2)
featurecounts_data <- read.table("/groups/ma/sradata/featurecounts_output/gene_counts.txt", header = TRUE, row.names = 1, sep = "\t")
head(featurecounts_data)
count_data <- featurecounts_data[, 7:ncol(featurecounts_data)]
head(count_data)
count_data <- featurecounts_data[, 6:ncol(featurecounts_data)]
head(count_data)
count_threshold <- 10
min_samples <- 2
filtered_data <- count_data[rowSums(count_data >= count_threshold) >= min_samples, ]
cat("Number of genes before filtering: ", nrow(count_data), "\n")
cat("Number of genes after filtering: ", nrow(filtered_data), "\n")
boxplot(log(filtered_data + 1), main="Boxplot of filtered count data (log-transformed)")
write.table(filtered_data, "filtered_featurecounts_output.txt", sep = "\t", quote = FALSE)
getwd()
write.table(filtered_data, "/groups/ma/sradata/featurecounts_output/filtered_featurecounts_output.txt", sep = "\t", quote = FALSE)
samples <- c("Sample1_Replicate1", "Sample1_Replicate2", 
             "Sample2_Replicate1", "Sample2_Replicate2", 
             "Sample3_Replicate1", "Sample3_Replicate2", 
             "Sample4_Replicate1", "Sample4_Replicate2", 
             "Sample5_Replicate1", "Sample5_Replicate2", 
             "Sample6_Replicate1", "Sample6_Replicate2", 
             "Sample7_Replicate1", "Sample7_Replicate2")
conditions <- c("1st_instar", "1st_instar", 
                "2nd_instar", "2nd_instar", 
                "3rd_instar", "3rd_instar", 
                "female_adult", "female_adult",
                "male_adult", "male_adult",
                "egg", "egg", 
                "pupae", "pupae")
replicates <- c(1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2)
colData <- data.frame(row.names = samples, condition = conditions, replicate = replicates  )
print(colData)
dds <- DESeqDataSetFromMatrix(countData = countData, colData = coldata, design = ~ condition)
count_data <- read.table("/groups/ma/sradata/featurecounts_output/filtered_featurecounts_output.txt", header = TRUE, row.names = 1, sep = "\t")
dds <- DESeqDataSetFromMatrix(countData = count_data, colData = colData, design = ~ condition)
colnames(count_data)
rownames(colData)

colnames(count_data)
rownames(colData)

colData$condition <- as.factor(colData$condition)
str(colData$condition)
dds <- DESeqDataSetFromMatrix(countData = count_data, 
                              colData = colData, 
                              design = ~ condition)
levels(colData$condition)
dds <- DESeq(dds)
normalized_counts <- counts(dds, normalized = TRUE)
write.table(normalized_counts, file = "/groups/ma/sradata/featurecounts_output/normalized_counts.txt", sep = "\t", quote = FALSE)
rlog_counts <- rlog(dds)
plotPCA(rlog_counts, intgroup = "condition")
boxplot(assay(rlog_counts), las = 2, main = "Boxplot of Normalized Counts")
res <- results(dds)
summary(res)