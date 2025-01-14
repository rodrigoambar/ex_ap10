CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
INT) RETURNS INT AS
$$
BEGIN
RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;
--1.1.1
DO $$
DECLARE
num INT;
BEGIN
	RAISE NOTICE 'numeros pares entre 1 e 100';
    FOR num IN 1..100 LOOP
        IF num % 2 = 0 THEN
            RAISE NOTICE '%', num;
        END IF;
	EXIT WHEN 
		intervalo % 2 != 0;
    END LOOP;
	
END;
$$

--1.1.2
DO $$
DECLARE
    num INT;
    cont INT := 0;
BEGIN
    FOR i IN 1 .. 6 LOOP
        num := valor_aleatorio_entre(-50, 50);
        RAISE NOTICE 'O valor % foi gerado', num;       
        IF num > 0 THEN
            cont := cont + 1;
        END IF;
    END LOOP;
    
    RAISE NOTICE 'Total de números positivos: %', cont;
END;
$$

--1.1.3
DO $$
DECLARE
num1 INT;
num2 INT;
soma INT := 0;
maior INT;
menor INT;
i INT;
BEGIN
	num1 := valor_aleatorio_entre(20,50);
	num2 := valor_aleatorio_entre(20,50);
	RAISE NOTICE 'foram gerados %, %', num1, num2;
	IF num1 > num2 THEN
		maior := num1;
		menor := num2;
	ELSE
		maior := num2;
		menor := num1;
	END IF;
		FOR i IN menor + 1 .. maior - 1 LOOP
			IF i % 2 != 0 THEN
				soma := soma + i;
			END IF;
			END LOOP;
	RAISE NOTICE 'A soma de todos os valores ímpares entre % e % é: %', menor, maior, soma;
END;
$$

-- 1.1.4
DO $$
DECLARE
    m INT;
    n INT;
    menor INT;
    maior INT;
    soma INT := 0;
    i INT;
BEGIN
	m := valor_aleatorio_entre(1, 100);
	n := valor_aleatorio_entre(1, 100);
	RAISE NOTICE 'Valores lidos: M = %, N = %', m, n;
	 IF m < n THEN
            menor := m;
            maior := n;
        ELSE
            menor := n;
            maior := m;
        END IF;
		RAISE NOTICE 'Sequência de % até %:', menor, maior;
        FOR i IN menor..maior LOOP
            RAISE NOTICE '%', i;
            soma := soma + i;
        END LOOP;
	RAISE NOTICE 'Soma dos valores entre % e %: %', menor, maior, soma;
END;
$$
        
--1.2 Faça um programa que calcule o determinante de uma matriz quadrada de ordem 3
--utilizando a regra de Sarrus. 
--Preencha a matriz com valores inteiros aleatórios no intervalo de 1 a 12.
DO $$
DECLARE
matriz INT[] := ARRAY[
[valor_aleatorio_entre(1, 12), valor_aleatorio_entre(1, 12), valor_aleatorio_entre(1, 12)],
[valor_aleatorio_entre(1, 12), valor_aleatorio_entre(1, 12), valor_aleatorio_entre(1, 12)],
[valor_aleatorio_entre(1, 12), valor_aleatorio_entre(1, 12), valor_aleatorio_entre(1, 12)]
];
matriz_sarrus INT[][];
linha1 INT[];
linha2 INT[];
dig_princ INT;
dig_secund INT;
det INT;
BEGIN
	linha1 := ARRAY[matriz[1][1], matriz[1][2], matriz[1][3]];
	linha2 := ARRAY[matriz[2][1], matriz[2][2], matriz[2][3]];
	
	matriz_sarrus := matriz || ARRAY[linha1] || ARRAY[linha2];
	RAISE NOTICE 'matriz sarrus %', matriz_sarrus;
	dig_princ := matriz[1][1] * matriz[2][2] * matriz[3][3] +
                 matriz[1][2] * matriz[2][3] * matriz[3][1] +
				 matriz[1][3] * matriz[2][1] * matriz[3][2];
				 
	dig_secund := matriz[3][1] * matriz[2][2] * matriz[1][3] +
                 matriz[3][2] * matriz[2][3] * matriz[1][1] +
				 matriz[3][3] * matriz[2][1] * matriz[1][2];
	RAISE NOTICE ' as diagonais  são: % e %', dig_princ, dig_secund;
	det := dig_princ - dig_secund;
	RAISE NOTICE 'o determinante da matriz % é : %', matriz, det;
END;				 
$$






