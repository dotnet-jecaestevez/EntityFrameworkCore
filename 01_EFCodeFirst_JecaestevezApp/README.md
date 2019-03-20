# Code first Entity Framework Dotnet Core 2x simple guide

## 1. Creating the solution projects for this guide
 Open a new Terminal window and then type the bellow commands or run the powershell script "1.SetupGuide.ps1" 

Create new empty solution "EFCodeFirst.JecaestevezApp"
 > dotnet new sln -n EFCodeFirst.JecaestevezApp

Create empty console application "ConsoleApp.Jecaestevez"
 > dotnet new console -n ConsoleApp.Jecaestevez -o ConsoleApp

Create empty library application "DAL.JecaestevezApp"
 > dotnet new classlib -n DAL.JecaestevezApp -o DAL

 Add the created console application to the solution
  > dotnet sln EFCodeFirst.JecaestevezApp.sln add ConsoleApp/ConsoleApp.Jecaestevez.csproj  

Add the console application to the solution
  > dotnet sln EFCodeFirst.JecaestevezApp.sln add DAL/DAL.JecaestevezApp.csproj  

Add a refrence from ConsoleApp to DAL.JecaestevezApp
  >dotnet add ConsoleApp/ConsoleApp.Jecaestevez.csproj reference DAL/DAL.JecaestevezApp.csproj

Build the solution
 > dotnet build

# 2 Add Entity Framework Core packages to 
Open terminal and navigate to 01_EFCodeFirst_JecaestevezApp\DAL

Add to "DAL.JecaestevezApp.csproj"  EntityFrameworkCore.SqlServer and EntityFrameworkCore.Tools

> dotnet add package Microsoft.EntityFrameworkCore.SqlServer

> dotnet add package Microsoft.EntityFrameworkCore.Tools 

> dotnet add package Microsoft.EntityFrameworkCore.Design 

# 3 Add a simple class to be used in a new  DBContext
Simple class "ItemType"
```
    public class ItemType
    {
        public int id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
    }
```
Add DBContext
```
    public class EfDbContext : DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            //TODO Extract connection string to a secret
            optionsBuilder.UseSqlServer(@"Server=.\;Database=EFCodeFirstDB;Trusted_Connection=True;MultipleActiveResultSets=true");
        }
        public DbSet<ItemType> ItemsTypes { get; set; }
    }
```
# 4 Create the first migration
Open terminal and navigate to 01_EFCodeFirst_JecaestevezApp\DAL

Using the terminal:
> dotnet ef  migrations add CreateDatabase --startup-project ../ConsoleApp

Using Package Manager Console:
Select the DAL.JecaestevezApp.csproj and execute 
> PM > add-migration CreateDatabase

It will be create a folder "Migrations" and the following files:
* CreateDatabase.cs
* CreateDatabase.Designer.cs
* EfDbContextModelSnapshot.cs

# 5 Update Database
Open terminal and navigate to 01_EFCodeFirst_JecaestevezApp\DAL
Using the terminal:
> dotnet ef database update --startup-project ../ConsoleApp

Using Package Manager Console:
Select the DAL.JecaestevezApp.csproj and execute 
> PM> update-database –verbose

# 6 Use DBContext in the console App
```
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            using (var context = new EfDbContext())
            {
                var itemType = new ItemType()
                {
                    Name = "Product"
                };

                context.Add(itemType);
                context.SaveChanges();
            }
        }
    }
```
