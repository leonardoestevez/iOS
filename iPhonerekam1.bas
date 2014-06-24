! Define the various UUIDs
blueRadiosUUID$ = "DA2B84F1-6279-48DE-BDC0-AFBEA0226079"
infoUUID$ = "99564A02-DC01-4D3C-B04E-3BB1EF0571B2"
modeUUID$ = "A87988B9-694C-479C-900E-95DFA6C00A24"
rxUUID$ = "BF03260C-7205-4C25-AF43-93B1C299D159"
txUUID$ = "18CDA784-4BD3-4370-85BB-BFED91EC86AF"

! Set to 1 for verbose debug output.
debug% = 0
line$ = ""
greaterless = 0

! This is the device we've connected to, if any.
DIM blueRadiosPeripheral AS BLEPeripheral

! Used to create a pause before accepting commands.
DIM commandsAllowed AS INTEGER, commandTime AS DOUBLE, delay AS DOUBLE
delay = 0.5


! Create a text field with a label.
DIM myTextField AS TextField,textFieldLabel AS Label
textFieldLabel = Graphics.newLabel(Graphics.width-180, Graphics.height-600, 180, 50)
textFieldLabel.setBackgroundColor(0.7, 0.7, 0.7)
textFieldLabel.setText("REKAM1 RESPONSE")
textFieldLabel.setFont("Arial", 12, 1)
textFieldLabel.setAlignment(2)

! Create a label to show the current value of the text field.
DIM textFieldValueLabel AS Label
textFieldValueLabel = Graphics.newLabel(Graphics.width-250, Graphics.height-540, 315, 50)

!Create a text view with a label.
DIM myTextView AS TextView, textViewLabel AS Label
textViewLabel = Graphics.newLabel(Graphics.width-250, Graphics.height-480, 120, 50)
textViewLabel.setBackgroundColor(0.7, 0.7, 0.7)
textViewLabel.setText("COMMAND LINE")
textViewLabel.setFont("Arial", 12, 1)
textViewLabel.setAlignment(2)

! Create a read-only text view to show the types text.
DIM textViewValue AS TextView, textViewValue1 AS TextView, textViewValue2 AS TextView, textViewValue3 AS TextView, textViewValue4 AS TextView, textViewValue5 AS TextView, textViewValue6 AS TextView, textViewValue7 AS TextView, textViewValue8 AS TextView,  textViewValue9 AS TextView, textViewValue10 AS TextView
textViewValue = Graphics.newTextView(Graphics.width-115, Graphics.height-480, 180, 50)
textViewValue.setEditable(0)

! Create an activity indicator with buttons.
DIM activityRead as Button, activityDo as Button, activityGet as Button, activityEndif as Button, activityPut as button, activityIf as Button, activitySleep as Button

! Create a Lessthan and Greaterthan picker.
DIM activityLessthan AS Label
activityLessthan = Graphics.newLabel(Graphics.width-75, Graphics.height-210, 60, 35)
activityLessthan.setBackgroundColor(0.3, 0.3, 0.3)
!activityLessthan.setText("ifl")
!activityLessthan.setAlignment(2)

DIM activityGreaterthan AS Label
activityGreaterthan = Graphics.newLabel(Graphics.width-75, Graphics.height-210, 60, 35)
activityGreaterthan.setBackgroundColor(0.3, 0.3, 0.3)
!activityGreaterthan.setText("ifg")
!activityGreaterthan.setAlignment(2)
activityGreaterthan.setHidden(1)


activityRead = Graphics.newButton(Graphics.width-250, Graphics.height-410, 60)
activityRead.setTitle("read")
activityRead.setBackgroundColor(1, 1, 1)
activityRead.setGradientColor(0.7, 0.7, 0.7)

activityDo = Graphics.newButton(Graphics.width-75, Graphics.height-410, 60)
activityDo.setTitle("do")
activityDo.setBackgroundColor(1, 1, 1)
activityDo.setGradientColor(0.7, 0.7, 0.7)

