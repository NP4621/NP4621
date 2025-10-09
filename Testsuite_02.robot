*** Settings ***
Documentation       PTT PRO Half Duplex Client Test Cases. Sever changes reflect on Client
Metadata            Version    ${PTT_PRO_TEST_SCRIPT_VERSION}
Metadata            Author    Devaraja, M    - WVH863,Balaji D - CKF746
Metadata            Test Case Count    30
Resource            ../../../../../Res/Android/VOIP/PTTPro/PTTProFunctions_Res.robot
Suite Setup         Run Keywords
...                     Set Pro Global Variables And Generate Random User Id With Suffix    102    AND
...                     Check And Install And Configure PTT PRO On 1 Devices
Suite Teardown      Run Keyword And Ignore Error
...                     Run Keywords
...                     PTT PRO Suite Teardown On 1 Devices    AND
...                     Check And Delete Ptt Pro User Via Api    ${DEVICE1}
Test Setup          Launch Pttpro
Test Teardown       Common Ptt Pro Teardown Form Test Case Failure
Test Timeout        5 minutes
Force Tags          1_device


*** Variables ***
${NUMBER_OF_DEVICES}    1


*** Test Cases ***
WFC-24054 [SERVER] Validate Bluetooth Always On Option Is Not Displayed On Client When Disabled On Server
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    Gen    bluetoothAlwaysOn    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTTPRo Settings General
    Scroll And Verify Ui Element Is Not Present    textContains=Bluetooth Always On
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    Gen    bluetoothAlwaysOn    show    1

WFC-24052 [SERVER] Validate Allow Bluetooth Audio Option Is Not Displayed On Client When Disabled On Server
    [Tags]    generic    ci_ats
    Change Settings Values For A User    ${DEVICE1}    Gen    allowBluetooth    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTTPRo Settings General
    Scroll And Verify Ui Element Is Not Present    textContains=Allow Bluetooth Audio
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    Gen    allowBluetooth    show    1

WFC-24053 [SERVER] Validate Bluetooth Always On Is Available On Client When Allow Bluetooth Audio Option Is Not Displayed
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    Gen    allowBluetooth    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTTPRo Settings General
    Scroll And Verify Ui Element Is Not Present    textContains=Allow Bluetooth Audio
    Scroll And Verify Ui Element Is Present    textContains=Bluetooth Always On
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    Gen    allowBluetooth    show    1

WFC-24050 [SERVER] Validate Notifications Page Is Blank On Client When Disabled On Server
    [Tags]    generic
    Disable Display On Phone Option For Multiple Settings
    ...    ${DEVICE1}
    ...    Gen
    ...    notifyForAllMissedCalls
    ...    notifyForAllNewMessages
    ...    newMessageAlert
    ...    newMessageAlertTime
    ...    missedCallEndlessAlert
    ...    alertCallRingTime
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Settings Page
    IF    "${PRO_APP_TYPE}"=="Gen2"    Click    textContains=Notifications
    Scroll And Verify Ui Element Is Not Present    textContains=Alert Call Ring Time
    Scroll And Verify Ui Element Is Not Present    textContains=Missed Call Endless Alert
    Scroll And Verify Ui Element Is Not Present    textContains=Foreground app on Call
    Scroll And Verify Ui Element Is Not Present    textContains=Notify for All Missed Calls
    Scroll And Verify Ui Element Is Not Present    textContains=Notify for All New Messages
    Scroll And Verify Ui Element Is Not Present    textContains=New Message Alert
    Scroll And Verify Ui Element Is Not Present    textContains=New Message Alert Time
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Disable Display On Phone Option For Multiple Settings    ${DEVICE1}    Gen

