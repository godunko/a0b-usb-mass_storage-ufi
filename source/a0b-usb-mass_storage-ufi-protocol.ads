--
--  Copyright (C) 2025, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with A0B.Types.Arrays;

package A0B.USB.Mass_Storage.UFI.Protocol
  with Pure, No_Elaboration_Code_All
is

   subtype Command_Buffer is A0B.Types.Arrays.Unsigned_8_Array (0 .. 11);

   --  type Operation_Code_Type is new A0B.Types.Unsigned_8;

   --  Format Unit_Operation_Code                  : 04#
   INQUIRY_Operation_Code                      : constant := 16#12#;
   --  Mode Select_Operation_Code                  : 55
   --  Mode Sense_Operation_Code                   : 5A
   --  Prevent-Allow Medium Removal_Operation_Code : 1E
   --  Read(10)_Operation_Code                     : 28
   --  Read(12)_Operation_Code                     : A8
   --  Read Capacity_Operation_Code                : 25
   --  Read Format Capacities_Operation_Code       : 23
   --  Request Sense_Operation_Code                : 03
   --  Rezero_Operation_Code                       : 01
   --  Seek(10)_Operation_Code                     : 2B
   --  Send Diagnostic_Operation_Code              : 1D
   --  Start-Stop Unit_Operation_Code              : 1B
   --  Test Unit Ready_Operation_Code              : 00
   --  Verify_Operation_Code                       : 2F
   --  Write(10)_Operation_Code                    : 2A
   --  Write(12)_Operation_Code                    : AA
   --  Write and Verify_Operation_Code             : 2E

   --  type Typical_Command_Block is record
   --     Operation_Code        : A0B.Types.Unsigned_8;
   --     Logical_Unit_Number   : A0B.Types.Unsigned_3;
   --     Reserved_1            : A0B.Types.Unsigned_5;
   --     Logical_Block_Address : A0B.Types.Unsigned_32;  --  MSB
   --     Reserved_2            : A0B.Types.Unsigned_8;
   --     --  Transfer or Parameter List or Allocation Length
   --     Data                  : A0B.Types.Unsigned_16;  --  MSB
   --     Reserved_3            : A0B.Types.Unsigned_8;
   --     Reserved_4            : A0B.Types.Unsigned_8;
   --     Reserved_5            : A0B.Types.Unsigned_8;
   --  end record with Size => 8 * 12;
   --
   --  for Typical_Command_Block use record
   --     Operation_Code        at 0 range 0 .. 7;
   --     Reserved_1            at 1 range 0 .. 4;
   --     Logical_Unit_Number   at 1 range 5 .. 7;
   --     Logical_Block_Address at 2 range 0 .. 31;
   --     Reserved_2            at 6 range 0 .. 7;
   --     Data                  at 7 range 0 .. 15;
   --     Reserved_3            at 9 range 0 .. 7;
   --     Reserved_4            at 10 range 0 .. 7;
   --     Reserved_5            at 11 range 0 .. 7;
   --  end record;

   type Command_Block is record
      Operation_Code        : A0B.Types.Unsigned_8;
      Logical_Unit_Number   : A0B.Types.Unsigned_3;
      Reserved_1            : A0B.Types.Reserved_5;
      Reserved_2            : A0B.Types.Reserved_8;
      Reserved_3            : A0B.Types.Reserved_8;
      Reserved_4            : A0B.Types.Reserved_8;
      Reserved_5            : A0B.Types.Reserved_8;
      Reserved_6            : A0B.Types.Reserved_8;
      Reserved_7            : A0B.Types.Reserved_8;
      Reserved_8            : A0B.Types.Reserved_8;
      Reserved_9            : A0B.Types.Reserved_8;
      Reserved_10           : A0B.Types.Reserved_8;
      Reserved_11           : A0B.Types.Reserved_8;
   end record with Size => 8 * 12;

   for Command_Block use record
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

   type INQUIRY_Command_Block is record
      Operation_Code        : A0B.Types.Unsigned_8 := INQUIRY_Operation_Code;
      Logical_Unit_Number   : A0B.Types.Unsigned_3;
      Reserved_1            : A0B.Types.Reserved_4;
      EVPD                  : A0B.Types.Unsigned_1 := 0;
      Page_Code             : A0B.Types.Unsigned_8 := 0;
      Reserved_3            : A0B.Types.Reserved_8;
      Allocation_Length     : A0B.Types.Unsigned_8;
      Reserved_5            : A0B.Types.Reserved_8;
      Reserved_6            : A0B.Types.Reserved_8;
      Reserved_7            : A0B.Types.Reserved_8;
      Reserved_8            : A0B.Types.Reserved_8;
      Reserved_9            : A0B.Types.Reserved_8;
      Reserved_10           : A0B.Types.Reserved_8;
      Reserved_11           : A0B.Types.Reserved_8;
   end record with Size => 8 * 12;

   for INQUIRY_Command_Block use record
      Operation_Code        at 0 range 0 .. 7;
      EVPD                  at 1 range 0 .. 0;
      Reserved_1            at 1 range 1 .. 4;
      Logical_Unit_Number   at 1 range 5 .. 7;
      Page_Code             at 2 range 0 .. 7;
      Reserved_3            at 3 range 0 .. 7;
      Allocation_Length     at 4 range 0 .. 7;
      Reserved_5            at 5 range 0 .. 7;
      Reserved_6            at 6 range 0 .. 7;
      Reserved_7            at 7 range 0 .. 7;
      Reserved_8            at 8 range 0 .. 7;
      Reserved_9            at 9 range 0 .. 7;
      Reserved_10           at 10 range 0 .. 7;
      Reserved_11           at 11 range 0 .. 7;
   end record;

   type Vendor_Information_Field is array (0 .. 7) of Character;

   type Product_Identification_Field is array (0 .. 15) of Character;

   type Product_Revision_Level_Field is array (0 .. 3) of Character;

   type INQUIRY_Data_Block is record
      Reserved_1             : A0B.Types.Reserved_3 := A0B.Types.Zero;
      Peripheral_Device_Type : A0B.Types.Unsigned_5;
      RMB                    : Boolean;
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
   end record with Size => 8 * 36;

   for INQUIRY_Data_Block use record
      Peripheral_Device_Type at 0 range 0 .. 4;
      Reserved_1             at 0 range 5 .. 7;
      Reserved_2             at 1 range 0 .. 6;
      RMB                    at 1 range 7 .. 7;
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

end A0B.USB.Mass_Storage.UFI.Protocol;