activityGet = Graphics.newButton(Graphics.width-250, Graphics.height-360, 60)
activityGet.setTitle("get")
activityGet.setBackgroundColor(1, 1, 1)
activityGet.setGradientColor(0.7, 0.7, 0.7)

textViewValue3 = Graphics.newTextView(Graphics.width-170, Graphics.height-360, 60, 35)
textViewValue3.setBackgroundColor(1, 1, 1)
textViewValue3.setFont("Arial", 16, 1)
textViewValue3.setAlignment(2)

activityEndif = Graphics.newButton(Graphics.width-75, Graphics.height-360, 60)
activityEndif.setTitle("endif")
activityEndif.setBackgroundColor(1, 1, 1)
activityEndif.setGradientColor(0.7, 0.7, 0.7)

activityPut = Graphics.newButton(Graphics.width-250, Graphics.height-310, 60)
activityPut.setTitle("put")
activityPut.setBackgroundColor(1, 1, 1)
activityPut.setGradientColor(0.7, 0.7, 0.7)

textViewValue5 = Graphics.newTextView(Graphics.width-170, Graphics.height-310, 60, 35)
textViewValue5.setBackgroundColor(1, 1, 1)
textViewValue5.setFont("Arial", 16, 1)
textViewValue5.setAlignment(2)

textViewValue9 = Graphics.newTextView(Graphics.width-170, Graphics.height-260, 60, 35)
textViewValue9.setBackgroundColor(1, 1, 1)
textViewValue9.setFont("Arial", 16, 1)
textViewValue9.setAlignment(2)

activityIf = Graphics.newButton(Graphics.width-250, Graphics.height-260, 60)
activityIf.setTitle("if")
activityIf.setBackgroundColor(1, 1, 1)
activityIf.setGradientColor(0.7, 0.7, 0.7)

textViewValue6 = Graphics.newTextView(Graphics.width-170, Graphics.height-260, 60, 35)
textViewValue6.setBackgroundColor(1, 1, 1)
textViewValue6.setFont("Arial", 16, 1)
textViewValue6.setAlignment(2)

! Create a segmented control to choose between various controls.
DIM controlPicker AS SegmentedControl
controlPicker = Graphics.newSegmentedControl(Graphics.width-75, Graphics.height-260, 60, 35)
controlPicker.insertSegment("<", 1, 0)
controlPicker.insertSegment(">", 2, 0)
controlPicker.setSelected(1)
controlPicker.setApportionByContent(1)

textViewValue7 = Graphics.newTextView(Graphics.width+5, Graphics.height-260, 60, 35)
textViewValue7.setBackgroundColor(1, 1, 1)
textViewValue7.setFont("Arial", 16, 1)
textViewValue7.setAlignment(2)

activitySleep = Graphics.newButton(Graphics.width-250, Graphics.height-210, 60)
activitySleep.setTitle("sleep")
activitySleep.setBackgroundColor(1, 1, 1)
activitySleep.setGradientColor(0.7, 0.7, 0.7)

textViewValue8 = Graphics.newTextView(Graphics.width-170, Graphics.height-210, 60, 35)
textViewValue8.setBackgroundColor(1, 1, 1)
textViewValue8.setFont("Arial", 16, 1)
textViewValue8.setAlignment(2)

! Paint the background gray.
Graphics.setColor(0.3, 0.3, 0.3)
Graphics.fillRect(0, 0, Graphics.width, Graphics.height)

! Show the graphics screen.
System.showGraphics(1)

! Start BLE processing and scan for a Blue Radios device.
BLE.startBLE
DIM uuid(1) AS STRING
uuid(1) = blueRadiosUUID$
BLE.startScan(uuid)

