*** Settings ***
Documentation       PTT PRO Half Duplex Client Test Cases. Sever changes reflect on Client
Metadata            Version    ${PTT_PRO_TEST_SCRIPT_VERSION}
Metadata            Author    Devaraja, M    - WVH863,Balaji D - CKF746
Metadata            Test Case Count    30
Resource            ../../../../../Res/Android/VOIP/PTTPro/PTTProFunctions_Res.robot
Suite Setup         Run Keywords
...                     Set Pro Global Variables And Generate Random User Id With Suffix    101    AND
...                     Check And Install And Configure PTT PRO On 1 Devices
Suite Teardown      Run Keyword And Ignore Error
...                     Run Keywords
...                     PTT PRO Suite Teardown On 1 Devices    AND
...                     Check And Delete Ptt Pro User Via Api    ${DEVICE1}
Test Setup          Run Keywords
...                     Go To DUT1    AND
...                     Launch Pttpro
Test Teardown       Common Ptt Pro Teardown Form Test Case Failure
Test Timeout        5 minutes
Force Tags          1_device


*** Variables ***
${NUMBER_OF_DEVICES}    1


*** Test Cases ***
WFC-24043 [SERVER] Validate Earpiece Mode Can Be Set On Server Reflects Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    Gen    startCallWithSpeaker    use    0
    builtin.Sleep    2s
    Change Settings Values For A User    ${DEVICE1}    Gen    startCallWithSpeaker    use    1
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    ${is_tablet}    Check Dut Is Tablet
    ${model}    Get Product Model Of Device
    ${is_wt6300}    Evaluate    "${model}"=="WT6300"
    IF    ${is_tablet} or ${is_wt6300}
        Verify Start Call With Speakerphone Is Not Seen
    ELSE
        Verify Start Call With Speakerphone Option Is Enabled
    END
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    Gen    startCallWithSpeaker    use    0

WFC-24056 [SERVER] Validate Activate DnD In Vibrate Mode Option Is Not Displayed On Client When Disabled On Server
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    Gen    activateDndInVibrateMode    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTTPRo Settings General
    Scroll And Verify Ui Element Is Not Present    textContains=Activate DnD in Vibrate Mode
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    Gen    activateDndInVibrateMode    show    1

WFC-24060 [SERVER] Validate Minimum Call Start Volume Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    callVolume    use    49
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Default Sound Profile Page
    Scroll To Object Vertically    textContains=Minimum Call Volume
    Click    textContains=Minimum Call Volume
    ${status}    Wait For Exists    textContains=49 percent
    Should Be True    ${status}    'Minimum Call Volume' option still not updated as Server values
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure

WFC-24061 [SERVER] Validate Ring On Incoming Call Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    ringOnIncomingCall    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Headset Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Ring on Incoming Call
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    ringOnIncomingCall    show    1

WFC-24062 [SERVER] Validate Vibrate On Incoming Call Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    vibrateOnIncomingCall    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Headset Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Vibrate on Incoming Call
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    vibrateOnIncomingCall    show    1

WFC-24064 [SERVER] Validate Vibrate On Grant Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    vibrateOnGrant    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Headset Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Vibrate on Grant
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    vibrateOnGrant    show    1

WFC-24065 [SERVER] Validate Play Grant Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playGrantTone    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Headset Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Grant Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playGrantTone    show    1

WFC-24066 [SERVER] Validate Play Floor Taken Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playTakenTone    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Headset Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Taken Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playTakenTone    show    1

WFC-24067 [SERVER] Validate Play Floor Idle Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playIdleTone    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Headset Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Idle Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playIdleTone    show    1

WFC-24068 [SERVER] Validate Play Floor Denied Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playDenyTone    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Headset Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Deny Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playDenyTone    show    1

WFC-24069 [SERVER] Validate Play Floor Revoked Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playRevokeTone    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Headset Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Revoke Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playRevokeTone    show    1

WFC-24070 [SERVER] Validate Play Call Lost Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playCallLostTone    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Headset Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Call Lost Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playCallLostTone    show    1

WFC-24071 [SERVER] Validate Play Busy Bonk Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playBusyBonk    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Headset Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Busy Bonk Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    playBusyBonk    show    1    AND
    ...    builtin.Sleep    10s    AND
    ...    Repeat Keyword    5
    ...        Press Back    AND
    ...    Launch Pttpro

WFC-24073 [SERVER] Validate Endless Alert On Missed Call - Disabled On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    Gen    missedCallEndlessAlert    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTTPRo Settings Notifications
    Scroll And Verify Ui Element Is Not Present    textContains=Missed Call Endless Alert
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    Gen    missedCallEndlessAlert    show    1