WFC-24048 [SERVER] Validate Integration Options Are Not Displayed On Client When Disabled On Server
    [Tags]    generic
    Disable Display On Phone Option For Multiple Settings
    ...    ${DEVICE1}
    ...    Gen
    ...    allowBluetooth
    ...    bluetoothAlwaysOn
    ...    activateDndInSilentMode
    ...    activateDndInVibrateMode
    ...    disableSoftPtt
    ...    callPriority
    ...    allowedScreenOrientations
    ...    lockSplitScreenSlider
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTTPRo Settings General
    Scroll And Verify Ui Element Is Not Present    textContains=Allow Bluetooth Audio
    Scroll And Verify Ui Element Is Not Present    textContains=Bluetooth Always On
    Scroll And Verify Ui Element Is Not Present    textContains=Activate DnD in Silent Mode
    Scroll And Verify Ui Element Is Not Present    textContains=Activate DnD in Vibrate Mode
    Scroll And Verify Ui Element Is Not Present    textContains=Disable Onscreen PTT
    Scroll And Verify Ui Element Is Not Present    textContains=Call Priority
    Scroll And Verify Ui Element Is Not Present    textContains=Allowed Screen Orientation
    Scroll And Verify Ui Element Is Not Present    textContains=Lock Split Screen Slider
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Disable Display On Phone Option For Multiple Settings    ${DEVICE1}    Gen

WFC-24046 [SERVER] Validate Default Callee Can Be Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    Gen    defaultCalleeType    show    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTTPRo Settings General
    Scroll And Verify Ui Element Is Not Present    textContains=Default Callee
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change Settings Values For A User    ${DEVICE1}    Gen    defaultCalleeType    show    1

WFC-24079 [SERVER] Validate Value Set For Headset Type On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    headsetSoundProfile    headsetType    use    1
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open Pttpro Menu Option Settings
    Scroll To Object Vertically    text=Headset Sound Profile
    Click    text=Headset Sound Profile
    Click    text=Headset Type
    ${status}    Wait For Exists    checked=true    text=Two Pulse
    IF    ${status} == ${FALSE}    Fail    Unlimited was not selected

WFC-24058 [SERVER] Validate Lanscape Orientation Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    Gen    allowedScreenOrientations    use    2
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    ${is_tablet}    Check Dut Is Tablet
    ${orienatation}    Set Variable If    ${is_tablet}    natural    left
    ${status}    Get Screen Orientation Of The Device
    Should Be Equal    "${status}"    "${orienatation}"
    [Teardown]    Run Keyword If    ${is_tablet}==${FALSE}
    ...    Change Settings Values For A User    ${DEVICE1}    Gen    allowedScreenOrientations    use    1

WFC-24059 [SERVER] Validate Portrait Orientation Set On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    Gen    allowedScreenOrientations    use    1
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    ${is_tablet}    Check Dut Is Tablet
    ${orienatation}    Set Variable If    ${is_tablet}    right    natural
    ${status}    Get Screen Orientation Of The Device
    Should Be Equal    "${status}"    "${orienatation}"
    [Teardown]    Run Keyword If    ${is_tablet}
    ...    Change Settings Values For A User    ${DEVICE1}    Gen    allowedScreenOrientations    use    2

WFC-24029 [SERVER] Validate Sign-out Option Not Available On Client
    [Tags]    generic
    Go To DUT1
    IF    "${PRO_APP_TYPE}"=="Gen1"
        Press Menu
    ELSE
        Open Ptt Pro Navigation Drawer
    END
    Verify Ui Element Is Present In Current Screen    textContains=Sign Out
    Press Home Key On Device
    builtin.Sleep    5s
    Verify Ui Element Is Not Present In Current Screen    packageName=${PTT_PRO_PACKAGE_NAME}
    Change FKS Values For A User    ${DEVICE1}    FK_ALLOW_USER_DEACTIVATE    0
    Verify Ui Element Is Not Present In Current Screen    packageName=${PTT_PRO_PACKAGE_NAME}
    Launch Pttpro
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    IF    "${PRO_APP_TYPE}"=="Gen1"
        Press Menu
    ELSE
        Open Ptt Pro Navigation Drawer
    END
    Verify Ui Element Is Not Present In Current Screen    textContains=Sign Out
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change FKS Values For A User    ${DEVICE1}    FK_ALLOW_USER_DEACTIVATE    1

