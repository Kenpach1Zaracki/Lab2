#include <iostream>
#include <string>

using namespace std;


struct Food
{
    int satisfaction = 0;
    string type = "eda";
};


struct Jam : public Food{
    Jam(){
        satisfaction  = 10;
        type = "Jam";
    }
};
struct Kabachok : public Food{
    Kabachok(){
        satisfaction  = 150;
        type = "Kabachok";
    }
};


struct Smile : public Food{
    int satisfaction = 50;
};

struct Kiwi : public Food
{
    int satisfaction = 60;
};

struct Brains : public Food{
    int satisfaction = 100;
};

struct Birds : public Food{
    Birds(){
        satisfaction = 200;
        type = "Birds";
    }
};

struct Zombie : public Food
{
    int satisfaction = 10000;
};
class Characters{
public:
    Characters(const string& key) : type(key) {}
    void Eat(Food food){
        cout << type << " ate a tasty "<< food.type<< " in " << food.satisfaction << endl;
    }
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
    string type = "basic";
};

class Mabel : public Characters{
public:
    Mabel() : Characters("Mabel"){
    }
};

class Dipper : public Characters{
public:
    Dipper() : Characters("Dipper"){}
};
class NormalHuman : public Characters{
public:    
    NormalHuman() : Characters("Normal Human"){}
};

class Stan : public Characters{
public:
    Stan() : Characters("Stan"){}
    void Sleep(){
        cout << "ZZZZZZZZZZ" << name << "The best" << endl;
    }
    string name = "Stan";
};

void restraunt(Characters& ch, Food& food){
    ch.Eat(food);
}

void Hostel(Characters& ch){
    ch.Sleep();
}

int main(){
    Jam j;
    Smile sml;
    Zombie z;
    Kabachok k;

    Mabel mbl;
    Dipper dpr;
    NormalHuman nh;
    Stan st;

    Hostel(st);

    return 0;
}
