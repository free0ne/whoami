local guys = { { "Уинстон Смит", "1984" },
{ "Джулия", "1984" },
{ "О’Брайен", "1984" },
{ "Остап Бендер", "12 стульев" },
{ "Гай Монтэг", "451 градус по Фаренгейту" },
{ "Кларисса Маклеллан", "451 градус по Фаренгейту" },
{ "Кристиан Грей", "50 оттенков серого" },
{ "Анастейша Стил", "50 оттенков серого" },
{ "Алиса", "Алиса в стране чудес" },
{ "Чеширский кот", "Алиса в стране чудес" },
{ "Безумный шляпник", "Алиса в стране чудес" },
{ "Ассоль", "Алые паруса" },
{ "Грей", "Алые паруса" },
{ "Анна Каренина", "Анна Каренина" },
{ "Тайлер Дерден", "Бойцовский клуб" },
{ "Марла", "Бойцовский клуб" },
{ "Артемон", "Буратино" },
{ "Буратино", "Буратино" },
{ "Карабас-Барабас", "Буратино" },
{ "Кот Базилио", "Буратино" },
{ "Лиса Алиса", "Буратино" },
{ "Мальвина", "Буратино" },
{ "Папа Карло", "Буратино" },
{ "Пьеро", "Буратино" },
{ "Геральт", "Ведьмак" },
{ "Винни-Пух", "Винни-Пух" },
{ "Ослик Иа-Иа", "Винни-Пух" },
{ "Сова", "Винни-Пух" },
{ "Пятачок", "Винни-Пух" },
{ "Кристофер Робин", "Винни-Пух" },
{ "Тигра", "Винни-Пух" },
{ "Ру", "Винни-Пух" },
{ "Гэндальф", "Властелин колец" },
{ "Фродо Бэггинс", "Властелин колец" },
{ "Бильбо Бэггинс", "Властелин колец" },
{ "Леголас", "Властелин колец" },
{ "Арагорн", "Властелин Колец" },
{ "Гэндальф", "Властелин Колец" },
{ "Леголас", "Властелин Колец" },
{ "Галадриэль", "Властелин Колец" },
{ "Саруман", "Властелин Колец" },
{ "Саурон", "Властелин Колец" },
{ "Андрей Болконский", "Война и Мир" },
{ "Пьер Безухов", "Война и Мир" },
{ "Наташа Ростова", "Война и Мир" },
{ "Элли", "Волшебник Изумрудного города" },
{ "Гудвин", "Волшебник Изумрудного города" },
{ "Страшила", "Волшебник Изумрудного города" },
{ "Железный дровосек", "Волшебник Изумрудного города" },
{ "Трусливый лев", "Волшебник Изумрудного города" },
{ "Гарри Поттер", "Гарри Поттер" },
{ "Гермиона Грейнджер", "Гарри Поттер" },
{ "Рон Уизли", "Гарри Поттер" },
{ "Драко Малфой", "Гарри Поттер" },
{ "Дамблдор", "Гарри Поттер" },
{ "Римус Люпин", "Гарри Поттер" },
{ "Хагрид", "Гарри Поттер" },
{ "Северус Снегг", "Гарри Поттер" },
{ "Чацкий", "Горе от ума" },
{ "Юрий Живаго", "Доктор Живаго" },
{ "Евгений Онегин", "Евгений Онегин" },
{ "Татьяна Ларина", "Евгений Онегин" },
{ "Владимир Ленский", "Евгений Онегин" },
{ "Дейенерис Таргариен", "Игра престолов" },
{ "Джон Сноу", "Игра престолов" },
{ "Кхал Дрого", "Игра престолов" },
{ "Серсея Ланнистер", "Игра престолов" },
{ "Тирион Ланнистер", "Игра престолов" },
{ "Санса Старк", "Игра престолов" },
{ "Арья Старк", "Игра престолов" },
{ "Джоффри Баратеон", "Игра престолов" },
{ "Рамси Болтон", "Игра престолов" },
{ "Джейме Ланнистер", "Игра престолов" },
{ "Ходор", "Игра престолов" },
{ "Акела", "Книга джунглей" },
{ "Багира", "Книга джунглей" },
{ "Балу", "Книга джунглей" },
{ "Бандар-логи", "Книга джунглей" },
{ "Каа", "Книга джунглей" },
{ "Маугли", "Книга джунглей" },
{ "Шерхан", "Книга джунглей" },
{ "Конек-горбунок", "Конек-горбунок" },
{ "Крокодил Гена", "Крокодил Гена и его друзья" },
{ "Крыска Лариска", "Крокодил Гена и его друзья" },
{ "Старуха шапокляк", "Крокодил Гена и его друзья" },
{ "Чебурашка", "Крокодил Гена и его друзья" },
{ "Курочка Ряба", "Курочка Ряба" },
{ "Лолита", "Лолита" },
{ "Маленький принц", "Маленький принц" },
{ "Лис", "Маленький принц" },
{ "Роза", "Маленький принц" },
{ "Карлсон", "Малыш и Карлсон" },
{ "Малыш", "Малыш и Карлсон" },
{ "ФрекенБок", "Малыш и Карлсон" },
{ "Кот Бегемот", "Мастер и маргарита" },
{ "Воланд", "Мастер и маргарита" },
{ "Мастер", "Мастер и маргарита" },
{ "Маргарита", "Мастер и маргарита" },
{ "Мэри Поппинс", "Мэри Поппинс" },
{ "Бернард Маркс", "О дивный новый мир" },
{ "Ленайна Краун", "О дивный новый мир" },
{ "Обломов", "Обломов" },
{ "Жан-Батист Гренуй", "Парфюмер" },
{ "Пеппи длинный чулок", "Пеппи длинный чулок" },
{ "Капитан Крюк", "Питер Пэн" },
{ "Питер Пэн", "Питер Пэн" },
{ "Фея Динь", "Питер Пэн" },
{ "Дориан Грей", "Портрет Дориана Грея" },
{ "Родион Раскольников", "Преступление и Наказание" },
{ "Софья Мармеладова", "Преступление и Наказание" },
{ "Старушка", "Преступление и Наказание" },
{ "Репка", "Репка" },
{ "Робин Гуд", "Робин Гуд" },
{ "Полиграф Шариков", "Собачье сердце" },
{ "Филипп Преображенский", "Собачье сердце" },
{ "Эдвард Каллен", "Сумерки" },
{ "Белла Свон", "Сумерки" },
{ "Джейкоб Блэк", "Сумерки" },
{ "Тарас Бульба", "Тарас Бульба" },
{ "Д'Артаньян", "Три мушкетера" },
{ "Атос", "Три мушкетера" },
{ "Портос", "Три мушкетера" },
{ "Арамис", "Три мушкетера" },
{ "Дядя Фёдор", "Трое из Простоквашино" },
{ "Матроскин", "Трое из Простоквашино" },
{ "Почтальон Печкин", "Трое из Простоквашино" },
{ "Шарик", "Трое из Простоквашино" },
{ "Линдсей Форд (Шантарам)", "Шантарам" },
{ "Шерлок Холмс", "Шерлок Холмс" },
{ "Доктор Ватсон", "Шерлок Холмс" },
{ "Мориарти", "Шерлок Холмс" } }


return guys
