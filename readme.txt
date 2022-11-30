To execute the receiver on a simulator-generated received file,
    1. Open "main.m" on MATLAB editor
    2. Set RECEIVED_DATA_FILE to the simulator-generated received file path + name 
       (eg: C:\commsys\Rn_GroupID.....txt).
    3. Set DECODED_DATA_FILE to a preferred filename (decoded signal will be written into this file. 
       eg: C:\commsys\decoded_data.txt).
    4. Set other parameters (GROUP_ID, FREQ_ID and FRAME_START) if necessary.
    5. Execute the "main.m" file.

This will generate the file specified by DECODED_DATA_FILE. The data format is similar to the 
simulator-generated input file (Input_GroupID.....txt).

Note that all the ".m" files should be placed within the same directory.