! Called to return information from a characteristic.
!
! Parameters:
!    time - The time when the information was received.
!    peripheral - The peripheral.
!    characteristic - The characteristic whose information
!        changed.
!    kind - The kind of call. One of
!        1 - Called after a discoverDescriptors call.
!        2 - Called after a readCharacteristics call.
!        3 - Called to report status after a writeCharacteristics
!            call.
!    message - For errors, a human-readable error message.
!    err - If there was an error, the Apple error number. If there
!        was no error, this value is 0.
!

SUB BLECharacteristicInfo (time AS DOUBLE, peripheral AS BLEPeripheral, characteristic AS BLECharacteristic, kind AS INTEGER, message AS STRING, err AS LONG)
IF kind = 2 THEN
DIM ch AS BLECharacteristic
DIM value(1) AS INTEGER
value = characteristic.value
SELECT CASE characteristic.uuid
CASE infoUUID$
  ! The device returned the initial information.
  DIM value(0) AS INTEGER
  value = characteristic.value
  IF debug% THEN
    PRINT "Info: "
  END IF
  IF (value(1) BITAND $02) = $02 THEN
    ! Start watching for data from the device.
    ch = findCharacteristic(txUUID$)
    peripheral.setNotify(ch, 1)

    ! Set the mode to remote command mode.
    ! value = [2]
    value = [1]
    ch = findCharacteristic(modeUUID$)
    peripheral.writeCharacteristic(ch, value, 1)
  ELSE
    PRINT "This device does not support terminal mode."
    STOP
  END IF

CASE txUUID$
  ! The device sent back information via TX.
  data% = characteristic.value
  data$ = ""
  FOR i = 1 TO UBOUND(data%, 1)
    IF data%(i) <> 13 THEN
      data$ = data$ & CHR(data%(i))
    END IF
  NEXT
  shared_value = 0
  textFieldValueLabel.setText(data$ & "\n ")
  textFieldValueLabel.setFont("Arial", 16, 1)
  textFieldValueLabel.setAlignment(1)

CASE modeUUID$
  ! The device sent back the mode.
  data% = characteristic.value
  IF debug% THEN
  PRINT data%
  END IF

CASE ELSE
  PRINT "Unexpected value from "; characteristic.uuid; ": "; valueToHex(characteristic.value)

END SELECT
ELSE IF kind = 3 THEN
! Write response recieved.
IF debug% THEN
r$ = "Response from characteristic " & characteristic.uuid
r$ = r$ & " with error code " & STR(err)
PRINT r$
END IF

! All write responses indicate we can accept a new command. Set the
! flag, but be sure and wait a short time for other response pieces to
! arrive.
IF characteristic.uuid = modeUUID$ THEN
! The mode has been set.
IF debug% THEN
  peripheral.readCharacteristic(characteristic)
END IF
END IF
commandsAllowed = 1
commandTime = time + delay
END IF
END SUB



! Called when a peripheral is found. If it is a BlueRadios device, we
! initiate a connection to is and stop scanning for peripherals.
!
! Parameters:
!    time - The time when the peripheral was discovered.
!    peripheral - The peripheral that was discovered.
!    services - List of services offered by the device.
!    advertisements - Advertisements (information provided by the
!        device without the need to read a service/characteristic)
!    rssi - Received Signal Strength Indicator

SUB BLEDiscoveredPeripheral (time AS DOUBLE, peripheral AS BLEPeripheral, services() AS STRING, advertisements(,) AS STRING, rssi)
blueRadiosPeripheral = peripheral
IF debug% THEN
PRINT "Attempting to connect to "; blueRadiosPeripheral.bleName
END IF
IF blueRadiosPeripheral.bleName = "BlueRadios115AD1" THEN
BLE.connect(blueRadiosPeripheral)
BLE.stopScan
PRINT "Platform Connected"
END IF
END SUB


! Called to report information about the connection status of the
! peripheral or to report that services have been discovered.
!
! Parameters:
!    time - The time when the information was received.
!    peripheral - The peripheral.
!    kind - The kind of call. One of
!        1 - Connection completed
!        2 - Connection failed
!        3 - Connection lost
!        4 - Services discovered
!    message - For errors, a human-readable error message.
!    err - If there was an error, the Apple error number. If there
!        was no error, this value is 0.

