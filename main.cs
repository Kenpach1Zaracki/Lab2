static void Task1()
{
    Console.Write("Введите размеры доски и строку команд (пример: 3 3 RRD): ");
    string input = Console.ReadLine();
    var inputs = input.Split(' ', StringSplitOptions.RemoveEmptyEntries);

    if (inputs.Length != 3 || 
        !int.TryParse(inputs[0], out int N) || 
        !int.TryParse(inputs[1], out int M))
    {
        Console.WriteLine("Неверный формат ввода.");
        return;
    }

    string S = inputs[2];

    if (N <= 0 || M <= 0)
    {
        Console.WriteLine("No");
        return;
    }

    if (S.Any(c => !"LRUD".Contains(c)))
    {
        Console.WriteLine("No");
        return;
    }

    int minX = 0, maxX = 0, minY = 0, maxY = 0;
    int x = 0, y = 0;

    foreach (char move in S)
    {
        if (move == 'L') x--;
        if (move == 'R') x++;
        if (move == 'D') y++;
        if (move == 'U') y--;
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
