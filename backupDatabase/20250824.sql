-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Tempo de geração: 25/08/2025 às 02:38
-- Versão do servidor: 10.11.6-MariaDB-1:10.11.6+maria~ubu2204
-- Versão do PHP: 8.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `database`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `alimentos`
--

CREATE TABLE `alimentos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  `criado_em` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `alimentos`
--

INSERT INTO `alimentos` (`id`, `usuario_id`, `nome`, `tipo_id`, `criado_em`) VALUES
(7, 1, 'cenoura', 1, '2025-08-25 02:13:10'),
(9, 2, 'cenoura', 1, '2025-08-25 02:13:28'),
(12, 1, 'beterraba', 1, '2025-08-25 02:17:11');

-- --------------------------------------------------------

--
-- Estrutura para tabela `alimentos_tipos`
--

CREATE TABLE `alimentos_tipos` (
  `id` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `unidade` varchar(30) NOT NULL,
  `abreviacao` varchar(5) NOT NULL,
  `criado_em` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `alimentos_tipos`
--

INSERT INTO `alimentos_tipos` (`id`, `nome`, `unidade`, `abreviacao`, `criado_em`) VALUES
(1, 'sólido', 'grama', 'g', '2025-08-25 00:47:03'),
(2, 'líquido', 'mililitro', 'mL', '2025-08-25 00:47:21');

-- --------------------------------------------------------

--
-- Estrutura para tabela `listas`
--

CREATE TABLE `listas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `criado_em` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `listas`
--

INSERT INTO `listas` (`id`, `usuario_id`, `nome`, `criado_em`) VALUES
(1, 1, 'primeira lista de compras', '2025-08-25 02:35:09');

-- --------------------------------------------------------

--
-- Estrutura para tabela `listas_compras`
--

CREATE TABLE `listas_compras` (
  `id` int(11) NOT NULL,
  `lista_id` int(11) NOT NULL,
  `alimento_id` int(11) NOT NULL,
  `qnt` int(11) NOT NULL,
  `comprado` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `listas_receitas`
--

CREATE TABLE `listas_receitas` (
  `id` int(11) NOT NULL,
  `lista_id` int(11) NOT NULL,
  `receita_id` int(11) NOT NULL,
  `qnt_porcoes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `listas_receitas`
--

INSERT INTO `listas_receitas` (`id`, `lista_id`, `receita_id`, `qnt_porcoes`) VALUES
(1, 1, 1, 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `receitas`
--

CREATE TABLE `receitas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `qnt_porcoes` int(11) NOT NULL,
  `preparo` varchar(3000) NOT NULL,
  `imagem` varchar(500) NOT NULL,
  `criado_em` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `receitas`
--

INSERT INTO `receitas` (`id`, `usuario_id`, `nome`, `qnt_porcoes`, `preparo`, `imagem`, `criado_em`) VALUES
(1, 1, 'abobora recheada', 1, '', '', '2025-08-25 02:15:46');

-- --------------------------------------------------------

--
-- Estrutura para tabela `receitas_alimentos`
--

CREATE TABLE `receitas_alimentos` (
  `id` int(11) NOT NULL,
  `receita_id` int(11) NOT NULL,
  `alimento_id` int(11) NOT NULL,
  `qnt` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `receitas_alimentos`
--

INSERT INTO `receitas_alimentos` (`id`, `receita_id`, `alimento_id`, `qnt`) VALUES
(1, 1, 7, 2),
(3, 1, 12, 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(100) NOT NULL,
  `criado_em` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `criado_em`) VALUES
(1, 'guilherme', 'domtoniolo@gmail.com', 'senha123', '2025-08-25 00:45:26'),
(2, 'larissa', 'larissabohlant07@gmail.com', 'senha123', '2025-08-25 00:47:59');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `alimentos`
--
ALTER TABLE `alimentos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_usuarioid_nome` (`usuario_id`,`nome`) USING BTREE,
  ADD KEY `fk_tipo` (`tipo_id`);

--
-- Índices de tabela `alimentos_tipos`
--
ALTER TABLE `alimentos_tipos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `listas`
--
ALTER TABLE `listas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_usuario2` (`usuario_id`);

--
-- Índices de tabela `listas_compras`
--
ALTER TABLE `listas_compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_lista2` (`lista_id`),
  ADD KEY `fk_alimento2` (`alimento_id`);

--
-- Índices de tabela `listas_receitas`
--
ALTER TABLE `listas_receitas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_lista1` (`lista_id`),
  ADD KEY `fk_receita2` (`receita_id`);

--
-- Índices de tabela `receitas`
--
ALTER TABLE `receitas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_usuario` (`usuario_id`);

--
-- Índices de tabela `receitas_alimentos`
--
ALTER TABLE `receitas_alimentos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_receitaid_alimentoid` (`receita_id`,`alimento_id`),
  ADD KEY `fk_alimento1` (`alimento_id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alimentos`
--
ALTER TABLE `alimentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `alimentos_tipos`
--
ALTER TABLE `alimentos_tipos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `listas`
--
ALTER TABLE `listas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `listas_compras`
--
ALTER TABLE `listas_compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `listas_receitas`
--
ALTER TABLE `listas_receitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `receitas`
--
ALTER TABLE `receitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `receitas_alimentos`
--
ALTER TABLE `receitas_alimentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `alimentos`
--
ALTER TABLE `alimentos`
  ADD CONSTRAINT `fk_tipo` FOREIGN KEY (`tipo_id`) REFERENCES `alimentos_tipos` (`id`),
  ADD CONSTRAINT `fk_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Restrições para tabelas `listas`
--
ALTER TABLE `listas`
  ADD CONSTRAINT `fk_usuario2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Restrições para tabelas `listas_compras`
--
ALTER TABLE `listas_compras`
  ADD CONSTRAINT `fk_alimento2` FOREIGN KEY (`alimento_id`) REFERENCES `alimentos` (`id`),
  ADD CONSTRAINT `fk_lista2` FOREIGN KEY (`lista_id`) REFERENCES `listas` (`id`);

--
-- Restrições para tabelas `listas_receitas`
--
ALTER TABLE `listas_receitas`
  ADD CONSTRAINT `fk_lista1` FOREIGN KEY (`lista_id`) REFERENCES `listas` (`id`),
  ADD CONSTRAINT `fk_receita2` FOREIGN KEY (`receita_id`) REFERENCES `receitas` (`id`);

--
-- Restrições para tabelas `receitas`
--
ALTER TABLE `receitas`
  ADD CONSTRAINT `fk_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Restrições para tabelas `receitas_alimentos`
--
ALTER TABLE `receitas_alimentos`
  ADD CONSTRAINT `fk_alimento1` FOREIGN KEY (`alimento_id`) REFERENCES `alimentos` (`id`),
  ADD CONSTRAINT `fk_receita1` FOREIGN KEY (`receita_id`) REFERENCES `receitas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