SUB BLEPeripheralInfo (time AS DOUBLE, peripheral AS BLEPeripheral, kind AS INTEGER, message AS STRING, err AS LONG)
DIM uuid(0) AS STRING

IF kind = 1 THEN
! The connection was established. Look for available services.
peripheral.discoverServices(uuid)
ELSE IF kind = 2 OR kind = 3 THEN
PRINT "The connection was lost."
ELSE IF kind = 4 THEN
! Services were found. If it is the main service, begin discovery
! of its characteristics.
DIM availableServices(1) AS BLEService
availableServices = peripheral.services
FOR a = 1 TO UBOUND(availableServices, 1)
IF debug% THEN
  PRINT "Found service "; availableServices(a).UUID
END IF
IF availableServices(a).UUID = blueRadiosUUID$ THEN
  peripheral.discoverCharacteristics(uuid, availableServices(a))
END IF
NEXT
END IF
END SUB


! Called to report information about a characteristic or included
! services for a service. If it is one we are interested in, start
! handling it.
!
! Parameters:
!    time - The time when the information was received.
!    peripheral - The peripheral.
!    service - The service whose characteristic or included
!        service was found.
!    kind - The kind of call. One of
!        1 - Characteristics found
!        2 - Included services found
!    message - For errors, a human-readable error message.
!    err - If there was an error, the Apple error number. If there
!        was no error, this value is 0.

SUB BLEServiceInfo (time AS DOUBLE, peripheral AS BLEPeripheral, service AS BLEService, kind AS INTEGER, message AS STRING, err AS LONG)
IF kind = 1 THEN
! Get the characteristics.
DIM characteristics(1) AS BLECharacteristic
characteristics = service.characteristics
FOR i = 1 TO UBOUND(characteristics, 1)
IF debug% THEN
  PRINT "Found characteristic "; i; ": "; characteristics(i).uuid
END IF
IF characteristics(i).uuid = infoUUID$ THEN
  peripheral.readCharacteristic(characteristics(i))
END IF
NEXT
END IF
END SUB


! Find a characteristic for the main blueRadiosUUID service by
! characteristic UUID. This cannot be done until after characteristics
! have been discovered.
!
! Parameters:
!    uuid - The UUID of the characteristic to find.
!
! Returns: The characteristic.

FUNCTION findCharacteristic (uuid AS STRING) AS BLECharacteristic
! Find the main BlueRadios service.
DIM availableServices(1) AS BLEService
availableServices = blueRadiosPeripheral.services
FOR a = 1 TO UBOUND(availableServices, 1)
IF availableServices(a).UUID = blueRadiosUUID$ THEN

! Find the characteristic.
DIM availableCharacteristics(1) AS BLECharacteristic
availableCharacteristics = availableServices(a).characteristics
FOR c = 1 TO UBOUND(availableCharacteristics, 1)
  IF availableCharacteristics(c).uuid = uuid THEN
    findCharacteristic = availableCharacteristics(c)
    GOTO 99
  END IF
NEXT
END IF
NEXT

PRINT "An expected characteristic was not found."
STOP

99:
END FUNCTION

!  ELSE
!    IF mySwitch.isOFF THEN
! END IF



! Called when nothing else is happening.
!
! Check to see if commands can be accepted. If so, get a user command.

SUB nullEvent (time AS DOUBLE)
IF commandsAllowed AND (time > commandTime) THEN
  ! Let the user type a command, sending it to RX.
!  LINE INPUT "> "; line$
!  DIM line%(LEN(line$) + 1)
!  FOR i = 1 TO LEN(line$)
!    line%(i) = ASC(MID(line$, i, 1))
!  NEXT
!  line%(UBOUND(line%, 1)) = 13