WFC-24031 [SERVER] Validate Groups Tab Is Not Available On Client
    [Tags]    generic
    Go To DUT1
    Launch PTTPro
    Tap On Groups
    Hide Group Tab From Pro Server For User    ${DEVICE1}
    Launch PTTPro
    Verify Ptt Pro Contact Page Is Seen
    Verify Ptt Pro Groups Tab Is Not Seen
    Show Group Tab From Pro Server For User    ${DEVICE1}
    Launch PTTPro
    Verify Ptt Pro Groups Tab Is Seen
    Tap On Groups
    Verify PTTPRO Groups Has Opened
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Run Keyword If Test Failed
    ...        Show Group Tab From Pro Server For User    ${DEVICE1}    AND
    ...    Repeat Keyword    5
    ...        Press Back    AND
    ...    Launch Pttpro

WFC-24030 [SERVER] Validate Contacts Tab Is Not Available On Client
    [Tags]    generic
    Go To DUT1
    Launch PTTPro
    Tap On Contacts
    Verify PTTPRO Contacts Has Opened
    Change FKS Values For A User    ${DEVICE1}    FK_SHOW_CONTACTS    0
    BuiltIn.Sleep    5s
    Launch PTTPro
    Wait Until PTT Configuration Are Loaded And Applied
    Wait For Exists    timeout=30000    resourceId=com.symbol.wfc.pttpro:id/ptt
    Tap On Contacts
    ${status}    Wait For Exists    text=Contacts
    Should Not Be True    ${status}    "Contacts has opened"
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change FKS Values For A User    ${DEVICE1}    FK_SHOW_CONTACTS    1

WFC-24032 [SERVER] Validate Map Tab Is Not Available On Client
    [Tags]    generic
    Launch PTTPro
    Tap On Map
    Verify PTTPRO Map Has Opened
    Change FKS Values For A User    ${DEVICE1}    FK_SHOW_MAP    0
    BuiltIn.Sleep    5s
    Launch PTTPro
    Wait Until PTT Configuration Are Loaded And Applied
    Wait For Exists    timeout=30000    resourceId=com.symbol.wfc.pttpro:id/ptt
    Tap On Map
    ${status}    Wait For Exists    text=Map
    Should Not Be True    ${status}    "Map has opened"
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change FKS Values For A User    ${DEVICE1}    FK_SHOW_MAP    1

WFC-24033 [SERVER] Validate Settings Option Is Not Available On Client
    [Tags]    generic
    Launch PTTPro
    IF    "${PRO_APP_TYPE}"=="Gen1"
        Press Menu
    ELSE
        Open Ptt Pro Navigation Drawer
    END
    ${status}    Wait For Exists    textContains=Settings
    Should Be True    ${status}
    Press Back
    Change FKS Values For A User    ${DEVICE1}    FK_SHOW_SETTINGS    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Builtin.Sleep    2s
    IF    "${PRO_APP_TYPE}"=="Gen1"
        Press Menu
    ELSE
        Open Ptt Pro Navigation Drawer
    END
    ${status}    Wait For Exists    textContains=Settings
    Should Not Be True    ${status}
    Press Back
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change FKS Values For A User    ${DEVICE1}    FK_SHOW_SETTINGS    1

WFC-24024 [SERVER] Validate A Login Name Can Be Changed From Server
    [Tags]    generic
    Edit Basic Details Of User Using API    ${DEVICE1}    UserLogin    ${DEVICE1}12
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open Pttpro Menu Option About
    BuiltIn.Sleep    2
    ${status}    Wait For Exists    textContains=${DEVICE1}12
    Should Be True    ${status}    Updated UserLogin not seen in PTT Pro Application
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Edit Basic Details Of User Using API    ${DEVICE1}12    UserLogin    ${DEVICE1}    AND
    ...    Repeat Keyword    3
    ...        Press Back    AND
    ...    Launch Pttpro

