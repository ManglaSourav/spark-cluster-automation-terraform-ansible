from pyspark.sql import SparkSession

# Initialize the SparkSession
spark = SparkSession.builder.appName("test").getOrCreate()

# Create an RDD with numbers from 1 to 10
rdd = spark.sparkContext.parallelize(range(1, 11))

# Perform a simple transformation: multiply each number by 2
transformed_rdd = rdd.map(lambda x: x * 2)

# Perform an action: collect and print the results
result = transformed_rdd.collect()
print("Transformed RDD:", result)

# Stop the SparkSession
spark.stop()
