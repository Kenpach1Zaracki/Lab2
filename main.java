import java.util.*;

public class Main {

    // Задание 1: Проверка на движение по доске
    public static void task1() {
        Scanner sc = new Scanner(System.in);
        System.out.println("Задание 1: Проверка движения по доске");
        
        // Ввод данных
        int N = sc.nextInt();
        int M = sc.nextInt();
        String S = sc.next();

        // Проверка на отрицательные размеры доски
        if (N <= 0 || M <= 0) {
            System.out.println("No");
            return;
        }

        // Проверка на недопустимые символы в строке команд
        if (!S.matches("[LRUD]*")) {
            System.out.println("No");
            return;
        }

        int minX = 0, maxX = 0, minY = 0, maxY = 0;
        int x = 0, y = 0;

        for (char move : S.toCharArray()) {
            switch (move) {
                case 'L': x--; break;
                case 'R': x++; break;
                case 'D': y++; break;
                case 'U': y--; break;
            }
            minX = Math.min(minX, x);
            maxX = Math.max(maxX, x);
            minY = Math.min(minY, y);
            maxY = Math.max(maxY, y);
        }

        if (maxX - minX < M && maxY - minY < N) {
            System.out.println("(" + (1 - minY) + "," + (1 - minX) + ")");
        } else {
            System.out.println("No");
        }
    }

    // Задание 2: Подсчёт уникальных email
    public static void task2() {
        Scanner sc = new Scanner(System.in);
        System.out.println("\nЗадание 2: Подсчёт уникальных email");

        // Массив email адресов
        String[] emails = {
            "mar.pha+science@corp.nstu.ru",
            "marpha+scie.nce@corp.nstu.ru",
            "marph.a+s.c.i.e.n.c.e+@corp.nstu.ru",
            "mar.pha+science@co.rp.nstu.ru"
        };

        Set<String> unique = new HashSet<>();
        for (String email : emails) {
            unique.add(normalizeEmail(email));
        }

        System.out.println("Уникальных адресов: " + unique.size());
    }

    // Функция нормализации email
    public static String normalizeEmail(String email) {
        String[] parts = email.split("@");
        String local = parts[0].split("\\+")[0].replace(".", "");
        return local + "@" + parts[1];
    }

    // Задание 3: Подсчёт серий чисел
    public static void task3() {
        Scanner sc = new Scanner(System.in);
        System.out.println("\nЗадание 3: Подсчёт серий чисел");

        // Ввод чисел
        String line = sc.nextLine(); 

        if (line.trim().isEmpty()) {
            System.out.println("Серий: 0");
            return;
        }

        String[] numbers = line.trim().split("\\s+"); 
        int count = 0;

        if (numbers.length > 0) {
            count = 1;
            int prev = Integer.parseInt(numbers[0]);

            for (int i = 1; i < numbers.length; i++) {
                int curr = Integer.parseInt(numbers[i]);
                if (curr < prev) {
                    count++;
                }
                prev = curr;
            }
        }

        System.out.println("Серий: " + count);
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        while (true) {
            // Меню выбора задания
            System.out.println("\nВыберите задание:");
            System.out.println("1 - Проверка движения по доске");
            System.out.println("2 - Подсчёт уникальных email");
            System.out.println("3 - Подсчёт серий чисел");
            System.out.println("0 - Выход");
            System.out.print("Ваш выбор: ");
            
            int choice = sc.nextInt();
            sc.nextLine(); // очистка буфера после ввода числа

            switch (choice) {
                case 1: task1(); break;
                case 2: task2(); break;
                case 3: task3(); break;
                case 0: 
                    System.out.println("Выход...");
                    return;
                default: 
                    System.out.println("Неверный выбор!");
                    break;
            }
        }
    }
}