WFC-24074 [SERVER] Validate Foreground App On Incoming Call - Disabled On Server Reflects On Client
    [Tags]    generic    ci_ats
    Change Settings Values For A User    ${DEVICE1}    Gen    foregroundAppOnIncomingCall    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTTPRo Settings General
    Scroll And Verify Ui Element Is Not Present    textContains=Foreground app on Call
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    Gen    foregroundAppOnIncomingCall    show    1

WFC-24075 [SERVER] Validate Notify All Missed Calls - Disabled On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    Gen    notifyForAllMissedCalls    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTTPRo Settings Notifications
    Scroll And Verify Ui Element Is Not Present    textContains=Notify for All Missed Calls
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    Gen    notifyForAllMissedCalls    show    1

WFC-24076 [SERVER] Validate Notify All New Messages - Disabled On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    Gen    notifyForAllNewMessages    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTTPRo Settings Notifications
    Scroll And Verify Ui Element Is Not Present    textContains=Notify for All New Messages
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    Gen    notifyForAllNewMessages    show    1

WFC-24080 [SERVER] Validate Wake Display At Call Start - Disabled On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    wakeLock    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Headset Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Wake Display at Call Start
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    wakeLock    show    1

WFC-24081 [SERVER] Validate Value Set For Minimum Call Start Volume On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    callVolume    use    60
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Headset Sound Profile Page
    Scroll To Object Vertically    textContains=Minimum Call Volume
    Click    textContains=Minimum Call Volume
    ${status}    Wait For Exists    textContains=60 percent
    Should Be True    ${status}    'Minimum Call Volume' option still not updated as Server values
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure

WFC-24082 [SERVER] Validate Ring On Incoming Call Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    ringOnIncomingCall    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Default Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Ring on Incoming Call
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    ringOnIncomingCall    show    1

WFC-24083 [SERVER] Validate Vibrate On Incoming Call Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    vibrateOnIncomingCall    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Default Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Vibrate on Incoming Call
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    vibrateOnIncomingCall    show    1

WFC-24084 [SERVER] Validate Vibrate On Grant Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    vibrateOnGrant    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Default Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Vibrate on Grant
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    vibrateOnGrant    show    1

WFC-24085 [SERVER] Validate Play Grant Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    playGrantTone    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Default Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Grant Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    playGrantTone    show    1

WFC-24086 [SERVER] Validate Play Floor Taken Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    playTakenTone    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Default Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Taken Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    playTakenTone    show    1

WFC-24087 [SERVER] Validate Play Floor Idle Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    playIdleTone    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Default Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Idle Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    playIdleTone    show    1

WFC-24088 [SERVER] Validate Play Floor Denied Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    playDenyTone    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Default Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Deny Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    playDenyTone    show    1

WFC-24089 [SERVER] Validate Play Floor Revoked Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    playRevokeTone    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Default Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Revoke Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    playRevokeTone    show    1

WFC-24090 [SERVER] Validate Play Call Lost Tone Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    playCallLostTone    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Default Sound Profile Page
    Scroll And Verify Ui Element Is Not Present    textContains=Play Call Lost Tone
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    defaultSoundProfile    playCallLostTone    show    1

WFC-24072 [SERVER] Validate Alert Call Ring Duration Set On Server Reflects On Client
    [Tags]    generic
    ${value}    Convert To Integer    60
    ${default}    Convert To Integer    30
    Update Pro Settings Of User    ${DEVICE1}    alertCallRingTime    use    ${value}
    builtin.Sleep    5s
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTTPRo Settings Notifications
    Scroll To Object    text=Alert Call Ring Time
    Click    text=Alert Call Ring Time
    ${status}    Wait For Exists    text=60 seconds    checked=true
    IF    ${status} == ${FALSE}    Fail    60 seconds was not checked
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Update Pro Settings Of User    ${DEVICE1}    alertCallRingTime    use    ${default}    AND
    ...    builtin.Sleep    10s    AND
    ...    Repeat Keyword    5
    ...        Press Back    AND
    ...    Launch Pttpro

WFC-24305 Validate DND Mode Reminder Is Set To 0 (No Reminder) By Default And Its Operation
    [Tags]    generic
    [Timeout]    45 Minutes
    Open PTTPRo Notifications Settings
    Click On DND Mode Reminder
    Verify DND Mode Reminder Options
    Go To Dut1
    General_ADB_Res.Clear All Notifications
    Launch Pttpro
    Enable Dnd Mode
    Set And Verify DND Mode Reminder As ${DND_MODE_REMINDER_OPTIONS}[15_MINUTES]
    builtin.Sleep    5m
    Set And Verify DND Mode Reminder As ${DND_MODE_REMINDER_OPTIONS}[NO_REMINDER]
    builtin.Sleep    12m
    Open Notification
    Verify PTT Pro DND Reminder Not Seen In Notification
    [Teardown]    Run Keywords
    ...    Repeat Keyword    3
    ...        Press Back    AND
    ...    Launch Pttpro    AND
    ...    Disable Dnd Mode
