-- Q1-Print details of sales where amounts are > 2,000 and boxes are < 100

	SELECT *
	FROM sales
	WHERE amount > 2000 AND boxes < 100;


-- Q2-How many sales did each of the salespersons have in January 2022?	

	SELECT p.salesperson, SUM(s.amount)AS sales_amount
	FROM sales AS s
	JOIN people AS p
	ON s.spid = p.spid
	WHERE EXTRACT(YEAR FROM s.saledate) = 2022 AND EXTRACT(MONTH FROM s.saledate) = 01
	GROUP BY p.salesperson;
		

-- Q3-Which product sells more boxes?
		
	SELECT p.pid, p.product, SUM(s.boxes) AS total_boxes_sold
	FROM products AS p
	JOIN sales AS s
	ON p.pid = s.pid
	GROUP BY p.product, p.pid
	ORDER BY total_boxes_sold DESC;
		

-- Q4-Which product sold more boxes in the first 7 days of February 2022? 
		
	SELECT  p.product, SUM(s.boxes) AS total_boxes_sold
	FROM sales AS s
	RIGHT JOIN products AS p 
	ON s.pid = p.pid
	WHERE s.saledate BETWEEN '2022-02-01' AND '2022-02-07'
	GROUP BY p.product
	ORDER BY total_boxes_sold DESC;
		

-- Q5-Which sales had under 100 customers & 100 boxes? Did any of them occur on Wednesday?
		
	WITH sales_day AS (
	    SELECT pid, TO_CHAR(saledate::date, 'Day') AS day_of_week
	    FROM sales
	    WHERE customers < 100
	    AND boxes < 100
	)
	SELECT COUNT(day_of_week) AS sales_on_wednesday
	FROM sales_day
	WHERE day_of_week = 'Wednesday';



