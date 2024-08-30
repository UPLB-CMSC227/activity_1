
![procedure](./assets/img/procedure.png)

# Activity #1
This repository contains a MySQL/MariaDB procedure for inserting an item into a database using a newly or recently used primary key.   

## Requirements
The following conditions must be met for this activity:

- The table must contain columns for **id** and **name**
- Column **name** must have a corresponding value of **four characters** + the assigned **primary key** of the newly inserted data.

> Sample Format: [abcd1], [xyz2], ... [xyz10]

- The value of the four characters may be ***randomly generated*** or a ***fixed value***

> Sample Fixed Value: [test1], [test2], [test3] ... [test10]

- The value of the inserted **id** should be the smallest unused or removed primary key value.

> ORIGINAL DATA

| ID   | Name  |
|---   | ---   |
| 5  |  test5  |
| 6  |  test6  |
| 7  |  test7  |

> MODIFIED DATA

| ID   | Name  |
|---   | ---   |
| 4  |  test4  |
| 5  |  test5  |
| 6  |  test6  |
| 7  |  test7  |


## Tools
Here is a list of tools and database management systems that could be used for this activity. Please note that you don't have to install MySQL if you already have MariaDB.
- [MariaDB](https://mariadb.org/download/?t=mariadb&p=mariadb&r=11.5.2)
- [MySQL](https://dev.mysql.com/downloads/)
- [phpMyAdmin](https://www.phpmyadmin.net/downloads/)
- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)

## License
Copyright (c) 2024 @jkga   

This project is licensed under the terms of the MIT license.

