using System;
using System.Collections.Generic;
using System.Linq;

class Program
{
    static void Main()
    {
        while (true)
        {
            Console.WriteLine("\nВыберите задание:");
            Console.WriteLine("1 - Проверка движения по доске");
            Console.WriteLine("2 - Подсчёт уникальных email (фиксированный список)");
            Console.WriteLine("3 - Подсчёт серий чисел");
            Console.WriteLine("0 - Выход");
            Console.Write("Ваш выбор: ");
            string choice = Console.ReadLine();

            switch (choice)
            {
                case "1":
                    Task1();
                    break;
                case "2":
                    Task2();
                    break;
                case "3":
                    Task3();
                    break;
                case "0":
                    Console.WriteLine("Выход...");
                    return;
                default:
                    Console.WriteLine("Неверный выбор!");
                    break;
            }
        }
    }

    // Задание 1: Проверка движения по доске
    static void Task1()
    {
        Console.Write("Введите размеры доски и строку команд (пример: 3 3 RRD): ");
        string[] parts = Console.ReadLine().Split(' ', StringSplitOptions.RemoveEmptyEntries);

        if (parts.Length != 3 ||
            !int.TryParse(parts[0], out int N) ||
            !int.TryParse(parts[1], out int M))
        {
            Console.WriteLine("No");
            return;
        }

        string S = parts[2];

        if (N <= 0 || M <= 0 || S.Any(c => !"LRUD".Contains(c)))
        {
            Console.WriteLine("No");
            return;
        }

        int x = 0, y = 0, minX = 0, maxX = 0, minY = 0, maxY = 0;

        foreach (char move in S)
        {
            if (move == 'L') x--;
            if (move == 'R') x++;
            if (move == 'U') y--;
            if (move == 'D') y++;

            minX = Math.Min(minX, x);
            maxX = Math.Max(maxX, x);
            minY = Math.Min(minY, y);
            maxY = Math.Max(maxY, y);
        }

        if (maxX - minX < M && maxY - minY < N)
        {
            Console.WriteLine($"Yes: ({1 - minY}, {1 - minX})");
        }
        else
        {
            Console.WriteLine("No");
        }
    }

    // Задание 2: Подсчёт уникальных email из фиксированного списка
    static void Task2()
    {
        List<string> emails = new List<string>
        {
            "mar.pha+science@corp.nstu.ru",
            "marpha+scie.nce@corp.nstu.ru",
            "marph.a+s.c.i.e.n.c.e+@corp.nstu.ru",
            "mar.pha+science@co.rp.nstu.ru"
        };

        HashSet<string> unique = new HashSet<string>();

        foreach (var email in emails)
        {
            int atIndex = email.IndexOf('@');
            string local = email.Substring(0, atIndex);
            string domain = email.Substring(atIndex);

            string normalizedLocal = "";
            foreach (char c in local)
            {
                if (c == '+') break;
                if (c != '.') normalizedLocal += c;
            }

            unique.Add(normalizedLocal + domain);
        }

        Console.WriteLine("Уникальных адресов: " + unique.Count);
    }

    // Задание 3: Подсчёт серий чисел
    static void Task3()
    {
        Console.Write("Введите числа через пробел: ");
        string[] parts = Console.ReadLine().Split(' ', StringSplitOptions.RemoveEmptyEntries);
        List<int> numbers = new List<int>();

        foreach (var part in parts)
        {
            if (int.TryParse(part, out int n))
                numbers.Add(n);
            else
            {
                Console.WriteLine("Некорректный ввод!");
                return;
            }
        }

        if (numbers.Count == 0)
        {
            Console.WriteLine("Серий: 0");
            return;
        }

        int count = 1;
        for (int i = 1; i < numbers.Count; i++)
        {
            if (numbers[i] < numbers[i - 1])
                count++;
        }

        Console.WriteLine("Серий: " + count);
    }
}

