## Java Application
Setiing up sample application
```
sudo apt install default-jk
sudo apt install default-jdk
java version
sudo apt install maven
sudo apt install tree
mvn --version
java version
java --version
mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
```

### MVN commands

```
cd my-app/
tree
cat src/main/java/com/mycompany/app/App.java 
mvn compile
tree
mvn test
tree
ls
mvn packagde
mvn package
ls
tree
java -cp target/my-app-1.0-SNAPSHOT.jar com.mycompany.app.App 
mvn clean
tree
mvn package
tree
mvn site
tree
```
