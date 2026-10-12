{ pkgs, ... }:

{
    # 1. automatically install the correct Java and Spark versions locally
    packages = [
    pkgs.openjdk11
    pkgs.apache-Spark
    ];

    # 2. scope the required environment variables strictly to this project
    enterShell = ''
        export JAVA_HOME=${pkgs.openjdk11}
        export SPARK_HOME=${pkgs.apache-spark}
        export PATH=$SPARK_HOME/bin:$PATH
        echo "⚡ isolated Spark development environment loaded!"
    '';
}