WFC-24034 [SERVER] Validate Set Default Tab View On Client
    [Tags]    generic
    Change FKS Values For A User    ${DEVICE1}    FK_DEFAULT_VIEW    1
    Builtin.Sleep    10s
    Refresh Pttpro Page
    Verify PTTPRO Groups Has Opened
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change FKS Values For A User    ${DEVICE1}    FK_DEFAULT_VIEW    0

WFC-24035 [SERVER] Validate DnD Option Is Available/ Not Available On Client
    [Tags]    generic
    Change FKS Values For A User    ${DEVICE1}    FK_ALLOW_DND    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    IF    "${PRO_APP_TYPE}"=="Gen1"
        Press Menu
    ELSE
        Open Ptt Pro Navigation Drawer
    END
    ${status}    Wait For Exists    &{PTT_PRO_ONLINE_ON}
    Should Not Be True    ${status}    'DnD' option still seen in PTTPro.
    Change FKS Values For A User    ${DEVICE1}    FK_ALLOW_DND    1
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    IF    "${PRO_APP_TYPE}"=="Gen1"
        Press Menu
    ELSE
        Open Ptt Pro Navigation Drawer
    END
    ${status}    Wait For Exists    &{PTT_PRO_ONLINE_ON}
    Should Be True    ${status}    'DnD' option is not seen in PTTPro.
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change FKS Values For A User    ${DEVICE1}    FK_ALLOW_DND    1

WFC-24038 [SERVER] Validate On Duty Option Is Available On Client
    [Tags]    generic
    Change FKS Values For A User    ${DEVICE1}    FK_REPORT_LOCATION    1
    BuiltIn.Sleep    10
    Change FKS Values For A User    ${DEVICE1}    FK_FORCE_DUTY_MODE    1
    Verify Ptt Pro Contact Page Is Seen
    Refresh PTTPro Contacts Page
    builtin.Sleep    2s
    IF    "${PRO_APP_TYPE}"=="Gen1"
        Press Menu
    ELSE
        Open Ptt Pro Navigation Drawer
    END
    ${status}    Wait For Exists    textContains=On Duty
    Should Be True    ${status}    'On Duty On' option is not seen in PTTPro.
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change FKS Values For A User    ${DEVICE1}    FK_FORCE_DUTY_MODE    0

WFC-24039 [SERVER] Validate Message Option Is Not Available On Client
    [Tags]    generic
    Change FKS Values For A User    ${DEVICE1}    FK_MESSAGING    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Verify PTTPRO Contacts Has Opened
    ${status}    Wait For Exists    &{PTT_PRO_MESSAGE_BUTTON}
    Should Not Be True    ${status}    'Messaging' option is still seen in PTTPro.
    ${status}    Wait For Exists    packageName=com.symbol.wfc.pttpro
    IF    ${status} == ${FALSE}
        Fail    App crashed after server value modification
    END
    Press Home
    ${status}    Wait For Exists    textContains=WAIT
    IF    ${status}    Fail    App has crashed
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change FKS Values For A User    ${DEVICE1}    FK_MESSAGING    1

WFC-24041 [SERVER] Validate Contact And Group Search Is Not Available On Client
    [Tags]    generic
    Change FKS Values For A User    ${DEVICE1}    FK_ALLOW_LM_CONTACTS    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Tap On Contacts
    Verify PTTPRO Contacts Has Opened
    Click    &{USER_CONTACT_SEARCH_BUTTON}
    ${status}    Wait For Exists    &{SERVER_SEARCH_LOCATOR}
    Should Not Be True    ${status}
    Change FKS Values For A User    ${DEVICE1}    FK_ALLOW_LM_CONTACTS    1
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Go To DUT1
    Launch PTTPro
    Tap On Contacts
    Verify PTTPRO Contacts Has Opened
    Click    &{USER_CONTACT_SEARCH_BUTTON}
    ${status}    Wait For Exists    &{SERVER_SEARCH_LOCATOR}
    Should Be True    ${status}
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change FKS Values For A User    ${DEVICE1}    FK_ALLOW_LM_CONTACTS    1

