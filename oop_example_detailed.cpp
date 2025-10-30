#include <iostream>
#include <string>

using namespace std;

// ============================================================================
// ПРИМЕР 1: Базовая структура Food и ее наследники
// ============================================================================

struct Food
{
    int satisfaction = 0;
    string type = "eda";
};

// Варенье - наследуется от Food
struct Jam : public Food{
    Jam(){
        satisfaction  = 10;
        type = "Jam";
    }
};

// Кабачок - наследуется от Food
struct Kabachok : public Food{
    Kabachok(){
        satisfaction  = 150;
        type = "Kabachok";
    }
};

// Улыбка - ПЛОХОЙ пример (переопределяет поле)
struct Smile : public Food{
    int satisfaction = 50;  // Создает новое поле вместо изменения базового
};

// Киви
struct Kiwi : public Food
{
    int satisfaction = 60;
};

// Мозги
struct Brains : public Food{
    int satisfaction = 100;
};

// Птицы - наследуется от Food
struct Birds : public Food{
    Birds(){
        satisfaction = 200;
        type = "Birds";
    }
};

// Зомби
struct Zombie : public Food
{
    int satisfaction = 10000;
};

// ============================================================================
// ПРИМЕР 2: Базовый класс Characters и его наследники
// ============================================================================

class Characters{
public:
    // Конструктор с параметром и списком инициализации
    Characters(const string& key) : type(key) {}
    
    // Метод для еды
    void Eat(Food food){
        cout << type << " ate a tasty "<< food.type<< " in " << food.satisfaction << endl;
    }
    
    // Метод для сна
    void Sleep (){
        if (type == "Mabel"){
            cout << "dsfsdfsdfsdfsdfsdf" << endl;
        }
        if (type == "Dipper"){
            cout << "AAAAAAAAAAAAAAAAA" << endl;
        }
        if (type == "Normal Human"){
            cout << "ZZZZZZZZZZZZZZZZZZZZZZ" << endl;
        }
        if (type == "Stan"){
            cout << "ZZZZZZZZZZ" << "The best" << endl;
        }
    }
    
protected:
    string type = "basic";  // Защищенное поле - доступно в наследниках
};

// Мейбл наследуется от Characters
class Mabel : public Characters{
public:
    Mabel() : Characters("Mabel"){
        // Вызываем конструктор базового класса с параметром "Mabel"
    }
};

// Диппер наследуется от Characters
class Dipper : public Characters{
public:
    Dipper() : Characters("Dipper"){}
};

// Обычный человек
class NormalHuman : public Characters{
public:    
    NormalHuman() : Characters("Normal Human"){}
};

// Стэн - переопределяет метод Sleep
class Stan : public Characters{
public:
    Stan() : Characters("Stan"){}
    
    // Переопределенный метод Sleep
    void Sleep(){
        cout << "ZZZZZZZZZZ" << name << " The best" << endl;
    }
    
    string name = "Stan";
};

// ============================================================================
// ФУНКЦИИ, принимающие параметры по ссылке
// ============================================================================

void restraunt(Characters& ch, Food& food){
    ch.Eat(food);
}

void Hostel(Characters& ch){
    ch.Sleep();
}

// ============================================================================
// ГЛАВНАЯ ФУНКЦИЯ с демонстрацией всех возможностей
// ============================================================================

int main(){
    cout << "=== ДЕМОНСТРАЦИЯ ООП КОНЦЕПЦИЙ ===" << endl << endl;
    
    // Создание объектов еды
    cout << "1. Создание объектов еды:" << endl;
    Jam j;
    Smile sml;
    Zombie z;
    Kabachok k;
    Birds b;
    cout << "   Созданы: Jam, Smile, Zombie, Kabachok, Birds" << endl << endl;

    // Создание объектов персонажей
    cout << "2. Создание объектов персонажей:" << endl;
    Mabel mbl;
    Dipper dpr;
    NormalHuman nh;
    Stan st;
    cout << "   Созданы: Mabel, Dipper, NormalHuman, Stan" << endl << endl;

    // Демонстрация метода Sleep для разных персонажей
    cout << "3. Демонстрация метода Sleep():" << endl;
    cout << "   Mabel: ";
    Hostel(mbl);
    
    cout << "   Dipper: ";
    Hostel(dpr);
    
    cout << "   NormalHuman: ";
    Hostel(nh);
    
    cout << "   Stan (переопределенный метод): ";
    Hostel(st);
    cout << endl;

    // Демонстрация метода Eat
    cout << "4. Демонстрация метода Eat():" << endl;
    cout << "   ";
    mbl.Eat(j);
    cout << "   ";
    dpr.Eat(k);
    cout << "   ";
    nh.Eat(b);
    cout << "   ";
    st.Eat(z);
    cout << endl;

    // Использование функции restraunt
    cout << "5. Использование функции restraunt (передача по ссылке):" << endl;
    cout << "   ";
    restraunt(mbl, k);
    cout << "   ";
    restraunt(st, j);
    cout << endl;

    // Демонстрация значений полей
    cout << "6. Значения полей объектов еды:" << endl;
    cout << "   Jam: satisfaction=" << j.satisfaction << ", type=" << j.type << endl;
    cout << "   Kabachok: satisfaction=" << k.satisfaction << ", type=" << k.type << endl;
    cout << "   Birds: satisfaction=" << b.satisfaction << ", type=" << b.type << endl;
    cout << endl;

    // Демонстрация проблемы со Smile (неправильное переопределение)
    cout << "7. Проблема с неправильным переопределением (Smile):" << endl;
    cout << "   Smile type (должно быть 'Smile', но будет 'eda'): " << sml.type << endl;
    cout << "   Это плохой пример - лучше использовать конструктор!" << endl;
    cout << endl;

    cout << "=== КОНЕЦ ДЕМОНСТРАЦИИ ===" << endl;

    return 0;
}
