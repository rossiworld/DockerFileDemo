
FROM microsoft/dotnet:sdk as publish
WORKDIR /publish
COPY AspNetCoreDemos.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish --output ./out

FROM microsoft/dotnet:aspnetcore-runtime
LABEL author="Roshan Shah"
WORKDIR /app
COPY --from=publish /publish/out .
ENV ASPNETCORE_URLS=http://*:5000
EXPOSE 5000
ENTRYPOINT ["dotnet","AspNetCoreDemos.dll"]
