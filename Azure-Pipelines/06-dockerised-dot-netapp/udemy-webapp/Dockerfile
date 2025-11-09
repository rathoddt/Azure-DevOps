# Instruction Arguments

# dotnet framwork 6.0 and above
# cd /app
# dotnet restore --> dependecies gets downloaded
# dotnet publish --> azdevsecops-webapp.dll
# dotnet azdevsecops-webapp.dll --> App runs locally 

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release 
RUN dotnet publish -c Release -o out

# Build runtime image
# FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /App
COPY --from=build-env /App/out .
ENV ASPNETCORE_URLS http://*:5000
EXPOSE 5000
ENTRYPOINT ["dotnet", "azdevsecops-webapp.dll"]