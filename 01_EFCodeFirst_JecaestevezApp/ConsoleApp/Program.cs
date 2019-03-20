using DAL.JecaestevezApp;
using DAL.JecaestevezApp.Model;
using System;

namespace ConsoleApp.Jecaestevez
{
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
}