WFC-24182 [Server] Validate 'Sign Out' And 'Quit App' Are Not Displayed If 'Allow Deactivation' Is Disabled From The Server
    [Tags]    generic
    Change FKS Values For A User    ${DEVICE1}    FK_ALLOW_USER_DEACTIVATE    0
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Launch Pttpro
    Open Ptt Pro Navigation Drawer
    ${status}    Wait For Exists    text=About
    IF    ${status} == ${FALSE}    Fail    About was supposed to be visible
    ${status}    Wait For Exists    text=Settings
    IF    ${status} == ${FALSE}    Fail    Settings was supposed to be visible
    ${status}    Wait For Exists    text=Sign Out
    IF    ${status}    Fail    Sign Out option is seen
    ${status}    Wait For Exists    text=Quit App
    IF    ${status}    Fail    Quit App option is seen
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Change FKS Values For A User    ${DEVICE1}    FK_ALLOW_USER_DEACTIVATE    1    AND
    ...    Repeat Keyword    3
    ...        Press Back    AND
    ...    Launch Pttpro

WFC-24007 [SERVER] Validate Group Created On Server With Allow Hiding Option Enable
    [Tags]    generic
    ${test_group_name}    Set Variable    ${COREID}_TestGroup
    Check And Delete Enterprise Group Via API    ${test_group_name}
    Create And Add Member To Enterprise Group Via API    ${test_group_name}    ${NUMBER_OF_DEVICES}
    BuiltIn.Sleep    5
    Tap On Groups
    BuiltIn.Sleep    5
    Refresh PTTPro Group Page
    Scroll To Object Vertically    textContains=${test_group_name}
    Click    textContains=${test_group_name}
    BuiltIn.Sleep    2
    Long Click    textContains=${test_group_name}
    Scroll To Object Vertically    textContains=Hide Group
    ${status}    Wait For Exists    textContains=Hide Group
    Should Be True    ${status}    Hide Group option is not seen
    Click    textContains=Hide Group
    Click On Element If Present    textContains=OK
    BuiltIn.Sleep    2
    ${status}    Wait For Exists    textContains=${test_group_name}
    Should Not Be True    ${status}    ${test_group_name} is seen
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Check And Delete Enterprise Group Via API    ${test_group_name}

WFC-24044 [SERVER] Validate Use Surveillance Call Mode Can Be Set On Server Reflects On Client
    [Tags]    generic
    Go To DUT1
    Change Settings Values For A User    ${DEVICE1}    Gen    enableSurveillanceCall    use    1
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Launch Pttpro
    Wait Until PTT Configuration Are Loaded And Applied
    Wait For Exists    timeout=30000    resourceId=com.symbol.wfc.pttpro:id/ptt
    Open PTTPRo Settings General
    Scroll To Object Vertically    textContains=Surveillance Call Brightness
    ${status}    Wait For Exists    textContains=Dim the screen brightness and display as full screen while in a call.
    Should Be True    ${status}    'Surveillance Call Brightness' option still not updated as Server values
    &{text}    Create Dictionary    text=Dim the screen brightness and display as full screen while in a call.
    &{enabled_status}    Get Relative Object Info
    ...    obj_a=&{text}
    ...    obj_b=&{SETTINGS_SWITCH_LOCATOR}
    ...    position=right
    Should Be Equal As Strings
    ...    "${enabled_status}[checked]"
    ...    "True"
    ...    Enable enableSurveillanceCall option is not enabled

