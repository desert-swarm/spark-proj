# Running Apache Spark Locally with Iceberg

## Background
creating a local instance using `devenv`. 

Google Chat instructions:

```text
{ pkgs, ... }:

{
  packages = [
    pkgs.openjdk11
    pkgs.apache-spark
  ];

  enterShell = ''
    export JAVA_HOME=${pkgs.openjdk11}
    export SPARK_HOME=${pkgs.apache-spark}
    export PATH=$SPARK_HOME/bin:$PATH

    # Define the Spark package version for Iceberg (match your Spark version)
    # This example uses Iceberg 1.5.0 for Spark 3.5 on Scala 2.12
    ICEBERG_PKG="org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.5.0"

    # Configure a local "hadoop" style catalog that writes right into your project folder
    ICEBERG_CONFS="--packages $ICEBERG_PKG \
      --conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions \
      --conf spark.sql.catalog.local=org.apache.iceberg.spark.SparkCatalog \
      --conf spark.sql.catalog.local.type=hadoop \
      --conf spark.sql.catalog.local.warehouse=$(pwd)/warehouse \
      --conf spark.sql.defaultCatalog=local"

    # Create aliases so typing 'pyspark' or 'spark-sql' automatically includes Iceberg
    alias pyspark="pyspark $ICEBERG_CONFS"
    alias spark-sql="spark-sql $ICEBERG_CONFS"
    alias spark-shell="spark-shell $ICEBERG_CONFS"

    echo "⚡ Isolated Spark + Iceberg Local Environment Loaded!"
    echo "   Your local data warehouse will be saved in: $(pwd)/warehouse"
  '';
}

```
