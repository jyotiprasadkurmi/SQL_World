---creating the table---
create table clocked_hours(
empd_id int,
swipe time,
flag char
);

insert into clocked_hours values
(11114,'08:30','I'),
(11114,'10:30','O'),
(11114,'11:30','I'),
(11114,'15:30','O'),
(11115,'09:30','I'),
(11115,'17:30','O');

solution1:

with table1 as
			(select *,
				lead(swipe,1) over(partition by empd_id order by swipe) as rnk
			from clocked_hours),
		table2 as (select *,
			timestampdiff(hour,swipe,rnk) as clckd_hr
		from table1
		where flag = 'I')
select empd_id, sum(clckd_hr) as clckd from table2
group by empd_id