WFC-24045 [SERVER] Validate Value Set For Surveillance Call Brightness Option On Server Reflects On Client
    [Tags]    generic
    Change Settings Values For A User    ${DEVICE1}    Gen    surveillanceCallBrightness    show    1
    BuiltIn.Sleep    10
    Change Settings Values For A User    ${DEVICE1}    Gen    surveillanceCallBrightness    use    60
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Launch Pttpro
    Wait Until PTT Configuration Are Loaded And Applied
    Wait For Exists    timeout=30000    resourceId=com.symbol.wfc.pttpro:id/ptt
    Open PTTPRo Settings General
    Scroll To Object Vertically    textContains=Surveillance Call Brightness
    Click    textContains=Surveillance Call Brightness
    ${status}    Wait For Exists    textContains=60 percent
    Should Be True    ${status}    'Surveillance Call Brightness' option still not updated as Server values

WFC-24049 [SERVER] Validate Default Sound Profile Page Is Blank On Client When Disabled On Server
    [Tags]    generic
    Disable Display On Phone Option For Multiple Settings
    ...    ${DEVICE1}
    ...    defaultSoundProfile
    ...    callVolume
    ...    volumeBoost
    ...    playBusyBonk
    ...    playCallLostTone
    ...    playDenyTone
    ...    playGrantTone
    ...    playIdleTone
    ...    playRevokeTone
    ...    playTakenTone
    ...    ringGain
    ...    ringOnIncomingCall
    ...    toneGain
    ...    vibrateOnGrant
    ...    vibrateOnIncomingCall
    ...    volumeBoost
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Settings Page
    Scroll To Object Vertically    textContains=Default Sound Profile
    ${status}    Wait For Exists    textContains=Default Sound Profile
    IF    "${PRO_APP_TYPE}"=="Gen2"
        Click    textContains=Default Sound Profile
    END
    IF    "${PRO_APP_TYPE}"=="Gen2"
        ${status}    Wait For Exists    resourceId=android:id/list    scrollable=true
    ELSE
        ${status}    Set Variable    ${NONE}
    END
    Should Not Be True    ${status}    'Default Sound Profile' option still seen in PTTPro Settings page
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Disable Display On Phone Option For Multiple Settings    ${DEVICE1}    defaultSoundProfile

WFC-24051 [SERVER] Validate Headset Sound Profile Page Is Blank On Client When Disabled On Server
    [Tags]    generic
    Disable Display On Phone Option For Multiple Settings
    ...    ${DEVICE1}
    ...    headsetSoundProfile
    ...    callVolume
    ...    headsetType
    ...    playBusyBonk
    ...    playCallLostTone
    ...    playDenyTone
    ...    playGrantTone
    ...    playIdleTone
    ...    playRevokeTone
    ...    playTakenTone
    ...    ringGain
    ...    ringOnIncomingCall
    ...    toneGain
    ...    vibrateOnGrant
    ...    vibrateOnIncomingCall
    ...    volumeBoost
    ...    wakeLock
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTT Pro Settings Page
    Scroll To Object Vertically    textContains=Headset Sound Profile
    ${status}    Wait For Exists    textContains=Headset Sound Profile
    IF    "${PRO_APP_TYPE}"=="Gen2"
        Click    textContains=Headset Sound Profile
    END
    IF    "${PRO_APP_TYPE}"=="Gen2"
        ${status}    Wait For Exists    resourceId=android:id/list    scrollable=true
    ELSE
        ${status}    Set Variable    ${NONE}
    END
    Should Not Be True    ${status}    'Headset Sound Profile' option still seen in PTTPro Settings page
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Disable Display On Phone Option For Multiple Settings    ${DEVICE1}    headsetSoundProfile

