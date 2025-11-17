Object subclass: #Ride
	instanceVariableNames: 'rideID pickupLocation dropoffLocation distance fare'
	classVariableNames: ''
	package: 'RideSharing'!

!Ride methodsFor: 'accessing' stamp: 'Abhishek'!
fare
	^ fare!

rideID
	^ rideID! !

!Ride methodsFor: 'initialization' stamp: 'Abhishek'!
initializeWithID: id pickup: pickup dropoff: dropoff distance: dist
	rideID := id.
	pickupLocation := pickup.
	dropoffLocation := dropoff.
	distance := dist.
	fare := 0.0.! !

!Ride methodsFor: 'operations' stamp: 'Abhishek'!
calculateFare
	self subclassResponsibility!

rideDetails
	^ String streamContents: [ :stream |
		stream nextPutAll: '  Ride ID: '; nextPutAll: rideID; cr.
		stream nextPutAll: '  From: '; nextPutAll: pickupLocation; cr.
		stream nextPutAll: '  To: '; nextPutAll: dropoffLocation; cr.
		stream nextPutAll: '  Distance: '; print: distance; nextPutAll: ' miles'; cr.
		stream nextPutAll: '  Fare: $'; print: (fare asFloat roundTo: 0.01); cr.
	]! !

Ride subclass: #StandardRide
	instanceVariableNames: ''
	classVariableNames: 'RATEPERMILE'
	package: 'RideSharing'!

!StandardRide class methodsFor: 'class initialization' stamp: 'Abhishek'!
initialize
	RATEPERMILE := 1.50.! !

!StandardRide methodsFor: 'operations' stamp: 'Abhishek'!
calculateFare
	fare := distance * RATEPERMILE.!

rideDetails
	^ String streamContents: [ :stream |
		stream nextPutAll: '--- Standard Ride ---'; cr.
		stream nextPutAll: (super rideDetails).
	]! !

StandardRide initialize!

Ride subclass: #PremiumRide
	instanceVariableNames: ''
	classVariableNames: 'RATEPERMILE MINIMUMFARE'
	package: 'RideSharing'!

!PremiumRide class methodsFor: 'class initialization' stamp: 'Abhishek'!
initialize
	RATEPERMILE := 3.00.
	MINIMUMFARE := 10.0.! !

!PremiumRide methodsFor: 'operations' stamp: 'Abhishek'!
calculateFare
	| calculatedFare |
	calculatedFare := distance * RATEPERMILE.
	fare := calculatedFare max: MINIMUMFARE.!

rideDetails
	^ String streamContents: [ :stream |
		stream nextPutAll: '--- Premium Ride ---'; cr.
		stream nextPutAll: (super rideDetails).
		stream nextPutAll: '  (Includes premium service)'; cr.
	]! !

PremiumRide initialize!

Object subclass: #Driver
	instanceVariableNames: 'driverID name rating assignedRides'
	classVariableNames: ''
	package: 'RideSharing'!

!Driver methodsFor: 'initialization' stamp: 'Abhishek'!
initialize
	super initialize.
	assignedRides := OrderedCollection new.!

initWithID: id name: n rating: r
	self initialize.
	driverID := id.
	name := n.
	rating := r.! !

!Driver methodsFor: 'operations' stamp: 'Abhishek'!
addRide: aRide
	assignedRides add: aRide.!

getDriverInfo
	| totalEarnings |
	totalEarnings := 0.
	assignedRides do: [ :r | totalEarnings := totalEarnings + r fare ].
	
	^ String streamContents: [ :stream |
		stream nextPutAll: '==========================='; cr.
		stream nextPutAll: 'Driver Info:'; cr.
		stream nextPutAll: 'Name: '; nextPutAll: name; nextPutAll: ' (ID: '; nextPutAll: driverID; nextPutAll: ')'; cr.
		stream nextPutAll: 'Rating: '; print: rating; nextPutAll: ' / 5.0'; cr.
		stream nextPutAll: 'Completed Rides: '; print: assignedRides size; cr.
		stream nextPutAll: 'Total Earnings: $'; print: (totalEarnings asFloat roundTo: 0.01); cr.
		stream nextPutAll: '==========================='; cr.
	]! !

Object subclass: #Rider
	instanceVariableNames: 'riderID name requestedRides'
	classVariableNames: ''
	package: 'RideSharing'!

!Rider methodsFor: 'initialization' stamp: 'Abhishek'!
initialize
	super initialize.
	requestedRides := OrderedCollection new.!

initWithID: id name: n
	self initialize.
	riderID := id.
	name := n.! !

!Rider methodsFor: 'operations' stamp: 'Abhishek'!
requestRide: aRide
	requestedRides add: aRide.
	^ aRide.!

viewRides
	^ String streamContents: [ :stream |
		stream nextPutAll: '==========================='; cr.
		stream nextPutAll: 'Rider History for: '; nextPutAll: name; cr.
		stream nextPutAll: 'Total Rides: '; print: requestedRides size; cr.
		stream nextPutAll: '---------------------------'; cr.
		requestedRides do: [ :r |
			stream nextPutAll: '  - Ride ID: '; nextPutAll: r rideID;
				nextPutAll: ', Fare: $'; print: (r fare asFloat roundTo: 0.01); cr.
		].
		stream nextPutAll: '==========================='; cr.
	]! !
