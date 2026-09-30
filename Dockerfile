FROM ://microsoft.com AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /app

FROM ://microsoft.com
WORKDIR /app
COPY --from-build /app .
ENV ASPNETCORE_URLS=http://0.0.0
EXPOSE 8080
ENTRYPOINT ["dotnet", "CampusEats.Api.dll"]