WFC-24047 [SERVER] Validate Call Options Are Not Displayed On Client When Disabled On Server
    [Tags]    generic
    Disable Display On Phone Option For Multiple Settings
    ...    ${DEVICE1}
    ...    Gen
    ...    wholeScreenAsPtt
    ...    startCallWithSpeaker
    ...    enableSurveillanceCall
    ...    surveillanceCallBrightness
    Verify Ptt Pro Contact Page Is Seen
    Refresh Pttpro Page
    Open PTTPRo Settings General
    Scroll And Verify Ui Element Is Not Present    textContains=Use Whole Screen as PTT
    Scroll And Verify Ui Element Is Not Present    textContains=Start call with Speakerphone
    Scroll And Verify Ui Element Is Not Present    textContains=Push to Talk Toggle
    Scroll And Verify Ui Element Is Not Present    textContains=Enable Surveillance Call
    Scroll And Verify Ui Element Is Not Present    textContains=Surveillance Call Brightness
    [Teardown]    Run Keywords
    ...    Common Ptt Pro Teardown Form Test Case Failure    AND
    ...    Disable Display On Phone Option For Multiple Settings    ${DEVICE1}    Gen

WFC-24312 Validate Reminder Notification Can Be Dismissed If User Disables The DnD Mode
    [Tags]    generic
    [Timeout]    45 Minutes
    Go To Dut1
    General_ADB_Res.Clear All Notifications
    Launch Pttpro
    Enable Dnd Mode
    Set And Verify DND Mode Reminder As ${DND_MODE_REMINDER_OPTIONS}[15_MINUTES]
    builtin.Sleep    5m
    Disable Dnd Mode
    builtin.Sleep    12m
    Open Notification
    Verify PTT Pro DND Reminder Not Seen In Notification
    [Teardown]    Run Keywords
    ...    Press Back    AND
    ...    Launch Pttpro    AND
    ...    Run Keyword If Test Failed
    ...        Disable Dnd Mode

WFC-24021 [SERVER] Validate A Contact Can Be Activated From Server
    [Tags]    generic
    Edit Basic Details Of User Using API    ${DEVICE1}    billingCode    0
    BuiltIn.Sleep    7
    Verify Authentication Failure Popup Is Seen
    Click    textContains=OK
    Edit Basic Details Of User Using API    ${DEVICE1}    billingCode    8
    Repeat Keyword    2
    ...    Press Back
    Launch PTTPro
    Click On Activate Button
    BuiltIn.Sleep    5
    Validate PTTPro Is Registered After Activation
    [Teardown]    Run Keywords
    ...    Repeat Keyword    2
    ...        Press Back    AND
    ...    Launch Pttpro    AND
    ...    Run Keyword If Test Failed
    ...        Edit Basic Details Of User Using API    ${DEVICE1}    billingCode    8    AND
    ...    Run Keyword If Test Failed
    ...        Builtin.Sleep    10s    AND
    ...    Run Keyword If Test Failed
    ...        Click On Activate Button    AND
    ...    Run Keyword If Test Failed
    ...        Validate PTTPro Is Registered After Activation

WFC-24016 [SERVER] Validate Clear Public Key Action Is Required When User Tries To Login To Application After Uninstalling And Installing Back The PTT Pro Apk On The Same Device, Try To Login With Same Activation Code
    [Tags]    generic
    [Timeout]    10m
    [Setup]    Go To DUT1
    ${activation_code}    Get Activation Code Of A User API    ${DEVICE1}
    UnInstall Pttpro Build
    builtin.Sleep    5s
    Install Pttpro Build
    Launch Pttpro
    Scroll To Object Vertically    &{PRO_DATA_USAGE_CONSENT_ACCEPT_BUTTON}
    builtin.Sleep    3s
    Click    &{PRO_DATA_USAGE_CONSENT_ACCEPT_BUTTON}
    builtin.Sleep    3s
    Enter Activation Code On Device    ${activation_code}    ${DUT1}
    builtin.Sleep    3s
    Click    &{ACTIVATE_PTTPRO_BUTTON}
    Wait For Exists    timeout=30000    resourceId=com.symbol.wfc.pttpro:id/tv_general_alert_description
    Verify Authentication Failure Popup Is Seen
    Click    textContains=OK
    ${activation_code}    Clear Public Key And Get Activation Code Of User Via Api    ${DEVICE1}
    BuiltIn.Sleep    10
    Activate PTTPro Client    ${activation_code}
