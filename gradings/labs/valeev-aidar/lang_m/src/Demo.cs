using System;
using System.Collections.Generic;
using System.IO;

namespace src
{
    class Demo
    {
        private const string InputFilePath = @"../../../in.txt";
        private const string OutputFilePath = @"../../../out.txt";

        private static void Main(string[] args)
        {
            try
            {
                var input = Read();

                var parcer = new Parcer(input);
                parcer.Statements();

                Write(parcer.ParcerResult);
            }
            catch (FileNotFoundException)
            {
                Write("File in.txt was not found.");
            }
        }

        private static string Read()
        {
            return File.ReadAllText(InputFilePath).Replace("\\n","\n");
        }

        private static void Write(string text)
        {
            File.WriteAllText(OutputFilePath, text);
        }
    }

}
