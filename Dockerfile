FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR "/jenkins"
RUN dotnet build "jenkins.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "jenkins.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "jenkins.dll"]