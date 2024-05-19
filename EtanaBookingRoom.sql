SELECT * FROM Users
SELECT * FROM Rooms
SELECT * FROM RoomFacilities
SELECT * FROM Facilities
SELECT * FROM BookingRooms
SELECT * FROM SesssionBookingRooms
SELECT * FROM SessionTime

/*
Update BookingRooms
	set Approver = NULL,
	ApproveDate = NULL,
	NoteApprove = NULL,
	Status = 2
	Where Id = 13
*/

SELECT (SELECT min(b.StartTime) FROM SessionTime b where b.Id=a.IdSessionTime) StartTime, 
(SELECT max(b.EndTime) FROM SessionTime b where b.Id=a.IdSessionTime) EndTime, a.* FROM SesssionBookingRooms a
where a.IdBookingRooms = 8

select (
select convert(nvarchar(MAX), min(suba.StartTime), 8) StartTime from(
SELECT 
(SELECT d.StartTime FROM SessionTime d where d.Id=c.IdSessionTime) StartTime FROM SesssionBookingRooms c
where c.IdBookingRooms = 8) as suba
) + ' - ' + (
select convert(nvarchar(MAX), max(subb.EndTime), 8) EndTime from(
SELECT 
(SELECT d.EndTime FROM SessionTime d where d.Id=c.IdSessionTime) EndTime FROM SesssionBookingRooms c
where c.IdBookingRooms = 8) as subb
) as Session