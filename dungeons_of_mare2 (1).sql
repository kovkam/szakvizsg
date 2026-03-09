-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3307
-- Létrehozás ideje: 2026. Már 09. 12:08
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `dungeons_of_mare2`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jatekosok`
--

CREATE TABLE `jatekosok` (
  `jatekos_id` int(11) NOT NULL,
  `felhasznalonev` varchar(50) NOT NULL,
  `letrehozas_datuma` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jatek_allas`
--

CREATE TABLE `jatek_allas` (
  `session_id` int(11) NOT NULL,
  `jatekos_id` int(11) DEFAULT NULL,
  `palya_id` int(11) DEFAULT NULL,
  `pontszam` int(11) DEFAULT NULL,
  `jatek_ido` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `palyak`
--

CREATE TABLE `palyak` (
  `palya_id` int(11) NOT NULL,
  `palya_nev` varchar(50) DEFAULT NULL,
  `szint` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szornyek`
--

CREATE TABLE `szornyek` (
  `szorny_id` int(11) NOT NULL,
  `nev` varchar(50) DEFAULT NULL,
  `tipus` varchar(20) DEFAULT NULL,
  `palya_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `jatekosok`
--
ALTER TABLE `jatekosok`
  ADD PRIMARY KEY (`jatekos_id`);

--
-- A tábla indexei `jatek_allas`
--
ALTER TABLE `jatek_allas`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `jatekos_id` (`jatekos_id`),
  ADD KEY `palya_id` (`palya_id`);

--
-- A tábla indexei `palyak`
--
ALTER TABLE `palyak`
  ADD PRIMARY KEY (`palya_id`);

--
-- A tábla indexei `szornyek`
--
ALTER TABLE `szornyek`
  ADD PRIMARY KEY (`szorny_id`),
  ADD KEY `palya_id` (`palya_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `jatekosok`
--
ALTER TABLE `jatekosok`
  MODIFY `jatekos_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `jatek_allas`
--
ALTER TABLE `jatek_allas`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `palyak`
--
ALTER TABLE `palyak`
  MODIFY `palya_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `szornyek`
--
ALTER TABLE `szornyek`
  MODIFY `szorny_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `jatek_allas`
--
ALTER TABLE `jatek_allas`
  ADD CONSTRAINT `jatek_allas_ibfk_1` FOREIGN KEY (`jatekos_id`) REFERENCES `jatekosok` (`jatekos_id`),
  ADD CONSTRAINT `jatek_allas_ibfk_2` FOREIGN KEY (`palya_id`) REFERENCES `palyak` (`palya_id`);

--
-- Megkötések a táblához `szornyek`
--
ALTER TABLE `szornyek`
  ADD CONSTRAINT `szornyek_ibfk_1` FOREIGN KEY (`palya_id`) REFERENCES `palyak` (`palya_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
