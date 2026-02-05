-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3307
-- Létrehozás ideje: 2026. Feb 05. 08:08
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
-- Adatbázis: `szakvizsga`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `futamok`
--

CREATE TABLE `futamok` (
  `futam_id` int(11) NOT NULL,
  `jatekos_id` int(11) DEFAULT NULL,
  `eredmeny` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jatekosok`
--

CREATE TABLE `jatekosok` (
  `id` int(11) NOT NULL,
  `nev` varchar(100) DEFAULT NULL,
  `felhasznalonev` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kapuk`
--

CREATE TABLE `kapuk` (
  `kapu_id` int(11) NOT NULL,
  `kapu_nev` varchar(100) DEFAULT NULL,
  `kapu_leiras` text DEFAULT NULL,
  `szorny_id` int(11) DEFAULT NULL,
  `szoba_id` int(11) NOT NULL,
  `cel_szoba_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `palyak`
--

CREATE TABLE `palyak` (
  `palya_id` int(11) NOT NULL,
  `futam_id` int(11) DEFAULT NULL,
  `palya_seed` int(11) DEFAULT NULL,
  `palya_meret` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szobak`
--

CREATE TABLE `szobak` (
  `szoba_id` int(11) NOT NULL,
  `palya_id` int(11) DEFAULT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `tipus` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szornyek`
--

CREATE TABLE `szornyek` (
  `szorny_id` int(11) NOT NULL,
  `nev` varchar(100) DEFAULT NULL,
  `tipus` varchar(50) DEFAULT NULL,
  `szoba_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `futamok`
--
ALTER TABLE `futamok`
  ADD PRIMARY KEY (`futam_id`),
  ADD KEY `jatekos_id` (`jatekos_id`);

--
-- A tábla indexei `jatekosok`
--
ALTER TABLE `jatekosok`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `kapuk`
--
ALTER TABLE `kapuk`
  ADD PRIMARY KEY (`kapu_id`),
  ADD KEY `szorny_id` (`szorny_id`),
  ADD KEY `fk_kapuk_szoba` (`szoba_id`),
  ADD KEY `fk_kapuk_cel_szoba` (`cel_szoba_id`);

--
-- A tábla indexei `palyak`
--
ALTER TABLE `palyak`
  ADD PRIMARY KEY (`palya_id`),
  ADD KEY `futam_id` (`futam_id`);

--
-- A tábla indexei `szobak`
--
ALTER TABLE `szobak`
  ADD PRIMARY KEY (`szoba_id`),
  ADD KEY `palya_id` (`palya_id`);

--
-- A tábla indexei `szornyek`
--
ALTER TABLE `szornyek`
  ADD PRIMARY KEY (`szorny_id`),
  ADD KEY `fk_szornyek_szobak` (`szoba_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `futamok`
--
ALTER TABLE `futamok`
  MODIFY `futam_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `jatekosok`
--
ALTER TABLE `jatekosok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `kapuk`
--
ALTER TABLE `kapuk`
  MODIFY `kapu_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `palyak`
--
ALTER TABLE `palyak`
  MODIFY `palya_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `szobak`
--
ALTER TABLE `szobak`
  MODIFY `szoba_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `szornyek`
--
ALTER TABLE `szornyek`
  MODIFY `szorny_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `futamok`
--
ALTER TABLE `futamok`
  ADD CONSTRAINT `futamok_ibfk_1` FOREIGN KEY (`jatekos_id`) REFERENCES `jatekosok` (`id`);

--
-- Megkötések a táblához `kapuk`
--
ALTER TABLE `kapuk`
  ADD CONSTRAINT `fk_kapuk_cel_szoba` FOREIGN KEY (`cel_szoba_id`) REFERENCES `szobak` (`szoba_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_kapuk_szoba` FOREIGN KEY (`szoba_id`) REFERENCES `szobak` (`szoba_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kapuk_ibfk_1` FOREIGN KEY (`szorny_id`) REFERENCES `szornyek` (`szorny_id`);

--
-- Megkötések a táblához `palyak`
--
ALTER TABLE `palyak`
  ADD CONSTRAINT `palyak_ibfk_1` FOREIGN KEY (`futam_id`) REFERENCES `futamok` (`futam_id`);

--
-- Megkötések a táblához `szobak`
--
ALTER TABLE `szobak`
  ADD CONSTRAINT `szobak_ibfk_1` FOREIGN KEY (`palya_id`) REFERENCES `palyak` (`palya_id`);

--
-- Megkötések a táblához `szornyek`
--
ALTER TABLE `szornyek`
  ADD CONSTRAINT `fk_szornyek_szobak` FOREIGN KEY (`szoba_id`) REFERENCES `szobak` (`szoba_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
