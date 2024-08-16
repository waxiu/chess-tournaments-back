# Etap 1: Budowa aplikacji
FROM maven:3.8.3-openjdk-17 AS build

WORKDIR /app

# Kopiowanie pliku pom.xml i instalacja zależności
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Kopiowanie całego projektu i budowa aplikacji
COPY src ./src
RUN mvn package -DskipTests

# Etap 2: Uruchomienie aplikacji
FROM openjdk:17-jdk

WORKDIR /app

# Kopiowanie zbudowanego pliku JAR z etapu budowy
COPY --from=build /app/target/*.jar ./app.jar

# Uruchomienie aplikacji
CMD ["java", "-jar", "app.jar"]

EXPOSE 8080
