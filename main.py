def task1():
    try:
        data = input().strip().split()
        N, M = map(int, data[:2])
        S = data[2]

        if N <= 0 or M <= 0:
            print("No")
            return

        if any(c not in 'LRUD' for c in S):
            print("No")
            return

        minX = minY = 0
        maxX = maxY = 0
        x = y = 0

        for move in S:
            if move == 'L': x -= 1
            if move == 'R': x += 1
            if move == 'D': y += 1
            if move == 'U': y -= 1

            minX = min(minX, x)
            maxX = max(maxX, x)
            minY = min(minY, y)
            maxY = max(maxY, y)

        if maxX - minX < M and maxY - minY < N:
            print(f"({1 - minY},{1 - minX})")
        else:
            print("No")
    except Exception as e:
        print("Ошибка:", e)

def normalize_email(email):
    local, domain = email.split('@')
    local = local.split('+')[0].replace('.', '')
    return f"{local}@{domain}"

def task2():
    try:
        emails = input().strip().split()
        unique_emails = {normalize_email(email) for email in emails}
        print("Уникальных адресов:", len(unique_emails))
    except Exception as e:
        print("Ошибка:", e)

def task3():
    try:
        line = input().strip()

        if not line:
            print("Серий: 0")
            return

        numbers = list(map(int, line.split()))
        count = 0

        if len(numbers) > 0:
            count = 1
            prev = numbers[0]

            for curr in numbers[1:]:
                if curr < prev:
                    count += 1
                prev = curr

        print(f"Серий: {count}")
    except Exception as e:
        print("Ошибка:", e)

def main():
    while True:
        print("Выберите задание:")
        print("1 - Проверка движения по доске")
        print("2 - Подсчёт уникальных email")
        print("3 - Подсчёт серий чисел")
        print("0 - Выход")

        choice = input()

        if choice == '1':
            print("Вы выбрали задание 1: Проверка движения по доске")
            task1()
        elif choice == '2':
            print("Вы выбрали задание 2: Подсчёт уникальных email")
            task2()
        elif choice == '3':
            print("Вы выбрали задание 3: Подсчёт серий чисел")
            task3()
        elif choice == '0':
            print("Выход...")
            break
        else:
            print("Неверный выбор!")

if __name__ == "__main__":
    main()

