FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source

COPY *.sln .
COPY App/*.csproj ./App/
RUN dotnet restore

COPY App/. ./App/
WORKDIR /source/App
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/runtime:5.0
WORKDIR /app
COPY --from=build /app ./
RUN echo Done!
ENTRYPOINT ["dotnet", "NetCore.Docker.dll"]
