FROM ://microsoft.com AS build
WORKDIR /src

# 1. Copy the project file from the subfolder and restore dependencies
COPY ["CampusEats.Api/CampusEats.Api.csproj", "CampusEats.Api/"]
RUN dotnet restore "CampusEats.Api/CampusEats.Api.csproj"

# 2. Copy the rest of the application files and build them
COPY . .
WORKDIR "/src/CampusEats.Api"
RUN dotnet publish -c Release -o /app

# 3. Final runtime image setup
FROM ://microsoft.com
WORKDIR /app
COPY --from=build /app .
ENV ASPNETCORE_URLS=http://0.0.0
EXPOSE 8080
ENTRYPOINT ["dotnet", "CampusEats.Api.dll"]
