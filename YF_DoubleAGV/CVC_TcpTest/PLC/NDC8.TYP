[IEC_IEC_NORM]
TYPE
    IntraVehicleLocation_T :
    STRUCT 
        X : DINT ;   (* Vehicle relative position X  *)
        Y : DINT ;   (* Vehicle relative position Y  *)
        Angle : REAL ;   (* Vehicle relative angle  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Device_T :
    STRUCT 
        DeviceType : STRING ;   (* Device type identifier  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Vmc_T :
    STRUCT 
        AllOK : BOOL ;   (* Vehicle controller AllOK signal  *)
        Clock : DINT ;   (* Vehicle clock (UTC). Seconds since 00:00:00 January 1 1970. Valid after the vehicle controller has connected to NT8000 followed by a restart of the vehicle controller.  *)
        LocalClock : DINT ;   (* Vehicle local clock adjusted for local timezone and daylight savings time. Seconds since 00:00:00 January 1 1970. Valid after the vehicle controller has connected to NT8000 followed by a restart of the vehicle controller.  *)
        PlcLoopTime : DINT ;   (* Time used for executing the last PLC loop.  *)
        PlcLoopTimeMax : DINT ;   (* Max time used for executing the PLC loop.  *)
        PlcLoopTimeAvg : DINT ;   (* Average time used for executing the PLC loop the last 100 times.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Wlan_T :
    STRUCT 
        AccessPoint : STRING ;   (* MAC address of the access point that is currently used.  *)
        SSID : STRING ;   (* SSID of the access point that is currently used. Set to - when we are not connected to an access point.  *)
        Channel : DINT ;   (* Currently used WLAN channel.  *)
        SignalLevel : DINT ;   (* Current signal level of the WLAN connection.  *)
        BitRate : DINT ;   (* Current WLAN bit rate.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Master_T :
    STRUCT 
        MasterLinkUp : BOOL ;   (* Vehicle is connected to master controller  *)
        MasterCom : STRING ;   (* Vehicle communication to master controller  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Vehicle_T :
    STRUCT 
        VehicleType : STRING ;   (* Vehicle type  *)
        VehicleID : DINT ;   (* Vehicle Identity in the NDC8 System. Configured in the vehicle web interface.  *)
        IndividualName : STRING ;   (* Name for this vehicle individual. Configured in the vehicle web interface. Only set when external individual parameter file is used.  *)
        OptionClass : DINT ;   (* Defines vehicle option class. Used when verifying options with the master computer.  *)
        MaxSpeed : DINT ;   (* This symbol defines the maximum speed for the vehicle defined in mm/s  *)
        SimulationMode : BOOL ;   (* Vehicle simulation mode  *)
        StopTolerance : DINT ;   (* Distance before the stop point at which the speed is set to zero  *)
        StopPointTrim : DINT ;   (* Moves the stop point to adjust for vehicle unique mechanics in the load handling. A positive value moves the stop point in the vehicles forward direction, i.e., the vehicle drives longer on a forward segment and stops earlier on a backward segment  *)
        CreepSpeed : DINT ;   (* Speed used during CreepDistance. CreepSpeed is used in the end of a drive order to be able to stop as close at the destination point as possible. Used in conjunction with StopTolerance, this will give a high stop precision  *)
        CreepDistance : DINT ;   (* The distance before the destination point where the vehicle shall drive with selected creep-speed  *)
        AccSlope : DINT ;   (* Vehicle acceleration  *)
        DecSlope : DINT ;   (* Deceleration used during normal slow down  *)
        UseDynamicDecSlope : BOOL ;   (* Deceleration slope changes dynamically during ramping down to be able
hit the target point or speed more precisely.  The value of the
Vehicle.DecSlope parameter is in this case the initial slope when
ramping down is started.

The controller can temporarily use a higher deceleration but not higher than
Vehicle.EmcyDecSlope.  Using dynamic decslope will most probably
decrease the need for a long Vehicle.CreepDistance, and also limit the
risk of overshooting the end point.  *)
        EmcyDecSlope : DINT ;   (* Emergency deceleration, used when outside safety-zone and position lost  *)
        SpeedDelayCompensation : DINT ;   (* Delay between the vehicle controller commanding a lower speed and the vehicle actually starting to slow down.  *)
        SteeringDelayCompensation : DINT ;   (* Compensation for delay in the steering control loop  *)
        Blocked : BOOL ;   (* Blocked at the end of the last segment.  *)
        CarrierType : DINT ;   (* Defines vehicle carriertype 1 to 8 (0 means any). Used in conjunction with segment carriertypes in the layout  *)
        WaitForWheelTurnMaxAngle : DINT ;   (* Maximum difference between actual (enc) wheel angle and new (set) wheel angle to make vehicle start driving. In manual and semi-manual mode this function is applied only once each time entering the mode. Hence, if writing a new value to the parameter, it will not have effect until next time entering manual or semimanual-mode.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    BlockedInfo_T :
    STRUCT 
        BlockedById : DINT ;   (* 0 = Unknown, 1 = Not blocked, 2 = Blocked by SSIO, 3 = Blocked by other Agv(s).  *)
        BlockedByText : STRING ;   (* Blocked by text.  *)
        LogicalLine : DINT ;   (* Logical SSIO line. Valid only when blocked by SSIO.  *)
        UnitNumber : DINT ;   (* Unit id in a logical line. Valid only when blocked by SSIO.  *)
        IoId : DINT ;   (* ID of input/output in unit. Valid only when blocked by SSIO.  *)
        IoType : DINT ;   (* 0 = Input, 1 = Output. Valid only when blocked by SSIO.  *)
        Status : DINT ;   (* 0 = OFF, 1 = ON, 2 = Flash 1Hz. Valid only when blocked by SSIO.  *)
        Vehicle1 : DINT ;   (* ID of blocking vehicle. Valid only when blocked by other AGV  *)
        Vehicle2 : DINT ;   (* ID of blocking vehicle. Valid only when blocked by other AGV  *)
        Vehicle3 : DINT ;   (* ID of blocking vehicle. Valid only when blocked by other AGV  *)
        Vehicle4 : DINT ;   (* ID of blocking vehicle. Valid only when blocked by other AGV  *)
        
   END_STRUCT;
END_TYPE
TYPE
    VehicleOptions_T :
    STRUCT 
        StatusID : DINT ;   (* Verfication of options. 0 = Valid, 1 = Unknown, 2 = Invalid option(s): 'number(s)'  *)
        StatusText : STRING ;   (* Status text.  *)
        MaxNoVehicles : DINT ;   (* Number of vehicles in class supported by dongle and software options KEY CODE.  *)
        MaxSpeed : DINT ;   (* Maximum travel speed limit supported by dongle and software options KEY CODE.  *)
        VehicleOptClass : DINT ;   (* Acknowledged vehicle option class by master computer.  *)
        VehicleTypeQuad : BOOL ;   (* Quad vehicle supported by dongle and software options KEY CODE.  *)
        VehicleTypeMultiWheel : BOOL ;   (* Multi vehicle supported by dongle and software options KEY CODE.  *)
        RadioComm : BOOL ;   (* Radio on serial port supported by dongle and software options KEY CODE.  *)
        NavLaser : BOOL ;   (* Navigation method Laser supported by dongle and software options KEY CODE.  *)
        NavSpot : BOOL ;   (* Navigation method Spot supported by dongle and software options KEY CODE.  *)
        NavMagnetic : BOOL ;   (* Navigation method Magnetic supported by dongle and software options KEY CODE.  *)
        NavInductive : BOOL ;   (* Navigation method Inductive supported by dongle and software options KEY CODE.  *)
        NavWall : BOOL ;   (* Navigation method Wall supported by dongle and software options KEY CODE.  *)
        ExternalPath : BOOL ;   (* Sending an external path to the vehicle supported by dongle and software options KEY CODE.  *)
        RangeAndWalls : BOOL ;   (* Sending wall data to the vehicle or to read range sensor scan data supported by dongle and software options KEY CODE.  *)
        DualCANBus : BOOL ;   (* A second CANbus supported by dongle and software options KEY CODE.  *)
        VehicleTypeMultiWheelerSD : BOOL ;   (* Multi wheeler SD supported by dongle and software options KEY CODE.  *)
        VehicleTypeMultiWheelerQuad4 : BOOL ;   (* Multi wheeler Quad for max 4 steeringwheels supported by dongle and software options KEY CODE.  *)
        VehicleTypeMultiWheelerQuad8 : BOOL ;   (* Multi wheeler Quad for max 8 steeringwheels supported by dongle and software options KEY CODE.  *)
        VehicleTypeMultiWheelerQuad16 : BOOL ;   (* Multi wheeler Quad for max 16 steeringwheels supported by dongle and software options KEY CODE.  *)
        VehicleTypeMultiWheelerQuad20 : BOOL ;   (* Multi wheeler Quad for max 20 steeringwheels supported by dongle and software options KEY CODE.  *)
        IMUSupport : BOOL ;   (* IMU supported by dongle and software options KEY CODE.  *)
        NetworkInterface : BOOL ;   (* Vehicle controller TCP/UDP interface supported by dongle and software options KEY CODE.  *)
        NavBarcode : BOOL ;   (* Navigation method Barcode supported by dongle and software options KEY CODE.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Wheel_T :
    STRUCT 
        MaxSpeed : DINT ;   (* Max speed allowed  *)
        X : DINT ;   (* Wheel position X  *)
        Y : DINT ;   (* Wheel position Y  *)
        
   END_STRUCT;
END_TYPE
TYPE
    SickScanner_T :
    STRUCT 
        RangeSensorType : DINT ;   (* Type of range sensor, 2=Sick S3000, 3=Sick S300  *)
        Connected : BOOL ;   (* True when the communication is working.  *)
        NavActive : BOOL ;   (* Use this range sensor for navigation at the moment  *)
        X : DINT ;   (* Range sensor position X  *)
        Y : DINT ;   (* Range sensor position Y  *)
        Angle : REAL ;   (* Range sensor position Angle  *)
        UpsideDown : BOOL ;   (* Indicates if the range sensor is mounted upside down.

Set to False if the range sensor is mounted right side up.
Set to True if the range sensor is mounted upside down.  *)
        Latency : DINT ;   (* Time delay between range sensor measurements and vehicle computer processing  *)
        Field1_X : DINT ;   (* Top of the field. Distance from the sensor where the field ends  *)
        Field1_Y1 : DINT ;   (* Right Y position where the field starts. This value should be less than Field1_Y2 to define a valid field.  *)
        Field1_Y2 : DINT ;   (* Left Y position where the field ends. This value should be greater than Field1_Y1 to define a valid field.  *)
        Field1_Triggered : BOOL ;   (* True if something is inside field  *)
        Field1_Dist : DINT ;   (* Distance to nearest object inside field. Valid only if Field1_Triggered is true.  *)
        Field2_X : DINT ;   (* Top of the field. Distance from the sensor where the field ends  *)
        Field2_Y1 : DINT ;   (* Right Y position where the field starts. This value should be less than Field2_Y2 to define a valid field.  *)
        Field2_Y2 : DINT ;   (* Left Y position where the field ends. This value should be greater than Field2_Y1 to define a valid field.  *)
        Field2_Triggered : BOOL ;   (* True if something is inside field  *)
        Field2_Dist : DINT ;   (* Distance to nearest object inside field. Valid only if Field2_Triggered is true.  *)
        Sector1_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector1_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector1_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        Sector2_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector2_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector2_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        Sector3_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector3_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector3_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        Sector4_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector4_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector4_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        Sector5_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector5_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector5_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        DetectDistance : DINT ;   (* Measurements more far away than this will not be used.  *)
        Attached : BOOL ;   (* When set to false the vehicle controller will not try to communicate with this sensor nor use measurement from it.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    LaserScanner_T :
    STRUCT 
        DetectDistance : DINT ;   (* Sight distance for laser scanner  *)
        X : DINT ;   (* Laser Scanner position X  *)
        Y : DINT ;   (* Laser Scanner position Y  *)
        Angle : REAL ;   (* Laser Scanner position Angle  *)
        Sector1_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector1_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector1_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        Sector2_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector2_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector2_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        Sector3_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector3_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector3_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        Sector4_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector4_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector4_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        Sector5_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector5_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector5_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        AngleMessageFormat : DINT ;   (* AngleMessageFormat
This property controls the angle message format used by the Laser Scanner and
need only to be altered for some vehicle SW configurations when need to change 
StatusFilter or when running Auto Surveyor 8 (AS8).
Value shall be 5 for normal application or if running AS8. Value shall be 2
to be able to use the StatusFilter parameter.  *)
        StatusFilter : DINT ;   (* StatusFilter
All scanner measurements are labeled with a status value (low status = good
measurement, high status = bad measurement) and this parameter can be used
to filter out measurements that have high status values before sending
measurements to the vehicle controller (the filter functionality is an internal
method of the Laser Scanner).

The value range for measurement status is 0-3 and the StatusFilter setting
has value range 0-4. StatusFilter 0=filter disabled and all measurements will
be sent, StatusFilter 1=only status 0 will be sent, StatusFilter 2=only status
0 and 1 will be sent, etc.

This setting should be used in situations when the working environment
contains a lot of unremovable false measurements, all with bad/high status.
Please, consider expert consulting and analysis of AS8 logs before setting new
value on StatusFilter.

The AngleMessageFormat parameter must be set to 2, to make any StatusFilter 
setting effectuated.  *)
        StatusEventEnable : BOOL ;   (* If this property is set, system event 217 will be sent when the laser scanner status changes  *)
        Attached : BOOL ;   (* When set to false the vehicle controller will not try to communicate with this sensor nor use measurement from it.  *)
        NavActive : BOOL ;   (* Use this sensor for navigation at the moment.  *)
        MaxDistanceDev : DINT ;   (* Max allowed deviation in distance when associating laserscanner measurements with known reflectors.
Note! This parameter shall not be set below 1000 mm for other reasons than for test purposes.  *)
        ScannerTimeout : DINT ;   (* Time before laser scanner stops rotating when vehicle is standing still  *)
        
   END_STRUCT;
END_TYPE
TYPE
    LS2000Scanner_T :
    STRUCT 
        DetectDistance : DINT ;   (* Sight distance for laser scanner  *)
        Sensitivity : DINT ;   (* Detection sensitivity level. High sensitivity give more detections but also potentially increases number of false. 
Low sensitivity eliminates a lot of false detecions but also removes potentially real (good) detections.  *)
        ReflectorShadow : DINT ;   (* Defines the length (in mm) of a reflector shadow - the area
immediately following a detected reflector where the LS2000
ignores any new reflectors.  The recommended value for this
parameter is 0.

Note: This parameter is incompatible with the UpsideDown
parameter.  *)
        X : DINT ;   (* Laser Scanner position X  *)
        Y : DINT ;   (* Laser Scanner position Y  *)
        Angle : REAL ;   (* Laser Scanner position Angle  *)
        UpsideDown : BOOL ;   (* Indicates if the range sensor is mounted upside down.

Set to False if the range sensor is mounted right side up.
Set to True if the range sensor is mounted upside down.  *)
        IP : STRING ;   (* The IP address used to connect to the scanner.  *)
        Field1_X1 : DINT ;   (* Bottom X position in vehicle coordinate where the field starts. This value should be less than Field1_X2 to define a valid field.  *)
        Field1_X2 : DINT ;   (* Top X position in vehicle coordinate where the field ends. This value should be greater than Field1_X1 to define a valid field.  *)
        Field1_Y1 : DINT ;   (* Right Y position in vehicle coordinate where the field starts. This value should be less than Field1_Y2 to define a valid field.  *)
        Field1_Y2 : DINT ;   (* Left Y position in vehicle coordinate where the field ends. This value should be greater than Field1_Y1 to define a valid field.  *)
        Field1_Triggered : BOOL ;   (* True if something is inside field  *)
        Field1_Dist : DINT ;   (* Distance from sensor to nearest object inside field. Valid only if Field1_Triggered is true.  *)
        Field2_X1 : DINT ;   (* Bottom X position in vehicle coordinate where the field starts. This value should be less than Field2_X2 to define a valid field.  *)
        Field2_X2 : DINT ;   (* Top X position in vehicle coordinate where the field ends. This value should be greater than Field2_X1 to define a valid field.  *)
        Field2_Y1 : DINT ;   (* Right Y position in vehicle coordinate where the field starts. This value should be less than Field2_Y2 to define a valid field.  *)
        Field2_Y2 : DINT ;   (* Left Y position in vehicle coordinate where the field ends. This value should be greater than Field1_Y1 to define a valid field.  *)
        Field2_Triggered : BOOL ;   (* True if something is inside field  *)
        Field2_Dist : DINT ;   (* Distance from sensor to nearest object inside field. Valid only if Field2_Triggered is true.  *)
        Sector1_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector1_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector1_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        Sector2_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector2_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector2_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        Sector3_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector3_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector3_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        Sector4_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector4_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector4_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        Sector5_Ignore : BOOL ;   (* If enabled bearings within sector will be ignored.  *)
        Sector5_Heading : DINT ;   (* Heading of sector. Measured from the symmetry axis of the vehicle to the center of the sector.  *)
        Sector5_Size : DINT ;   (* Size of sector. The ignored sector is from Heading - Size/2 to Heading + Size/2.  *)
        ReflectorType : DINT ;   (* 0:Flat reflector, 1:Cylindrical reflector.  *)
        Connected : BOOL ;   (* True when the communication with LS2000 is working.  *)
        NavActive : BOOL ;   (* Use this sensor for navigation at the moment  *)
        Attached : BOOL ;   (* When set to false the vehicle controller will not try to communicate with this sensor nor use measurement from it.  *)
        MaxDistanceDev : DINT ;   (* Max allowed deviation in distance when associating laserscanner measurements with known reflectors.  *)
        TraceRawMeasurements : BOOL ;   (* Write raw measurements from LS2000 to a binary file that is include in the blackbox.  *)
        Temperature : DINT ;   (* The temperature reported by the LS2000, updated every 2 seconds when LS2000 is used. This value is only valid when Connected=1.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    SpotAntenna_T :
    STRUCT 
        X : DINT ;   (* Antenna position X  *)
        Y : DINT ;   (* Antenna position Y  *)
        Angle : REAL ;   (* Antenna position Angle  *)
        IgnoreUnknown : BOOL ;   (* If enabled, unknown spot will not cause navigation error.  *)
        MeasurementX : DINT ;   (* X-coordinate of last detected spot  *)
        MeasurementY : DINT ;   (* Y-coordinate of last detected spot  *)
        SpotId : DINT ;   (* Identity of last detected spot. O means unknown spot  *)
        ResidualX : DINT ;   (* X-coordinate residual of last detected spot in vehicle coordinate system. Only valid if SpotId is non-zero.  *)
        ResidualY : DINT ;   (* Y-coordinate residual of last detected spot in vehicle coordinate system. Only valid if SpotId is non-zero.  *)
        Connection : STRING ;   (* Name of the device the antenna is connected to and slot. Example: SDIO_1.Spot1.  *)
        NavActive : BOOL ;   (* If enabled the antenna will be used for navigation.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    MagneticAntenna_T :
    STRUCT 
        X : DINT ;   (* Antenna position X  *)
        Y : DINT ;   (* Antenna position Y  *)
        Angle : REAL ;   (* Antenna position Angle  *)
        OffsetInput : STRING ;   (* Analog input used for the antennas offset signal. Example: SDIO_1.AnalogInput1  *)
        ValidInput : STRING ;   (* Digital input slot used for the antennas valid signal. Example: SDIO_1.DigitalInput1.  *)
        IgnoreUnknown : BOOL ;   (* If enabled, unknown wire will not cause navigation error.  *)
        IgnoreMissing : BOOL ;   (* If enabled, missed wire will not cause navigation error.  *)
        NavActive : BOOL ;   (* If enabled the antenna will be used for navigation. Does not effect semi manual guidance.  *)
        SemiManual_ProportionalPart : REAL ;   (* P part of the PID controller  *)
        SemiManual_IntegratingPart : REAL ;   (* I part of the PID controller.  *)
        SemiManual_DerivativePart : REAL ;   (* D part of the PID controller.  *)
        SemiManual_IntegratingLimit : REAL ;   (* Limit for I part.  *)
        WireId : DINT ;   (* Identity of wire.  *)
        StatusID : DINT ;   (* 0 = no wire signal, 1 = good wire, 2 = missing wire signal, 3 = bad wire angle, 4 = multiple wires, 5 = unknown wire, 6 = antenna disabled.  *)
        StatusText : STRING ;   (* Status text  *)
        
   END_STRUCT;
END_TYPE
TYPE
    InductiveAntenna_T :
    STRUCT 
        X : DINT ;   (* Antenna position X  *)
        Y : DINT ;   (* Antenna position Y  *)
        Angle : REAL ;   (* Antenna position Angle  *)
        OffsetRef : STRING ;   (* Symbolic name for offset.  *)
        AngleRef : STRING ;   (* Symbolic name for angle.  *)
        FreqIndexRef : STRING ;   (* Symbolic name for frequency index.  *)
        SignalRef : STRING ;   (* Symbolic name for signal.  *)
        OverloadRef : STRING ;   (* Symbolic name for overload.  *)
        IgnoreUnknown : BOOL ;   (* If enabled, unknown wire will not cause navigation error.  *)
        IgnoreMissing : BOOL ;   (* If enabled, missed wire will not cause navigation error.  *)
        NavActive : BOOL ;   (* If enabled the antenna will be used for navigation. Does not effect semi manual guidance.  *)
        SemiManual_ProportionalPart : REAL ;   (* P part of the PID controller  *)
        SemiManual_IntegratingPart : REAL ;   (* I part of the PID controller.  *)
        SemiManual_DerivativePart : REAL ;   (* D part of the PID controller.  *)
        SemiManual_IntegratingLimit : REAL ;   (* Limit for I part.  *)
        WireId : DINT ;   (* Identity of wire.  *)
        WireFrequency : STRING ;   (* Frequency of wire.  *)
        StatusID : DINT ;   (* 0 = no wire signal, 1 = good wire, 2 = missing wire signal, 3 = bad wire angle, 4 = multiple wires, 5 = unknown wire, 6 = antenna disabled.  *)
        StatusText : STRING ;   (* Status text  *)
        
   END_STRUCT;
END_TYPE
TYPE
    DigitalSensor_T :
    STRUCT 
        X : DINT ;   (* Sensor position X  *)
        Y : DINT ;   (* Sensor position Y  *)
        TrimDistance : DINT ;   (* Distance between sensor at the time of an edge and centre of the target.  *)
        Delay : DINT ;   (* Compensation for delay in sensor.  *)
        DigitalInputEdge : STRING ;   (* Timestamped edge of digital signal provided by sdio. Example: SDIO_1.RisingEdge1 or SDIO_1.FallingEdge1  *)
        DigitalInput : STRING ;   (* Digital Input that uses the timestamped edge provided by sdio.  *)
        StatusID : DINT ;   (* 0 = no signal, 1 = good distance marker, 2 = missing signal, 3 = unknown distance marker, 4 = not moving  *)
        StatusText : STRING ;   (* Status text  *)
        NavActive : BOOL ;   (* Use this digital sensor for navigation at the moment. A reason
to set NavActive to false is if there are situations when the
digital sensor do not give a good distance update. For example,
when not passing over the distance marker in the normal direction,
when driving off-wire, or when the magnetic- or wire-antennas are
not enabled.  *)
        IgnoreUnknown : BOOL ;   (* If enabled, unknown distance marker will not cause navigation error.  *)
        IgnoreMissing : BOOL ;   (* If enabled, missed distance marker will not cause navigation error.  *)
        DistanceMarkerId : DINT ;   (* Identity of distance marker.  *)
        MeasurementX : DINT ;   (* When Status = 1, x-coordinate of last detected distance marker, when Status = 2, x-coordinate where distance marker was excpected.  *)
        MeasurementY : DINT ;   (* When Status = 1, y-coordinate of last detected distance marker, when Status = 2, y-coordinate where distance marker was excpected.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    InertialSensor_T :
    STRUCT 
        Axis : STRING ;   (* The axis in the IMU that gives the angular rate for vehicle.  *)
        NavActive : BOOL ;   (* Use the angular rate from the IMU when calculating the position of the vehicle.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    SDIOInertialSensor_T :
    STRUCT 
        IMUAxis : STRING ;   (* The axis in the IMU that gives the angular rate for vehicle.  *)
        IMUNavActive : BOOL ;   (* Use the angular rate from the IMU when calculating the position of the vehicle.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    BarcodeSensor_T :
    STRUCT 
        X : DINT ;   (* Sensor position X  *)
        Y : DINT ;   (* Sensor position Y  *)
        Angle : REAL ;   (* Sensor position Angle  *)
        ResidualX : DINT ;   (* X-coordinate residual of last detected barcode in vehicle coordinate system.
The residual is the difference between expected and actual barcode position.  *)
        ResidualY : DINT ;   (* Y-coordinate residual of last detected barcode in vehicle coordinate system.
The residual is the difference between expected and actual barcode position.  *)
        ResidualAngle : DINT ;   (* Angle residual of last detected barcode.
The residual is the difference between expected and actual barcode angle.  *)
        IgnoreMissing : BOOL ;   (* If enabled, missed position marker will not cause navigation error.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    ReflectorInit_T :
    STRUCT 
        MaxBearingDev : DINT ;   (* Max allowed deviation in bearing when associating laserscanner measurements with reflectors.  *)
        CheckAmbigousPosition : BOOL ;   (* Check if more than one position makes it possible to associate enough bearings. Will increase time needed to do reflectorinit.  *)
        AllowAmbigousPosition : BOOL ;   (* Use the best position if there are more than one acceptable positions. If disabled the init process will fail when there is more than one possible solution. Has only effect if CheckAmbigousPosition is set  *)
        WriteToFile : BOOL ;   (* Enable logging of input to and output from the reflector init process. The files will be included in the blackbox.  *)
        StatusID : DINT ;   (* 0 = position found, 1 = too few angles, 2 = bad spread of angles,  3 = too many false angles (failed to associate angles with known reflectors within specified area), 4 = ambiguous position (alias point), 5 = aborted, 7 = vehicle is moving  *)
        StatusText : STRING ;   (* Status text  *)
        
   END_STRUCT;
END_TYPE
TYPE
    WallNavigator_T :
    STRUCT 
        MissingWeight : DINT ;   (* Adjustment of navigation level when no range measurements could be associated to the navigation walls in the layout, although the walls should be within sight for the sensor.  *)
        GoodWeight : DINT ;   (* Adjustment of adjustment navigation level when some range measurements can be associated to one or more navigation walls in the layout.  *)
        NoWeight : DINT ;   (* Adjustment of navigation level when no navigation walls are in sight for the sensor.  *)
        GoodDistance : DINT ;   (* Acceptance window when associating range measurements to navigation walls. Only range measurements who lies at a distance less than GoodDistance from a navigation wall are considered to be observation of the wall.  *)
        GoodNumber : DINT ;   (* Lower limit on number of associated range measurement. Only of the number of associated range measurements to a navigation wall, in a single range scan, is equal or greater than GoodNumber it will be used for correction the vehicles position.  *)
        GoodAngleDev : DINT ;   (* Maximal angle deviation between navigation wall and measured wall. The direction of the measured wall is based on the regression line of associated range measurements. Only if the angle deviation is equal to or less than GoodAngleDev the associated range measurements will be used to update the vehicles position.  *)
        TraceUsedWall : BOOL ;   (* Enable logging to blackbox of walls used for navigation  *)
        VarRange : REAL ;   (* Modeled variance in for measured range.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    NaturalNavigator_T :
    STRUCT 
        MatchRatio : DINT ;   (* Ratio between points matched to map and total number of points in range scan.  *)
        LowMatchRatio : DINT ;   (* Limit for acceptable match ratio value. Nav lost if lower.  *)
        HighMatchRatio : DINT ;   (* Max navigation level if match ratio is higher than this. Note that for a Navigation Init to be valid, the match ratio value must be equal or higher than this limit.  *)
        Reliability : DINT ;   (* Quality of range scan as a position observation.  *)
        LowReliability : DINT ;   (* Low limit for acceptable reliability value. Navigation lost if lower.  *)
        HighReliability : DINT ;   (* High limit for reliability value. If reliability value is higher than this it will not reduce the navigation level.  *)
        CorrectionXLimit : DINT ;   (* If VehicleNavigator.CorrectionX is higher than this, navigation is lost. Navlevel starts to decrease at half of this limit.  *)
        CorrectionYLimit : DINT ;   (* If VehicleNavigator.CorrectionY is higher than this, navigation is lost. Navlevel starts to decrease at half of this limit.  *)
        CorrectionAngleLimit : DINT ;   (* If VehicleNavigator.CorrectionAngle is higher than this, navigation is lost. Navlevel starts to decrease at half of this limit.  *)
        PointThreshold : REAL ;   (* Match point if the Mahalanobi distance is less than this.  *)
        VarScan : REAL ;   (* Models uncertainty in range measurement versus dead reckoning.  *)
        SensorTimeout : DINT ;   (* Sets navigation level to 0 if no new measurements are received from the sensor within this time limit.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    LaserNavigator_T :
    STRUCT 
        RefStatValid : BOOL ;   (* Reflector statistics file is valid  *)
        GoodLimit : DINT ;   (* Acceptance window for bearing association.  *)
        NoGoodLimit : DINT ;   (* NoGood window in bearing association.  *)
        FalseWeight : DINT ;   (* Adjustment of association level for False bearings.  *)
        GoodWeight : DINT ;   (* Adjustment of association level for Good bearings.  *)
        NoWeight : DINT ;   (* Adjustment of association level for no bearings.  *)
        NoGoodWeight : DINT ;   (* Adjustment of association level for bearings in NoGood window.  *)
        DoubleReflectorWeight : DINT ;   (* Adjustment of association level for bearings that can be associated to two reflectors.  *)
        DoubleAngleWeight : DINT ;   (* Adjustment of association level when two bearings are associated to the same reflector.  *)
        BadStatusWeight : DINT ;   (* Adjustment of association level for false bearings with bad status  *)
        FalseReflEvent : BOOL ;   (* Enable flag for false reflection and false reflector events (system event 146 and 147).  *)
        IgnoreFalseReflEvent : BOOL ;   (* Enable flag for ignore false reflector event (system event 148).  *)
        DoubleReflEvent : BOOL ;   (* Enable flag for double reflector event (system event 188).  *)
        SameReflMaxDist : DINT ;   (* Max distance between calculated positions of false reflectors for which they will be considered as the same reflector.  *)
        MaxEventTimeSilence : DINT ;   (* Time before an event for the same reflector will be sent again.  *)
        MaxEventDistSilence : DINT ;   (* Max distance that the vehicle will travel before an event for the same reflector will be sent again.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    SpotNavigator_T :
    STRUCT 
        MaxSpotDistance : DINT ;   (* Max travelled distance without detecting a spot.  *)
        GoodSpotWindow : DINT ;   (* Acceptance window for observed spots.  *)
        MaxInitDistance : DINT ;   (* Max travelled distance without detecting two spots after init.  *)
        VarAntOffset : REAL ;   (* Variance in measured antenna offset  *)
        VarAntTime : REAL ;   (* Variance in measured detectiontime  *)
        StatusID : DINT ;   (* 0 = no error, 1 = Distance between spot too long, 2 = false spot detected, 3 = Moved too far without detecting first two spot, 4 = same spot detected twice, 5 = no spot init done  *)
        StatusText : STRING ;   (* Status text  *)
        MaxDetectTime : DINT ;   (* Upper limit for time between positive and negative flank on the detect signal.  *)
        MinDetectVelocity : DINT ;   (* Lower limit for speed during spot detection.  *)
        MinDetectDistance : DINT ;   (* Lower limit for the distance that the antenna moves between positive and negative flank.  *)
        MaxSpeedChange : DINT ;   (* Upper limit for change of speed as the antenna moves between positive and negative flank.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    WireNavigator_T :
    STRUCT 
        NoWireDistance : DINT ;   (* Max travelled distance without sensing a wire. This sets a limit on how far the vehicle can move off-wire and still report position known. Typically this will have effect when driving in automatic mode and negotiating a curve off-wire or when manually driving the vehicle off the wire.  *)
        MissingWireDistance : DINT ;   (* Max travelled distance without sensing an expected wire. The distance is measured from the point where the layout position of a wire for the first time is inside the expect window for the antenna. The expect window is defined by ExpectX and ExpectY around the estimated global position of the antenna. Once the vehicle has moved more then MissingWireDistance without the antenna sensing the wire it will report navigation error (missed wire). This value should be larger than ExpectX plus a margin for position error.  *)
        DetectCrossingWireSpeed : DINT ;   (* When the antenna is crossing a wire at this speed or slower, detection of the wire is required and a missed detection will stop the vehicle. If the antenna is crossing the wire at a higher speed then missed detection is allowed.  *)
        GoodX : DINT ;   (* Acceptance (good) window in antenna direction for wire. The acceptance window is defined by GoodX and GoodY around the estimated global position of the antenna. When the antenna is sensing a wire and there is a defined navigation wire in the layout, or part of it, that lies within the acceptance window then the antenna reading is used to update the vehicles position. If the antenna is sensing a wire but there is no wire defined in the layout inside the acceptance window then the vehicle will report navigation error (unknown wire).  *)
        GoodY : DINT ;   (* Sideway acceptance (good) window. The acceptance window is defined by GoodX and GoodY around the estimated global position of the antenna. When the antenna is sensing a wire and there is a defined navigation wire in the layout, or part of it, that lies within the acceptance window then the antenna reading is used to update the vehicles position. If the antenna is sensing a wire but there is no wire defined in the layout inside the acceptance window then the vehicle will report navigation error (unknown wire).  *)
        GoodAngle : DINT ;   (* Upper limit for deviation between orientation of wire and antenna. Used to decide wether to use the antenna reading or to discard it. The orientation of the antenna is compared with the tangent of associated wire in the layout.  *)
        ExpectX : DINT ;   (* Size of expect window in antenna-direction for wire. The expect window is defined by ExpectX and ExpectY around the estimated global position of the antenna in the shape of a rectangle with size 2*ExpectX times 2*ExpectY. The expect window is used to decide which wires that should be seen. This is done by picking out wires in the layout that lies within the window.  *)
        ExpectY : DINT ;   (* Sideway expect window size for wire. The expect window is defined by ExpectX and ExpectY around the estimated global position of the antenna in the shape of a rectangle with size 2*ExpectX times 2*ExpectY. The expect window is used to decide which wires that should be seen. This is done by picking out wires in the layout that lies within the window.  *)
        VarAntOffset : REAL ;   (* Variance in measured antenna offset  *)
        MaxAntennaChange : DINT ;   (* The wire navigator only uses antenna readings that differ less than MaxAntennaChange compared to previous reading. This is used to filter out spurious measurements as the antenna enters or leaves the wire.  *)
        AllowMultipleWires : BOOL ;   (* With this enabled the wire navigator will use measurements from the antenna even if two or more navigation wires are within the Good window around the antenna. The measurement will be used with less weight by assuming it is an observation of the nearest navigation wire.  *)
        StatusID : DINT ;   (* Status identifier. 0 = no error, 1 = unknown wire, 2 = no wire, 3 = missed wire, 4 = unknown distance marker, 5 = missed distance marker, 6 = no init  *)
        StatusText : STRING ;   (* Status text  *)
        
   END_STRUCT;
END_TYPE
TYPE
    DistanceMarker_T :
    STRUCT 
        MissingMarkerDistance : DINT ;   (* Max travelled distance without sensing an expected distance marker. The distance is measured from the point where the layout position of a distance marker for the first time is inside the expect window for the digital sensor. The expect window is defined by ExpectMarkerWindow around the estimated path for the sensor. Once the vehicle has moved more than MissingMarkerDistance without sensing the distance marker it will report navigation error (missed distance marker). This value should be larger than ExpectMarkerWindow plus a margin for position error.  *)
        GoodMarkerWindow : DINT ;   (* Acceptance window size for good distance marker. The acceptance window is defined by GoodMarkerWindow around the estimated global position a distance marker detection. The acceptance window is used when a distance marker has been detected by a digital sensor. If there is a defined distance marker in the layout that lies within the acceptance window then the observation is used to update the vehicles position. Otherwise the vehicle will report navigation error (unknown marker).  *)
        ExpectMarkerWindow : DINT ;   (* Window size for when to expect distance marker. The expect window is defined by ExpectMarkerWindow around the estimated path for the sensor. The expect window is used to decide which distance markers that should be seen. This is done by picking out the distance markers in the layout who lies within a range less than ExpectMarkerWindow from the estimated path for the digital sensor. The ExpectMarkerWindow should be less than MissingMarkerDistance.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    BarcodeNavigator_T :
    STRUCT 
        MaxMarkerDistance : DINT ;   (* Max travelled distance without detecting a position marker.  *)
        VarPosition : REAL ;   (* Modeled uncertainty of marker measurement in position.  *)
        GoodDistance : DINT ;   (* Acceptance window for the distance between measured and expected position (x, y) of a marker (i.e. upper acceptance limit for BarcodeSensor/ResidualX and ResidualY).  *)
        GoodAngle : DINT ;   (* Acceptance window for the difference between measured and expected angle of a marker (i.e. upper acceptance limit for BarcodeSensor/ResidualAngle).  *)
        
   END_STRUCT;
END_TYPE
TYPE
    VehicleNavigator_T :
    STRUCT 
        NavMethod : DINT ;   (* Current navigation method, 1 = reflector, 2 = spot, 4 = wire, 5 = wall, 7 = natural, 8 = barcode  *)
        NavMethodText : STRING ;   (* Current navigation method.  *)
        StartupNavMethod : DINT ;   (* Vehicle navigation method at startup. 1 = reflector, 2 = spot, 4 = wire, 5 = wall, 7 = natural, 8 = barcode  *)
        SetNavMethod : DINT ;   (* Set navigation method, 1 = reflector, 2 = spot, 4 = wire, 5 = wall, 7 = natural, 8 = barcode  *)
        SetNavMethodEN : BOOL ;   (* Set this to request current navigation method to change to SetNavMethod. Clear when SetNavMethodENO is cleared.  *)
        SetNavMethodENO : BOOL ;   (* Set by background program when SetNavModeError is properly set. Cleared when SetNavMethodEN is cleared.  *)
        SetNavMethodErr : DINT ;   (* 0 = no error, 1 = not supported by vehicle application.  *)
        SetNavMethodErrText : STRING ;   (* Error text.  *)
        IgnoreAbnormalEncVal : BOOL ;   (* When enabled a single sample with abnormal encoder values will not cause position unknown. Instead previous encoder values are used to update position.  *)
        TraceMeasurements : BOOL ;   (* Enable logging of incoming measurements. The files will be included in the blackbox.  *)
        RangeLogInhibit : DINT ;   (* Minimal time between range scan sent to black box file and service tool. Only read on startup of vehicle controller.  *)
        NavLevelEventLimit : DINT ;   (* A system event will be sent if Position.NavLevel goes below NavLevelEventLimit when the vehicle is in Automatic mode. Set to 0 to disable.  *)
        SleepTime : DINT ;   (* No position updates from sensor data when the vehicle has been standing still this time or longer. If SleepTime is set to -1 then the position will always be updated.  *)
        CorrectionX : DINT ;   (* Accumulated correction in vehicle local coordinates, with 5 s exponential decay.  *)
        CorrectionY : DINT ;   (* Accumulated correction in vehicle local coordinates, with 5 s exponential decay.  *)
        CorrectionAngle : DINT ;   (* Accumulated correction in vehicle local coordinates, with 5 s exponential decay.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    NavInit_T :
    STRUCT 
        Method : DINT ;   (* Navigation init methods:
0. NavAreaInit. The vehicle controller will search for a
   position within the given navigation area. If navigation area is
   set to 0 the vehicle controller will search the whole layout. Only
   supported by laser (reflector) navigation and natural navigation.

1. PointInit. The vehicle controller will search for a position in an
   area around the given NDC point. The size of the search area is
   defined by PointSearchLimit and PointAngleSearchLimit. Only
   supported by laser (reflector) navigation and natural navigation.

2. SetPosition. The vehicle controller will set its position to that
   of the given NDC point. The vehicle must be in manual or semi manual 
   mode and standing still.
    
3. CoordinatesInit. The vehicle controller will search for a position
   in an area around the given coordinates. The size of the search
   area is defined by PointSearchLimit and PointAngleSearchLimit. Only
   supported by laser (reflector) navigation and natural navigation.

4. SetCoordinates. The vehicle controller will set its position to
   that of the given given coordinates. The vehicle must be in manual
   or semi manual mode and standing still.  *)
        Target : DINT ;   (* Target is point id in case of PointInit or SetPosition methods. For
NavAreaInit it is the area id. Not used for other init methods.  *)
        TargetX : DINT ;   (* Target X coordinate, only used if init method is SetCoordinates or CoordinatesInit  *)
        TargetY : DINT ;   (* Target Y coordinate, only used if init method is SetCoordinates or CoordinatesInit  *)
        TargetAngle : DINT ;   (* Target Angle coordinate in cdeg, only used in case of SetCoordinates or CoordinatesInit  *)
        RequestEN : BOOL ;   (* Input valid  *)
        RequestENO : BOOL ;   (* Output valid  *)
        Error : DINT ;   (* Error codes
0 = Navigation initialization succeeded.
1 = Unknown method.
3 = Target does not exist.
4 = Not supported.
5 = Not in manual mode or semi manual.
6 = Too few reflector bearings.
7 = Bad distribution of bearings.
8 = Reflector init failed in current search area.
9 = Ambiguous position. More than one valid position found in current search
    area.
10 = Init calculation aborted.
11 = Vehicle is moving.
12 = Position outside search area.
15 = No range measurements.
16 = Bad range match.
17 = Empty init area.
18 = Multi oriented point.
19 = Unknown position marker.
20 = No position marker measurements.  *)
        PointSearchLimit : DINT ;   (* Max distance from the target point in PointInit and CoordinatesInit.
If no position is found within the limits, the vehicle will redo the init-process until it finds one.  *)
        PointSearchAngleLimit : DINT ;   (* Maximum angular deviation allowed from the target point in PointInit
and CoordinatesInit. If no position is found within the limits, the
vehicle will redo the init-process until it finds one.  *)
        LostSearchLimit : DINT ;   (* Max distance from old position when doing init after navigation
lost. If no position is found within the distance, the vehicle will
redo the init-process until it finds one.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Position_T :
    STRUCT 
        X : DINT ;   (* Vehicle position X  *)
        Y : DINT ;   (* Vehicle position Y  *)
        Angle : DINT ;   (* Vehicle position angle  *)
        Angle2 : DINT ;   (* Vehicle position angle  *)
        NavLevel : DINT ;   (* Navigation quality in percent. 0 = lost, 100 = superb  *)
        Valid : BOOL ;   (* Valid signal (property values are valid)  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Guidance_T :
    STRUCT 
        SafetyZoneX : DINT ;   (* This parameter defines the safety zone for the segment end-points. The value is defined in mm.  *)
        SafetyZoneY : DINT ;   (* This parameter defines the safety zone on the sides of the segment. The value is defined in mm.  *)
        SafetyZoneTh : DINT ;   (* This parameter defines the safety zone for the vehicle angle deviation from the segment. The value is defined in degrees.  *)
        OutsideSafetyZone : BOOL ;   (* The vehicle is outside the Safety Zone  *)
        LateralWeight : REAL ;   (* Weight for lateral error in the cost function used to compute control gains for path following.  A higher value will reduce lateral errors faster but makes the steering less smoth.  *)
        IntegralWeight : REAL ;   (* Weight for integrated lateral error in the cost function used to compute control gains for path following.  A higher value will reduce lateral errors faster but makes the steering less smoth.  *)
        HeadingWeight : REAL ;   (* Weight for heading error in the cost function used to compute control gains for path following. A higher value will reduce heading errors faster but makes the steering less smoth.  *)
        IntegralLimit : REAL ;   (* The integrated lateral error will be limited by this value when used in the guidance control loop.  *)
        UsePredictedPosition : BOOL ;   (* Use a predicted position to guide the vehicle. The predicted position is computed using the vehicles current velocity and the time Vehicle.SteeringDelayCompensation.  *)
        CurvatureLimitsControl : BOOL ;   (* When enabled the guidance feedback control is limited in such a way that the sum of feedforward part due to curvature and the control part neved exceed 90 degrees for a wheel on the symmetry axis. This will reduce the risk of unstable steering in cases of large guidance errors in sharp curves.  *)
        DisableDiffMode : BOOL ;   (* Use 2XSD steer mode also on diff segment. This require that the wheels are able to turn more than +90/-90 degree.  *)
        TransitionRotationTrim : REAL ;   (* Parameter to fine-tune vehicle rotation on transition and crab segment. A non-zero value will add a rotation feedforward term in the guidance control. Typically values are between -0.1 and 0.1.  *)
        LoopTime : DINT ;   (* Time between updates of setvalues.  *)
        StatusTrigDistance : DINT ;   (* When the vehicle has this distance left to drive a guide status (and also a nav status) is trigged and sent to host and application (PLC). 0 (default) means the function is disabled  *)
        DevPosValid : BOOL ;   (* True when the vehicle is not moving and the Guidance.DevX, Guidance.DevY and Guidance.DevAngle are updated for the current position.  *)
        DevX : DINT ;   (* Distance to end point on current command, positive value if beyond point.  *)
        DevY : DINT ;   (* The vehicle y deviation from the segment.  *)
        DevAngle : DINT ;   (* The vehicle angle deviation from the segment.  *)
        DistanceToStop : DINT ;   (* Distance to drive until the vehicle has to stop. The reason for the stop is indicated in the StopReason property. Valid when the vehicle is in Automatic mode.  *)
        StopReason : DINT ;   (* Reason for stop. Valid when the vehicle is in Automatic mode. 
0 = Vehicle will stop because it has not received any more drive commands
1 = Vehicle will stop and change travel direction
2 = Vehicle will stop and change steer mode
3 = Vehicle must stop and turn the wheels before continuing to drive
4 = Vehicle will stop before or after a rotation
5 = Vehicle will stop at a z-segment  *)
        
   END_STRUCT;
END_TYPE
TYPE
    TurnSignal_T :
    STRUCT 
        CurvatureLimit : DINT ;   (* The minimum curvature regarded as start of turn. The curvature value is defined as 1 / (turn radius in km). For an SD vehicle the relation between steer angle and curvature is: curvature = tan (steer angle) / wheel base.  *)
        RightTurn : BOOL ;   (* True if a RightTurnDistance value is available, or if the vehicle is currently turning.  *)
        RightTurnDistance : DINT ;   (* The distance to the next upcoming right turn, will be set to 0 when the vehicle is in the turn. Only valid if RightTurn is true.  *)
        RightTurnCurvature : DINT ;   (* The curvature of an upcoming turn, value defined as 1 / (turn radius in km). The presented curvature is the max curvature for the complete turn.  *)
        LeftTurn : BOOL ;   (* True if a LeftTurnDistance value is available, or if the vehicle is currently turning.  *)
        LeftTurnDistance : DINT ;   (* The distance to the next upcoming left turn, will be set to 0 when the vehicle is in the turn. Only valid if LeftTurn is true.  *)
        LeftTurnCurvature : DINT ;   (* The curvature of an upcoming turn, value defined as 1 / (turn radius in km). The presented curvature is the max curvature for the complete turn.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    VehicleApplication_T :
    STRUCT 
        Name : STRING ;   (* Vehicle application name  *)
        ModificationDate : STRING ;   (* Date when last edit  *)
        ModificationTime : STRING ;   (* Time when last edit  *)
        CompilationID : STRING ;   (* Generated at last export  *)
        TimeStamp : DINT ;   (* Time stamp  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Layout_T :
    STRUCT 
        LayoutName : STRING ;   (* Name of Layout  *)
        SystemName : STRING ;   (* Name of System  *)
        ModificationDate : STRING ;   (* Date when last edit  *)
        ModificationTime : STRING ;   (* Time when last edit  *)
        FileRevision : DINT ;   (* Winlay revision number  *)
        NewLayoutAvailable : BOOL ;   (* Indicates that a new layout has been downloaded to the vehicle.  *)
        ReloadNewLayout : BOOL ;   (* When set to true and a new layout is available, the vehicle controller
will load the new layout when the vehicle is standing still. This
parameter allows the PLC to control when the reload will happen.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Autoinsert_T :
    STRUCT 
        Speed : DINT ;   (* Autoinsert speed. This speed is used during the whole autoinsert  *)
        AllowBackwards : BOOL ;   (* Allows the vehicle to autoinsert backwards  *)
        SearchAngleLimit : DINT ;   (* From vehicle, the maximum angle where to search for a point to autoinsert to  *)
        SearchDistance : DINT ;   (* The maximum distance from the vehicle where to search for a point to autoinsert to  *)
        PointAngleLimit : DINT ;   (* Maximum angle deviation to consider the vehicle to be on point or segment. If this value exceeds 0.75*Guidance.SafetyZoneTh then 0.75*Guidance.SafetyZoneY will be used instead.  *)
        PointTolerance : DINT ;   (* The maximum distance to a point/segment to consider the vehicle to be on that point/segment. If this value exceeds 0.75*Guidance.SafetyZoneY then 0.75*Guidance.SafetyZoneY will be used instead.  *)
        PointInsertInhibit : BOOL ;   (* PointInsertInhibit
This flag has only effect if none of the segments leading into a potential
insert point are autoinsert segments. If so, and an insert point is found when
the flag is set, the vehicle will not insert to the point, and not to any 
other point in the layout. The insert is aborted and the vehicle will remain
"not in system"  *)
        OnSegment : BOOL ;   (* Is set if the vehicle is inside the safetyzone, during an autoinsert. When OnSegment, the user can release the override button on the MCD  *)
        Target : DINT ;   (* The point the vehicle is inserting to.  *)
        QuickEnable : BOOL ;   (* Allows new orders to execute as soon as the vehicle is on segment during an autoinsert. Also make vehicle use the layout speed instead of autoinsert speed when on segment. If this flag is set, when an autoinsert is running, a new order will be accepted and the vehicle will immediately drive to the destination without stopping on the aimed autoinsert point. Requires a NDC8 2.4 compatible Master.  *)
        StatusID : DINT ;   (* Autoinsert states:
0 = Idle. Enters this state when switched to manual mode. Leaves the state when switched to auto or semi-automatic mode.
1 = Searching. Searching for a point or segment to insert to.
2 = InProgressForward. Autoinserting in forward direction. Need a positive manual speed as long as not on segment.
3 = InProgressBackward. Autoinserting in backward direction. Need a negative manual speed as long as not on segment.
4 = Finished. The vehicle is in system. Will keep this state until switched to manual mode.
5 = Failed. The autoinsert failed. Will keep this state until switched to manual mode.  *)
        StatusText : STRING ;   (* Autoinsert state text. See StatusID.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    GenericDisplay_T :
    STRUCT 
        VehicleStatusID : DINT ;   (* Background choosen id of current vehicle status  *)
        VehicleStatusInlineValue : DINT ;   (* The value that the Background can insert into the vehicle status string  *)
        PlcVehicleStatusID : DINT ;   (* Plc choosen id of current vehicle status  *)
        PlcVehicleStatusInlineValue : DINT ;   (* The value that the PLC optionally can insert into the vehicle status string  *)
        PlcEnable : BOOL ;   (* Enable PLC rights to use set vehicle status  *)
        
   END_STRUCT;
END_TYPE
TYPE
    LayoutPosition_T :
    STRUCT 
        InSystem : BOOL ;   (* Set to true when the vehicle is in the system, after a successful auto insert.  *)
        Point : DINT ;   (* Current point. When not on point, the value is set to zero  *)
        Segment : DINT ;   (* The segment that the vehicle is currently traveling on. When the current segment is unknown the value is set to zero.  *)
        Distance : DINT ;   (* Traveled distance on current segment. Valid if LayoutPosition.Segment is non-zero.  *)
        RemainingDistance : DINT ;   (* Remaining distance on current segment. Valid if LayoutPosition.Segment is non-zero.  *)
        MaxSpeed : DINT ;   (* By the layout allowed maximum speed on current segment. Valid if LayoutPosition.Segment is non-zero.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    ExternalPath_T :
    STRUCT 
        ReqExtSegment : BOOL ;   (* Requesting a new external segment when true  *)
        ReqSegmentId : DINT ;   (* Id of the requested external segment.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Automatic_T :
    STRUCT 
        DestPoint : DINT ;   (* The endpoint of current order  *)
        ExecDriveCommand : BOOL ;   (* Vehicle executes a drive mission (or has one in queue)  *)
        CurrentOrderMode : DINT ;   (* 1 = Master mode, 2 = Local mode, 3 = Local mode with TM  *)
        StartupOrderMode : DINT ;   (* Vehicle order mode at startup. 1 = Master mode, 2 = Local mode, 3 = Local mode with TM  *)
        SetOrderMode : DINT ;   (* Set new vehicle order mode . 1 = Master mode, 2 = Local mode, 3 = Local mode with TM  *)
        SetOrderModeError : DINT ;   (* Error codes from background program when trying to set order mode. 0 = Ok, 1 = Undefined mode, 2 = Order in progress  *)
        SetOrderModeEN : BOOL ;   (* Set this when proper value is assigned to SetOrderMode. Clear it when SetOrderModeENO is set  *)
        SetOrderModeENO : BOOL ;   (* Set by background program when SetOrderModeError is properly set. Cleared when SetOrderModeEN is cleared  *)
        StatusID : DINT ;   (* Order status:
0 = No order.
1 = Have order with no operation and the vehicle is driving to the destination point.
2 = Have order with operation and the vehicle is driving to the destination point.
3 = Standing on the operation point and wait for operation to finish.
4 = Master has canceled the non operation order and the vehicle is driving to the end of the last ordered segment.
5 = Master has canceled the operation order and the vehicle is driving to the end of the operation segment.
6 = Master has canceled the operation order and the vehicle is standing on the operation point, waiting for the PLC to cancel the order.  *)
        StatusText : STRING ;   (* Status text  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Manual_T :
    STRUCT 
        PlcAngle : DINT ;   (* Manual angle set by Plc to background software if proper bit in PlcSelectMask and PlcSelected is set  *)
        PlcSpeed : DINT ;   (* Manual speed set by Plc to background software if proper bit in PlcSelectMask and PlcSelected is set.  *)
        PlcSteerMode : DINT ;   (* Manual steer mode for a Quad/2xSD vehicle set by Plc to background software if proper bit in PlcSelectMask and PlcSelected is set. 0: 2*SD Anti-parallel, 1: 2*SD Parallel, 2: DiffDrive  *)
        PlcSetOperationMode : DINT ;   (* Operation mode set by Plc to background software if proper bit in PlcSelectMask and PlcSelected is set. 0 = Automatic, 1 = Manual, 2 = SemiAutomatic, 3 = SemiManual  *)
        PlcSelectMask : DINT ;   (* Individually select mask: Bit0:PlcAngle Bit1:PlcSpeed Bit2:PlcSetOperationMode Bit3:Reserved Bit4:PlcSteerMethod  *)
        PlcSelect : BOOL ;   (* PLC overrides MCD signals  *)
        
   END_STRUCT;
END_TYPE
TYPE
    SemiManual_T :
    STRUCT 
        MaxDistanceWireLost : DINT ;   (* Max distance the vehicle can travel without antenna updates before it behave as the wire is lost.  *)
        StatusID : DINT ;   (* 0:Off wire, 1:Guiding, 2:Wire lost  *)
        StatusText : STRING ;   (* Status text  *)
        
   END_STRUCT;
END_TYPE
TYPE
    BlackBox_T :
    STRUCT 
        TrigENO : BOOL ;   (* Set when a BlackBox is trigged manually.  Cleared when EN is cleared  *)
        TrigEN : BOOL ;   (* Set this when you want to trig a BlackBox. Clear it when ENO is set  *)
        TrigReason : STRING ;   (* Short description why blackbox was trigged. Used as title in the vehicle controller web interface.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    PointTrigger_T :
    STRUCT 
        Value : DINT ;   (* Point attribute value  *)
        Value2 : DINT ;   (* Point attribute value  *)
        Bit0 : BOOL ;   (* Point attribute bit  *)
        Bit1 : BOOL ;   (* Point attribute bit  *)
        Bit2 : BOOL ;   (* Point attribute bit  *)
        Bit3 : BOOL ;   (* Point attribute bit  *)
        Bit4 : BOOL ;   (* Point attribute bit  *)
        Bit5 : BOOL ;   (* Point attribute bit  *)
        Bit6 : BOOL ;   (* Point attribute bit  *)
        Bit7 : BOOL ;   (* Point attribute bit  *)
        Bit8 : BOOL ;   (* Point attribute bit  *)
        Bit9 : BOOL ;   (* Point attribute bit  *)
        Bit10 : BOOL ;   (* Point attribute bit  *)
        Bit11 : BOOL ;   (* Point attribute bit  *)
        Bit12 : BOOL ;   (* Point attribute bit  *)
        Bit13 : BOOL ;   (* Point attribute bit  *)
        Bit14 : BOOL ;   (* Point attribute bit  *)
        Bit15 : BOOL ;   (* Point attribute bit  *)
        
   END_STRUCT;
END_TYPE
TYPE
    SegmentTrigger_T :
    STRUCT 
        Value : DINT ;   (* Segment attribute value  *)
        Value2 : DINT ;   (* Segment attribute value  *)
        Bit0 : BOOL ;   (* Segment attribute bit  *)
        Bit1 : BOOL ;   (* Segment attribute bit  *)
        Bit2 : BOOL ;   (* Segment attribute bit  *)
        LeftTurn : BOOL ;   (* Segment attribute bit  *)
        RightTurn : BOOL ;   (* Segment attribute bit  *)
        DirectionY : BOOL ;   (* Segment attribute bit  *)
        DirectionX : BOOL ;   (* Segment attribute bit  *)
        Bit7 : BOOL ;   (* Segment attribute bit  *)
        Bit8 : BOOL ;   (* Segment attribute bit  *)
        Bit9 : BOOL ;   (* Segment attribute bit  *)
        Bit10 : BOOL ;   (* Segment attribute bit  *)
        Bit11 : BOOL ;   (* Segment attribute bit  *)
        Bit12 : BOOL ;   (* Segment attribute bit  *)
        Bit13 : BOOL ;   (* Segment attribute bit  *)
        Bit14 : BOOL ;   (* Segment attribute bit  *)
        Bit15 : BOOL ;   (* Segment attribute bit  *)
        
   END_STRUCT;
END_TYPE
TYPE
    LoadDocking_T :
    STRUCT 
        OnLastSegment : BOOL ;   (* Vehicle is driving on the segment leading to the operation point  *)
        DistOpPoint : DINT ;   (* Remaining distance to the operation point. The distance is measured as the crow flies  *)
        RequestDistance : BOOL ;   (* Set by background program to request the PLC for a distance to drive on a flexible segment  *)
        PlcDistError : DINT ;   (* Error reported during a plc distance sequence:
0 = Ok.
1 = Distance error. The distance is probably longer than distance left on the segment. or PlcDistFromEnd flag is not properly set.
2 = Wrong mode. A plc distance sequence is started by the PLC, but the background program has not requested one (RequestDistance is not set).
3 = No line. A plc distance sequence is started on a segment that is not a line.
4 = Wrong segment. The symbol ArrivedEN has been set on a segment that is either not flexible or not the last commanded segment.  *)
        PlcDistENO : BOOL ;   (* Function executed by background and error is properly set. Cleared when EN is cleared.  *)
        PlcDistance : DINT ;   (* Set the distance to drive on the flexible segment  *)
        PlcDistFromEnd : BOOL ;   (* Set if PlcDistance shall be measured from the endpoint of the flexible segment. Otherwise it will be from the startpoint  *)
        PlcDistEN : BOOL ;   (* Set this when the other plc dist parameters are set properly. Clear it when ENO is set  *)
        OnTarget : BOOL ;   (* Set by background program when standing on the operation point. This is the start signal to the PLC for the load operation. It is cleared when the PLC sets LoadOpDoneEN and the background program responds with LoadOpDoneENO.  *)
        ArrivedEN : BOOL ;   (* Set arrived on a flexible segment, when the vehicle stands still, to force the LoadDocking.OnTarget signal. Clear when ENO is set  *)
        ArrivedENO : BOOL ;   (* Respond to PLC arrived is executed. Clear when EN is cleared  *)
        
   END_STRUCT;
END_TYPE
TYPE
    LoadOperation_T :
    STRUCT 
        OperationCode : DINT ;   (* Operation code. Used by the PLC to perform some application defined action at the operation point  *)
        OperationParam1 : DINT ;   (* Operation parameter 1. Additional operation data  *)
        OperationParam2 : DINT ;   (* Operation parameter 2. Additional operation data  *)
        CancelOperation : BOOL ;   (* Cancel operation is requested. This does not necessarily mean that the operation will be canceled. The PLC determine if to do or not. If the PLC cancels the operation it shall answer with a nonzero LoadOpError value in the LoadOpDone function  *)
        LoadOpDoneError : DINT ;   (* 0 = load operation ok, 1.. = load operation failed  *)
        LoadOpDoneResult : DINT ;   (* Operation result code  *)
        LoadOpDoneEN : BOOL ;   (* Set this when error and result is set properly. Clear when ENO is set. This must not be set/used if not OnTarget is set  *)
        LoadOpDoneENO : BOOL ;   (* Function is executed by background  *)
        
   END_STRUCT;
END_TYPE
TYPE
    CANBus_T :
    STRUCT 
        Protocol : STRING ;   (* CAN protocol  *)
        BusID : DINT ;   (* Physical CAN ID  *)
        MasterNodeID : DINT ;   (* Node ID for the CanOpen Master. If the buses are interconnected make sure they don't have the same MasterNodeID.  *)
        LoadBase : DINT ;   (* This property specifies the amount of CAN bus load that is allocated as margin and for background communication.  *)
        Bitrate : DINT ;   (* Bitrate (kBit/s)  *)
        NMTMaster : BOOL ;   (* Set to true if this unit is NMT master in a CANOpen network  *)
        SlaveComponent : STRING ;   (* Name of the component that represent the vehicle controller slave. Ignored if NMTMaster is true  *)
        SyncGeneration : BOOL ;   (* Set to true if syncs should be sent on this can channel. Ignored if NMTMaster is false  *)
        ReadSDO_NodeID : DINT ;   (* Node ID  *)
        ReadSDO_ObjectIndex : DINT ;   (* Object Index  *)
        ReadSDO_SubIndex : DINT ;   (* Sub Index  *)
        ReadSDO_Value : DINT ;   (* Output value  *)
        ReadSDO_StrValue : STRING ;   (* String output value  *)
        ReadSDO_DataType : STRING ;   (* Data type of value to read. Valid datatypes are:
BOOLEAN, UNSIGNED8, INTEGER8, UNSIGNED16, INTEGER16, UNSIGNED32, INTEGER32, VISIBLE_STRING.
For the type VISIBLE_STRING the value is passed in ReadSDO_StrValue parameter.  *)
        ReadSDO_Valid : BOOL ;   (* True if the returned Value is valid  *)
        ReadSDO_ErrorText : STRING ;   (* Error description. Empty if no error  *)
        ReadSDO_EN : BOOL ;   (* Trigger of SDO read operation  *)
        ReadSDO_ENO : BOOL ;   (* Trigger of operation done  *)
        WriteSDO_NodeID : DINT ;   (* Node ID  *)
        WriteSDO_ObjectIndex : DINT ;   (* Object Index  *)
        WriteSDO_SubIndex : DINT ;   (* Sub Index  *)
        WriteSDO_Value : DINT ;   (* Input value  *)
        WriteSDO_StrValue : STRING ;   (* Input value  *)
        WriteSDO_DataType : STRING ;   (* Data type of value to read. Valid datatypes are:
BOOLEAN, UNSIGNED8, INTEGER8, UNSIGNED16, INTEGER16, UNSIGNED32, INTEGER32, VISIBLE_STRING.
For the type VISIBLE_STRING the value is passed in WriteSDO_StrValue parameter.  *)
        WriteSDO_Valid : BOOL ;   (* True if the returned Value is valid  *)
        WriteSDO_ErrorText : STRING ;   (* Error description. Empty if no error  *)
        WriteSDO_EN : BOOL ;   (* Trigger of SDO write operation  *)
        WriteSDO_ENO : BOOL ;   (* Trigger of operation done  *)
        VerboseMode : BOOL ;   (* Switch to enable/disable printing of CAN status messages in the blackbox  *)
        State : DINT ;   (* CAN channel state 0=disabled, 1=active, 2=error passive, 3=bus off  *)
        
   END_STRUCT;
END_TYPE
TYPE
    GenericCanDevice_T :
    STRUCT 
        BusID : DINT ;   (* CAN bus ID  *)
        NodeID : DINT ;   (* CAN node ID  *)
        FailureAction : DINT ;   (* 0 = Background, the background programs takes action when an error occur in the device. 1 = PLC, no action from background program. The error should be handled by the PLC application.  *)
        ActiveInSafeState : BOOL ;   (* Decides if the device will start up in safe state.  *)
        NMTState : UDINT ;   (* The current CANopen state of the device.  *)
        SdoBufferSize : DINT ;   (* The current size of the client SDO buffer (read/write SDO's from the vehicle controller to this device).  *)
        
   END_STRUCT;
END_TYPE
TYPE
    VehicleControl_T :
    STRUCT 
        SetSpeed : DINT ;   (* Current commanded vehicle set-speed  *)
        TravelDir : DINT ;   (* Current, and latest, travel direction. 1 = forward, 0 = backward  *)
        Moving : BOOL ;   (* Vehicle is moving  *)
        Estop : BOOL ;   (* Set when the vehicle is emergency stopped  *)
        Stop : BOOL ;   (* The PLC sets this to stop the vehicle using the normal Vehicle.DecSlope.  *)
        QuickStop : BOOL ;   (* The PLC sets this to stop the vehicle using the Vehicle.EmcyDecSlope.  *)
        SlowDown : BOOL ;   (* The PLC sets this to make the vehicle enter SlowDownSpeed. Typically used on flexible segments when using sensor stop  *)
        SlowDownSpeed : DINT ;   (* Slowdown speed. See SlowDown  *)
        OperationMode : DINT ;   (* Current operation mode. 0 = Automatic, 1 = Manual, 2 = SemiAutomatic, 3 = SemiManual  *)
        SensorStopInputSignal : STRING ;   (* Symbolic name for digital input to be used as sensor stop. Also see SensorStopEnable  *)
        SensorStopInputPolarity : BOOL ;   (* Polarity switch for SensorStopInputSignal. Also see SensorStopEnable  *)
        SensorStopEnable : BOOL ;   (* Enable / Disable of SensorStopInput 0=disable, 1=enable. The intention is to use this to stop the vehicle on a sensor, at an operation point on a flexible segment and in conjunction with the LoadDocking.Arrived function. Though, there are no limits to use it in other situations too. When enabled, the vehicle will stop and stand still, as long as the selected sensor, SensorStopInputSignal, is active, due to its polarity, SensorStopInputPolarity. When the signal is not active, the vehicle goes on driving (if commanded of course)  *)
        BrakeOutputSignal : STRING ;   (* Symbolic name for digital output where brake is connected, to disable type NotUsed  *)
        BrakeOutputPolarity : BOOL ;   (* Polarity setting for brake digital output  *)
        BrakeOnDelay : DINT ;   (* Delay before the brakes are applied  *)
        BrakeOffDelay : DINT ;   (* Delay before trying to move the vehicle after the brakes have been released. To allow for the brakes to mechanically release.  *)
        EstopInputSignal : STRING ;   (* Symbolic name for digital input where Estop is connected, to disable type NotUsed. If you have not set this correct you can get emcy on the Can-Bus. This happens when the regulators try to move the wheels and there's no power on the servos.  *)
        EstopInputPolarity : BOOL ;   (* Polarity setting for estop digital input  *)
        HaltRequest : BOOL ;   (* Halt request to PLC application, used in detour function  *)
        HaltRequestDone : BOOL ;   (* Halt request done, set by PLC application, used in detour function  *)
        PreventAppDownload : BOOL ;   (* When true will an application transfer from AppDesigner and halt and restart from web interface be prevented.  *)
        PlcSetSteerEnable : BOOL ;   (* Set by PLC to enable/disable external steer regulator if proper bit in PlcSelectMask and PlcSelect is set. If vehicle is e-stopped the regulator must be disabled.  *)
        PlcSetDriveEnable : BOOL ;   (* Set by PLC to enable/disable external drive regulator if proper bit in PlcSelectMask and PlcSelect is set. If vehicle is e-stopped the regulator must be disabled.  *)
        PlcSelectMask : DINT ;   (* Select mask: Bit0:PlcSetAngle Bit1:PlcSetSpeed Bit2:PlcSetSteerEnable Bit3:PlcSetDriveEnable (PlcSetAngle and PlcSetSpeed is controlled per defined wheel)  *)
        PlcSelect : BOOL ;   (* PLC overrides bits selected by mask.  *)
        VeryLateSSIO : BOOL ;   (* Request for PLC application to stop movement, due to late SSIO blocking  *)
        CollisionRisk : BOOL ;   (* When the System Manager detects there is a collision risk for the vehicle, it will
transfer this information to the vehicle and the CollisionRisk parameter will be set. The parameter can only
be set in automatic and master mode. In all other cases the parameter is cleared.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    GenericMcdDevice_T :
    STRUCT 
        Speed : DINT ;   (* Speed from Mcd  *)
        Angle : DINT ;   (* Angle from Mcd  *)
        Buttons : DINT ;   (* Buttons from Mcd  *)
        Button1 : BOOL ;   (* Button from Mcd  *)
        Button2 : BOOL ;   (* Button from Mcd  *)
        Button3 : BOOL ;   (* Button from Mcd  *)
        Button4 : BOOL ;   (* Button from Mcd  *)
        Button5 : BOOL ;   (* Button from Mcd  *)
        Button6 : BOOL ;   (* Button from Mcd  *)
        Button7 : BOOL ;   (* Button from Mcd  *)
        Button8 : BOOL ;   (* Button from Mcd  *)
        Button9 : BOOL ;   (* Button from Mcd  *)
        Button10 : BOOL ;   (* Button from Mcd  *)
        Button11 : BOOL ;   (* Button from Mcd  *)
        Button12 : BOOL ;   (* Button from Mcd  *)
        Button13 : BOOL ;   (* Button from Mcd  *)
        Button14 : BOOL ;   (* Button from Mcd  *)
        Button15 : BOOL ;   (* Button from Mcd  *)
        Button16 : BOOL ;   (* Button from Mcd  *)
        McdHighSpeed : DINT ;   (* Mcd high or max speed  *)
        DeviceType : STRING ;   (* A Manual Control Device  *)
        
   END_STRUCT;
END_TYPE
TYPE
    MCD7P_T :
    STRUCT 
        Speed : DINT ;   (* Speed from Mcd  *)
        Angle : DINT ;   (* Angle from Mcd  *)
        Buttons : DINT ;   (* Buttons from Mcd  *)
        DeviceType : STRING ;   (* A Manual Control Device  *)
        Button1 : BOOL ;   (* Auto mode button  *)
        Button2 : BOOL ;   (* Semi mode button  *)
        Button3 : BOOL ;   (* Man mode button  *)
        Button4 : BOOL ;   (* Forward backward button  *)
        Button5 : BOOL ;   (* Low speed button  *)
        Button6 : BOOL ;   (* High speed button  *)
        Button7 : BOOL ;   (* Override button  *)
        Button8 : BOOL ;   (* Load1 up button  *)
        Button9 : BOOL ;   (* Load1 down button  *)
        Button10 : BOOL ;   (* Load2 left button  *)
        Button11 : BOOL ;   (* Load2 right button  *)
        McdHighSpeed : DINT ;   (* Mcd high or max speed  *)
        McdLowSpeed : DINT ;   (* Mcd low speed  *)
        Valid : BOOL ;   (* Set when an MCD device is up and running  *)
        
   END_STRUCT;
END_TYPE
TYPE
    GenericRemoteJoystick_T :
    STRUCT 
        Speed : DINT ;   (* Speed from Mcd  *)
        Angle : DINT ;   (* Angle from Mcd  *)
        Buttons : DINT ;   (* Buttons from Mcd  *)
        Button1 : BOOL ;   (* Button1 from Joystick  *)
        Button2 : BOOL ;   (* Button2 from Joystick  *)
        Button3 : BOOL ;   (* Button3 from Joystick  *)
        Button4 : BOOL ;   (* Button4 from Joystick  *)
        Button5 : BOOL ;   (* Button5 from Joystick  *)
        Button6 : BOOL ;   (* Button6 from Joystick  *)
        Button7 : BOOL ;   (* Button7 from Joystick  *)
        Button8 : BOOL ;   (* Button8 from Joystick  *)
        Button9 : BOOL ;   (* Button9 from Joystick  *)
        Button10 : BOOL ;   (* Button10 from Joystick  *)
        Button11 : BOOL ;   (* Button11 from Joystick  *)
        Button12 : BOOL ;   (* Button12 from Joystick  *)
        Button13 : BOOL ;   (* Button13 from Joystick  *)
        Button14 : BOOL ;   (* Button14 from Joystick  *)
        Button15 : BOOL ;   (* Button15 from Joystick  *)
        Button16 : BOOL ;   (* Button16 from Joystick  *)
        McdHighSpeed : DINT ;   (* Mcd high or max speed  *)
        Valid : BOOL ;   (* Set when a joystick is connected and communicating with the background program  *)
        Port : DINT ;   (* TCP port connected to joystick  *)
        DeviceType : STRING ;   (* OEM joysticks from WingMan, Logitech etc  *)
        
   END_STRUCT;
END_TYPE
TYPE
    PLC_Application_T :
    STRUCT 
        TxStatusBit0 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit1 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit2 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit3 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit4 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit5 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit6 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit7 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit8 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit9 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit10 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit11 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit12 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit13 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit14 : BOOL ;   (* Application status bit to Master  *)
        TxStatusBit15 : BOOL ;   (* Application status bit to Master  *)
        UserEventEN : BOOL ;   (* Set this flag to send a User Event. Clear when ENO is set  *)
        UserEventENO : BOOL ;   (* Response to PLC User Event is executed. Clear when EN is cleared  *)
        UserEventCode : DINT ;   (* User Event code  *)
        UserEventPar1 : DINT ;   (* User Event parameter 1  *)
        UserEventPar2 : DINT ;   (* User Event parameter 2  *)
        UserEventPar3 : DINT ;   (* User Event parameter 3  *)
        UserEventPar4 : DINT ;   (* User Event parameter 4  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Rcu_T :
    STRUCT 
        Protocol : STRING ;   (* Protocol  *)
        SetRcuChannel : DINT ;   (* Set RCU Channel  *)
        CurRcuChannel : DINT ;   (* Current RCU Channel  *)
        TraceEnable : BOOL ;   (* Enable SCC trace  *)
        
   END_STRUCT;
END_TYPE
TYPE
    Satel_T :
    STRUCT 
        Protocol : STRING ;   (* Protocol  *)
        TraceEnable : BOOL ;   (* Enable SCC trace  *)
        
   END_STRUCT;
END_TYPE
TYPE
    IRModem_T :
    STRUCT 
        Protocol : STRING ;   (* Protocol  *)
        TraceEnable : BOOL ;   (* Enable SCC trace  *)
        
   END_STRUCT;
END_TYPE
TYPE
    SerialPort_T :
    STRUCT 
        Baudrate : DINT ;   (* Baudrate (bits/second)  *)
        Databits : DINT ;   (* Number of data bits  *)
        Parity : STRING ;   (* Parity (None, Even, Odd)  *)
        Stopbits : DINT ;   (* Number of stopbits  *)
        Protocol : STRING ;   (* Protocol  *)
        
   END_STRUCT;
END_TYPE
TYPE
    SerialPort_RS232_T :
    STRUCT 
        Baudrate : DINT ;   (* Baudrate (bits/second)  *)
        Databits : DINT ;   (* Number of data bits  *)
        Parity : STRING ;   (* Parity (None, Even, Odd)  *)
        Stopbits : DINT ;   (* Number of stopbits  *)
        Protocol : STRING ;   (* Protocol  *)
        
   END_STRUCT;
END_TYPE
TYPE
    SerialPort_RS422_T :
    STRUCT 
        Baudrate : DINT ;   (* Baudrate (bits/second)  *)
        Databits : DINT ;   (* Number of data bits  *)
        Parity : STRING ;   (* Parity (None, Even, Odd)  *)
        Stopbits : DINT ;   (* Number of stopbits  *)
        Protocol : STRING ;   (* Protocol  *)
        
   END_STRUCT;
END_TYPE
TYPE
    SerialPort_RS485_T :
    STRUCT 
        Baudrate : DINT ;   (* Baudrate (bits/second)  *)
        Databits : DINT ;   (* Number of data bits  *)
        Parity : STRING ;   (* Parity (None, Even, Odd)  *)
        Stopbits : DINT ;   (* Number of stopbits  *)
        Protocol : STRING ;   (* Protocol  *)
        
   END_STRUCT;
END_TYPE
TYPE
    WheelSD_T :
    STRUCT 
        MaxAngularSpeed : DINT ;   (* Max steer angular speed allowed  *)
        MinSteerAngle : DINT ;   (* Min steer angle allowed  *)
        MaxSteerAngle : DINT ;   (* Max steer angle allowed  *)
        X : DINT ;   (* Wheel position X (lengthwise along the symmetry axis). Positive in the forwards direction.  *)
        Y : DINT ;   (* Wheel position Y (perpendicular to the symmetry axis). Positive to the left.  *)
        SetSpeedRef : STRING ;   (* Symbolic name for wheel set speed  *)
        SetAngleRef : STRING ;   (* Symbolic name for wheel set angle  *)
        SetSpeedEnableRef : STRING ;   (* Symbolic name for wheel speed regulator enable  *)
        SetAngleEnableRef : STRING ;   (* Symbolic name for wheel angle regulator enable  *)
        EncSpeedRef : STRING ;   (* Symbolic name for wheel speed feedback  *)
        EncDistRef : STRING ;   (* Symbolic name for wheel distance feedback. If set to NotUsed EncSpeedRef will be used for distance feedback.  *)
        EncAngleRef : STRING ;   (* Symbolic name for wheel angle feedback  *)
        EncSpeedPlcInputRef : STRING ;   (* If EncSpeedRef or EncDistRef points to a symbol that is computed by PLC then this should point to the variable that the PLC uses as input for the calculation. The encoder value is then considered to be ready when the input variable has been received over the CAN bus (or otherwised updated) and the PLC has been executed.  *)
        EncAnglePlcInputRef : STRING ;   (* If EncAngleRef points to a symbol that is computed by PLC then this should point to the variable that the PLC uses as input for the calculation. The encoder value is then considered to be ready when the input variable has been received over the CAN bus (or otherwised updated) and the PLC has been executed.  *)
        WheelType : STRING ;   (* Type of wheel, Possible values are Steer, Drive and SD  *)
        PlcSetAngle : DINT ;   (* Set by PLC to control steering. Sent directly to external steer regulator 
                if proper bit in PlcSelectMask and PlcSelect is set.  *)
        PlcSetSpeed : DINT ;   (* Set by PLC to control speed. Sent directly to external drive regulator 
                if proper bit in PlcSelectMask and PlcSelect is set.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    WheelDD_T :
    STRUCT 
        MaxAngularSpeed : DINT ;   (* Max steer angular speed of allowed  *)
        MinSteerAngle : DINT ;   (* Min steer angle allowed  *)
        MaxSteerAngle : DINT ;   (* Max steer angle allowed  *)
        X : DINT ;   (* Wheel position X (lengthwise along the symmetry axis). Positive in the forwards direction.  *)
        Y : DINT ;   (* Wheel position Y (perpendicular to the symmetry axis). Positive to the left.  *)
        Gauge : DINT ;   (* Distance between the individual wheels of type DD.  *)
        SteerRegP : DINT ;   (* Propotional control parameter for DD-wheel.  *)
        SteerRegI : DINT ;   (* Integral control parameter for DD-wheel.  *)
        SteerRegILimit : DINT ;   (* Limit for integral error in PID steer controller.  *)
        SteerRegD : DINT ;   (* Derivative control parameter for DD-wheel.  *)
        SteerRegPIDLimit : DINT ;   (* Limit for part of wheel speed due to steer controller PID.  *)
        SteerRegCheckOutHysteres : DINT ;   (* Threshold for steer encoder supervision. When the set angle for the wheelpair changes at a higher rate than this it is required that the encoder reports change of angle in the same direction.  *)
        SteerRegCheckError : DINT ;   (* Threshold for steer encoder supervision. It is required that the encoder reports an angle that differ less than this from the set angle.  *)
        SteerRegFailureDelay : DINT ;   (* Delay before safe state in absence of correct steer encoder feedback movement. A zero value means that steer encoder supervision is disabled.  *)
        WheelType : STRING ;   (* Type of wheel, Possible values are Steer, Drive, SD and DD  *)
        PlcLeftSetSpeed : DINT ;   (* Set by PLC to control speed of left wheel. Sent directly to external drive regulator if proper bit in PlcSelectMask and PlcSelect is set.  *)
        PlcRightSetSpeed : DINT ;   (* Set by PLC to control speed of right wheel. Sent directly to external drive regulator if proper bit in PlcSelectMask and PlcSelect is set.  *)
        LeftSetSpeedRef : STRING ;   (* Symbolic name for left wheel set speed  *)
        LeftSetSpeedEnableRef : STRING ;   (* Symbolic name for left wheel speed regulator enable  *)
        LeftEncSpeedRef : STRING ;   (* Symbolic name for left wheel speed feedback  *)
        LeftEncDistRef : STRING ;   (* Symbolic name for left wheel distance feedback  *)
        LeftReverse : BOOL ;   (* Set to true if mounted with positive speed in backward direction  *)
        RightSetSpeedRef : STRING ;   (* Symbolic name for left wheel set speed  *)
        RightSetSpeedEnableRef : STRING ;   (* Symbolic name for right wheel speed regulator enable  *)
        RightEncSpeedRef : STRING ;   (* Symbolic name for left wheel speed feedback  *)
        RightEncDistRef : STRING ;   (* Symbolic name for left wheel distance feedback  *)
        RightReverse : BOOL ;   (* Set to true if mounted with positive speed in backward direction  *)
        EncAngleRef : STRING ;   (* Symbolic name for wheel angle feedback  *)
        
   END_STRUCT;
END_TYPE
TYPE
    OMPLC_T :
    STRUCT 
        Data1 : INT ;   (*   *)
        Data2 : INT ;   (*   *)
        Data3 : INT ;   (*   *)
        Data4 : INT ;   (*   *)
        Data5 : INT ;   (*   *)
        Data6 : INT ;   (*   *)
        Data7 : INT ;   (*   *)
        GroupFlag : INT ;   (*   *)
        Data9 : INT ;   (*   *)
        Data10 : INT ;   (*   *)
        Data11 : INT ;   (*   *)
        Data12 : INT ;   (*   *)
        Data13 : INT ;   (*   *)
        Data14 : INT ;   (*   *)
        Data15 : INT ;   (*   *)
        Data16 : INT ;   (*   *)
        Data17 : INT ;   (*   *)
        Data18 : INT ;   (*   *)
        Data19 : INT ;   (*   *)
        Data20 : INT ;   (*   *)
        Data21 : INT ;   (*   *)
        Data22 : INT ;   (*   *)
        Data23 : INT ;   (*   *)
        Data24 : INT ;   (*   *)
        Data25 : INT ;   (*   *)
        Data26 : INT ;   (*   *)
        Data27 : INT ;   (*   *)
        Data28 : INT ;   (*   *)
        Data29 : INT ;   (*   *)
        Data30 : INT ;   (*   *)
        Data31 : INT ;   (*   *)
        Data32 : INT ;   (*   *)
        Data33 : INT ;   (*   *)
        Data34 : INT ;   (*   *)
        Data35 : INT ;   (*   *)
        Data36 : INT ;   (*   *)
        Data37 : INT ;   (*   *)
        Data38 : INT ;   (*   *)
        Data39 : INT ;   (*   *)
        Data40 : INT ;   (*   *)
        Data41 : INT ;   (*   *)
        Data42 : INT ;   (*   *)
        Data43 : INT ;   (*   *)
        Data44 : INT ;   (*   *)
        Data45 : INT ;   (*   *)
        Data46 : INT ;   (*   *)
        Data47 : INT ;   (*   *)
        Data48 : INT ;   (*   *)
        Data49 : INT ;   (*   *)
        Data50 : INT ;   (*   *)
        Data51 : INT ;   (*   *)
        Data52 : INT ;   (*   *)
        Data53 : INT ;   (*   *)
        Data54 : INT ;   (*   *)
        Data55 : INT ;   (*   *)
        Data56 : INT ;   (*   *)
        Data57 : INT ;   (*   *)
        Data58 : INT ;   (*   *)
        Data59 : INT ;   (*   *)
        Data60 : INT ;   (*   *)
        Data61 : INT ;   (*   *)
        Data62 : INT ;   (*   *)
        Data63 : INT ;   (*   *)
        Data64 : INT ;   (*   *)
        Data65 : INT ;   (*   *)
        Data66 : INT ;   (*   *)
        Data67 : INT ;   (*   *)
        Data68 : INT ;   (*   *)
        Data69 : INT ;   (*   *)
        Data70 : INT ;   (*   *)
        Data71 : INT ;   (*   *)
        Data72 : INT ;   (*   *)
        Data73 : INT ;   (*   *)
        Data74 : INT ;   (*   *)
        Data75 : INT ;   (*   *)
        Data76 : INT ;   (*   *)
        Data77 : INT ;   (*   *)
        Data78 : INT ;   (*   *)
        Data79 : INT ;   (*   *)
        Data80 : INT ;   (*   *)
        Data81 : INT ;   (*   *)
        Data82 : INT ;   (*   *)
        Data83 : INT ;   (*   *)
        Data84 : INT ;   (*   *)
        Data85 : INT ;   (*   *)
        Data86 : INT ;   (*   *)
        Data87 : INT ;   (*   *)
        Data88 : INT ;   (*   *)
        Data89 : INT ;   (*   *)
        Data90 : INT ;   (*   *)
        Data91 : INT ;   (*   *)
        Data92 : INT ;   (*   *)
        Data93 : INT ;   (*   *)
        Data94 : INT ;   (*   *)
        Data95 : INT ;   (*   *)
        Data96 : INT ;   (*   *)
        Data97 : INT ;   (*   *)
        Data98 : INT ;   (*   *)
        Data99 : INT ;   (*   *)
        Data100 : INT ;   (*   *)
        Data101 : INT ;   (*   *)
        Data102 : INT ;   (*   *)
        Data103 : INT ;   (*   *)
        Data104 : INT ;   (*   *)
        Data105 : INT ;   (*   *)
        Data106 : INT ;   (*   *)
        Data107 : INT ;   (*   *)
        Data108 : INT ;   (*   *)
        Data109 : INT ;   (*   *)
        Data110 : INT ;   (*   *)
        Data111 : INT ;   (*   *)
        Data112 : INT ;   (*   *)
        Data113 : INT ;   (*   *)
        Data114 : INT ;   (*   *)
        Data115 : INT ;   (*   *)
        Data116 : INT ;   (*   *)
        Data117 : INT ;   (*   *)
        Data118 : INT ;   (*   *)
        Data119 : INT ;   (*   *)
        Data120 : INT ;   (*   *)
        
   END_STRUCT;
END_TYPE
TYPE
    WGUController_T :
    STRUCT 
        Enabled : BOOL ;   (* Enable Narrow Aisle Wire Guidance  *)
        MaxPickupTime : DINT ;   (* Max time to pickup wire (s)  *)
        Pickup : BOOL ;   (* Trying to lock on a wire  *)
        PickupTimeout : BOOL ;   (* Timeout during pickup  *)
        Locked : BOOL ;   (* Locked on wire  *)
        Unlocked : BOOL ;   (* Unlocked from wire  *)
        NavError : BOOL ;   (* Nav error on transition  *)
        ModeID : DINT ;   (* Current WGU mode. 0=Normal, 1=Narrow Aisle  *)
        ModeText : STRING ;   (* Descriptive mode string  *)
        Valid : BOOL ;   (* Valid signal (property values are valid)  *)
        Error : BOOL ;   (* Error signal  *)
        StatusID : DINT ;   (* Status identifier  *)
        StatusText : STRING ;   (* Status text  *)
        
   END_STRUCT;
END_TYPE
TYPE
    LocalOrder_T :
    STRUCT 
        DestPoint : DINT ;   (* Destination point  *)
        OpCode : DINT ;   (* Operation code if there is an operation to be performed at the destination point  *)
        OpParam1 : DINT ;   (* Additional operation parameter  *)
        OpParam2 : DINT ;   (* Additional operation parameter  *)
        Error : DINT ;   (* Error codes set by background. Only valid when OrderENO is set.
0  = Ok. 
1  = General nack. 
2  = Destination point does not exist.
3  = Sync point not ok. Probably zero. The sync point is where the last order stopped, and from where the new order starts.
4  = No way to reach the destination point. 
10 = Not in system. 
11 = Master mode. 
12 = Wrong operation mode. The vehicle must be in Auto mode to accept local orders.
20 = Invalid destination point. 
21 = Order in progress.  *)
        OrderEN : BOOL ;   (* Set when proper values are assigned to the local order parameters. Cleared when ENO is set  *)
        OrderENO : BOOL ;   (* Set by background program when Error is assigned. Cleared when EN is cleared  *)
        
   END_STRUCT;
END_TYPE
TYPE
    SSIO_T :
    STRUCT 
        LogicalLine : DINT ;   (* Logical SSIO line.  *)
        UnitNumber : DINT ;   (* Unit id in a logical line.  *)
        InputOutputID : DINT ;   (* ID of input/output in unit.  *)
        RequestType : DINT ;   (* 0:Read input status, 1:Read output status, 2:Set output status.  *)
        SetStatus : DINT ;   (* The status to set in case of a Set output status request, 0:OFF, 1:ON, 2:Flash 1Hz.  *)
        Status : DINT ;   (* The returned status in case of a read request. Valid only when SSIO_ENO is set.  *)
        SSIO_EN : BOOL ;   (* First set SSIO address and request type then set this property to initiate a SSIO request. Clear when SSIO_ENO is set and Status has been read.  *)
        SSIO_ENO : BOOL ;   (* Set by background software when the SSIO request has been executed. For a read request this means that the reply can be read from the Status property.  *)
        Error : DINT ;   (* 0:No error, 1:Timeout.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    CanOpenMaster_T :
    STRUCT 
        MasterExecutionPeriod : DINT ;   (* Execution period for the CANopen master component. Unit is [ms].  *)
        SyncPeriod : DINT ;   (* Sync producer period given in multiples of MasterExecutionPeriod.  *)
        CollectTimeout : DINT ;   (* Collect timeout before can server enters safe state  *)
        CanMasterCmd : DINT ;   (* Command to CAN master when CanMasterEN is set, 1 = RestartCan, 2 = GoToSafeState  *)
        CanMasterCmdEN : BOOL ;   (* Commands CAN master to CanMasterCmd. Clear it when CanMasterCmdENO is set.  *)
        CanMasterCmdENO : BOOL ;   (* Set by background when commands CAN master to CanMasterCmd. Cleared when CanMasterEN is cleared.  *)
        NMTState : UDINT ;   (* The current CANopen state of the vehicle controller. Interpretation:
                        Initializing (0) = loading definition,
                        Stopped (4) = unable to start due to fatal definition error,
                        Operational (5) = The vehicle controller fully operational either in normal state or in safestate,
                        PreOperational (127) = pre-operational, configuration of slave devices,
                        Unknown (255) = state undefined, no communication with node  *)
        State : DINT ;   (* Current state of the CanOpenMaster application, 0 = NormalState, 1 = SafeState. When any error is detected that PLC does not handle, the vehicle controller will enter SafeState. Information about the error causing SafeState is available in properties StatusText, EMCY_NodeID, EMCY_Code, EMCY_ErrReg, EMCY_Byte1, etc. SafeState is a passive/diagnostic state and AllOk will be set to false.  *)
        StatusText : STRING ;   (* Text description of error that caused the vehicle controller to enter SafeState. Only valid when State = SafeState.  *)
        EMCY_BusID : DINT ;   (* Bus ID that reported the error. Only valid when State = SafeState.  *)
        EMCY_NodeID : DINT ;   (* Node ID that reported the error. Only valid when State = SafeState.  *)
        EMCY_Code : DINT ;   (* CANopen emergency code, see device documentation. Only valid when State = SafeState.  *)
        EMCY_ErrReg : DINT ;   (* Error registry. Only valid when State = SafeState.  *)
        EMCY_Byte1 : DINT ;   (* Manufacturer specific field, byte 1. Only valid when State = SafeState.  *)
        EMCY_Byte2 : DINT ;   (* Manufacturer specific field, byte 2. Only valid when State = SafeState.  *)
        EMCY_Byte3 : DINT ;   (* Manufacturer specific field, byte 3. Only valid when State = SafeState.  *)
        EMCY_Byte4 : DINT ;   (* Manufacturer specific field, byte 4. Only valid when State = SafeState.  *)
        EMCY_Byte5 : DINT ;   (* Manufacturer specific field, byte 5. Only valid when State = SafeState.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    CanOpenEmergency_T :
    STRUCT 
        EmcyEN : BOOL ;   (* Set by background when emergency data is available for a CAN device that has FailureAction set to PLC. Cleared when ENO is set.  *)
        EmcyENO : BOOL ;   (* Set by PLC when read emergency data, cleared when EN is cleared.  *)
        BusID : DINT ;   (* CAN bus id.  *)
        NodeID : DINT ;   (* CAN node id.  *)
        Code : DINT ;   (* Error code according to CANopen standard. When an emergency is generated by background program (node id is negative), the node id for the node it concerns is the last 5 bits of the code.  *)
        ErrReg : DINT ;   (* Error register according to CANopen standard.  *)
        Byte1 : DINT ;   (* Manufacturer specific error field according to CANopen standard.  *)
        Byte2 : DINT ;   (* Manufacturer specific error field according to CANopen standard.  *)
        Byte3 : DINT ;   (* Manufacturer specific error field according to CANopen standard.  *)
        Byte4 : DINT ;   (* Manufacturer specific error field according to CANopen standard.  *)
        Byte5 : DINT ;   (* Manufacturer specific error field according to CANopen standard.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    PLCEmergency_T :
    STRUCT 
        Canbus : DINT ;   (* Bus to send emergency on. 0 = first bus, 1 = second bus.  *)
        Code : DINT ;   (* Error code according to CANopen standard.  *)
        ErrReg : DINT ;   (* Error register according to CANopen standard.  *)
        Byte1 : DINT ;   (* Manufacturer specific error field according to CANopen standard.  *)
        Byte2 : DINT ;   (* Manufacturer specific error field according to CANopen standard.  *)
        Byte3 : DINT ;   (* Manufacturer specific error field according to CANopen standard.  *)
        Byte4 : DINT ;   (* Manufacturer specific error field according to CANopen standard.  *)
        Byte5 : DINT ;   (* Manufacturer specific error field according to CANopen standard.  *)
        EmcyEN : BOOL ;   (* Set by PLC when emergency data is available. Cleared by PLC when ENO is set.  *)
        EmcyENO : BOOL ;   (* Set by the vehicle controller when emergency data has been read. Cleared by the vehicle controller when EN is cleared.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    SlavebusControl_T :
    STRUCT 
        EnterPreOpEN : BOOL ;   (* Set by background when requesting to enter NMT state pre-operational. Cleared when ENO is set.  *)
        EnterPreOpENO : BOOL ;   (* Set by PLC when transition to NMT state pre-operational is granted. Cleared when EN is cleared.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    PPA_T :
    STRUCT 
        LaserScannerRef : STRING ;   (* Reference to the Laser scanner component  *)
        FrontWheelRef : STRING ;   (* Reference to the front wheel component  *)
        SteerEncRef : STRING ;   (* Symbol address where the steer encoder offset is defined. Ex: SDIO_1.SteerEncOffset  *)
        CurrentState : DINT ;   (* Current or last state of action:
0 = Idle
1 = Driving sequence 1
2 = Driving sequence 2
3 = Driving sequence 3
4 = Driving sequence 4
5 = Driving sequence 5
6 = Estimation in progress
7 = Estimation done result ok  *)
        EstimationProgress : DINT ;   (* Progressbar during calculation  *)
        CmdID : DINT ;   (* ID of current movement 1-5  *)
        ErrorID : DINT ;   (* Error Id for error condition. 0 = no error  *)
        CmdDone : DINT ;   (* Indicates completion of requested command.  *)
        SteerEncOffset : DINT ;   (* Calculated value  *)
        LaserScannerX : DINT ;   (* Calculated value  *)
        LaserScannerY : DINT ;   (* Calculated value  *)
        LaserScannerAngle : REAL ;   (* Calculated value  *)
        
   END_STRUCT;
END_TYPE
TYPE
    LanSerialPort_T :
    STRUCT 
        Protocol : DINT ;   (* Protocol used for IP communication.  *)
        IP : STRING ;   (* In case of Protocol set to UDP client or TCP client this should be set
to the IP address of the UDP/TCP server that the PLC connects to. With
Protocol set to UDP server or TCP server this specify the IP address of
the vehicle controller which clients should use.

In the case of Protocol set to UDP server or TCP server, the special
value "LAN" means that connections are only allowed on the
LAN interface and the special value "ANY" allows connections
on both the LAN interface and the WLAN interface.

Changing the address from the PLC will result in the connection being
closed. The new IP address will be used in the next PLC loop serial
read/write.  Note! It is not possible to change the address for a
range sensor connected using a LAN-serial-adapter.  *)
        Port : DINT ;   (* In case of Protocol set to UDP client or TCP client this should be set
to the port of the UDP/TCP server that the PLC connects to. With
Protocol set to UDP server or TCP server this specify the port on the
vehicle controller that the PLC opens for connections.

Changing the port from the PLC will result in the connection being
closed. The new port will be used in the next PLC loop serial
read/write.  Note! It is not possible to change the port for a range
sensor connected using a LAN-serial-adapter.  *)
        SendBuffer : BOOL ;   (* With SendBuffer set, outgoing data is sent over IP when the PLC
function block NDC_SERIAL_WRITE is called with argument
LENGTH=0. Without SendBuffer set, data is sent immediately but each IP
packet will contain at most 32 bytes data with more IP traffic as a
result.  *)
        
   END_STRUCT;
END_TYPE
TYPE
    UserDefined_T :
    STRUCT 
        HeartBeatTimeOut : BOOL ;   (*   *)
        MasterErrorStop : BOOL ;   (*   *)
        Boolean_3 : BOOL ;   (*   *)
        Boolean_4 : BOOL ;   (*   *)
        Boolean_5 : BOOL ;   (*   *)
        Boolean_6 : BOOL ;   (*   *)
        Boolean_7 : BOOL ;   (*   *)
        Boolean_8 : BOOL ;   (*   *)
        Boolean_9 : BOOL ;   (*   *)
        Boolean_10 : BOOL ;   (*   *)
        Boolean_11 : BOOL ;   (*   *)
        Boolean_12 : BOOL ;   (*   *)
        Boolean_13 : BOOL ;   (*   *)
        Boolean_14 : BOOL ;   (*   *)
        Boolean_15 : BOOL ;   (*   *)
        Boolean_16 : BOOL ;   (*   *)
        Boolean_17 : BOOL ;   (*   *)
        Boolean_18 : BOOL ;   (*   *)
        Boolean_19 : BOOL ;   (*   *)
        Boolean_20 : BOOL ;   (*   *)
        Boolean_21 : BOOL ;   (*   *)
        Boolean_22 : BOOL ;   (*   *)
        Boolean_23 : BOOL ;   (*   *)
        Boolean_24 : BOOL ;   (*   *)
        Boolean_25 : BOOL ;   (*   *)
        Boolean_26 : BOOL ;   (*   *)
        Boolean_27 : BOOL ;   (*   *)
        Boolean_28 : BOOL ;   (*   *)
        Boolean_29 : BOOL ;   (*   *)
        Boolean_30 : BOOL ;   (*   *)
        Integer32_1 : DINT ;   (*   *)
        Integer32_2 : DINT ;   (*   *)
        Integer32_3 : DINT ;   (*   *)
        Integer32_4 : DINT ;   (*   *)
        Integer32_5 : DINT ;   (*   *)
        Integer32_6 : DINT ;   (*   *)
        Integer32_7 : DINT ;   (*   *)
        Integer32_8 : DINT ;   (*   *)
        Integer32_9 : DINT ;   (*   *)
        Integer32_10 : DINT ;   (*   *)
        Integer32_11 : DINT ;   (*   *)
        Integer32_12 : DINT ;   (*   *)
        Integer32_13 : DINT ;   (*   *)
        Integer32_14 : DINT ;   (*   *)
        Integer32_15 : DINT ;   (*   *)
        Integer32_16 : DINT ;   (*   *)
        Integer32_17 : DINT ;   (*   *)
        Integer32_18 : DINT ;   (*   *)
        Integer32_19 : DINT ;   (*   *)
        Integer32_20 : DINT ;   (*   *)
        Integer32_21 : DINT ;   (*   *)
        TractionEncSpeed : DINT ;   (*   *)
        TractionSetSpeed : DINT ;   (*   *)
        FrontSetSpeed : DINT ;   (*   *)
        FrontEncSpeed : DINT ;   (*   *)
        FrontSetAngle : DINT ;   (*   *)
        FrontEncAngle : DINT ;   (*   *)
        RearSetSpeed : DINT ;   (*   *)
        RearEncSpeed : DINT ;   (*   *)
        RearSetAngle : DINT ;   (*   *)
        RearEncAngle : DINT ;   (*   *)
        VirFrontSetSpeed : DINT ;   (*   *)
        VirFrontEncSpeed : DINT ;   (*   *)
        VirFrontSetAngle : DINT ;   (*   *)
        VirFrontEncAngle : DINT ;   (*   *)
        VirRearSetSpeed : DINT ;   (*   *)
        VirRearEncSpeed : DINT ;   (*   *)
        VirRearSetAngle : DINT ;   (*   *)
        VirRearEncAngle : DINT ;   (*   *)
        Integer32_40 : DINT ;   (*   *)
        VirFFeedbackSpeed : DINT ;   (*   *)
        VirFFeedbackAngle : DINT ;   (*   *)
        VirRFeedbackSpeed : DINT ;   (*   *)
        VirRFeedbackAngle : DINT ;   (*   *)
        Integer32_45 : DINT ;   (*   *)
        Integer32_46 : DINT ;   (*   *)
        Integer32_47 : DINT ;   (*   *)
        Integer32_48 : DINT ;   (*   *)
        Integer32_49 : DINT ;   (*   *)
        Integer32_50 : DINT ;   (*   *)
        Integer32_51 : DINT ;   (*   *)
        Integer32_52 : DINT ;   (*   *)
        Integer32_53 : DINT ;   (*   *)
        Integer32_54 : DINT ;   (*   *)
        Integer32_55 : DINT ;   (*   *)
        Integer32_56 : DINT ;   (*   *)
        Integer32_57 : DINT ;   (*   *)
        Integer32_58 : DINT ;   (*   *)
        Integer32_59 : DINT ;   (*   *)
        Integer32_60 : DINT ;   (*   *)
        
   END_STRUCT;
END_TYPE
TYPE
    SDIO_T :
    STRUCT 
        SteerRegP : UINT ;   (* Steering Regulator P Gain  *)
        SteerRegI : UINT ;   (* Steering Regulator I Gain  *)
        SteerRegILimit : UINT ;   (* Steering Regulator I Gain Limit  *)
        SteerRegD : UINT ;   (* Steering Regulator D Gain  *)
        SteerRegPIDLimit : UINT ;   (* Limits the effect of feedback on the steering regulator.
The unit is mV in an SDIO-FSA system.
For system only feeding the regulator output on the canbus, the value is pure binary.  *)
        SteerRegOutOffset : INT ;   (* Output offset for the steering regulator.
This offset is added to the regulator output after the PID regulation.
The unit is mV in an SDIO-FSA system.
For system only feeding the regulator output on the canbus, the value is pure binary.  *)
        SteerRegOutLimit : UINT ;   (* Total output limit of the steering regulator.
The unit is mV in an SDIO-FSA system.
For system only feeding the regulator output on the canbus, the value is pure binary.  *)
        SteerRegFailureDelay : UINT ;   (* Delay before safe state in absence of correct feedback movement  *)
        SteerRegCheckOutHysteres : UINT ;   (* Feedback movement is checked when the regulator output is larger than this level  *)
        SteerEncScale : UINT ;   (* Steering Encoder Scale  *)
        SteerEncOffset : INT ;   (* Steering Encoder Offset (Position of Sync pulse)  *)
        SteerEncSyncFilter : UINT ;   (* Steering Encoder Sync Filter Window, unit [pulses]. Filter is applied with half of the value to the right and half of the value to the left of the last valid sync pulse. 0 = Filter disabled. OBS! Disabling the sync filter can be a serious safety issue!  *)
        SteerEncSyncEmergency : BOOL ;   (* Steering Encoder Sync Emergency. 0 = Sync Emergency disabled. OBS! Disabling the sync emergency can be a serious safety issue!  *)
        SteerEncSyncEnable : BOOL ;   (* Enable signal for encoder sync mechanism. Usually needed when having a multiturning steering encoder  *)
        SyncGateInput : USINT ;   (* Digital input used for sync gate. 0 = disabled  *)
        DriveRegFeedForward : UINT ;   (* Driving Regulator FeedForward Gain  *)
        DriveRegOffset : UINT ;   (* Driving Regulator Offset  *)
        DriveRegP : UINT ;   (* Driving Regulator P Gain  *)
        DriveRegI : UINT ;   (* Driving Regulator I Gain  *)
        DriveRegILimit : UINT ;   (* Driving Regulator I Gain Limit  *)
        DriveRegD : UINT ;   (* Driving Regulator D Gain  *)
        DriveRegPIDLimit : UINT ;   (* Limits the effect of feedback on the drive regulator.
The unit is mV in an SDIO-FSA system.
For system only feeding the regulator output on the canbus, the value is pure binary.  *)
        DriveRegOutOffset : INT ;   (* Output offset for the drive regulator.
This offset is added to the regulator output after the PID regulation.
The unit is mV in an SDIO-FSA system.
For system only feeding the regulator output on the canbus, the value is pure binary.  *)
        DriveRegOutLimit : UINT ;   (* Total output limit of the drive regulator. 
The unit is mV in an SDIO-FSA system.
For system only feeding the regulator output on the canbus, the value is pure binary.  *)
        DriveRegFailureDelay : UINT ;   (* Delay before safe state in absence of correct feedback movement  *)
        DriveRegCheckOutHysteres : UINT ;   (* Feedback movement is checked when the regulator output is larger than this level  *)
        DriveEncScale : UINT ;   (* Driving Encoder Scale  *)
        DigitalInput6_Polarity : BOOL ;   (* Digital Input 6 Polarity, pin #A21  *)
        FSA1Failure_Polarity : BOOL ;   (* FSA 1 Failure Polarity, pin #A20  *)
        FSA2Failure_Polarity : BOOL ;   (* FSA 2 Failure Polarity, pin #A19  *)
        DigitalInput9_Polarity : BOOL ;   (* Digital Input 9 Polarity, pin #B22  *)
        DigitalInput10_Polarity : BOOL ;   (* Digital Input 10 Polarity, pin #B23  *)
        DigitalInput11_Polarity : BOOL ;   (* Digital Input 11 Polarity, pin #A18  *)
        DigitalInput12_Polarity : BOOL ;   (* Digital Input 12 Polarity, pin #A17  *)
        DigitalOutput2_Polarity : BOOL ;   (* Digital Output 2 Polarity, pin #B7  *)
        DigitalOutput3_Polarity : BOOL ;   (* Digital Output 3 Polarity, pin #B6  *)
        DigitalOutput4_Polarity : BOOL ;   (* Digital Output 4 Polarity, pin #B5  *)
        DigitalOutput5_Polarity : BOOL ;   (* Digital Output 5 Polarity, pin #B4  *)
        DigitalOutput6_Polarity : BOOL ;   (* Digital Output 6 Polarity, pin #B1  *)
        DigitalOutput12_Polarity : BOOL ;   (* Digital Output 12 Polarity, pin #A3  *)
        AnInp1_Scale : DINT ;   (* Analog Input 1 Scale, pin #B15  *)
        AnInp2_Scale : DINT ;   (* Analog Input 2 Scale, pin #B17  *)
        AnInp3_Scale : DINT ;   (* Analog Input 3 Scale, pin #B10  *)
        AnInp4_Scale : DINT ;   (* Analog Input 4 Scale, pin #B18  *)
        AnInp5_Scale : DINT ;   (* Analog Input 5 Scale, pin #B11  *)
        AnInp6_Scale : DINT ;   (* Analog Input 6 Scale, pin #B19  *)
        AnInp7_Scale : DINT ;   (* Analog Input 7 Scale, pin #B12  *)
        AnInp8_Scale : DINT ;   (* Analog Input 8 Scale, pin #B20  *)
        AnInp9_Scale : DINT ;   (* Analog Input 9 Scale, pin #B13  *)
        AnInp10_Scale : DINT ;   (* Analog Input 10 Scale, pin #B21  *)
        AnInp11_Scale : DINT ;   (* Analog Input 11 Scale, pin #B14  *)
        AnInp1_Delta : UDINT ;   (* Asynchroneous transmission will be triggered if input has changed more than this value since last transmission.  *)
        AnInp2_Delta : UDINT ;   (* Asynchroneous transmission will be triggered if input has changed more than this value since last transmission.  *)
        AnInp3_Delta : UDINT ;   (* Asynchroneous transmission will be triggered if input has changed more than this value since last transmission.  *)
        AnInp4_Delta : UDINT ;   (* Asynchroneous transmission will be triggered if input has changed more than this value since last transmission.  *)
        AnInp5_Delta : UDINT ;   (* Asynchroneous transmission will be triggered if input has changed more than this value since last transmission.  *)
        AnInp6_Delta : UDINT ;   (* Asynchroneous transmission will be triggered if input has changed more than this value since last transmission.  *)
        AnInp7_Delta : UDINT ;   (* Asynchroneous transmission will be triggered if input has changed more than this value since last transmission.  *)
        AnInp8_Delta : UDINT ;   (* Asynchroneous transmission will be triggered if input has changed more than this value since last transmission.  *)
        AnInp9_Delta : UDINT ;   (* Asynchroneous transmission will be triggered if input has changed more than this value since last transmission.  *)
        AnInp10_Delta : UDINT ;   (* Asynchroneous transmission will be triggered if input has changed more than this value since last transmission.  *)
        AnInp11_Delta : UDINT ;   (* Asynchroneous transmission will be triggered if input has changed more than this value since last transmission.  *)
        AnInp1_Offset : DINT ;   (* Analog Input 1 Offset, pin #B15  *)
        AnInp2_Offset : DINT ;   (* Analog Input 2 Offset, pin #B17  *)
        AnInp3_Offset : DINT ;   (* Analog Input 3 Offset, pin #B10  *)
        AnInp4_Offset : DINT ;   (* Analog Input 4 Offset, pin #B18  *)
        AnInp5_Offset : DINT ;   (* Analog Input 5 Offset, pin #B11  *)
        AnInp6_Offset : DINT ;   (* Analog Input 6 Offset, pin #B19  *)
        AnInp7_Offset : DINT ;   (* Analog Input 7 Offset, pin #B12  *)
        AnInp8_Offset : DINT ;   (* Analog Input 8 Offset, pin #B20  *)
        AnInp9_Offset : DINT ;   (* Analog Input 9 Offset, pin #B13  *)
        AnInp10_Offset : DINT ;   (* Analog Input 10 Offset, pin #B21  *)
        AnInp11_Offset : DINT ;   (* Analog Input 11 Offset, pin #B14  *)
        Enc1AngularSpeed : INT ;   (* Encoder 1 Angular Speed  *)
        Enc1Angle : INT ;   (* Encoder 1 Angle  *)
        Enc1SyncValid : BOOL ;   (* Encoder 1 Sync Valid  *)
        Enc1Warning : BOOL ;   (* Encoder 1 Warning  *)
        Enc2Dist : UINT ;   (* Encoder 2 Distance  *)
        Enc2Speed : INT ;   (* Encoder 2 Speed  *)
        SetAngle : INT ;   (* Set Angle  *)
        SteerEnable : BOOL ;   (* Steering Control Enable  *)
        SetSpeed : INT ;   (* Set Speed  *)
        DriveEnable : BOOL ;   (* Driving Control Enable  *)
        Reserved_DigitalInput1 : BOOL ;   (* Reserved Digital Input 1 (Enc 1 A, pin #A14)  *)
        Reserved_DigitalInput2 : BOOL ;   (* Reserved Digital Input 2 (Enc 1 B, pin #A22)  *)
        Reserved_DigitalInput3 : BOOL ;   (* Reserved Digital Input 3 (Enc 1 Sync, pin #A7)  *)
        Reserved_DigitalInput4 : BOOL ;   (* Reserved Digital Input 4 (Enc 2 A, pin #A6)  *)
        Reserved_DigitalInput5 : BOOL ;   (* Reserved Digital Input 5 (Enc 2 B, pin #A13)  *)
        DigitalInput6 : BOOL ;   (* Digital Input 6 value, pin #A21  *)
        FSA1Failure : BOOL ;   (* FSA 1 Failure value, pin #A20  *)
        FSA2Failure : BOOL ;   (* FSA 2 Failure value, pin #A19  *)
        DigitalInput9 : BOOL ;   (* Digital Input 9 value, pin #B22  *)
        DigitalInput10 : BOOL ;   (* Digital Input 10 value, pin #B23  *)
        DigitalInput11 : BOOL ;   (* Digital Input 11 value, pin #A18  *)
        DigitalInput12 : BOOL ;   (* Digital Input 12 value, pin #A17  *)
        AllOK_DigitalOutput1 : BOOL ;   (* Reserved Digital Output 1 (All-OK, pin #B8)  *)
        DigitalOutput2 : BOOL ;   (* Digital Output 2 value, pin #B7  *)
        DigitalOutput3 : BOOL ;   (* Digital Output 3 value, pin #B6  *)
        DigitalOutput4 : BOOL ;   (* Digital Output 4 value, pin #B5  *)
        DigitalOutput5 : BOOL ;   (* Digital Output 5 value, pin #B4  *)
        DigitalOutput6 : BOOL ;   (* Digital Output 6 value, pin #B1  *)
        DigitalOutput12 : BOOL ;   (* Digital Output 12 value, pin #A3  *)
        AnalogInput1 : INT ;   (* Analog Input 1 value, pin #B15. The value is the applied input voltage (in Volts) * Scale + Offset  *)
        AnalogInput2 : INT ;   (* Analog Input 2 value, pin #B17. The value is the applied input voltage (in Volts) * Scale + Offset  *)
        AnalogInput3 : INT ;   (* Analog Input 3 value, pin #B10. The value is the applied input voltage (in Volts) * Scale + Offset  *)
        AnalogInput4 : INT ;   (* Analog Input 4 value, pin #B18. The value is the applied input voltage (in Volts) * Scale + Offset  *)
        AnalogInput5 : INT ;   (* Analog Input 5 value, pin #B11. The value is the applied input voltage (in Volts) * Scale + Offset  *)
        AnalogInput6 : INT ;   (* Analog Input 6 value, pin #B19. The value is the applied input voltage (in Volts) * Scale + Offset  *)
        AnalogInput7 : INT ;   (* Analog Input 7 value, pin #B12. The value is the applied input voltage (in Volts) * Scale + Offset  *)
        AnalogInput8 : INT ;   (* Analog Input 8 value, pin #B20. The value is the applied input voltage (in Volts) * Scale + Offset  *)
        AnalogInput9 : INT ;   (* Analog Input 9 value, pin #B13. The value is the applied input voltage (in Volts) * Scale + Offset  *)
        AnalogInput10 : INT ;   (* Analog Input 10 value, pin #B21. The value is the applied input voltage (in Volts) * Scale + Offset  *)
        AnalogInput11 : INT ;   (* Analog Input 11 value, pin #B14. The value is the applied input voltage (in Volts) * Scale + Offset  *)
        PWMOutput1 : INT ;   (* PWM Output 1 value, pin #A5. The value is the duty cycle of the output.  *)
        PWMOutput2 : INT ;   (* PWM Output 2 value, pin #A12. The value is the duty cycle of the output.  *)
        PWMOutput3 : INT ;   (* PWM Output 3 value, pin #A11. The value is the duty cycle of the output.  *)
        Reg1Output : INT ;   (* Regulator 1 output value  *)
        Reg2Output : INT ;   (* Regulator 2 output value  *)
        GroundFaultEvent : BOOL ;   (* If set to true, a ground fault will cause a system event 229.  *)
        GroundFaultActive : BOOL ;   (* True if a ground fault is present  *)
        Temperature : DINT ;   (* Current temperature  *)
        XV_Out : DINT ;   (* Current xv out voltage  *)
        B_Plus : DINT ;   (* Current b plus voltage  *)
        BusID : DINT ;   (* CAN bus ID  *)
        NodeID : DINT ;   (* CAN node ID  *)
        FailureAction : DINT ;   (* 0 = Background, the background programs takes action when an error occur in the device. 1 = PLC, no action from background program. The error should be handled by the PLC application.  *)
        ActiveInSafeState : BOOL ;   (* Decides if the device will start up in safe state.  *)
        NMTState : UDINT ;   (* The current CANopen state of the device.  *)
        SdoBufferSize : DINT ;   (* The current size of the client SDO buffer (read/write SDO's from the vehicle controller to this device).  *)
        
   END_STRUCT;
END_TYPE

TYPE
    NDC8_T : 
    STRUCT 
	NavInit : NavInit_T;
	    Mcd : MCD7P_T;
	    Position : Position_T;
	    Guidance : Guidance_T;
	    Autoinsert : Autoinsert_T;
	    Opt : GenericDisplay_T;
	    LayoutPosition : LayoutPosition_T;
	    Automatic : Automatic_T;
	    Manual : Manual_T;
	    BlackBox : BlackBox_T;
	    LocalOrder : LocalOrder_T;
	    SSIO : SSIO_T;
	    SegmentTrigger : SegmentTrigger_T;
	    PointTrigger : PointTrigger_T;
	    LoadDocking : LoadDocking_T;
	    LoadOperation : LoadOperation_T;
	    CANBus1 : CANBus_T;
	    CANBus2 : CANBus_T;
	    VehicleControl : VehicleControl_T;
	    VehicleOptions : VehicleOptions_T;
	    PLC_Application : PLC_Application_T;
	    COM1 : SerialPort_RS232_T;
	    COM2 : SerialPort_RS422_T;
	    COM3 : SerialPort_RS485_T;
	    Master : Master_T;
	    Vmc : Vmc_T;
	    Wlan : Wlan_T;
	    OMPLC : OMPLC_T;
	    VehicleApplication : VehicleApplication_T;
	    Layout : Layout_T;
	    CanOpenMaster : CanOpenMaster_T;
	    CanOpenEmergency : CanOpenEmergency_T;
	    PLCEmergency : PLCEmergency_T;
	    SlavebusControl : SlavebusControl_T;
	    UserDefined : UserDefined_T;
	    ExternalPath : ExternalPath_T;
	    BlockedInfo : BlockedInfo_T;
	    FrontWheel : WheelSD_T;
	    LS2000 : LS2000Scanner_T;
	    COM5 : LanSerialPort_T;
	    Vehicle : Vehicle_T;
	    PPA : PPA_T;
	    TurnSignal : TurnSignal_T;
	    LaserNavigator : LaserNavigator_T;
	    ReflectorInit : ReflectorInit_T;
	    NaturalNavigator : NaturalNavigator_T;
	    VehicleNavigator : VehicleNavigator_T;
	    SDIO : SDIO_T;
	    

   END_STRUCT;
END_TYPE