!  DIM ch AS BLECharacteristic
!  ch = findCharacteristic(rxUUID$)
!  blueRadiosPeripheral.writeCharacteristic(ch, line%, 1)

  ! Don't allow additional commmands until this one is complete.
!  commandsAllowed = 0
END IF
END SUB


! Convert an array of byte values to a hexadecimal string.
!
! Parameters:
!       value - The array of bytes.
!
! Returns: A string of hexadecimal digits representing the value.

FUNCTION valueToHex (value() AS INTEGER) AS STRING
s$ = ""
FOR i = 1 TO UBOUND(value, 1)
  s$ = s$ & RIGHT(HEX(value(i)), 2)
NEXT
valueToHex = s$
END FUNCTION


! Handle a tap on a button.
!
! Parameters:
!    ctrl - The button that was tapped.
!    time - The time stamp when the button was tapped.
!
SUB touchUpInside (ctrl AS Button, time AS DOUBLE)

IF ctrl = activityRead THEN

textViewValue.setText("read")
line$ = "read" & "\n"
textViewValue.setAlignment(2)
textViewValue.setFont("Arial", 20, 1)
END IF

IF ctrl = activityDo THEN

textViewValue.setText("do")
line$ = "do" & "\n"
textViewValue.setAlignment(2)
textViewValue.setFont("Arial", 20, 1)
END IF

IF ctrl = activityGet THEN

textViewValue.setText("get" & " " & textViewValue3.getText)
line$ = "get" & " " & textViewValue3.getText & "\n"
textViewValue.setAlignment(2)
textViewValue.setFont("Arial", 20, 1)
END IF

IF ctrl = activityEndif THEN

textViewValue.setText("endif")
line$ = "endif" & "\n"
textViewValue.setAlignment(2)
textViewValue.setFont("Arial", 20, 1)
END IF

IF ctrl = activityPut THEN

textViewValue.setText("put" & " " & textViewValue5.getText  & " " &textViewValue9.getText)
line$ = "put" & " " & textViewValue5.getText  & " " & textViewValue9.getText & "\n"
textViewValue.setAlignment(2)
textViewValue.setFont("Arial", 20, 1)
END IF

IF ctrl = activityIf THEN

IF greaterless = 0 THEN

textViewValue.setText("ifl" & " " & textViewValue6.getText  & " " & textViewValue7.getText)
line$ = "ifl" & " " & textViewValue6.getText  & " " & textViewValue7.getText & "\n"
textViewValue.setAlignment(2)
textViewValue.setFont("Arial", 20, 1)

ELSE

textViewValue.setText("ifg" & " " & textViewValue6.getText  & " " & textViewValue7.getText)
line$ = "ifg" & " " & textViewValue6.getText  & " " & textViewValue7.getText & "\n"
textViewValue.setAlignment(2)
textViewValue.setFont("Arial", 20, 1)

END IF

END IF

IF ctrl = activitySleep THEN

textViewValue.setText("sleep" & " " & textViewValue8.getText)
line$ = "sleep" & " " & textViewValue8.getText & "\n"
textViewValue.setAlignment(2)
textViewValue.setFont("Arial", 20, 1)
END IF

DIM line%(LEN(line$) + 1)
  FOR i = 1 TO LEN(line$)
    line%(i) = ASC(MID(line$, i, 1))
  NEXT
  line%(UBOUND(line%, 1)) = 13

  DIM ch AS BLECharacteristic
  ch = findCharacteristic(rxUUID$)
  blueRadiosPeripheral.writeCharacteristic(ch, line%, 1)

END SUB

SUB valueChanged (ctrl AS Control, time AS DOUBLE)
IF ctrl = controlPicker THEN
  SELECT CASE controlPicker.selected
    CASE 1:
      activityLessthan.setHidden(0)
      activityGreaterthan.setHidden(1)
      greaterless=0
    CASE 2:
      activityLessthan.setHidden(1)
      activityGreaterthan.setHidden(0)
      greaterless=1
  END SELECT

END IF

END SUB