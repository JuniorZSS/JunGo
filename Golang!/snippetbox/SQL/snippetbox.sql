SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `snippetbox`
--

-- --------------------------------------------------------

--
-- Table structure for table `snippets`
--

CREATE TABLE `snippets` (
  `id` int NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `expires` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `snippets`
--

INSERT INTO `snippets` (`id`, `title`, `content`, `created`, `expires`) VALUES
(1, 'Не имей сто рублей', 'Не имей сто рублей,\nа имей сто друзей.', '2021-01-27 13:09:34', '2030-01-27 13:09:34'),
(2, 'Лучше один раз увидеть', 'Лучше один раз увидеть,\nчем сто раз услышать.', '2021-01-27 13:09:40', '2030-01-27 13:09:40'),
(3, 'Не откладывай на завтра', 'Не откладывай на завтра,\nчто можешь сделать сегодня.', '2021-01-27 13:09:44', '2021-02-03 13:09:44'),
(4, 'История про улитку', 'Улитка выползла из раковины,\nвытянула рожки,\nи опять подобрала их.', '2021-04-21 14:39:12', '2021-04-28 14:39:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `snippets`
--
ALTER TABLE `snippets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_snippets_created` (`created`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `snippets`
--
ALTER TABLE `snippets`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
