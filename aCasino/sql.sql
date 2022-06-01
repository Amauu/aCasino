INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_casino', 'Casino', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_casino', 'Casino', 1);

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('casino', 'Casino', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('casino', 0, 'employer', 'Employer', 0, '', ''),
('casino', 1, 'securite', 'Agent de sécurité', 0, '', ''),
('casino', 2, 'diradj', 'Directeur-adjoint', 0, '', ''),
('casino', 3, 'boss', 'Directeur', 0, '', '');

ALTER TABLE `users` ADD `jetons` INT(11);

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES ('jetons', 'Jeton(s)', -1, 0, 1);

INSERT INTO items (name, label, weight) VALUES
    ('menthe','Feuille de menthe', 50),
    ('rhum','Rhum', 50),
    ('coca','Coca', 50)
    ('whisky','Whisky', 50)
    ('whiskycoca','Whisky-Coca', 50)
    ('jusfruit','Jus de fruits', 50)
    ('sucreP','Sucre en Poudre', 50)
    ('rhumfruit','Rhum-jus de fruits', 50)
; 