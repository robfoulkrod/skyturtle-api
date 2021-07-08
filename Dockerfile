FROM mcr.microsoft.com/dotnet/sdk:5.0 as build
WORKDIR /app

COPY turtle-api.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c release -o out

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app

COPY --from=build /app/out ./

EXPOSE 80

ENTRYPOINT [ "dotnet", "turtle-api.dll" ]