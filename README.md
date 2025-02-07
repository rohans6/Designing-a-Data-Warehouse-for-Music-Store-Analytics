# Designing a Data Warehouse for Music Store Analytics

The Chinook Music Store is a digital platform that sells tracks, albums, and other media globally. Currently, its operational data is fragmented, making it challenging to derive insights into sales trends, customer behavior, product popularity, and employee performance. To address this, a centralized data warehouse will be designed and implemented, enabling advanced analytics and reporting.


## **Step 1: Define Business and Data Requirements**
### **Business Goals**
The data warehouse is being developed to address the following business needs:

1. **Sales Analytics**:  
   - Analyze daily, monthly, and yearly sales trends.  
   - Identify top-selling tracks, albums, and genres.  

2. **Customer Insights**:  
   - Segment customers based on purchase patterns, geography, and lifetime value.  
   - Analyze customer retention and identify engagement opportunities.  

3. **Employee Performance**:  
   - Evaluate employee contributions to sales.  
   - Identify top-performing employees and areas for improvement.  

### **Data Characteristics**
- The **data is already scraped and stored in an S3 bucket**.
- The primary data sources include:  
  - **Transactions Data**: Sales transactions with timestamps, product IDs, customer IDs, and employee IDs.  
  - **Customer Data**: Includes customer demographics, purchase history, and location.  
  - **Employee Data**: Employee roles, performance metrics, and contributions to sales.  
  - **Product and Genre Data**: Track, album, and genre information.  
- **Granularity**: Sales transactions recorded **daily**.  
- **Performance Requirements**: Queries must be **fast** for analytics.  
- **Storage Constraints**: The solution should be **optimized** for efficient storage while handling large-scale data.  

---

## **Step 2: Design the Data Warehouse Architecture**
### **Selecting AWS Redshift**
Given the performance and storage constraints, AWS Redshift is the preferred data warehouse solution due to:

- **Columnar Storage**: Optimized for analytical workloads, reducing disk I/O and improving query speed.  
- **Massively Parallel Processing (MPP)**: Enables fast query execution by distributing workloads across multiple nodes.  
- **Compression Techniques**: Helps reduce storage footprint and speeds up data retrieval.  
- **Seamless Integration with S3**: Facilitates fast data ingestion using `COPY` commands from Amazon S3.  
- **Scalability**: Can easily scale storage and compute capacity as data grows


