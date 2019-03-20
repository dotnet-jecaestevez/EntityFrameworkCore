dotnet new sln -n EFCodeFirst.JecaestevezApp
dotnet new console -n ConsoleApp.Jecaestevez -o ConsoleApp
dotnet new classlib -n DAL.JecaestevezApp -o DAL
dotnet sln EFCodeFirst.JecaestevezApp.sln add ConsoleApp/ConsoleApp.Jecaestevez.csproj
dotnet sln EFCodeFirst.JecaestevezApp.sln add DAL/DAL.JecaestevezApp.csproj
dotnet add ConsoleApp/ConsoleApp.Jecaestevez.csproj reference DAL/DAL.JecaestevezApp.csproj
dotnet build