package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func task1() {
	var N, M int
	var S string

	fmt.Print("Введите размеры доски и строку команд (пример: 3 3 RRD): ")
	fmt.Scan(&N, &M, &S)

	if N <= 0 || M <= 0 {
		fmt.Println("No")
		return
	}

	for _, c := range S {
		if !strings.ContainsRune("LRUD", c) {
			fmt.Println("No")
			return
		}
	}

	minX, maxX, minY, maxY := 0, 0, 0, 0
	x, y := 0, 0

	for _, move := range S {
		switch move {
		case 'L':
			x--
		case 'R':
			x++
		case 'D':
			y++
		case 'U':
			y--
		}
		if x < minX {
			minX = x
		}
		if x > maxX {
			maxX = x
		}
		if y < minY {
			minY = y
		}
		if y > maxY {
			maxY = y
		}
	}

	if maxX-minX < M && maxY-minY < N {
		fmt.Printf("Yes: (%d, %d)\n", 1-minY, 1-minX)
	} else {
		fmt.Println("No")
	}
}

func normalizeEmail(email string) string {
	parts := strings.Split(email, "@")
	local := strings.Split(parts[0], "+")[0]
	local = strings.ReplaceAll(local, ".", "")
	return local + "@" + parts[1]
}

func task2() {
	emails := []string{
		"mar.pha+science@corp.nstu.ru",
		"marpha+scie.nce@corp.nstu.ru",
		"marph.a+s.c.i.e.n.c.e+@corp.nstu.ru",
		"mar.pha+science@co.rp.nstu.ru",
	}

	unique := make(map[string]bool)
	for _, email := range emails {
		unique[normalizeEmail(email)] = true
	}

	fmt.Printf("Уникальных адресов: %d\n", len(unique))
}

func task3() {
	fmt.Print("Введите числа через пробел: ")
	reader := bufio.NewReader(os.Stdin)
	line, _ := reader.ReadString('\n')
	line = strings.TrimSpace(line)

	if line == "" {
		fmt.Println("Серий: 0")
		return
	}

	numbers := strings.Fields(line)
	count := 0

	if len(numbers) > 0 {
		count = 1
		prev, _ := strconv.Atoi(numbers[0])

		for i := 1; i < len(numbers); i++ {
			curr, _ := strconv.Atoi(numbers[i])
			if curr < prev {
				count++
			}
			prev = curr
		}
	}

	fmt.Printf("Серий: %d\n", count)
}

func main() {
	for {
		fmt.Println("\nВыберите задание:")
		fmt.Println("1 - Проверка движения по доске")
		fmt.Println("2 - Подсчёт уникальных email")
		fmt.Println("3 - Подсчёт серий чисел")
		fmt.Println("0 - Выход")
		fmt.Print("Ваш выбор: ")

		var choice int
		fmt.Scan(&choice)

		switch choice {
		case 1:
			task1()
		case 2:
			task2()
		case 3:
			task3()
		case 0:
			fmt.Println("Выход...")
			return
		default:
			fmt.Println("Неверный выбор!")
		}
	}
}

