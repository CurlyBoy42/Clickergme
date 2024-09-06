<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gravity Falls Mine</title>
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            background: url('https://i.pinimg.com/originals/7c/75/fa/7c75fa0266744d51790e8653cce6a0ff.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
            color: #fff;
            overflow: hidden;
        }

        .container {
            position: relative;
            display: flex;
            justify-content: space-between;
            width: 90%;
            height: 90%;
            max-width: 1200px;
        }

        #shop {
            background-color: rgba(0, 0, 0, 0.7);
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            width: 200px;
            position: relative;
            z-index: 1;
        }

        button {
            padding: 15px;
            font-size: 18px;
            background-color: #e74c3c;
            color: #fff;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin-top: 10px;
            width: 100%;
        }

        button:active {
            transform: scale(0.95);
        }

        button:disabled {
            background-color: #bdc3c7;
            cursor: not-allowed;
        }

        #clickImage {
            width: 100px;
            height: 100px;
            background-color: transparent;
            border: none;
            cursor: pointer;
            position: relative;
            margin: auto;
            display: block;
            background-size: cover;
            background-position: center;
        }

        .main-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            flex-grow: 1;
            position: relative;
            z-index: 0;
        }

        .main-content > * {
            margin: 5px;
        }

        .health-bar {
            width: 100px;
            height: 20px;
            background-color: #444;
            border-radius: 5px;
            margin-bottom: 10px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .health-bar-fill {
            height: 100%;
            background-color: #e74c3c;
            border-radius: 5px;
            width: 100%; /* Начальное значение - 100% */
        }

        .health-text {
            position: absolute;
            color: #fff;
            font-size: 14px;
            font-weight: bold;
        }

        .helper-menu {
            display: none;
            flex-direction: column;
            background-color: rgba(0, 0, 0, 0.8);
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            position: absolute;
            top: 20%;
            left: 50%;
            transform: translate(-50%, -20%);
            z-index: 3;
            width: 300px;
        }

        .helper-menu.active {
            display: flex;
        }

        .helper {
            margin: 10px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .helper img {
            width: 50px;
            height: 50px;
            border-radius: 10px;
        }

        .locked img {
            opacity: 0.3;
        }

        .close-menu {
            background-color: #e74c3c;
            margin-top: 10px;
        }

        .header-info {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header-info .coins,
        .header-info .crystals {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .header-info .coins img,
        .header-info .crystals img {
            width: 30px;
            height: 30px;
        }

        @keyframes crumble {
            0% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.2) rotate(10deg);
                opacity: 0.7;
            }
            100% {
                transform: scale(0.1) rotate(360deg);
                opacity: 0;
            }
        }

        .crumble {
            animation: crumble 1s forwards;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
    </style>
</head>
<body>
    <div class="header-info">
        <div class="coins">
            <img src="https://img.icons8.com/?size=100&id=6U2tFbH0pmLw&format=png&color=000000" alt="Монеты">
            <span id="score">Монеты: 0</span>
        </div>
        <div class="crystals">
            <img src="https://img.icons8.com/?size=100&id=j8fwtlJzVvem&format=png&color=000000" alt="Кристаллы">
            <span id="crystalCount">0</span>
        </div>
    </div>

    <div class="container">
        <div id="shop">
            <h2>Магазин</h2>
            <button id="helperMenuButton">Помощники и Прокачка</button>
        </div>
        <div class="main-content">
            <div class="health-bar">
                <div id="healthFill" class="health-bar-fill"></div>
                <div id="healthText" class="health-text">100</div>
            </div>
            <div id="levelText">Уровень: 1</div>
            <div id="miniLevelText">0/10</div>
            <button id="clickImage" style="background-image: url(https://banner2.cleanpng.com/20180528/qtf/kisspng-san-andreas-multiplayer-gravity-falls-sticker-game-5b0b866b36ae06.495648471527481963224.jpg);" aria-label="Клик!"></button>
        </div>
    </div>

    <div id="helperMenu" class="helper-menu">
        <h2>Помощники и Прокачка</h2>
        <div class="helper">
            <span>Прокачка кликов</span>
            <button id="upgradeButton">Улучшение (10 монет)</button>
        </div>
        <div id="dipperHelper" class="helper">
            <img src="https://64.media.tumblr.com/9fb97e5c0265be2ee3cda8e7456894e6/tumblr_os14bj4nus1u6w1edo5_100.gifv" alt="Диппер">
            <div>
                <span>Дипперов: <span id="gnomeCount">0</span></span>
                <button id="buyGnomeButton">Купить Диппера (50 монет)</button>
                <button id="upgradeGnomeButton" disabled>Улучшить Диппера (100 монет)</button>
            </div>
        </div>
        <div id="maybleHelper" class="helper locked">
            <img src="https://i.pinimg.com/originals/03/97/12/0397121d5e963c2eb0cdbd4c49a9bfbc.gif" alt="Мейбл">
            <div>
                <span>Мейблов: <span id="elfCount">0</span></span>
                <button id="buyElfButton" disabled>Купить Мейбл (500 монет)</button>
                <button id="upgradeElfButton" disabled>Улучшить Мейбл (1000 монет)</button>
            </div>
        </div>
        <button id="closeHelperMenu" class="close-menu">Закрыть</button>
    </div>

    <script>
        let score = 0;
        let clickValue = 1;
        let upgradeCost = 10;
        let scorePerImage = 2;
        let gnomeCost = 50;
        let elfCost = 500;
        let elfUpgradeCost = 1000;

        let gnomeLevel = 0;
        let gnomeIncome = 1;
        let elfLevel = 0;
        let elfIncome = 10;

        let currentHealth = 100;
        let maxHealth = 100;
        let level = 1;
        let miniLevel = 0;
        const miniLevelsToNextLevel = 10;

        const scoreElement = document.getElementById("score");
        const clickImage = document.getElementById("clickImage");
        const upgradeButton = document.getElementById("upgradeButton");
        const gnomeCountElement = document.getElementById("gnomeCount");
        const buyGnomeButton = document.getElementById("buyGnomeButton");
        const upgradeGnomeButton = document.getElementById("upgradeGnomeButton");
        const helperMenu = document.getElementById("helperMenu");
        const helperMenuButton = document.getElementById("helperMenuButton");
        const closeHelperMenu = document.getElementById("closeHelperMenu");
        const elfCountElement = document.getElementById("elfCount");
        const buyElfButton = document.getElementById("buyElfButton");
        const upgradeElfButton = document.getElementById("upgradeElfButton");
        const healthFill = document.getElementById("healthFill");
        const healthText = document.getElementById("healthText");
        const levelText = document.getElementById("levelText");
        const miniLevelText = document.getElementById("miniLevelText");

        function updateScore() {
            scoreElement.textContent = "Монеты: " + score;
        }

        function updateHealth() {
            const healthPercentage = Math.max(0, (currentHealth / maxHealth) * 100); // Ensure health percentage is not negative
            healthFill.style.width = healthPercentage + "%";
            healthText.textContent = currentHealth;
        }

        function levelUp() {
            level++;
            maxHealth += 20;
            currentHealth = maxHealth; // Restore health
            scorePerImage = 2 + Math.floor(level / 5);
            updateHealth();
            levelText.textContent = "Уровень: " + level;
            miniLevel = 0; // Reset miniLevel after leveling up
            miniLevelText.textContent = `${miniLevel}/${miniLevelsToNextLevel}`;
        }

        function resetLevel() {
            miniLevel++;
            if (miniLevel >= miniLevelsToNextLevel) {
                levelUp();
            } else {
                miniLevelText.textContent = `${miniLevel}/${miniLevelsToNextLevel}`;
            }
        }

        clickImage.addEventListener("click", function() {
            currentHealth -= 10;
            updateHealth();

            if (currentHealth <= 0) {
                score += scorePerImage;
                updateScore();
                clickImage.classList.add("crumble");

                setTimeout(() => {
                    clickImage.classList.remove("crumble");
                }, 1000);

                currentHealth = maxHealth; // Restore health after click
                resetLevel();
            }
        });

        upgradeButton.addEventListener("click", function() {
            if (score >= upgradeCost) {
                score -= upgradeCost;
                clickValue += 1;
                upgradeCost *= 2;
                upgradeButton.textContent = "Улучшение (" + upgradeCost + " монет)";
                updateScore();
            }
        });

        buyGnomeButton.addEventListener("click", function() {
            if (score >= gnomeCost) {
                score -= gnomeCost;
                gnomeLevel += 1;
                gnomeCountElement.textContent = gnomeLevel;
                gnomeCost *= 2;
                buyGnomeButton.textContent = "Купить Диппера (" + gnomeCost + " монет)";
                updateScore();

                if (gnomeLevel >= 2) {
                    upgradeGnomeButton.disabled = false;
                }
            }
        });

        upgradeGnomeButton.addEventListener("click", function() {
            if (score >= gnomeCost * 2) {
                score -= gnomeCost * 2;
                gnomeIncome += 1;
                updateScore();
            }
        });

        buyElfButton.addEventListener("click", function() {
            if (score >= elfCost && !document.getElementById("maybleHelper").classList.contains("locked")) {
                score -= elfCost;
                elfLevel += 1;
                elfCountElement.textContent = elfLevel;
                elfCost *= 2;
                buyElfButton.textContent = "Купить Мейбл (" + elfCost + " монет)";
                updateScore();

                if (elfLevel >= 2) {
                    upgradeElfButton.disabled = false;
                }
            }
        });

        upgradeElfButton.addEventListener("click", function() {
            if (score >= elfUpgradeCost) {
                score -= elfUpgradeCost;
                elfIncome += 10;
                updateScore();
            }
        });

        helperMenuButton.addEventListener("click", function() {
            helperMenu.classList.add("active");
        });

        closeHelperMenu.addEventListener("click", function() {
            helperMenu.classList.remove("active");
        });

        setInterval(function() {
            score += gnomeLevel * gnomeIncome;
            score += elfLevel * elfIncome;
            updateScore();
        }, 1000);

        updateHealth();
        levelText.textContent = "Уровень: " + level;
        miniLevelText.textContent = `${miniLevel}/${miniLevelsToNextLevel}`;
    </script>
</body>
</html>
