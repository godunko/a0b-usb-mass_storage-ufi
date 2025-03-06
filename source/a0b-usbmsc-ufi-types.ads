--
--  Copyright (C) 2025, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with System;

with A0B.Types.Arrays;
with A0B.Types.Big_Endian;

package A0B.USBMSC.UFI.Types
  with Pure, No_Elaboration_Code_All
is

   use type A0B.Types.Unsigned_32;

   Command_Block_Length : constant := 12;
   --  Command_Block_Size   : constant :=
   --    Command_Block_Length * A0B.Types.Unsigned_8'Size;

   subtype Command_Buffer is
     A0B.Types.Arrays.Unsigned_8_Array (0 .. Command_Block_Length - 1);

   type Operation_Code is new A0B.Types.Unsigned_8;

   TEST_UNIT_READY_Operation_Code         : constant Operation_Code := 16#00#;
   REQUEST_SENSE_Operation_Code                : constant := 16#03#;
   INQUIRY_Operation_Code                 : constant Operation_Code := 16#12#;
   READ_CAPACITY_Operation_Code           : constant Operation_Code := 16#25#;
   READ_10_Operation_Code                      : constant := 16#28#;
   MODE_SENSE_Operation_Code              : constant Operation_Code := 16#5A#;
   --  Format Unit_Operation_Code                  : 04#
   --  Mode Select_Operation_Code                  : 55
   --  Prevent-Allow Medium Removal_Operation_Code : 1E
   --  Read(12)_Operation_Code                     : A8
   --  Read Format Capacities_Operation_Code       : 23
   --  Rezero_Operation_Code                       : 01
   --  Seek(10)_Operation_Code                     : 2B
   --  Send Diagnostic_Operation_Code              : 1D
   --  Start-Stop Unit_Operation_Code              : 1B
   --  Verify_Operation_Code                       : 2F
   --  Write(10)_Operation_Code                    : 2A
   --  Write(12)_Operation_Code                    : AA
   --  Write and Verify_Operation_Code             : 2E

   --  NO_SENSE_Sense_Key        : constant := 16#0#;
   --  RECOVERED_ERROR_Sense_Key : constant := 16#1#;
   --  NOT_READY_Sense_Key       : constant := 16#2#;
   --  MEDIUM_ERROR_Sense_Key    : constant := 16#3#;
   --  HARDWARE_ERROR_Sense_Key  : constant := 16#4#;
   --  ILLEGAL_REQUEST_Sense_Key : constant := 16#5#;
   --  UNIT_ATTENTION_Sense_Key  : constant := 16#6#;
   --  DATA_PROTECT_Sense_Key    : constant := 16#7#;
   --  BLANK_CHECK_Sense_Key     : constant := 16#8#;
   --  ABORTED_COMMAND_Sense_Key : constant := 16#B#;
   --  VOLUME_OVERFLOW_Sense_Key : constant := 16#D#;
   --  MISCOMPARE_Sense_Key      : constant := 16#E#;

   type Sense_Keys is record
      Sense_Key                       : A0B.Types.Unsigned_4;
      Additional_Sense_Code           : A0B.Types.Unsigned_8;
      Additional_Sence_Code_Qualifier : A0B.Types.Unsigned_8;
   end record;

   NO_SENSE                  : constant Sense_Keys := (16#0#, 16#00#, 16#00#);
   INVALID_COMMAND_OPERATION_CODE :
                               constant Sense_Keys := (16#5#, 16#20#, 16#00#);

--  Sense
--  Key
--  00
--  01
--  01
--  02
--  02
--  02
--  02
--  02
--  02
--  02
--  02
--  02
--  02
--  02
--  02
--  03
--  03
--  03
--  03
--  03
--  03
--  03
--  03
--  03
--  04
--  05
--  05
--  05
--  05
--  05
--  05
--  05
--  05
--  05
--  06
--  ASCASCQ
--  00
--  17
--  18
--  04
--  04
--  04
--  04
--  06
--  08
--  08
--  08
--  3A
--  54
--  80
--  FF
--  02
--  03
--  10
--  11
--  12
--  13
--  14
--  30
--  31
--  40
--  1A
--  20
--  21
--  24
--  25
--  26
--  26
--  26
--  39
--  2800
--  01
--  00
--  01
--  02
--  04
--  FF
--  00
--  00
--  01
--  80
--  00
--  00
--  00
--  FF
--  00
--  00
--  00
--  00
--  00
--  00
--  00
--  01
--  01
--  NN
--  00
--  00
--  00
--  00
--  00
--  00
--  01
--  02
--  00
--  00
--  062900
--  06
--  07
--  0B2F
--  27
--  4E00
--  00
--  00
--  1999.01.05
--  Description of Error
--  NO SENSE
--  RECOVERED DATA WITH RETRIES
--  RECOVERED DATA WITH ECC
--  LOGICAL DRIVE NOT READY - BECOMING READY
--  LOGICAL DRIVE NOT READY - INITIALIZATION REQUIRED
--  LOGICAL UNIT NOT READY - FORMAT IN PROGRESS
--  LOGICAL DRIVE NOT READY - DEVICE IS BUSY
--  NO REFERENCE POSITION FOUND
--  LOGICAL UNIT COMMUNICATION FAILURE
--  LOGICAL UNIT COMMUNICATION TIME-OUT
--  LOGICAL UNIT COMMUNICATION OVERRUN
--  MEDIUM NOT PRESENT
--  USB TO HOST SYSTEM INTERFACE FAILURE
--  INSUFFICIENT RESOURCES
--  UNKNOWN ERROR
--  NO SEEK COMPLETE
--  WRITE FAULT
--  ID CRC ERROR
--  UNRECOVERED READ ERROR
--  ADDRESS MARK NOT FOUND FOR ID FIELD
--  ADDRESS MARK NOT FOUND FOR DATA FIELD
--  RECORDED ENTITY NOT FOUND
--  CANNOT READ MEDIUM - UNKNOWN FORMAT
--  FORMAT COMMAND FAILED
--  DIAGNOSTIC FAILURE ON COMPONENT NN (80H-FFH)
--  PARAMETER LIST LENGTH ERROR
--  INVALID COMMAND OPERATION CODE
--  LOGICAL BLOCK ADDRESS OUT OF RANGE
--  INVALID FIELD IN COMMAND PACKET
--  LOGICAL UNIT NOT SUPPORTED
--  INVALID FIELD IN PARAMETER LIST
--  PARAMETER NOT SUPPORTED
--  PARAMETER VALUE INVALID
--  SAVING PARAMETERS NOT SUPPORT
--  NOT READY TO READY TRANSITION - MEDIA
--  CHANGED
--  POWER ON RESET OR BUS DEVICE RESET
--  OCCURRED
--  COMMANDS CLEARED BY ANOTHER INITIATOR
--  WRITE PROTECTED MEDIA
--  OVERLAPPED COMMAND ATTEMPTED

   type Command_Block is record
      Operation_Code      : Types.Operation_Code;
      Logical_Unit_Number : A0B.Types.Unsigned_3;
      Reserved_1          : A0B.Types.Reserved_5;
      Reserved_2          : A0B.Types.Reserved_8;
      Reserved_3          : A0B.Types.Reserved_8;
      Reserved_4          : A0B.Types.Reserved_8;
      Reserved_5          : A0B.Types.Reserved_8;
      Reserved_6          : A0B.Types.Reserved_8;
      Reserved_7          : A0B.Types.Reserved_8;
      Reserved_8          : A0B.Types.Reserved_8;
      Reserved_9          : A0B.Types.Reserved_8;
      Reserved_10         : A0B.Types.Reserved_8;
      Reserved_11         : A0B.Types.Reserved_8;
   end record
     with Size      => Command_Block_Length * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for Command_Block use record
      Operation_Code      at 0 range 0 .. 7;
      Reserved_1          at 1 range 0 .. 4;
      Logical_Unit_Number at 1 range 5 .. 7;
      Reserved_2          at 2 range 0 .. 7;
      Reserved_3          at 3 range 0 .. 7;
      Reserved_4          at 4 range 0 .. 7;
      Reserved_5          at 5 range 0 .. 7;
      Reserved_6          at 6 range 0 .. 7;
      Reserved_7          at 7 range 0 .. 7;
      Reserved_8          at 8 range 0 .. 7;
      Reserved_9          at 9 range 0 .. 7;
      Reserved_10         at 10 range 0 .. 7;
      Reserved_11         at 11 range 0 .. 7;
   end record;

   --  REQUEST_SENSE (03)

   type REQUEST_SENSE_Command_Block is record
      Operation_Code      : A0B.Types.Unsigned_8 :=
        REQUEST_SENSE_Operation_Code;
      Logical_Unit_Number : A0B.Types.Unsigned_3;
      Reserved_1          : A0B.Types.Reserved_5;
      Reserved_2          : A0B.Types.Reserved_8;
      Reserved_3          : A0B.Types.Reserved_8;
      Allocation_Length   : A0B.Types.Unsigned_8;
      Reserved_5          : A0B.Types.Reserved_8;
      Reserved_6          : A0B.Types.Reserved_8;
      Reserved_7          : A0B.Types.Reserved_8;
      Reserved_8          : A0B.Types.Reserved_8;
      Reserved_9          : A0B.Types.Reserved_8;
      Reserved_10         : A0B.Types.Reserved_8;
      Reserved_11         : A0B.Types.Reserved_8;
   end record
     with Size      => 12 * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for REQUEST_SENSE_Command_Block use record
      Operation_Code      at 0 range 0 .. 7;
      Reserved_1          at 1 range 0 .. 4;
      Logical_Unit_Number at 1 range 5 .. 7;
      Reserved_2          at 2 range 0 .. 7;
      Reserved_3          at 3 range 0 .. 7;
      Allocation_Length   at 4 range 0 .. 7;
      Reserved_5          at 5 range 0 .. 7;
      Reserved_6          at 6 range 0 .. 7;
      Reserved_7          at 7 range 0 .. 7;
      Reserved_8          at 8 range 0 .. 7;
      Reserved_9          at 9 range 0 .. 7;
      Reserved_10         at 10 range 0 .. 7;
      Reserved_11         at 11 range 0 .. 7;
   end record;

   type REQUEST_SENSE_Data_Block is record
      Valid                           : Boolean;
      Error_Code                      : A0B.Types.Unsigned_7 := 16#70#;
      Reserved_1                      : A0B.Types.Reserved_8;
      Reserved_2                      : A0B.Types.Reserved_4;
      Sense_Key                       : A0B.Types.Unsigned_4;
      Information                     : A0B.Types.Big_Endian.Unsigned_32;
      Additional_Sense_Length         : A0B.Types.Unsigned_8;
      Reserved_8                      : A0B.Types.Reserved_8;
      Reserved_9                      : A0B.Types.Reserved_8;
      Reserved_10                     : A0B.Types.Reserved_8;
      Reserved_11                     : A0B.Types.Reserved_8;
      Additional_Sense_Code           : A0B.Types.Unsigned_8;
      Additional_Sense_Code_Qualifier : A0B.Types.Unsigned_8;
      Reserved_14                     : A0B.Types.Reserved_8;
      Reserved_15                     : A0B.Types.Reserved_8;
      Reserved_16                     : A0B.Types.Reserved_8;
      Reserved_17                     : A0B.Types.Reserved_8;
   end record
     with Size      => 18 * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for REQUEST_SENSE_Data_Block use record
      Error_Code                      at 0 range 0 .. 6;
      Valid                           at 0 range 7 .. 7;
      Reserved_1                      at 1 range 0 .. 7;
      Sense_Key                       at 2 range 0 .. 3;
      Reserved_2                      at 2 range 4 .. 7;
      Information                     at 3 range 0 .. 31;
      Additional_Sense_Length         at 7 range 0 .. 7;
      Reserved_8                      at 8 range 0 .. 7;
      Reserved_9                      at 9 range 0 .. 7;
      Reserved_10                     at 10 range 0 .. 7;
      Reserved_11                     at 11 range 0 .. 7;
      Additional_Sense_Code           at 12 range 0 .. 7;
      Additional_Sense_Code_Qualifier at 13 range 0 .. 7;
      Reserved_14                     at 14 range 0 .. 7;
      Reserved_15                     at 15 range 0 .. 7;
      Reserved_16                     at 16 range 0 .. 7;
      Reserved_17                     at 17 range 0 .. 7;
   end record;

   --  INQUIRY (12)

   type INQUIRY_Command_Block is record
      Operation_Code            : Types.Operation_Code := INQUIRY_Operation_Code;
      Logical_Unit_Number       : A0B.Types.Unsigned_3;
      Reserved_1                : A0B.Types.Reserved_4;
      Enable_Vital_Product_Data : A0B.Types.Unsigned_1 := 0;
      Page_Code                 : A0B.Types.Unsigned_8 := 0;
      Reserved_3                : A0B.Types.Reserved_8;
      Allocation_Length         : A0B.Types.Unsigned_8;
      Reserved_5                : A0B.Types.Reserved_8;
      Reserved_6                : A0B.Types.Reserved_8;
      Reserved_7                : A0B.Types.Reserved_8;
      Reserved_8                : A0B.Types.Reserved_8;
      Reserved_9                : A0B.Types.Reserved_8;
      Reserved_10               : A0B.Types.Reserved_8;
      Reserved_11               : A0B.Types.Reserved_8;
   end record
     with Size      => Command_Block_Length * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for INQUIRY_Command_Block use record
      Operation_Code            at 0 range 0 .. 7;
      Enable_Vital_Product_Data at 1 range 0 .. 0;
      Reserved_1                at 1 range 1 .. 4;
      Logical_Unit_Number       at 1 range 5 .. 7;
      Page_Code                 at 2 range 0 .. 7;
      Reserved_3                at 3 range 0 .. 7;
      Allocation_Length         at 4 range 0 .. 7;
      Reserved_5                at 5 range 0 .. 7;
      Reserved_6                at 6 range 0 .. 7;
      Reserved_7                at 7 range 0 .. 7;
      Reserved_8                at 8 range 0 .. 7;
      Reserved_9                at 9 range 0 .. 7;
      Reserved_10               at 10 range 0 .. 7;
      Reserved_11               at 11 range 0 .. 7;
   end record;

   type Vendor_Information_Field is array (0 .. 7) of Character;

   type Product_Identification_Field is array (0 .. 15) of Character;

   type Product_Revision_Level_Field is array (0 .. 3) of Character;

   INQUIRY_Data_Block_Length : constant := 36;

   type INQUIRY_Data_Block is record
      Reserved_1             : A0B.Types.Reserved_3 := A0B.Types.Zero;
      Peripheral_Device_Type : A0B.Types.Unsigned_5;
      Removable_Media_Bit    : Boolean;
      Reserved_2             : A0B.Types.Reserved_7 := A0B.Types.Zero;
      ISO_Version            : A0B.Types.Unsigned_2 := 0;
      ECMA_Version           : A0B.Types.Unsigned_3 := 0;
      ANSI_Version           : A0B.Types.Unsigned_3 := 0;
      Reserved_3             : A0B.Types.Reserved_4 := A0B.Types.Zero;
      Response_Data_Format   : A0B.Types.Unsigned_4 := 16#01#;
      Additional_Length      : A0B.Types.Unsigned_8 := 16#1F#;
      Reserved_5             : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_6             : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_7             : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Vendor_Information     : Vendor_Information_Field;
      Product_Identification : Product_Identification_Field;
      Product_Revision_Level : Product_Revision_Level_Field;
   end record
     with Size      => INQUIRY_Data_Block_Length * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for INQUIRY_Data_Block use record
      Peripheral_Device_Type at 0 range 0 .. 4;
      Reserved_1             at 0 range 5 .. 7;
      Reserved_2             at 1 range 0 .. 6;
      Removable_Media_Bit    at 1 range 7 .. 7;
      ANSI_Version           at 2 range 0 .. 2;
      ECMA_Version           at 2 range 3 .. 5;
      ISO_Version            at 2 range 6 .. 7;
      Response_Data_Format   at 3 range 0 .. 3;
      Reserved_3             at 3 range 4 .. 7;
      Additional_Length      at 4 range 0 .. 7;
      Reserved_5             at 5 range 0 .. 7;
      Reserved_6             at 6 range 0 .. 7;
      Reserved_7             at 7 range 0 .. 7;
      Vendor_Information     at 8 range 0 .. 8 * 8 - 1;
      Product_Identification at 16 range 0 .. 8 * 16 - 1;
      Product_Revision_Level at 32 range 0 .. 8 * 4 - 1;
   end record;

   Media_Type_And_Write_Protect_Page      : constant := 16#00#;
   Read_Write_Error_Recovery_Page         : constant := 16#01#;
   Flexible_Disk_Page                     : constant := 16#05#;
   Removable_Block_Access_Capacities_Page : constant := 16#1B#;
   Timer_And_Protect_Page                 : constant := 16#1C#;
   All_Pages                              : constant := 16#3F#;

   type MODE_SENSE_Command_Block is record
      Operation_Code           : Types.Operation_Code :=
        MODE_SENSE_Operation_Code;
      Logical_Unit_Number      : A0B.Types.Unsigned_3;
      Reserved_1_4_4           : A0B.Types.Reserved_1;
      Disable_Block_Descriptor : Boolean              := False;
      Reserved_1_0_2           : A0B.Types.Reserved_1;
      Page_Control             : A0B.Types.Unsigned_2;
      Page_Code                : A0B.Types.Unsigned_6;
      Reserved_3               : A0B.Types.Reserved_8;
      Reserved_4               : A0B.Types.Reserved_8;
      Reserved_5               : A0B.Types.Reserved_8;
      Reserved_6               : A0B.Types.Reserved_8;
      Parameter_List_Length    : A0B.Types.Big_Endian.Unsigned_16;
      Reserved_9               : A0B.Types.Reserved_8;
      Reserved_10              : A0B.Types.Reserved_8;
      Reserved_11              : A0B.Types.Reserved_8;
   end record
     with Size      => Command_Block_Length * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for MODE_SENSE_Command_Block use record
      Operation_Code           at 0 range 0 .. 7;
      Reserved_1_0_2           at 1 range 0 .. 2;
      Disable_Block_Descriptor at 1 range 3 .. 3;
      Reserved_1_4_4           at 1 range 4 .. 4;
      Logical_Unit_Number      at 1 range 5 .. 7;
      Page_Code                at 2 range 0 .. 5;
      Page_Control             at 2 range 6 .. 7;
      Reserved_3               at 3 range 0 .. 7;
      Reserved_4               at 4 range 0 .. 7;
      Reserved_5               at 5 range 0 .. 7;
      Reserved_6               at 6 range 0 .. 7;
      Parameter_List_Length    at 7 range 0 .. 15;
      Reserved_9               at 9 range 0 .. 7;
      Reserved_10              at 10 range 0 .. 7;
      Reserved_11              at 11 range 0 .. 7;
   end record;

   Mode_Parameter_Header_Block_Length : constant := 8;

   type Mode_Parameter_Header_Block is record
      Mode_Data_Length : A0B.Types.Big_Endian.Unsigned_16 := (Value => 0);
      Medium_Type_Code : A0B.Types.Unsigned_8;
      Write_Protected  : Boolean;
      Reserved_3_5_6   : A0B.Types.Reserved_2;
      DPOFUA           : Boolean                          := False;
      Reserved_3_0_3   : A0B.Types.Reserved_4;
      Reserved_4       : A0B.Types.Reserved_8;
      Reserved_5       : A0B.Types.Reserved_8;
      Reserved_6       : A0B.Types.Reserved_8;
      Reserved_7       : A0B.Types.Reserved_8;
   end record
     with Size      =>
            Mode_Parameter_Header_Block_Length * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for Mode_Parameter_Header_Block use record
      Mode_Data_Length at 0 range 0 .. 15;
      Medium_Type_Code at 2 range 0 .. 7;
      Reserved_3_0_3   at 3 range 0 .. 3;
      DPOFUA           at 3 range 4 .. 4;
      Reserved_3_5_6   at 3 range 5 .. 6;
      Write_Protected  at 3 range 7 .. 7;
      Reserved_4       at 4 range 0 .. 7;
      Reserved_5       at 5 range 0 .. 7;
      Reserved_6       at 6 range 0 .. 7;
      Reserved_7       at 7 range 0 .. 7;
   end record;

   Read_Write_Error_Recovery_Page_Block_Length : constant := 12;

   type Read_Write_Error_Recovery_Page_Block is record
      Parameters_Savable                  : A0B.Types.Unsigned_1 := 0;
      Reserved_0                          : A0B.Types.Reserved_1;
      Page_Code                           : A0B.Types.Unsigned_6 :=
        Read_Write_Error_Recovery_Page;
      Page_Length                         : A0B.Types.Unsigned_8 := 16#0A#;
      Automatic_Write_Reallocation_Enable : A0B.Types.Unsigned_1 := 0;
      Reserved_2_5_6                      : A0B.Types.Reserved_2;
      Read_Continuous                     : A0B.Types.Unsigned_1 := 0;
      Post_Error                          : Boolean;
      Reserved_2_1_1                      : A0B.Types.Reserved_1;
      Disable_Correction                  : A0B.Types.Unsigned_1 := 0;
      Read_Retry_Count                    : A0B.Types.Unsigned_8;
      Reserved_4                          : A0B.Types.Reserved_8;
      Reserved_5                          : A0B.Types.Reserved_8;
      Reserved_6                          : A0B.Types.Reserved_8;
      Reserved_7                          : A0B.Types.Reserved_8;
      Write_Retry_Count                   : A0B.Types.Unsigned_8;
      Reserved_9                          : A0B.Types.Reserved_8;
      Reserved_10                         : A0B.Types.Reserved_8;
      Reserved_11                         : A0B.Types.Reserved_8;
   end record
     with Size      =>
            Read_Write_Error_Recovery_Page_Block_Length
              * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for Read_Write_Error_Recovery_Page_Block use record
      Page_Code                           at 0 range 0 .. 5;
      Reserved_0                          at 0 range 6 .. 6;
      Parameters_Savable                  at 0 range 7 .. 7;
      Page_Length                         at 1 range 0 .. 7;
      Disable_Correction                  at 2 range 0 .. 0;
      Reserved_2_1_1                      at 2 range 1 .. 1;
      Post_Error                          at 2 range 2 .. 2;
      Read_Continuous                     at 2 range 3 .. 3;
      Reserved_2_5_6                      at 2 range 4 .. 6;
      Automatic_Write_Reallocation_Enable at 2 range 7 .. 7;
      Read_Retry_Count                    at 3 range 0 .. 7;
      Reserved_4                          at 4 range 0 .. 7;
      Reserved_5                          at 5 range 0 .. 7;
      Reserved_6                          at 6 range 0 .. 7;
      Reserved_7                          at 7 range 0 .. 7;
      Write_Retry_Count                   at 8 range 0 .. 7;
      Reserved_9                          at 9 range 0 .. 7;
      Reserved_10                         at 10 range 0 .. 7;
      Reserved_11                         at 11 range 0 .. 7;
   end record;

   Flexible_Disk_Page_Block_Length : constant := 32;

   type Flexible_Disk_Page_Block is record
      Parameters_Savable    : A0B.Types.Unsigned_1 := 0;
      Reserved_0            : A0B.Types.Reserved_1;
      Page_Code             : A0B.Types.Unsigned_6 := Flexible_Disk_Page;
      Page_Length           : A0B.Types.Unsigned_8 := 16#1E#;
      Transfer_Rate         : A0B.Types.Big_Endian.Unsigned_16;
      Number_Of_Heads       : A0B.Types.Unsigned_8 := 2;
      Sectors_Per_Track     : A0B.Types.Unsigned_8;
      Data_Bytes_Per_Sector : A0B.Types.Unsigned_16;
      Number_Of_Cylinders   : A0B.Types.Unsigned_16;
      Reserved_10           : A0B.Types.Reserved_8;
      Reserved_11           : A0B.Types.Reserved_8;
      Reserved_12           : A0B.Types.Reserved_8;
      Reserved_13           : A0B.Types.Reserved_8;
      Reserved_14           : A0B.Types.Reserved_8;
      Reserved_15           : A0B.Types.Reserved_8;
      Reserved_16           : A0B.Types.Reserved_8;
      Reserved_17           : A0B.Types.Reserved_8;
      Reserved_18           : A0B.Types.Reserved_8;
      Motor_On_Delay        : A0B.Types.Unsigned_8 := 5;
      Motor_Off_Delay       : A0B.Types.Unsigned_8 := 30;
      Reserved_21           : A0B.Types.Reserved_8;
      Reserved_22           : A0B.Types.Reserved_8;
      Reserved_23           : A0B.Types.Reserved_8;
      Reserved_24           : A0B.Types.Reserved_8;
      Reserved_25           : A0B.Types.Reserved_8;
      Reserved_26           : A0B.Types.Reserved_8;
      Reserved_27           : A0B.Types.Reserved_8;
      Medium_Rotation_Rate  : A0B.Types.Unsigned_16;
      Reserved_30           : A0B.Types.Reserved_8;
      Reserved_31           : A0B.Types.Reserved_8;
   end record
     with Size      =>
            Flexible_Disk_Page_Block_Length * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for Flexible_Disk_Page_Block use record
      Page_Code             at 0 range 0 .. 5;
      Reserved_0            at 0 range 6 .. 6;
      Parameters_Savable    at 0 range 7 .. 7;
      Page_Length           at 1 range 0 .. 7;
      Transfer_Rate         at 2 range 0 .. 15;
      Number_Of_Heads       at 4 range 0 .. 7;
      Sectors_Per_Track     at 5 range 0 .. 7;
      Data_Bytes_Per_Sector at 6 range 0 .. 15;
      Number_Of_Cylinders   at 8 range 0 .. 15;
      Reserved_10           at 10 range 0 .. 7;
      Reserved_11           at 11 range 0 .. 7;
      Reserved_12           at 12 range 0 .. 7;
      Reserved_13           at 13 range 0 .. 7;
      Reserved_14           at 14 range 0 .. 7;
      Reserved_15           at 15 range 0 .. 7;
      Reserved_16           at 16 range 0 .. 7;
      Reserved_17           at 17 range 0 .. 7;
      Reserved_18           at 18 range 0 .. 7;
      Motor_On_Delay        at 19 range 0 .. 7;
      Motor_Off_Delay       at 20 range 0 .. 7;
      Reserved_21           at 21 range 0 .. 7;
      Reserved_22           at 22 range 0 .. 7;
      Reserved_23           at 23 range 0 .. 7;
      Reserved_24           at 24 range 0 .. 7;
      Reserved_25           at 25 range 0 .. 7;
      Reserved_26           at 26 range 0 .. 7;
      Reserved_27           at 27 range 0 .. 7;
      Medium_Rotation_Rate  at 28 range 0 .. 15;
      Reserved_30           at 30 range 0 .. 7;
      Reserved_31           at 31 range 0 .. 7;
   end record;

   Removable_Block_Access_Capabilities_Page_Block_Length : constant := 12;

   type Removable_Block_Access_Capabilities_Page_Block is record
      Parameters_Savable                 : A0B.Types.Unsigned_1 := 0;
      Reserved_0                         : A0B.Types.Reserved_1;
      Page_Code                          : A0B.Types.Unsigned_6 :=
        Removable_Block_Access_Capacities_Page;
      Page_Length                        : A0B.Types.Unsigned_8 := 16#0A#;
      System_Floppy_Type                 : Boolean;
      Supports_Reporting_Format_Progress : A0B.Types.Unsigned_1 := 0;
      Reserved_2                         : A0B.Types.Reserved_6;
      Non_CD                             : A0B.Types.Unsigned_1 := 0;
      Single_Multiple_LUN                : A0B.Types.Unsigned_1 := 0;
      Reserved_3                         : A0B.Types.Reserved_3;
      Total_Number_Of_Logical_Units      : A0B.Types.Unsigned_3 := 1;
      Reserved_4                         : A0B.Types.Reserved_8;
      Reserved_5                         : A0B.Types.Reserved_8;
      Reserved_6                         : A0B.Types.Reserved_8;
      Reserved_7                         : A0B.Types.Reserved_8;
      Reserved_8                         : A0B.Types.Reserved_8;
      Reserved_9                         : A0B.Types.Reserved_8;
      Reserved_10                        : A0B.Types.Reserved_8;
      Reserved_11                        : A0B.Types.Reserved_8;
   end record
     with Size      =>
            Removable_Block_Access_Capabilities_Page_Block_Length
              * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for  Removable_Block_Access_Capabilities_Page_Block use record
      Page_Code                          at 0 range 0 .. 5;
      Reserved_0                         at 0 range 6 .. 6;
      Parameters_Savable                 at 0 range 7 .. 7;
      Page_Length                        at 1 range 0 .. 7;
      Reserved_2                         at 2 range 0 .. 5;
      Supports_Reporting_Format_Progress at 2 range 6 .. 6;
      System_Floppy_Type                 at 2 range 7 .. 7;
      Total_Number_Of_Logical_Units      at 3 range 0 .. 2;
      Reserved_3                         at 3 range 3 .. 5;
      Single_Multiple_LUN                at 3 range 6 .. 6;
      Non_CD                             at 3 range 7 .. 7;
      Reserved_4                         at 4 range 0 .. 7;
      Reserved_5                         at 5 range 0 .. 7;
      Reserved_6                         at 6 range 0 .. 7;
      Reserved_7                         at 7 range 0 .. 7;
      Reserved_8                         at 8 range 0 .. 7;
      Reserved_9                         at 9 range 0 .. 7;
      Reserved_10                        at 10 range 0 .. 7;
      Reserved_11                        at 11 range 0 .. 7;
   end record;

   Timer_And_Protect_Page_Block_Length : constant := 8;

   type Timer_And_Protect_Page_Block is record
      Parameters_Savable                 : A0B.Types.Unsigned_1 := 0;
      Reserved_0                         : A0B.Types.Reserved_1;
      Page_Code                          : A0B.Types.Unsigned_6 :=
        Timer_And_Protect_Page;
      Page_Length                        : A0B.Types.Unsigned_8 := 16#06#;
      Reserved_2                         : A0B.Types.Reserved_8;
      Reserved_3                         : A0B.Types.Reserved_4;
      Inactivity_Time_Multiplier         : A0B.Types.Unsigned_4;
      Reserved_4                         : A0B.Types.Reserved_6;
      Disable_Media_Access_Until_Power   : A0B.Types.Unsigned_1 := 0;
      Software_Write_Protect_Until_Power : A0B.Types.Unsigned_1 := 0;
      Reserved_5                         : A0B.Types.Reserved_8;
      Reserved_6                         : A0B.Types.Reserved_8;
      Reserved_7                         : A0B.Types.Reserved_8;
   end record
     with Size      =>
            Timer_And_Protect_Page_Block_Length * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for Timer_And_Protect_Page_Block use record
      Page_Code                          at 0 range 0 .. 5;
      Reserved_0                         at 0 range 6 .. 6;
      Parameters_Savable                 at 0 range 7 .. 7;
      Page_Length                        at 1 range 0 .. 7;
      Reserved_2                         at 2 range 0 .. 7;
      Inactivity_Time_Multiplier         at 3 range 0 .. 3;
      Reserved_3                         at 3 range 4 .. 7;
      Software_Write_Protect_Until_Power at 4 range 0 .. 0;
      Disable_Media_Access_Until_Power   at 4 range 1 .. 1;
      Reserved_4                         at 4 range 2 .. 7;
      Reserved_5                         at 5 range 0 .. 7;
      Reserved_6                         at 6 range 0 .. 7;
      Reserved_7                         at 7 range 0 .. 7;
   end record;

   Mode_Parameter_List_Length : constant :=
     Mode_Parameter_Header_Block_Length
       + Read_Write_Error_Recovery_Page_Block_Length
       + Flexible_Disk_Page_Block_Length
       + Removable_Block_Access_Capabilities_Page_Block_Length
       + Timer_And_Protect_Page_Block_Length;

   type Mode_Parameter_List is record
      Header                            : Mode_Parameter_Header_Block;
      Read_Write_Error_Recovery         : Read_Write_Error_Recovery_Page_Block;
      Flexible_Disk                     : Flexible_Disk_Page_Block;
      Removable_Block_Access_Capacities :
        Removable_Block_Access_Capabilities_Page_Block;
      Timer_And_Protect                 : Timer_And_Protect_Page_Block;
   end record
     with Size => Mode_Parameter_List_Length * A0B.Types.Unsigned_8'Size;

   type READ_10_Command_Block is record
      Operation_Code        : A0B.Types.Unsigned_8;
      Logical_Unit_Number   : A0B.Types.Unsigned_3;
      DPO                   : A0B.Types.Unsigned_1 := 0;
      FUA                   : A0B.Types.Unsigned_1 := 0;
      Reserved_1            : A0B.Types.Reserved_2;
      RelAdr                : A0B.Types.Unsigned_1 := 0;
      Logical_Block_Address : A0B.Types.Big_Endian.Unsigned_32;
      Reserved_6            : A0B.Types.Reserved_8;
      Transfer_Length       : A0B.Types.Big_Endian.Unsigned_16;
      Reserved_9            : A0B.Types.Reserved_8;
      Reserved_10           : A0B.Types.Reserved_8;
      Reserved_11           : A0B.Types.Reserved_8;
   end record
     with Size      => 12 * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for READ_10_Command_Block use record
      Operation_Code        at 0 range 0 .. 7;
      RelAdr                at 1 range 0 .. 0;
      Reserved_1            at 1 range 1 .. 2;
      FUA                   at 1 range 3 .. 3;
      DPO                   at 1 range 4 .. 4;
      Logical_Unit_Number   at 1 range 5 .. 7;
      Logical_Block_Address at 2 range 0 .. 31;
      Reserved_6            at 6 range 0 .. 7;
      Transfer_Length       at 7 range 0 .. 15;
      Reserved_9            at 9 range 0 .. 7;
      Reserved_10           at 10 range 0 .. 7;
      Reserved_11           at 11 range 0 .. 7;
   end record;

   type READ_CAPACITY_Command_Block is record
      Operation_Code        : Types.Operation_Code             :=
        READ_CAPACITY_Operation_Code;
      Logical_Unit_Number   : A0B.Types.Unsigned_3;
      Reserved_1            : A0B.Types.Reserved_4;
      RelAdr                : A0B.Types.Unsigned_1             := 0;
      Logical_Block_Address : A0B.Types.Big_Endian.Unsigned_32 := (Value => 0);
      Reserved_6            : A0B.Types.Reserved_8;
      Reserved_7            : A0B.Types.Reserved_8;
      Reserved_8            : A0B.Types.Reserved_7;
      PMI                   : A0B.Types.Unsigned_1             := 0;
      Reserved_9            : A0B.Types.Reserved_8;
      Reserved_10           : A0B.Types.Reserved_8;
      Reserved_11           : A0B.Types.Reserved_8;
   end record
     with Size      => Command_Block_Length * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for READ_CAPACITY_Command_Block use record
      Operation_Code        at 0 range 0 .. 7;
      RelAdr                at 1 range 0 .. 0;
      Reserved_1            at 1 range 1 .. 4;
      Logical_Unit_Number   at 1 range 5 .. 7;
      Logical_Block_Address at 2 range 0 .. 31;
      Reserved_6            at 6 range 0 .. 7;
      Reserved_7            at 7 range 0 .. 7;
      PMI                   at 8 range 0 .. 0;
      Reserved_8            at 8 range 1 .. 7;
      Reserved_9            at 9 range 0 .. 7;
      Reserved_10           at 10 range 0 .. 7;
      Reserved_11           at 11 range 0 .. 7;
   end record;

   READ_CAPACITY_Data_Block_Length : constant := 8;

   type READ_CAPACITY_Data_Block is record
      Last_Logical_Block_Address : A0B.Types.Big_Endian.Unsigned_32;
      Block_Length_In_Bytes      : A0B.Types.Big_Endian.Unsigned_32;
   end record
     with Size      =>
            READ_CAPACITY_Data_Block_Length * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for READ_CAPACITY_Data_Block use record
      Last_Logical_Block_Address at 0 range 0 .. 31;
      Block_Length_In_Bytes      at 4 range 0 .. 31;
   end record;

   type TEST_UNIT_READY_Command_Block is record
      Operation_Code      : A0B.Types.Unsigned_8;
      Logical_Unit_Number : A0B.Types.Unsigned_3;
      Reserved_1          : A0B.Types.Reserved_5;
      Reserved_2          : A0B.Types.Reserved_8;
      Reserved_3          : A0B.Types.Reserved_8;
      Reserved_4          : A0B.Types.Reserved_8;
      Reserved_5          : A0B.Types.Reserved_8;
      Reserved_6          : A0B.Types.Reserved_8;
      Reserved_7          : A0B.Types.Reserved_8;
      Reserved_8          : A0B.Types.Reserved_8;
      Reserved_9          : A0B.Types.Reserved_8;
      Reserved_10         : A0B.Types.Reserved_8;
      Reserved_11         : A0B.Types.Reserved_8;
   end record
     with Size      => 12 * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for TEST_UNIT_READY_Command_Block use record
      Operation_Code        at 0 range 0 .. 7;
      Reserved_1            at 1 range 0 .. 4;
      Logical_Unit_Number   at 1 range 5 .. 7;
      Reserved_2            at 2 range 0 .. 7;
      Reserved_3            at 3 range 0 .. 7;
      Reserved_4            at 4 range 0 .. 7;
      Reserved_5            at 5 range 0 .. 7;
      Reserved_6            at 6 range 0 .. 7;
      Reserved_7            at 7 range 0 .. 7;
      Reserved_8            at 8 range 0 .. 7;
      Reserved_9            at 9 range 0 .. 7;
      Reserved_10           at 10 range 0 .. 7;
      Reserved_11           at 11 range 0 .. 7;
   end record;

end A0B.USBMSC.UFI.Types;
