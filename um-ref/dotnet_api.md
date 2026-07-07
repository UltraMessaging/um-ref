# .NET API Reference

Auto-generated from XML-doc-commented public API in the `com.latencybusters.lbm` namespace (lbmcs/ source).

## Contents

- [JMSMessageId](#jmsmessageid)
- [LBM](#lbm)
- [LBMContext](#lbmcontext)
- [LBMContextAttributes](#lbmcontextattributes)
- [LBMContextEvent](#lbmcontextevent)
- [LBMContextEventCallback](#lbmcontexteventcallback)
- [LBMContextSourceEventCallback](#lbmcontextsourceeventcallback)
- [LBMContextStatistics](#lbmcontextstatistics)
- [LBMEInvalException](#lbmeinvalexception)
- [LBMEMessageSelectorException](#lbmemessageselectorexception)
- [LBMENoMemException](#lbmenomemexception)
- [LBMEOPException](#lbmeopexception)
- [LBMEOSException](#lbmeosexception)
- [LBMETimedOutException](#lbmetimedoutexception)
- [LBMEWouldBlockException](#lbmewouldblockexception)
- [LBMEventQueue](#lbmeventqueue)
- [LBMEventQueueAttributes](#lbmeventqueueattributes)
- [LBMEventQueueCallback](#lbmeventqueuecallback)
- [LBMEventQueueStatistics](#lbmeventqueuestatistics)
- [LBMException](#lbmexception)
- [LBMHFX](#lbmhfx)
- [LBMHFXAttributes](#lbmhfxattributes)
- [LBMHFXReceiver](#lbmhfxreceiver)
- [LBMHotFailoverReceiver](#lbmhotfailoverreceiver)
- [LBMHotFailoverSource](#lbmhotfailoversource)
- [LBMImmediateMessageCallback](#lbmimmediatemessagecallback)
- [LBMImmediateMessageReceiverStatistics](#lbmimmediatemessagereceiverstatistics)
- [LBMImmediateMessageSourceStatistics](#lbmimmediatemessagesourcestatistics)
- [LBMLogging](#lbmlogging)
- [LBMMessage](#lbmmessage)
- [LBMMessageChannelInfo](#lbmmessagechannelinfo)
- [LBMMessageProperties](#lbmmessageproperties)
- [LBMMessageProperty](#lbmmessageproperty)
- [LBMMessageReclamationCallback](#lbmmessagereclamationcallback)
- [LBMMonitor](#lbmmonitor)
- [LBMMonitorContextStatisticsCallback](#lbmmonitorcontextstatisticscallback)
- [LBMMonitorEAgainException](#lbmmonitoreagainexception)
- [LBMMonitorEAlreadyException](#lbmmonitorealreadyexception)
- [LBMMonitorEInvalException](#lbmmonitoreinvalexception)
- [LBMMonitorELBMFailException](#lbmmonitorelbmfailexception)
- [LBMMonitorEModFailException](#lbmmonitoremodfailexception)
- [LBMMonitorENoMemException](#lbmmonitorenomemexception)
- [LBMMonitorEventQueueStatisticsCallback](#lbmmonitoreventqueuestatisticscallback)
- [LBMMonitorImmediateMessageReceiverStatisticsCallback](#lbmmonitorimmediatemessagereceiverstatisticscallback)
- [LBMMonitorImmediateMessageSourceStatisticsCallback](#lbmmonitorimmediatemessagesourcestatisticscallback)
- [LBMMonitorReceiver](#lbmmonitorreceiver)
- [LBMMonitorReceiverStatisticsCallback](#lbmmonitorreceiverstatisticscallback)
- [LBMMonitorSource](#lbmmonitorsource)
- [LBMMonitorSourceStatisticsCallback](#lbmmonitorsourcestatisticscallback)
- [LBMNewTransportInfo](#lbmnewtransportinfo)
- [LBMObjectRecycler](#lbmobjectrecycler)
- [LBMObjectRecyclerBase](#lbmobjectrecyclerbase)
- [LBMOperationCompleteCallback](#lbmoperationcompletecallback)
- [LBMReceiver](#lbmreceiver)
- [LBMReceiverAttributes](#lbmreceiverattributes)
- [LBMReceiverCallback](#lbmreceivercallback)
- [LBMReceiverCreationCallback](#lbmreceivercreationcallback)
- [LBMReceiverStatistics](#lbmreceiverstatistics)
- [LBMRegistrationIdCallback](#lbmregistrationidcallback)
- [LBMRequest](#lbmrequest)
- [LBMResolverEventCallback](#lbmresolvereventcallback)
- [LBMResponseCallback](#lbmresponsecallback)
- [LBMSource](#lbmsource)
- [LBMSourceAttributes](#lbmsourceattributes)
- [LBMSourceChannelInfo](#lbmsourcechannelinfo)
- [LBMSourceCostCallback](#lbmsourcecostcallback)
- [LBMSourceCreationCallback](#lbmsourcecreationcallback)
- [LBMSourceDeletionCallback](#lbmsourcedeletioncallback)
- [LBMSourceEvent](#lbmsourceevent)
- [LBMSourceEventCallback](#lbmsourceeventcallback)
- [LBMSourceEventFlightSizeNotification](#lbmsourceeventflightsizenotification)
- [LBMSourceEventSequenceNumberInfo](#lbmsourceeventsequencenumberinfo)
- [LBMSourceEventTimestampInfo](#lbmsourceeventtimestampinfo)
- [LBMSourceEventWakeupInfo](#lbmsourceeventwakeupinfo)
- [LBMSourceNotification](#lbmsourcenotification)
- [LBMSourceSendExInfo](#lbmsourcesendexinfo)
- [LBMSourceStatistics](#lbmsourcestatistics)
- [LBMStatistics](#lbmstatistics)
- [LBMTimer](#lbmtimer)
- [LBMTimerCallback](#lbmtimercallback)
- [LBMTopic](#lbmtopic)
- [LBMTransportMappingCallback](#lbmtransportmappingcallback)
- [LBMTransportSourceInfo](#lbmtransportsourceinfo)
- [LBMUMMInfo](#lbmumminfo)
- [LBMWildcardPatternCallback](#lbmwildcardpatterncallback)
- [LBMWildcardReceiver](#lbmwildcardreceiver)
- [LBMWildcardReceiverAttributes](#lbmwildcardreceiverattributes)
- [LBMWildcardReceiverCreateCallback](#lbmwildcardreceivercreatecallback)
- [LBMWildcardReceiverDeleteCallback](#lbmwildcardreceiverdeletecallback)
- [LBMXSP](#lbmxsp)
- [LBMXSPAttributes](#lbmxspattributes)
- [LBMZeroTransportsCallback](#lbmzerotransportscallback)
- [UMEDeregistrationCompleteInfo](#umederegistrationcompleteinfo)
- [UMEDeregistrationSuccessInfo](#umederegistrationsuccessinfo)
- [UMEMessageAck](#umemessageack)
- [UMENoQueueException](#umenoqueueexception)
- [UMENoRegException](#umenoregexception)
- [UMENoStoreException](#umenostoreexception)
- [UMEReceiverLivenessCallbackInfo](#umereceiverlivenesscallbackinfo)
- [UMEReceiverLivenessCreationCallback](#umereceiverlivenesscreationcallback)
- [UMEReceiverLivenessDeletionCallback](#umereceiverlivenessdeletioncallback)
- [UMERecoverySequenceNumberCallback](#umerecoverysequencenumbercallback)
- [UMERecoverySequenceNumberCallbackInfo](#umerecoverysequencenumbercallbackinfo)
- [UMERegistrationCompleteInfo](#umeregistrationcompleteinfo)
- [UMERegistrationIdExCallback](#umeregistrationidexcallback)
- [UMERegistrationIdExCallbackInfo](#umeregistrationidexcallbackinfo)
- [UMERegistrationSuccessInfo](#umeregistrationsuccessinfo)
- [UMESourceEventAckInfo](#umesourceeventackinfo)
- [UMESourceEventDeregistrationCompleteInfo](#umesourceeventderegistrationcompleteinfo)
- [UMESourceEventDeregistrationSuccessInfo](#umesourceeventderegistrationsuccessinfo)
- [UMESourceEventRegistrationCompleteInfo](#umesourceeventregistrationcompleteinfo)
- [UMESourceEventRegistrationSuccessInfo](#umesourceeventregistrationsuccessinfo)
- [UMEStoreEntry](#umestoreentry)
- [UMEStoreGroupEntry](#umestoregroupentry)
- [UMQContextEventRegistrationCompleteInfo](#umqcontexteventregistrationcompleteinfo)
- [UMQContextEventRegistrationSuccessInfo](#umqcontexteventregistrationsuccessinfo)
- [UMQDeregistrationCompleteInfo](#umqderegistrationcompleteinfo)
- [UMQIndexAssignedInfo](#umqindexassignedinfo)
- [UMQIndexAssignmentEligibilityStartCompleteInfo](#umqindexassignmenteligibilitystartcompleteinfo)
- [UMQIndexAssignmentEligibilityStopCompleteInfo](#umqindexassignmenteligibilitystopcompleteinfo)
- [UMQIndexInfo](#umqindexinfo)
- [UMQIndexReleasedInfo](#umqindexreleasedinfo)
- [UMQMessageId](#umqmessageid)
- [UMQMessageTotalLifetimeInfo](#umqmessagetotallifetimeinfo)
- [UMQQueueIndexInfo](#umqqueueindexinfo)
- [UMQQueueInfo](#umqqueueinfo)
- [UMQQueueInstanceInfo](#umqqueueinstanceinfo)
- [UMQRegistrationCompleteInfo](#umqregistrationcompleteinfo)
- [UMQSourceEventAckInfo](#umqsourceeventackinfo)
- [UMQSourceEventMessageIdInfo](#umqsourceeventmessageidinfo)
- [UMQSourceEventRegistrationCompleteInfo](#umqsourceeventregistrationcompleteinfo)
- [UMQSourceEventULBMessageInfo](#umqsourceeventulbmessageinfo)
- [UMQSourceEventULBReceiverInfo](#umqsourceeventulbreceiverinfo)
- [lbmdump](#lbmdump)

## JMSMessageId

*class* `com.latencybusters.lbm.JMSMessageId`

### JMSMessageId

```csharp
public JMSMessageId(String topic)
```

 Creates a JMSMessageId object and initializes fields to the
supplied values.

<param name="topic">A topic string.
</param>

### getMessageId

```csharp
public virtual string getMessageId()
```

 Get the JMS MessageId.
<returns> JMS MessageId string.
</returns>

## LBM

*class* `com.latencybusters.lbm.LBM`

### LBM

```csharp
public LBM()
```

Instantiate LBM utility class

### setLicenseFile

```csharp
public static void setLicenseFile(String licenseFile)
```

Initialize the LBM license from the contents of a disk file.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
This method will only be effective if it is called before
any other LBM API method.
</remarks>
<param name="licenseFile">String containing the name of a
file that contains the LBM license.  This string is the same
as that which would otherwise be specified as the  value of
the LBM_LICENSE_FILENAME environmental variable.</param>

### setLicenseString

```csharp
public static void setLicenseString(String licenseString)
```

Initialize the LBM license from a string.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
This method will only be effective if it is called before
any other LBM API method.
</remarks>
<param name="licenseString">String containing LBM license.
This string is the same as that which would otherwise be
specified as the  value of the LBM_LICENSE_FILENAME
environmental variable.</param>

### setConfiguration

```csharp
public static void setConfiguration(string fileName)
```

Configure LBM attributes from a file, tftp or http URL.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="fileName">String containing a file name or URL (tftp or http). File names with a ".xml" extension be processed by the setConfigurationXml API with a null applicationName. </param>

### setConfigurationXml

```csharp
public static void setConfigurationXml(string fileName, string applicationName)
```

Configure LBM attributes from an xml file.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="fileName">String containing the xml file name or URL (tftp or http)</param>
<param name="applicationName">String containing the application name</param>

### setConfigurationXmlString

```csharp
public static void setConfigurationXmlString(string xmlString, string applicationName)
```

Configure LBM attributes from a string.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="xmlString">String containing LBM XML configuration data </param>
<param name="applicationName">String containing the application name</param>

### setUmmInfo

```csharp
unsafe public static void setUmmInfo(LBMUMMInfo _info)
```

Connect to and retrieve configuration from a UMM daemon

<remarks>
This method will only be effective if it is called before
any other LBM API method.
</remarks>
<exception ref="com.latencybusters.lbm.LBMException">UMM info has already been initialized, or invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="_info">UMM daemon connection options</param>

### version

```csharp
public static string version()
```

Get LBM version information.

<returns>LBM version</returns>

### setLogger

```csharp
public void setLogger(LBMLogging logger)
```

Inform LBM to use a specific logger for logging

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="logger">Logging callback implementing the LBMLogging delegate interface</param>

### setDebugFilename

```csharp
public static void setDebugFilename(String filename)
```

Specify the name of the debug log to be written

<param name="filename">Name of the file to be written with debug data</param>

### setDebugMask

```csharp
public static void setDebugMask(ulong mask)
```

Specify the debugging mask to be applied to debugging output.
This is set based on recommendation of support staff.

<param name="mask">The debugging mask to be used when determining if an item should be logged</param>

### setUimLossRate

```csharp
public static void setUimLossRate(int rate)
```

Specify the receiver-side loss rate for UIMs.

<param name="rate">The percentage (0-100) of messages for which loss is desired.</param>

### setLbtrmLossRate

```csharp
public static void setLbtrmLossRate(int rate)
```

Specify the receiver-side loss rate for LBTRM transports.

<param name="rate">The percentage (0-100) of messages for which loss is desired.</param>

### setLbtrmSrcLossRate

```csharp
public static void setLbtrmSrcLossRate(int rate)
```

Specify the source-side loss rate for LBTRM transports.

<param name="rate">The percentage (0-100) of messages for which loss is desired.</param>

### setLbtruLossRate

```csharp
public static void setLbtruLossRate(int rate)
```

Specify the receiver-side loss rate for LBTRU transports.

<param name="rate">The percentage (0-100) of messages for which loss is desired.</param>

### setLbtruSrcLossRate

```csharp
public static void setLbtruSrcLossRate(int rate)
```

Specify the source-side loss rate for LBTRU transports.

<param name="rate">The percentage (0-100) of messages for which loss is desired.</param>

### setDebugLogCallback

```csharp
public static void setDebugLogCallback(bool enable)
```

Enable logging of debug messages to the application logging callback
set by LBM.setLogger(). By default, if lbm debug logging is enabled it is
sent to the filename specified by setDebugFilename(), or stderr.
Calling setDebugLogCallback() with a value of true will redirect debug
logging to the application logger set by setLogger(), or
stderr if no logger is set.

<param name="enable">true enables, false disables.</param>

### dumpDebugLog

```csharp
public static void dumpDebugLog(String filename, bool append)
```

 Dump the in-memory LBM debug log to a specified file.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="filename">Name of the file to dump debug log events to.</param>
<param name="append">Set to true to append the debug log to the file; otherwise, the file is overwritten.</param>

### errorNumber

```csharp
public static int errorNumber()
```

Returns last LBM error number

<returns>LBM error number</returns>

### errorMessage

```csharp
public static string errorMessage()
```

Returns last LBM error message

<returns>LBM error message</returns>

## LBMContext

*class* `com.latencybusters.lbm.LBMContext`

### LBMContext

```csharp
public LBMContext() : this(null)
```

Instantiate an LBMContext object using default attributes.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### LBMContext

```csharp
public LBMContext(LBMContextAttributes lbmcattr)
```

Instantiate an LBMContext object using given attributes.

<param name="lbmcattr">LBMContextAttributes used to initialize the context</param>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### close

```csharp
public void close()
```

Close and dispose of this context.
<para><b>Warning</b>: It is not safe to call this method from a context thread callback.</para>

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Returns an array of context attributes in LBConfigOption

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>Returns an array of context attributes in LBConfigOption</returns>

### getAttributeValue

```csharp
public string getAttributeValue(string attributeName)
```

Returns the value of a context-related attribute for this context.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setAttributeValue

```csharp
public void setAttributeValue(string attributeName, string attributeValue)
```

Set the value of a context-related attribute for this context.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Note that this method bypasses the property list.
As such no attributes configured using this method will appear in
the property list.
</remarks>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### processEvents

```csharp
public void processEvents(long msec)
```

Process internal events in the given LBM context object.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
When the operational mode is set to "sequential",
it is the responsibility of the application to explicitly process
events for the LBM context. This method will process timers and
API timer and file descriptor/socket events.
<para><b>Warning</b>: It is not safe to call this method from a context thread callback.</para>
</remarks>
<param name="msec">Continue event processing loop for at least msec milliseconds before returning.</param>

### processEvents

```csharp
public void processEvents(long msec, int flags)
```

Process internal events in the given LBM context object.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
When the operational mode is set to "sequential",
it is the responsibility of the application to explicitly process
events for the LBM context. This method will process timers and
API timer and file descriptor/socket events.
<para><b>Warning</b>: It is not safe to call this method from a context thread callback.</para>
</remarks>
<param name="msec">Continue event processing loop for at least msec milliseconds before returning.</param>
<param name="flags">Flags to select various features.</param>
<see cref="LBM.PROC_EVENT_EX_FLAG_NO_MAIN_LOOP_MUTEX"/>

### processEvents

```csharp
public void processEvents(long msec, int flags, UInt32 tv_sec, UInt32 tv_usec)
```

Process internal events in the given LBM context object.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
When the operational mode is set to "sequential",
it is the responsibility of the application to explicitly process
events for the LBM context. This method will process timers and
API timer and file descriptor/socket events.
<para><b>Warning</b>: It is not safe to call this method from a context thread callback.</para>
</remarks>
<param name="msec">Continue event processing loop for at least msec milliseconds before returning.</param>
<param name="flags">Flags to select various features.</param>
<see cref="LBM.PROC_EVENT_EX_FLAG_NO_MAIN_LOOP_MUTEX"/>
<see cref="LBM.PROC_EVENT_EX_FLAG_USER_TIME"/>
<param name="tv_sec">User supplies time when the LBM.PROC_EVENT_EX_FLAG_USER_TIME flag is set.</param>
<param name="tv_usec">User supplies time when the LBM.PROC_EVENT_EX_FLAG_USER_TIME flag is set.</param>

### unblockProcessEvents

```csharp
public void unblockProcessEvents()
```

Unblock processEvents call.

<exception ref="com.latencybusters.lbm.LBMException"> if any error occurs.</exception>
<remarks>
When the operational mode is set to "sequential",
this API forces a call to processEvents to return immediately after
completing the current set of I/O operations instead of waiting.
</remarks>

### lookupTopic

```csharp
public LBMTopic lookupTopic(string symbol)
```

Create an LBMTopic object (useable for an LBM receiver) for a given topic name.
Topic strings should be limited in length to 246 characters (not including
the final null).

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="symbol">Topic name string</param>
<returns>LBMTopic object for specified topic name</returns>

### lookupTopic

```csharp
public LBMTopic lookupTopic(string symbol, LBMReceiverAttributes lbmrattr)
```

Create an LBMTopic object (useable for an LBM receiver)
for given topic name and attributes.
Topic strings should be limited in length to 246 characters (not including
the final null).

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="symbol"> Topic name string</param>
<param name="lbmrattr">lbmrattr LBMReceiverAttributes object</param>
<returns>LBMTopic object for specified topic name and attributes</returns>

### allocTopic

```csharp
public LBMTopic allocTopic(string symbol)
```

Create an LBMTopic object (useable for an LBM source)
for given topic name and attributes.
Topic strings should be limited in length to 246 characters (not including
the final null).

<param name="symbol">Topic name string</param>
<returns>LBMTopic object for specified topic name and attributes</returns>

### allocTopic

```csharp
public LBMTopic allocTopic(string symbol, LBMSourceAttributes lbmsattr)
```

Create an LBMTopic object (useable for an LBM source)
for given topic name and attributes.
Topic strings should be limited in length to 246 characters (not including
the final null).

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="symbol">Topic name string</param>
<param name="lbmsattr">LBMSourceAttributes object</param>
<returns>LBMTopic object for specified topic name and attributes</returns>

### enableImmediateMessageReceiver

```csharp
public void enableImmediateMessageReceiver()
```

Enable LBM to receive non-topic immediate messages.

<remarks>
This method does not establish a callback handler.
The callback to handle immediate messages should be
established using <see cref="addImmediateMessageReceiver"/>.
<seealso cref="addImmediateMessageReceiver"/>
</remarks>

### enableImmediateMessageReceiver

```csharp
public void enableImmediateMessageReceiver(LBMEventQueue lbmevq)
```

Enable LBM to receive non-topic immediate messages (using an event
queue).

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
This method does not establish a callback handler.
The callback to handle immediate messages should be
established using <see cref="addImmediateMessageReceiver"/>.
<seealso cref="addImmediateMessageReceiver"/>
</remarks>
<param name="lbmevq">LBMEventQueue on which to process responses (may be null
if not using an event queue)</param>

### addImmediateMessageReceiver

```csharp
public void addImmediateMessageReceiver(LBMImmediateMessageCallback cb)
```

Register a callback for handling of non-topic immediate messages

\note
Reception of non-topic immediate messages is disabled by default
and may be enabled only by calling
<see cref="enableImmediateMessageReceiver"/>.

<seealso cref="enableImmediateMessageReceiver"/>
<seealso cref="LBMImmediateMessageCallback"/>
<seealso cref="removeImmediateMessageReceiver"/>
<param name="cb">Object implementing the LBMImmediateMessageCallback delegate interface</param>

### addImmediateMessageReceiver

```csharp
public void addImmediateMessageReceiver(LBMImmediateMessageCallback cb, object cbArg)
```

Register a callback for handling of non-topic immediate messages

\note
Reception of non-topic immediate messages is disabled by default
and may be enabled only by calling
<see cref="enableImmediateMessageReceiver"/>

<seealso cref="LBMImmediateMessageCallback"/>
<seealso cref="removeImmediateMessageReceiver"/>
<param name="cb">Callback implementing the LBMImmediateMessageCallback delegate interface</param>
<param name="cbArg">Callback token object</param>

### removeImmediateMessageReceiver

```csharp
public void removeImmediateMessageReceiver(LBMImmediateMessageCallback cb)
```

Deregister a non-topic, immediate message callback

<remarks>
<seealso cref="enableImmediateMessageReceiver"/>
<seealso cref="addImmediateMessageReceiver"/>
<seealso cref="LBMImmediateMessageCallback"/>
</remarks>
<param name="cb">Callback implementing the LBMImmediateMessageCallback delegate interface</param>

### removeImmediateMessageReceiver

```csharp
public void removeImmediateMessageReceiver(LBMImmediateMessageCallback cb, object cbArg)
```

Deregister a non-topic, immediate message callback

<remarks>
<seealso cref="enableImmediateMessageReceiver"/>
<seealso cref="addImmediateMessageReceiver"/>
<seealso cref="LBMImmediateMessageCallback"/>
</remarks>
<param name="cb">Callback implementing the LBMImmediateMessageCallback delegate interface</param>
<param name="cbArg">Callback token for previously registered callback</param>

### send

```csharp
public void send(string target, string topic, byte [] data, int dataLength, int flags)
```

Send a unicast immediate message to the target and topic.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
The target is a string of one of the following forms:
<ul>
<li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
    the ID of the destination topic resolution domain, <i>ip</i> is the IP address
    of the destination host, and <i>port</i> is the request port for
    the context of the destination application.
</li>
<li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
    of the destination host and <i>port</i> is the request port for
    the context of the destination application. This usage assumes
    the destination is in the same topic resolution domain as the sender.
</li>
<li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
    string associated with a source's transport session. This allows
    a subscriber to send a unicast immediate message directly to a
    publishing application.  See \ref sendingtosources for details.
</li>
</ul>

 \note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

Note that immediate messages are processed somewhat less efficiently
than source-based messages.
</remarks>
<param name="target">Destination address string.</param>
<param name="topic">Topic name to send message to or null for non-topic</param>
<param name="data">Data to send in this message</param>
<param name="dataLength">Length (in bytes) of the data to send in this message</param>
<param name="flags">Flags indicating various conditions.</param>

### sendTopicless

```csharp
public void sendTopicless(string target, byte[] data, int dataLength, int flags)
```

Send a topicless unicast immediate message to the target.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
The target is a string of one of the following forms:
<ul>
<li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
    the ID of the destination topic resolution domain, <i>ip</i> is the IP address
    of the destination host, and <i>port</i> is the request port for
    the context of the destination application.
</li>
<li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
    of the destination host and <i>port</i> is the request port for
    the context of the destination application. This usage assumes
    the destination is in the same topic resolution domain as the sender.
</li>
<li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
    string associated with a source's transport session. This allows
    a subscriber to send a unicast immediate message directly to a
    publishing application.  See \ref sendingtosources for details.
</li>
</ul>

 \note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

Note that immediate messages are processed somewhat less efficiently
than source-based messages.
</remarks>
<param name="target">Destination address string.</param>
<param name="data">Data to send in this message</param>
<param name="dataLength">Length (in bytes) of the data to send in this message</param>
<param name="flags">Flags indicating various conditions.</param>

### sendc

```csharp
public void sendc(char [] target, char [] topic, byte[] data, int dataLength, int flags)
```

Send a unicast immediate message to the target and topic.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
The target is a string of one of the following forms:
<ul>
<li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
    the ID of the destination topic resolution domain, <i>ip</i> is the IP address
    of the destination host, and <i>port</i> is the request port for
    the context of the destination application.
</li>
<li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
    of the destination host and <i>port</i> is the request port for
    the context of the destination application. This usage assumes
    the destination is in the same topic resolution domain as the sender.
</li>
<li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
    string associated with a source's transport session. This allows
    a subscriber to send a unicast immediate message directly to a
    publishing application.  See \ref sendingtosources for details.
</li>
</ul>

 \note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

Note that immediate messages are processed somewhat less efficiently
than source-based messages.
</remarks>
<param name="target">Destination address string.</param>
<param name="topic">Topic name to send message to or null for non-topic</param>
<param name="data">Data to send in this message</param>
<param name="dataLength">Length (in bytes) of the data to send in this message</param>
<param name="flags">Flags indicating various conditions.</param>

### sendTopicless

```csharp
public void sendTopicless(char[] target, byte[] data, int dataLength, int flags)
```

Send a topicless unicast immediate message to the target.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
The target is a string of one of the following forms:
<ul>
<li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
    the ID of the destination topic resolution domain, <i>ip</i> is the IP address
    of the destination host, and <i>port</i> is the request port for
    the context of the destination application.
</li>
<li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
    of the destination host and <i>port</i> is the request port for
    the context of the destination application. This usage assumes
    the destination is in the same topic resolution domain as the sender.
</li>
<li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
    string associated with a source's transport session. This allows
    a subscriber to send a unicast immediate message directly to a
    publishing application.  See \ref sendingtosources for details.
</li>
</ul>

 \note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

Note that immediate messages are processed somewhat less efficiently
than source-based messages.
</remarks>
<param name="target">Destination address string.</param>
<param name="data">Data to send in this message</param>
<param name="dataLength">Length (in bytes) of the data to send in this message</param>
<param name="flags">Flags indicating various conditions.</param>

### send

```csharp
public void send(string target, string topic, LBMRequest lbmreq, LBMEventQueue lbmevq, int flags)
```

Send a unicast immediate request message to the target and topic.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
The target is a string of one of the following forms:
<ul>
<li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
    the ID of the destination topic resolution domain, <i>ip</i> is the IP address
    of the destination host, and <i>port</i> is the request port for
    the context of the destination application.
</li>
<li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
    of the destination host and <i>port</i> is the request port for
    the context of the destination application. This usage assumes
    the destination is in the same topic resolution domain as the sender.
</li>
<li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
    string associated with a source's transport session. This allows
    a subscriber to send a unicast immediate message directly to a
    publishing application.  See \ref sendingtosources for details.
</li>
</ul>

 \note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

Note that immediate messages are processed somewhat less efficiently
than source-based messages.
</remarks>
<param name="target">Destination address string.</param>
<param name="topic">Topic name to send message to or null for non-topic</param>
<param name="lbmreq">LBMRequest object</param>
<param name="lbmevq">LBMEventQueue on which to process responses (may be null if not using an event queue)</param>
<param name="flags">Flags indicating various conditions</param>

### send

```csharp
public void send(string target, string topic, LBMRequest lbmreq, int flags)
```

Send a unicast immediate request message to the target and topic.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
The target is a string of one of the following forms:
<ul>
<li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
    the ID of the destination topic resolution domain, <i>ip</i> is the IP address
    of the destination host, and <i>port</i> is the request port for
    the context of the destination application.
</li>
<li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
    of the destination host and <i>port</i> is the request port for
    the context of the destination application. This usage assumes
    the destination is in the same topic resolution domain as the sender.
</li>
<li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
    string associated with a source's transport session. This allows
    a subscriber to send a unicast immediate message directly to a
    publishing application.  See \ref sendingtosources for details.
</li>
</ul>
</remarks>

 \note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

Note that immediate messages are processed somewhat less efficiently
than source-based messages.
<param name="target">Destination address string.</param>
<param name="topic">Topic name to send message to or null for non-topic</param>
<param name="lbmreq">LBMRequest object</param>
<param name="flags">Flags indicating various conditions</param>

### send

```csharp
public void send(string topic, byte [] data, int dataLength, int flags)
```

Send a multicast immediate message to a specific topic

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Possible OR'd set of flag value include:
<see cref="LBM.SRC_NONBLOCK"/>, <see cref="LBM.SRC_BLOCK"/>, and <see cref="LBM.MSG_FLUSH"/>

 \note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

</remarks>
<param name="topic">Topic name to send message to or null for non-topic</param>
<param name="data">Data to send in this message</param>
<param name="dataLength">Length (in bytes) of the data to send in this message</param>
<param name="flags">Flags indicating various conditions</param>

### sendc

```csharp
public void sendc(char [] topic, byte[] data, int dataLength, int flags)
```

Send a multicast immediate message to a specific topic

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Possible OR'd set of flag value include:
<see cref="LBM.SRC_NONBLOCK"/>, <see cref="LBM.SRC_BLOCK"/>, and <see cref="LBM.MSG_FLUSH"/>

 \note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

</remarks>
<param name="topic">Topic name to send message to or null for non-topic</param>
<param name="data">Data to send in this message</param>
<param name="dataLength">Length (in bytes) of the data to send in this message</param>
<param name="flags">Flags indicating various conditions</param>

### sendTopicless

```csharp
public void sendTopicless(byte[] data, int dataLength, int flags)
```

Send a topicless multicast immediate message

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Possible OR'd set of flag value include:
<see cref="LBM.SRC_NONBLOCK"/>, <see cref="LBM.SRC_BLOCK"/>, and <see cref="LBM.MSG_FLUSH"/>

 \note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

</remarks>
<param name="data">Data to send in this message</param>
<param name="dataLength">Length (in bytes) of the data to send in this message</param>
<param name="flags">Flags indicating various conditions</param>

### send

```csharp
public void send(string topic, LBMRequest lbmreq, LBMEventQueue lbmevq, int flags)
```

Send a multicast immediate request to a specific topic (specifying an
Event Queue for processing of the response(s))

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Possible OR'd set of flag value include:
<see cref="LBM.SRC_NONBLOCK"/>, <see cref="LBM.SRC_BLOCK"/>, and <see cref="LBM.MSG_FLUSH"/>

 \note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

</remarks>
<param name="topic">Topic name to send message to or null for non-topic</param>
<param name="lbmreq">LBMRequest object</param>
<param name="lbmevq">LBMEventQueue on which to process responses (may be
null if not using an event queue)</param>
<param name="flags">Flags indicating various conditions</param>

### send

```csharp
public void send(string topic, LBMRequest lbmreq, int flags)
```

Send a multicast immediate request to a specific topic

<remarks>
Possible OR'd set of flag value include:
<see cref="LBM.SRC_NONBLOCK"/>, <see cref="LBM.SRC_BLOCK"/>, and <see cref="LBM.MSG_FLUSH"/>

 \note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

</remarks>
<param name="topic">Topic name to send message to or null for non-topic</param>
<param name="lbmreq">LBMRequest object</param>
<param name="flags">Flags indicating various conditions</param>

### send

```csharp
public void send(string queue, string topic, byte [] data, int dataLength, int flags, LBMSourceSendExInfo exinfo)
```

Send a multicast immediate message on a specific topic to a queue. (UMQ only)

<remarks>
Possible OR'd set of flag value include:
<see cref="LBM.SRC_NONBLOCK"/>, <see cref="LBM.SRC_BLOCK"/>, and <see cref="LBM.MSG_FLUSH"/>

 \note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

</remarks>
<param name="queue">Queue to submit message to</param>
<param name="topic">Topic name to send message to or null for non-topic</param>
<param name="data">Data to send in this message</param>
<param name="dataLength">Length (in bytes) of the data to send in this message</param>
<param name="flags">Flags indicating various conditions</param>
<param name="exinfo">LBMSourceSendExInfo object, which includes flags to
change callback behavior and a client-supplied object to be passed back.</param>

### createTimer

```csharp
public LBMTimer createTimer(long milliseconds)
```

Create an LBM Timer object

<remarks>
References to timers created using this method are not maintained internally.  If the timer
returned by this method goes out of scope and is reclaimed by the garbage collector, callbacks
registered for this timer will not execute.  To create a timer with an internally maintained
reference, see the <see cref="scheduleTimer"/> method.
</remarks>
<param name="milliseconds">Number of milliseconds until the timer expires</param>
<returns>LBMTimer object</returns>

### createTimer

```csharp
public LBMTimer createTimer(long milliseconds, LBMEventQueue lbmevq)
```

Creates a timer associated with this context and a specified event queue
that expires with a specified delay.

<remarks>
References to timers created using this method are not maintained internally.  If the timer
returned by this method goes out of scope and is reclaimed by the garbage collector, callbacks
registered for this timer will not execute.  To create a timer with an internally maintained
reference, see the <see cref="scheduleTimer"/> method.
</remarks>
<param name="milliseconds">Number of milliseconds until the timer expires</param>
<param name="lbmevq">Event queue with with which to associate this timer
(the timer events will be posted to this event queue)</param>
<returns>LBMTimer object</returns>

### createTimer

```csharp
public LBMTimer createTimer(long milliseconds, LBMTimerCallback cb, Object cbArg)
```

Creates a timer associated with this context that expires with
specified delay.

<remarks>
References to timers created using this method are not maintained internally.  If the timer
returned by this method goes out of scope and is reclaimed by the garbage collector, callbacks
registered for this timer will not execute.  To create a timer with an internally maintained
reference, see the <see cref="scheduleTimer"/> method.
</remarks>
<param name="milliseconds">Number of milliseconds until the timer expires</param>
<param name="cb">Callback implementing the LBMTimerCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>
<returns>LBMTimer object</returns>

### createTimer

```csharp
public LBMTimer createTimer(long milliseconds, LBMTimerCallback cb, object cbArg, LBMEventQueue lbmevq)
```

Creates a timer associated with this context and a specified event queue
that expires with a specified delay.

<remarks>
References to timers created using this method are not maintained internally.  If the timer
returned by this method goes out of scope and is reclaimed by the garbage collector, callbacks
registered for this timer will not execute.  To create a timer with an internally maintained
reference, see the <see cref="scheduleTimer"/> method.
</remarks>
<param name="milliseconds">Number of milliseconds until the timer expires</param>
<param name="cb">Callback implementing the LBMTimerCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>
<param name="lbmevq">Event queue with with which to associate this timer
(the timer events will be posted to this event queue)</param>
<returns>LBMTimer object</returns>

### scheduleTimer

```csharp
public LBMTimer scheduleTimer(long milliseconds)
```

Create an LBM Timer object and retains an internal reference to it.
This prevents the timer from being reclaimed by the garbage collector before it expires.

<remarks>
See <see cref="createTimer"/> to create a timer that will be reclaimed by the
garbage collector in the normal manner once it goes out of scope.
</remarks>
<param name="milliseconds">Number of milliseconds until the timer expires</param>
<returns>LBMTimer object</returns>

### scheduleTimer

```csharp
public LBMTimer scheduleTimer(long milliseconds, LBMEventQueue lbmevq)
```

Creates a timer associated with this context and a specified event queue
that expires with a specified delay, and retains an internal reference to it.
This prevents the timer from being reclaimed by the garbage collector before it expires.

<remarks>
See <see cref="createTimer"/> to create a timer that will be reclaimed by the
garbage collector in the normal manner once it goes out of scope.
</remarks>
<param name="milliseconds">Number of milliseconds until the timer expires</param>
<param name="lbmevq">Event queue with with which to associate this timer
(the timer events will be posted to this event queue)</param>
<returns>LBMTimer object</returns>

### scheduleTimer

```csharp
public LBMTimer scheduleTimer(long milliseconds, LBMTimerCallback cb, Object cbArg)
```

Creates a timer associated with this context that expires with
specified delay, and retains an internal reference to it.
This prevents the timer from being reclaimed by the garbage collector before it expires.

<remarks>
See <see cref="createTimer"/> to create a timer that will be reclaimed by the
garbage collector in the normal manner once it goes out of scope.
</remarks>
<param name="milliseconds">Number of milliseconds until the timer expires</param>
<param name="cb">Callback implementing the LBMTimerCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>
<returns>LBMTimer object</returns>

### scheduleTimer

```csharp
public LBMTimer scheduleTimer(long milliseconds, LBMTimerCallback cb, Object cbArg, LBMEventQueue lbmevq)
```

Creates a timer associated with this context and a specified event queue
that expires with a specified delay.
This prevents the timer from being reclaimed by the garbage collector before it expires.

<remarks>
See <see cref="createTimer"/> to create a timer that will be reclaimed by the
garbage collector in the normal manner once it goes out of scope.
</remarks>
<param name="milliseconds">Number of milliseconds until the timer expires</param>
<param name="cb">Callback implementing the LBMTimerCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>
<param name="lbmevq">Event queue with with which to associate this timer
(the timer events will be posted to this event queue)</param>
<returns>LBMTimer object</returns>

### createSource

```csharp
public LBMSource createSource(LBMTopic lbmtopic)
```

Create an LBM Source object associated with this context and a given topic.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the source.</param>
<returns>LBMSource object</returns>

### createSource

```csharp
public LBMSource createSource(LBMTopic lbmtopic, LBMSourceEventCallback cb, object cbArg)
```

Create an LBM Source object associated with this context
and a given topic.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the source</param>
<param name="cb">Callback implementing the LBMSourceEventCallback delegate interface</param>
<param name="cbArg">Callback token object</param>
<returns>LBMSource object</returns>

### createSource

```csharp
public LBMSource createSource(LBMTopic lbmtopic, LBMEventQueue lbmevq)
```

Create an LBM Source object associated with this given context
and a given topic and event queue.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the source</param>
<param name="lbmevq">vent queue with which to associate the source
(all source events will be posted to this event queue)</param>
<returns>LBMSource object</returns>

### createSource

```csharp
public LBMSource createSource(LBMTopic lbmtopic, LBMSourceEventCallback cb, object cbArg, LBMEventQueue lbmevq)
```

Create an LBM Source object associated with this context
and a given topic and event queue.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the source</param>
<param name="cb">Callback implementing the LBMSourceEventCallback delegate interface</param>
<param name="cbArg">Callback token object</param>
<param name="lbmevq">Event queue with which to associate the source
(all source events will be posted to this event queue)</param>
<returns>LBMSource object</returns>

### createHotFailoverSource

```csharp
public LBMHotFailoverSource createHotFailoverSource(LBMTopic lbmtopic)
```

Create an LBM Hot-Failover Source object associated with this context and a given topic.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the source.</param>
<returns>LBMHotFailoverSource object</returns>

### createHotFailoverSource

```csharp
public LBMHotFailoverSource createHotFailoverSource(LBMTopic lbmtopic, LBMSourceEventCallback cb, object cbArg)
```

Create an LBM Hot-Failover Source object associated with this context
and a given topic.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the source</param>
<param name="cb">Callback implementing the LBMSourceEventCallback delegate interface</param>
<param name="cbArg">Callback token object</param>
<returns>LBMHotFailoverSource object</returns>

### createHotFailoverSource

```csharp
public LBMHotFailoverSource createHotFailoverSource(LBMTopic lbmtopic, LBMEventQueue lbmevq)
```

Create an LBM Hot-Failover Source object associated with this given context
and a given topic and event queue.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the source</param>
<param name="lbmevq">vent queue with which to associate the source
(all source events will be posted to this event queue)</param>
<returns>LBMHotFailoverSource object</returns>

### createHotFailoverSource

```csharp
public LBMHotFailoverSource createHotFailoverSource(LBMTopic lbmtopic, LBMSourceEventCallback cb, object cbArg, LBMEventQueue lbmevq)
```

Create an LBM Hot-Failover Source object associated with this context
and a given topic and event queue.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the source</param>
<param name="cb">Callback implementing the LBMSourceEventCallback delegate interface</param>
<param name="cbArg">Callback token object</param>
<param name="lbmevq">Event queue with which to associate the source
(all source events will be posted to this event queue)</param>
<returns>LBMHotFailoverSource object</returns>

### createReceiver

```csharp
public LBMReceiver createReceiver(LBMTopic lbmtopic)
```

Create an LBM Receiver object associated with this context
and a given topic.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the receiver</param>
<returns>LBMReceiver object</returns>

### createReceiver

```csharp
public LBMReceiver createReceiver(LBMTopic lbmtopic, LBMEventQueue lbmevq)
```

Create an LBM Receiver object associated with this context
and a given topic and event queue.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the receiver</param>
<param name="lbmevq">Event queue with which to associate the receiver
(all receiver events will be posted to this event queue)</param>
<returns>LBMReceiver object</returns>

### createReceiver

```csharp
public LBMReceiver createReceiver(LBMTopic lbmtopic, LBMReceiverCallback cb, object cbArg)
```

Create an LBM Receiver object associated with this context
and a given topic.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the receiver</param>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>
<returns>LBMReceiver object</returns>

### createReceiver

```csharp
public LBMReceiver createReceiver(LBMTopic lbmtopic, LBMReceiverCallback cb, object cbArg, LBMEventQueue lbmevq)
```

Create an LBM Receiver object associated with this context
and a given topic and event queue.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the receiver</param>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>
<param name="lbmevq">Event queue with which to associate the receiver
(all receiver events will be posted to this event queue)</param>
<returns>LBMReceiver object</returns>

### createHotFailoverReceiver

```csharp
public LBMHotFailoverReceiver createHotFailoverReceiver(LBMTopic lbmtopic)
```

Create an LBM Hot-Failover Receiver object associated with this context
and a given topic.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the receiver</param>
<returns>LBMHotFailoverReceiver object</returns>

### createHotFailoverReceiver

```csharp
public LBMHotFailoverReceiver createHotFailoverReceiver(LBMTopic lbmtopic, LBMEventQueue lbmevq)
```

Create an LBM Hot-Failover Receiver object associated with this context
and a given topic and event queue.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the receiver</param>
<param name="lbmevq">Event queue with which to associate the receiver
(all receiver events will be posted to this event queue)</param>
<returns>LBMReceiver object</returns>

### createHotFailoverReceiver

```csharp
public LBMHotFailoverReceiver createHotFailoverReceiver(LBMTopic lbmtopic, LBMReceiverCallback cb, object cbArg)
```

Create an LBM Hot-Failover Receiver object associated with this context
and a given topic.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the receiver</param>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>
<returns>LBMHotFailoverReceiver object</returns>

### createHotFailoverReceiver

```csharp
public LBMHotFailoverReceiver createHotFailoverReceiver(LBMTopic lbmtopic, LBMReceiverCallback cb, object cbArg, LBMEventQueue lbmevq)
```

Create an LBM Hot-Failover Receiver object associated with this context
and a given topic and event queue.

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<param name="lbmtopic">LBMTopic used to initialize the receiver</param>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>
<param name="lbmevq">Event queue with which to associate the receiver
(all receiver events will be posted to this event queue)</param>
<returns>LBMReceiver object</returns>

### addSourceNotifyCallback

```csharp
public void addSourceNotifyCallback(LBMSourceNotification cb)
```

Register a callback interface to be
called when a new source is seen for any topic.

<remarks>
This callback is
called directly in line and does not use the event queue; therefore,
the callback function used should not block or it will block the
context thread processing.  This facility is disabled by default
and may be enabled by calling the
<see cref="LBMContextAttributes.enableSourceNotification"/>
method prior to instantiation of LBMContext.
<seealso cref="LBMSourceNotification"/>
<seealso cref="removeSourceNotifyCallback"/>
</remarks>
<param name="cb">Callback implementing the LBMSourceNotification delegate interface</param>

### addSourceNotifyCallback

```csharp
public void addSourceNotifyCallback(LBMSourceNotification cb, object cbArg)
```

Register a callback interface (and a callback handle argument) to be
called when a new source is seen for any topic.

<remarks>
This callback is
called directly in line and does not use the event queue; therefore,
the callback function used should not block or it will block the
context thread processing.  This facility is disabled by default
and may be enabled by calling the
<see cref="LBMContextAttributes.enableSourceNotification"/>
method prior to instantiation of LBMContext.
<seealso cref="LBMSourceNotification"/>
<seealso cref="removeSourceNotifyCallback"/>
</remarks>
<param name="cb">Callback implementing the LBMSourceNotification delegate interface</param>
<param name="cbArg">Callback object passed as a token to the callback interface</param>

### removeSourceNotifyCallback

```csharp
public void removeSourceNotifyCallback(LBMSourceNotification cb)
```

Deregister a source notification callback

<remarks>
<seealso cref="LBMSourceNotification"/>
<seealso cref="addSourceNotifyCallback"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMSourceNotification delegate interface</param>

### getStatistics

```csharp
public LBMContextStatistics getStatistics()
```

Return the current set of statistics for this context

<returns>LBMContextStatistics object containing the statistics
corresponding to this context</returns>

### resetStatistics

```csharp
public void resetStatistics()
```

This will reset the statistics for this context at the c layer.
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### getSourceStatistics

```csharp
public LBMSourceStatistics getSourceStatistics(int maxStats)
```

Return the aggregate set of source transport statistics for this context

<param name="maxStats">Maximum number of sources</param>
<returns>LBMReceiverStatistics object containing the statistics
corresponding to the specified number of sources</returns>

### resetSourceStatistics

```csharp
public void resetSourceStatistics()
```

This will reset the transport statistics for all sources in this context.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### getReceiverStatistics

```csharp
public LBMReceiverStatistics getReceiverStatistics(int maxStats)
```

Return the aggregate set of receiver transport statistics for this context

<param name="maxStats">Maximum number of sources</param>
<returns>LBMReceiverStatistics object containing the statistics
corresponding to the specified number of sources</returns>

### resetReceiverStatistics

```csharp
public void resetReceiverStatistics()
```

This will reset the transport stats for all receivers in this context.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### getImmediateMessageSourceStatistics

```csharp
public LBMImmediateMessageSourceStatistics getImmediateMessageSourceStatistics(int maxStats)
```

Return the immediate message source statistics for this context.

<param name="maxStats">Maximum number of sources</param>
<returns>LBMImmediateMessageSourceStatistics object containing the statistics corresponding
to this context</returns>

### resetImmediateMessageSourceStatistics

```csharp
public void resetImmediateMessageSourceStatistics()
```

This will reset the immediate message source transport statistics for this context.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### getImmediateMessageReceiverStatistics

```csharp
public LBMImmediateMessageReceiverStatistics getImmediateMessageReceiverStatistics(int maxStats)
```

Return the immediate message source statistics for this context.

<param name="maxStats">Maximum number of sources</param>
<returns>LBMImmediateMessageSourceStatistics object containing the statistics corresponding
to this context</returns>

### resetImmediateMessageReceiverStatistics

```csharp
public void resetImmediateMessageReceiverStatistics()
```

Reset the immediate message receiver transport statistics for this context.

### getUMQInflight

```csharp
public int getUMQInflight(string queue)
```

Get the current UMQ inflight value for this context
<param name="queue">Name of the queue</param>
<returns>the inflight value</returns>
<exception ref="com.latencybusters.lbm.LBMException">if an error occurs while retrieving the inflight value</exception>

### setUMQInflight

```csharp
public int setUMQInflight(string queue, LBMSetInflightCallback cb, object cbObj)
```

Set the current UMQ inflight value for this context. This function is deprecated
<param name="queue">Name of the queue</param>
<param name="cb">LBMSetInflightCallback delegate</param>
<param name="cbObj">Client object passed into callback</param>
<returns>the new inflight value</returns>
<exception ref="com.latencybusters.lbm.LBMException">if an error occurs while setting the inflight value</exception>

### setUMQMessageStable

```csharp
public void setUMQMessageStable(string queue, UMQMessageId msg_id)
```

Mark a specific msg_id as stable, triggering an event if configured to do so, and adjusting the inflight if necessary. This function is deprecated.
<param name="queue">Name of the queue</param>
<param name="msg_id">MessageId of the message to mark stable</param>
<exception ref="com.latencybusters.lbm.LBMException">if an error occurs while marking the message stable</exception>

### requestTopicResolution

```csharp
public void requestTopicResolution(ushort flags, uint interval_msec, uint duration_sec)
```

Request Topic Advertisements (sources), Topic Queries (receivers),
and/or Wildcard Topic Queries (wildcard receivers) in the configured topic
resolution address domain.

<remarks>
Since Advertisements and Queries can become quiescent after a
period defined by the Topic Resolution configuration attributes,
this function will schedule Topic Resolution Requests at the given
interval and duration. Contexts that receive these requests
will respond with one advertisement per source and/or one
query per receiver as appropriate. These requests
will be ignored for topics that are not quiescent. Note that
requests are only sent on the outgoing address and are only
received on the incoming address. Responses to the request
will similarly be sent only on the outgoing address.
</remarks>
<param name="flags">Flags indicating desired requests.  ORed set of values.
<see cref="LBM.TOPIC_RES_REQUEST_ADVERTISEMENT" /> - Request advertisements from quiescent sources.
<see cref="LBM.TOPIC_RES_REQUEST_QUERY" /> - Request queries from quiescent receivers.
<see cref="LBM.TOPIC_RES_REQUEST_WILDCARD_QUERY" /> - Request queries from quiescent wildcard receivers.</param>
<see cref="LBM.TOPIC_RES_REQUEST_CONTEXT_ADVERTISEMENT" /> - Request context advertisements from quiescent contexts.
<see cref="LBM.TOPIC_RES_REQUEST_CONTEXT_QUERY" /> - Request context queries from quiescent contexts.
<param name="interval_msec"> Interval between requests in milliseconds.  Less than 10 should be used with caution.  Less than 5 is not recommended.</param>
<param name="duration_sec"> Minimum duration of requests in seconds.  Actual duration can be longer depending on the interval.  A value of zero will result in 1 request and the interval will be meaningless.</param>

### removeSourceNotifyCallback

```csharp
public void removeSourceNotifyCallback(LBMSourceNotification cb, object cbArg)
```

Deregister a source notification callback

<remarks>
<seealso cref="LBMSourceNotification"/>
<seealso cref="addSourceNotifyCallback"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMSourceNotification delegate interface</param>
<param name="cbArg">Callback token for previously registered callback</param>

### Dispose

```csharp
public void Dispose()
```

Same as <see cref="close"/>

<remarks><seealso cref="close"/></remarks>

## LBMContextAttributes

*class* `com.latencybusters.lbm.LBMContextAttributes`

### LBMContextAttributes

```csharp
unsafe public LBMContextAttributes()
```

Instantiate an LBMContextAttributes class

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### LBMContextAttributes

```csharp
unsafe public LBMContextAttributes(string contextName)
```

Instantiate an LBMContextAttributes class using a context name from the xml configuration that
must have been previously loaded.  Use an empty string ("") to match a context without a name.

<param name="contextName">Context name string. Is written into the attributes object.</param>
<exception ref="com.latencybusters.lbm.LBMException">The contextName is not permitted by the XML configuration, or other unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of attributes.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of attributes (same as Dispose()).
<seealso cref="Dispose"/>

### setFromXml

```csharp
unsafe public void setFromXml(string contextName)
```

Set values in an LBMContextAttributes class using a context name from the xml configuration that
must have been previously loaded.  Use an empty string ("") to match a context without a name.

<param name="contextName">Context name string. Is written into the attributes object.</param>
<exception ref="com.latencybusters.lbm.LBMException">The contextName is not permitted by the XML configuration, or other unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Returns an array of context attributes in LBConfigOption

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>Returns an array of context attributes in LBConfigOption</returns>

### getValue

```csharp
unsafe public string getValue(string attributeName)
```

Returns the current value of an attribute from this set of context attributes.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setValue

```csharp
unsafe public void setValue(string attributeName, string attributeValue)
```

Set the current value of an attribute in this set of
context attributes.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### setSourceNotification

```csharp
public void setSourceNotification(LBMSourceNotification cb, object cbarg)
```

Set the callback and token to be used for source notifications.

<param name="cb">The source notification callback</param>
<param name="cbarg">The callback object token</param>

### clearSourceNotification

```csharp
public void clearSourceNotification()
```

Clear the currently stored source notification callback and token

### enableSourceNotification

```csharp
public void enableSourceNotification()
```

Enable new source notifications.

<remarks>
New source notifications are delivered via the source notification
callback set by <see cref="LBMContext.addSourceNotifyCallback"/>.
<seealso cref="LBMContext.addSourceNotifyCallback"/>
<seealso cref="disableSourceNotification"/>
</remarks>

### disableSourceNotification

```csharp
public void disableSourceNotification()
```

Disable new source notifications.

<remarks>
<seealso cref="enableSourceNotification"/>
</remarks>

### setResolverEventCallback

```csharp
public void setResolverEventCallback(LBMResolverEventCallback cb, object cbArg)
```

Set the context event callback for an LBMContext.

<param name="cb">
A delegate of type LBMResolverEventCallback
</param>
<param name="cbArg">
A token to be passed in to the callback when an event occurs
</param>

### setResolverEventCallback

```csharp
public void setResolverEventCallback(LBMResolverEventCallback cb)
```

Set the context event callback for an LBMContext.

<param name="cb">
A delegate of type LBMResolverEventCallback
</param>

### setSourceCostCallback

```csharp
public void setSourceCostCallback(LBMSourceCostCallback cb)
```

Set the source cost callback function for an LBMContext,
which is an application callback to evaluate the cost of a newly discovered source

<param name="cb">LBMSourceCostCallback callback delegate</param>

### setSourceCostCallback

```csharp
public void setSourceCostCallback(LBMSourceCostCallback cb, object cbArg)
```

Set the source cost callback function for an LBMContext,
which is an application callback to evaluate the cost of a newly discovered source

<param name="cb">LBMSourceCostCallback callback delegate</param>
<param name="cbArg">Callback object token</param>

### setTransportMappingCallback

```csharp
public void setTransportMappingCallback(LBMTransportMappingCallback cb)
```

Set the transport mapping callback function for an LBMContext

<param name="cb">LBMTransportMappingCallback callback delegate</param>

### setTransportMappingCallback

```csharp
public void setTransportMappingCallback(LBMTransportMappingCallback cb, object cbArg)
```

Set the transport mapping callback function for an LBMContext

<param name="cb">LBMTransportMappingCallback callback delegate</param>
<param name="cbArg">Callback object token</param>

### setContextSourceEventCallback

```csharp
public void setContextSourceEventCallback(LBMContextSourceEventCallback cb)
```

Set the context-level source event callback for an LBMContext.

<param name="cb">LBMContextSourceEventCallback callback delegate.</param>

### setContextSourceEventCallback

```csharp
public void setContextSourceEventCallback(LBMContextSourceEventCallback cb, LBMEventQueue evq)
```

Set the context-level source event callback for an LBMContext.

<param name="cb">LBMContextSourceEventCallback callback delegate.</param>
<param name="evq">LBMEventQueue on which to place context-level source events (can be null).</param>

### setContextSourceEventCallback

```csharp
public void setContextSourceEventCallback(LBMContextSourceEventCallback cb, object cbArg)
```

Set the context-level source event callback for an LBMContext.

<param name="cb">LBMContextSourceEventCallback callback delegate.</param>
<param name="cbArg">Callback object.</param>

### setContextSourceEventCallback

```csharp
public void setContextSourceEventCallback(LBMContextSourceEventCallback cb, object cbArg, LBMEventQueue evq)
```

Set the context-level source event callback for an LBMContext.

<param name="cb">LBMContextSourceEventCallback callback delegate.</param>
<param name="cbArg">Callback object.</param>
<param name="evq">LBMEventQueue on which to place context-level source events (can be null).</param>

### setContextEventCallback

```csharp
public void setContextEventCallback(LBMContextEventCallback cb)
```

Set the context event callback for an LBMContext.

<param name="cb">
A delegate of type LBMContextEventCallback
</param>

### setContextEventCallback

```csharp
public void setContextEventCallback(LBMContextEventCallback cb, object cbArg)
```

Set the context event callback for an LBMContext.

<param name="cb">
A delegate of type LBMContextEventCallback
</param>
<param name="cbArg">
A token to be passed in to the callback when an event occurs
</param>

### setContextEventCallback

```csharp
public void setContextEventCallback(LBMContextEventCallback cb, object cbArg, LBMEventQueue evq)
```

Set the context event callback for an LBMContext.

<param name="cb">
A delegate of type LBMContextEventCallback
</param>
<param name="cbArg">
A token to be passed in to the callback when an event occurs
</param>
<param name="evq">
An event queue used to hold context events until the application is ready to process them
</param>

### setImmediateMessageCallback

```csharp
public void setImmediateMessageCallback(LBMImmediateMessageCallback cb)
```

Set (and enable) the context callback for topic-less immediate mode messages.

<param name="cb">LBMImmediateMessageCallback callback delegate.</param>

### setImmediateMessageCallback

```csharp
public void setImmediateMessageCallback(LBMImmediateMessageCallback cb, LBMEventQueue evq)
```

Set (and enable) the context callback for topic-less immediate mode messages.

<param name="cb">LBMImmediateMessageCallback callback delegate.</param>
<param name="evq">LBMEventQueue on which to place received topic-less immediate-mode messages (can be null).</param>

### setImmediateMessageCallback

```csharp
public void setImmediateMessageCallback(LBMImmediateMessageCallback cb, object cbArg)
```

Set (and enable) the context callback for topic-less immediate mode messages.

<param name="cb">LBMImmediateMessageCallback callback delegate.</param>
<param name="cbArg">Callback object.</param>

### setImmediateMessageCallback

```csharp
public void setImmediateMessageCallback(LBMImmediateMessageCallback cb, object cbArg, LBMEventQueue evq)
```

Set (and enable) the context callback for topic-less immediate mode messages.

<param name="cb">LBMImmediateMessageCallback callback delegate.</param>
<param name="cbArg">Callback object.</param>
<param name="evq">LBMEventQueue on which to place received topic-less immediate-mode messages (can be null).</param>

### setUMEReceiverLivenessNotificationCallbacks

```csharp
public void setUMEReceiverLivenessNotificationCallbacks(UMEReceiverLivenessCreationCallback creationCb, UMEReceiverLivenessDeletionCallback deletionCb, object cbArg)
```

Set per receiver context liveness detection creation and deletion notification callback functions.

<exception ref="com.latencybusters.lbm.LBMEInvalException">Both receiver liveness notification callbacks must be set or cleared at once.</exception>
<exception ref="com.latencybusters.lbm.LBMException">Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer functions.</exception>
<param name="creationCb">UME Receiver Liveness creation callback delegate</param>
<param name="deletionCb">UME Reciever Liveness deletion callback delegate</param>
<param name="cbArg">Client-supplied callback object.</param>

### setObjectRecycler

```csharp
public void setObjectRecycler(LBMObjectRecyclerBase objRec, Object objRecCbArg)
```

Set the LBM object recycler that can be used by the context to reuse LBMMessage objects as
well as LBM Context/Receiver/Source Statistics objects.

<param name="objRec">an LBM object recycler that will be called when objects need to be retrieved</param>
<param name="objRecCbArg">a callback object token that will be passed in the retrieve method</param>

## LBMContextEvent

*class* `com.latencybusters.lbm.LBMContextEvent`

### LBMContextEvent

```csharp
public LBMContextEvent()
```

 Create an empty LBM Context Event

### type

```csharp
public virtual int type()
```

 LBM Context Event Type
<returns> LBM Context Event type
</returns>
<seealso cref="LBM">
</seealso>

### dataString

```csharp
public virtual System.String dataString()
```

 Error string associated with this event.
This event may not be valid for all event types.

<returns> Error string
</returns>
<seealso cref="LBM">
</seealso>

### registrationSuccessInfo

```csharp
public virtual UMQContextEventRegistrationSuccessInfo registrationSuccessInfo()
```

 Registration success info object associated with this event.
This event may not be valid for all event types.

<returns> UMQContextEventRegistrationSuccessInfo object
</returns>
<seealso cref="LBM">
</seealso>

### registrationCompleteInfo

```csharp
public virtual UMQContextEventRegistrationCompleteInfo registrationCompleteInfo()
```

 Registration complete info object associated with this event.
This event may not be valid for all event types.

<returns> UMQContextEventRegistrationCompleteInfo object
</returns>
<seealso cref="LBM">
</seealso>

## LBMContextEventCallback

*delegate* `com.latencybusters.lbm.LBMContextEventCallback`

### LBMContextEventCallback

```csharp
public delegate int LBMContextEventCallback(object cbArg, LBMContextEvent contextEvent)
```

Context event callback.
<param name="cbArg">Callback object token </param>
<param name="contextEvent">LBMContextEvent object encapsulating event </param>
<returns> an int, which should always be 0. </returns>

## LBMContextSourceEventCallback

*delegate* `com.latencybusters.lbm.LBMContextSourceEventCallback`

### LBMContextSourceEventCallback

```csharp
public delegate void LBMContextSourceEventCallback(object cbArg, LBMContextSourceEvent sourceEvent)
```

Context source event callback delegate

<param name="cbArg">Callback object token</param>
<param name="sourceEvent">LBMContextSourceEvent object encapsulating context source event information</param>

## LBMContextStatistics

*class* `com.latencybusters.lbm.LBMContextStatistics`

### LBMContextStatistics

```csharp
public LBMContextStatistics()
```

Instantiate an empty object containing no statistics.

### LBMContextStatistics

```csharp
public LBMContextStatistics(LBMContext lbmctx)
```

Instantiate an object containing the current set of
statistics for a given context.

<param name="lbmctx">LBMContext object to load statistics from.</param>

### refresh

```csharp
unsafe public void refresh(LBMContext lbmctx)
```

Refresh the current set of statistics using the given lbm context.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="lbmctx">LBMContext object</param>

### topicResolutionDatagramsSent

```csharp
public long topicResolutionDatagramsSent()
```

Number of topic resolution datagrams sent from this context.

<returns>
Number of topic resolution datagrams sent from this context. Each
datagram can contain
one or more advertisements, queries, query responses, etc. from source or receiver
objects. A faster accumulation of counts typically indicates more source, receiver,
and/or context objects are being created.
</returns>

### topicResolutionBytesSent

```csharp
public long topicResolutionBytesSent()
```

Number of topic resolution datagram bytes sent.

<returns>
Number of topic resolution datagram bytes sent. This count is triggered under the
same circumstances as datagrams sent (above), but measures the total number of bytes
for all datagrams sent, including their headers.
</returns>

### topicResolutionDatagramsReceived

```csharp
public long topicResolutionDatagramsReceived()
```

Number of topic resolution datagrams received by this context.

<returns>
Number of topic resolution datagrams received by this context.
Each datagram can contain
one or more advertisements, queries, query responses, etc. from source or receiver
objects. A faster accumulation of counts typically indicates more source, receiver,
and/or context objects are being created.
</returns>

### topicResolutionBytesReceived

```csharp
public long topicResolutionBytesReceived()
```

Number of topic resolution datagram bytes received.

<returns>
Number of topic resolution datagram bytes received.
This count is triggered under the
same circumstances as datagrams received (above), but measures the total number of
bytes for all datagrams received, including their headers.
</returns>

### topicResolutionDatagramsDroppedVersion

```csharp
public long topicResolutionDatagramsDroppedVersion()
```

Number of topic resolution datagrams discarded due to incorrect version.

<returns>
Number of topic resolution datagrams discarded due to incorrect version.
The datagram's
version field must match the expectations of the receiving context.
</returns>

### topicResolutionDatagramsDroppedType

```csharp
public long topicResolutionDatagramsDroppedType()
```

Number of topic resolution datagrams discarded due to incorrect type. The datagram's
type field must match the expectations of the receiving context. A mismatch in
encryption (TLS) or compression will also be treated as a mismatch of type.

<returns>Number of topic resolution datagrams discarded due to incorrect
type. The datagram's type field must match the expectations of the
receiving context.</returns>

### topicResolutionDatagramsDroppedMalformed

```csharp
public long topicResolutionDatagramsDroppedMalformed()
```

Number of topic resolution datagrams discarded due to being malformed.

<returns>Number of topic resolution datagrams discarded due to being
malformed or corrupted. </returns>

### topicResolutionDatagramsSendFailed

```csharp
public long topicResolutionDatagramsSendFailed()
```

Number of topic resolution datagram sends that failed.

<returns>Number of topic resolution datagram sends that failed.  This count
should be at or at least near 0. </returns>

### topicResolutionSourceTopics

```csharp
public long topicResolutionSourceTopics()
```

Total number of topics in the source topic resolver cache.

<returns> Number of topics in the source topic resolver cache
(also known as the topic map). Inordinately large or growing values here may
impact performance.  </returns>

### topicResolutionReceiverTopics

```csharp
public long topicResolutionReceiverTopics()
```

Total number of topics in the receiver topic resolver cache.

<returns>Total number of topics in the receiver topic resolver cache (also
referred to as the topic map). Inordinately large or growing values here
may impact performance.</returns>

### topicResolutionUnresolvedReceiverTopics

```csharp
public long topicResolutionUnresolvedReceiverTopics()
```

Number of unresolved topics in the receiver topic resolver cache.

<returns> Number of unresolved topics in the receiver topic resolver cache
(aka topic map). Inordinately large or growing values here may impact
performance, though this count can be close to the total number of topics in
the resolver cache under normal conditions.</returns>

### lbtrmUnknownMessagesReceived

```csharp
public long lbtrmUnknownMessagesReceived()
```

Number of LBT-RM datagrams received not belonging to any transport session.

<returns>
Number of LBT-RM datagrams received not belonging to any transport
session. Such occurrences should be investigated. These datagrams can be
from a source in a different topic resolution domain targeting the same group
(or IP) and port as a source of interest on this receiver's topic resolution
domain. Among less likely possibilities would be an attempt to spoof UM
messages. </returns>

### lbtruUnknownMessagesReceived

```csharp
public long lbtruUnknownMessagesReceived()
```

Number of LBT-RU datagrams received not belonging to any transport session.

<returns>
Number of LBT-RU datagrams received not belonging to any transport session. Such
occurrences should be investigated. These datagrams can be from a source in a
different topic resolution domain targeting the same group (or IP) and port
as a source of interest on this receiver's topic resolution domain. Among less
likely possibilities would be an attempt to spoof UM messages.
</returns>

### sendBlocked

```csharp
public long sendBlocked()
```

Number of incidents where a UM send call was blocked.

<returns>Number of incidents where a UM send call was blocked. Unusually
high counts could indicate performance degradation or I/O problems.</returns>

### sendWouldBlock

```csharp
public long sendWouldBlock()
```

Number of incidents where a UM send call returned EWOULDBLOCK.

<returns>
Number of incidents where a UM send call returned EWOULDBLOCK. This is when a send
call set to be nonblocking encounters an error condition where it would otherwise be
blocked. Under normal operating conditions, this count should be at or near 0.
</returns>

### responseBlocked

```csharp
public long responseBlocked()
```

Number of incidents where a UM send response call was blocked.

<returns>Number of incidents where a UM send response call was blocked.
Unusually high counts could indicate performance degradation or I/O problems.
</returns>

### responseWouldBlock

```csharp
public long responseWouldBlock()
```

Number of incidents where a UM send response call returned EWOULDBLOCK.

<returns>
Number of incidents where a UM send response call returned EWOULDBLOCK. This
is when a send response call
set to be nonblocking encounters an error condition where it would otherwise be
blocked. Under normal operating conditions, this count should be at or near 0.
</returns>

### unicastImmediateMessageDuplicatesReceived

```csharp
public long unicastImmediateMessageDuplicatesReceived()
```

Number of duplicate unicast immediate messages (UIMs) received and dropped.

<returns>Number of duplicate unicast immediate messages (UIMs) received and dropped.</returns>

### unicastImmediateMessageNoStreamReceived

```csharp
public long unicastImmediateMessageNoStreamReceived()
```

Number of unicast immediate messages (UIMs) received without stream information.

<returns>Number of unicast immediate messages (UIMs) received without stream information.</returns>

### fragmentsLost

```csharp
public long fragmentsLost()
```

Number of fragments that have possibly been lost. This stat
is incremented when a gap is detected by a receiver delivery controller. A
delivery controller is created for every topic that has an interested
receiver. This stat is not updated for gaps detected in responses,
MIM transports, or UIMs. This stat will not be updated for hot-failover
receivers with arrival-order delivery (i.e. option ordered_delivery set to
0). SMX receivers are excluded from this stat. THIS FIELD IS UNSUPPORTED.

<returns>Number of fragments possibly lost. THIS FIELD IS UNSUPPORTED.</returns>

### fragmentsUnrecoverablyLost

```csharp
public long fragmentsUnrecoverablyLost()
```

Number of fragments that have been declared
as unrecoverably lost. This stat is incremented when
LBM_MSG_UNRECOVERABLE_LOSS or LBM_MSG_UNRECOVERABLE_LOSS_BURST is
delivered to an UM receiver callback. In the case of burst loss,
the stat is incremented by the number of fragments lost in the burst
event. This stat will not be updated for hot-failover receivers
with arrival-order delivery (i.e. option ordered_delivery set to
0). For hot-failover receivers, this stat may be updated while no
actual LBM_MSG_UNRECOVERABLE_LOSS/LOSS_BURST messages are delivered
to the application. In that case, one of the receivers underlying the
hot-failover receivers had experienced unrecoverable loss, but the other
underlying receiver was able to compensate. SMX receivers are excluded
from this stat. THIS FIELD IS UNSUPPORTED.

<returns>Number of fragments unrecoverably lost. THIS FIELD IS UNSUPPORTED.</returns>

### receiveCallbackServiceTimeMin

```csharp
public long receiveCallbackServiceTimeMin()
```

Minimum time (in milliseconds) spent in message delivery
callbacks associated with LBM receivers, wildcard receivers, hot-failover
receivers. For the Java and .NET APIs, the overhead time spent in crossing
the managed/jni boundaries is included. This stat is only collected if
the context option receiver_callback_service_time_enabled is set to 1. SMX
receivers are excluded from these stats. THIS FIELD IS UNSUPPORTED.

<returns>Minimum message delivery service time. THIS FIELD IS UNSUPPORTED.</returns>

### receiveCallbackServiceTimeMax

```csharp
public long receiveCallbackServiceTimeMax()
```

Maximum time (in milliseconds) spent in message delivery
callbacks associated with LBM receivers, wildcard receivers, hot-failover
receivers. For the Java and .NET APIs, the overhead time spent in crossing
the managed/jni boundaries is included. This stat is only collected if
the context option receiver_callback_service_time_enabled is set to 1. SMX
receivers are excluded from these stats. THIS FIELD IS UNSUPPORTED.

<returns>Maximum message delivery service time. THIS FIELD IS UNSUPPORTED.</returns>

### receiveCallbackServiceTimeMean

```csharp
public long receiveCallbackServiceTimeMean()
```

Mean time (in milliseconds) spent in message delivery
callbacks associated with LBM receivers, wildcard receivers, hot-failover
receivers. This is an exponentially weighted moving average (weighted
to more recent). For the Java and .NET APIs, the overhead time spent
in crossing the managed/jni boundaries is included. This stat is only
collected if the context option receiver_callback_service_time_enabled
is set to 1. SMX receivers are excluded from these stats. THIS FIELD IS
UNSUPPORTED.

<returns>Mean message delivery service time. THIS FIELD IS UNSUPPORTED.</returns>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of statistics.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of statistics (same as Dispose()).
<seealso cref="Dispose"/>

## LBMEInvalException

*class* `com.latencybusters.lbm.LBMEInvalException`

### LBMEInvalException

```csharp
public LBMEInvalException(string errorMessage) : base(1, errorMessage)
```

Instantiate LBMEInvalException class

<param name="errorMessage">Exception error message</param>

## LBMEMessageSelectorException

*class* `com.latencybusters.lbm.LBMEMessageSelectorException`

### LBMEMessageSelectorException

```csharp
public LBMEMessageSelectorException(string errorMessage) : base(LBM.EMSG_SELECTOR, errorMessage)
```

Instantiate LBMEMessageSelectorException class

<param name="errorMessage">Exception error message</param>

## LBMENoMemException

*class* `com.latencybusters.lbm.LBMENoMemException`

### LBMENoMemException

```csharp
public LBMENoMemException(string errorMessage) : base(3, errorMessage)
```

Instantiate LBMENoMemException class

<param name="errorMessage">Exception error message</param>

## LBMEOPException

*class* `com.latencybusters.lbm.LBMEOPException`

### LBMEOPException

```csharp
public LBMEOPException(string errorMessage) : base(4, errorMessage)
```

Instantiate LBMEOPException class

<param name="errorMessage">Exception error message</param>

## LBMEOSException

*class* `com.latencybusters.lbm.LBMEOSException`

### LBMEOSException

```csharp
public LBMEOSException(string errorMessage) : base(5, errorMessage)
```

Instantiate LBMEOSException class

<param name="errorMessage">Exception error message</param>

## LBMETimedOutException

*class* `com.latencybusters.lbm.LBMETimedOutException`

### LBMETimedOutException

```csharp
public LBMETimedOutException(string errorMessage) : base(6, errorMessage)
```

Instantiate LBMETimedOutException class

<param name="errorMessage">Exception error message</param>

## LBMEWouldBlockException

*class* `com.latencybusters.lbm.LBMEWouldBlockException`

### LBMEWouldBlockException

```csharp
public LBMEWouldBlockException(string errorMessage) : base(2, errorMessage)
```

Instantiate LBMEWouldBlockException class

<param name="errorMessage">Exception error message</param>

## LBMEventQueue

*class* `com.latencybusters.lbm.LBMEventQueue`

### LBMEventQueue

```csharp
public LBMEventQueue() : this(null)
```

Instantiate an LBM Event Queue object using default attributes.
See \ref eventqueueobject for a full description of Event Queues.

### LBMEventQueue

```csharp
public LBMEventQueue(LBMEventQueueAttributes lbmevqattr)
```

Instantiate an LBM Event Queue object using the given attributes.
See \ref eventqueueobject for a full description of Event Queues.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="lbmevqattr">LBMEventQueueAttributes used to initialize the event queue</param>

### close

```csharp
public void close()
```

Close and dispose of this event queue

<remarks>
Since this method deletes the underlying LBM event queue object, it
should not be called prior to closing or canceling of its dependent
objects (e.g., LBMSource, LBMReceiver, LBMRequest, LBMTimer).
</remarks>

### size

```csharp
public int size()
```

Determine the number of queued events in the event queue

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
This method is only supported when the queue_size_warning config variable is set.
If not set, then this function will throw an exception with an error number == LBM.EINVAL.
</remarks>
<returns>Number of events queued on the event queue.</returns>

### shutdown

```csharp
public int shutdown()
```

Shutdown the event queue by purging any pending events and not allowing additional events to be added to the queue

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>Always returns 0 although an exception may be thrown in
event of an error.</returns>

### getAttributeValue

```csharp
public string getAttributeValue(string attributeName)
```

Returns the value of an event queue-related attribute for this event queue

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Dump source configuration options

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>An array of LBMConfigOptions</returns>

### setAttributeValue

```csharp
public void setAttributeValue(string attributeName, string attributeValue)
```

Set the value of an event queue-related attribute for this event queue.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### run

```csharp
public void run(long milliseconds)
```

Dispatch waiting events to the appropriate callback methods.

<param name="milliseconds">Number of milliseconds to block before returning.</param>

### stop

```csharp
public void stop()
```

Signal any threads dispatching the event queue to return as soon as possible.

<remarks><seealso cref="run"/></remarks>

### addMonitor

```csharp
public void addMonitor(LBMEventQueueCallback cb)
```

Register a monitor callback

<remarks>
<seealso cref="LBMEventQueueCallback"/>
<seealso cref="removeMonitor"/>
</remarks>
<param name="cb">Callback implementing the LBMEventQueueCallback delegate interface</param>

### addMonitor

```csharp
public void addMonitor(LBMEventQueueCallback cb, Object cbArg)
```

Register a monitor callback

<remarks>
<seealso cref="LBMEventQueueCallback"/>
<seealso cref="removeMonitor"/>
</remarks>
<param name="cb">Callback implementing the LBMEventQueueCallback delegate interface</param>
<param name="cbArg">Callback token object</param>

### removeMonitor

```csharp
public void removeMonitor(LBMEventQueueCallback cb)
```

Deregister a monitor callback

<remarks>
<seealso cref="LBMEventQueueCallback"/>
<seealso cref="addMonitor"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMEventQueueCallback delegate interface</param>

### removeMonitor

```csharp
public void removeMonitor(LBMEventQueueCallback cb, Object cbArg)
```

Deregister a monitor callback

<remarks>
<seealso cref="LBMEventQueueCallback"/>
<seealso cref="addMonitor"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMEventQueueCallback delegate interface</param>
<param name="cbArg">Token for previously registered callback</param>

### getStatistics

```csharp
public LBMEventQueueStatistics getStatistics()
```

Return the current set of statistics for this context.

<returns>LBMEventQueueStatistics object containing the statistics corresponding to this event queue.</returns>

### resetStatistics

```csharp
public void resetStatistics()
```

This will reset the statistics for this event queue.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### Dispose

```csharp
public void Dispose()
```

Same as <see cref="close"/>

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks><seealso cref="close"/></remarks>

## LBMEventQueueAttributes

*class* `com.latencybusters.lbm.LBMEventQueueAttributes`

### LBMEventQueueAttributes

```csharp
unsafe public LBMEventQueueAttributes()
```

Instantiate LBMEventQueueAttributes class

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### LBMEventQueueAttributes

```csharp
unsafe public LBMEventQueueAttributes(string eventQueueName)
```

Instantiate an LBMEventQueueAttributes class using an event queue name from the xml configuration that
must have been previously loaded.

<param name="eventQueueName">Event queue name string. Is written into the attributes object.</param>
<exception ref="com.latencybusters.lbm.LBMException">The event queue name is not permitted by the XML configuration or other unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of attributes.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of attributes (same as Dispose()).
<seealso cref="Dispose"/>

### setFromXml

```csharp
unsafe public void setFromXml(string eventQueueName)
```

Set values in an LBMEventQueueAttributes class using an event queue name from the xml configuration that
must have been previously loaded.

<param name="eventQueueName">Event queue name string. Is written into the attributes object.</param>
<exception ref="com.latencybusters.lbm.LBMException">The event queue name is not permitted by the XML configuration or other unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Dump source configuration options

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>An array of LBMConfigOptions</returns>

### getValue

```csharp
unsafe public string getValue(string attributeName)
```

Returns the current value of an attribute from this set of
event queue attributes

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setValue

```csharp
unsafe public void setValue(string attributeName, string attributeValue)
```

Set the current value of an attribute in this set of
event queue attributes

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### setObjectRecycler

```csharp
public void setObjectRecycler(LBMObjectRecyclerBase objRec, Object objRecCbArg)
```

Set the LBM object recycler that can be used by the event queue to reuse stats objects.

<param name="objRec">an LBM object recycler that will be called when objects need to be retrieved</param>
<param name="objRecCbArg">a callback object token that will be passed in the retrieve method</param>

## LBMEventQueueCallback

*delegate* `com.latencybusters.lbm.LBMEventQueueCallback`

### LBMEventQueueCallback

```csharp
public delegate void LBMEventQueueCallback(object cbArg, int eventType, int eventQueueSize, long eventQueueDelay)
```

Event queue callback delegate

<param name="cbArg">Callback object token</param>
<param name="eventType">Type of event</param>
<param name="eventQueueSize">Current queue size (number of messages)</param>
<param name="eventQueueDelay">Queuing delay (in microseconds) associated with the first message on the event queue</param>

## LBMEventQueueStatistics

*class* `com.latencybusters.lbm.LBMEventQueueStatistics`

### LBMEventQueueStatistics

```csharp
public LBMEventQueueStatistics()
```

Instantiate an empty object containing no statistics.

### LBMEventQueueStatistics

```csharp
public LBMEventQueueStatistics(LBMEventQueue lbmevq)
```

Instantiate an object containing the current set of
statistics for a given event queue.

<param name="lbmevq">LBMEventQueue object to load statistics from.</param>

### refresh

```csharp
unsafe public void refresh(LBMEventQueue lbmevq)
```

Refresh the current set of statistics using the given event queue.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="lbmevq">LBMEventQueue object</param>

### dataMessages

```csharp
public long dataMessages()
```

Number of data messages currently in the event queue.

<returns>
Number of data messages currently in the event queue, i.e., a snapshot.
Configuration option queue_count_enabled must be activated.
</returns>

### dataMessagesTotal

```csharp
public long dataMessagesTotal()
```

Total number of data messages enqueued since last reset.

<returns>
Total accumulated number of data messages that have been added to the event
queue (even if subsequently de-queued) since last reset. Configuration
option queue_count_enabled must be activated.
</returns>

### dataMessagesMinimumServiceTime

```csharp
public long dataMessagesMinimumServiceTime()
```

Minimum service time for data messages (in microseconds).

<returns>
Minimum service time for data messages (in microseconds). This is
the low-water mark (i.e., the shortest so far) for data message service
durations, measured from the point of de-queuement until the application has
finished servicing the message. Configuration option
queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
</returns>

### dataMessagesMeanServiceTime

```csharp
public long dataMessagesMeanServiceTime()
```

Mean service time for data messages (in microseconds).

<returns>
Mean service time for data messages (in microseconds).
This is an exponentially weighted moving average (weighted to more recent)
for accumulated data message service durations, measured from the point of
de-queuement until the application has finished servicing the message.
Configuration option queue_service_time_enabled must be activated.
</returns>

### dataMessagesMaximumServiceTime

```csharp
public long dataMessagesMaximumServiceTime()
```

Maximum service time for data messages (in microseconds).

<returns>
Maximum service time for data messages (in microseconds). This is
the high-water mark (i.e., the longest so far) for data message service
durations measured from the point of de-queuement until the application has
finished servicing the message. Configuration option
queue_service_time_enabled must be activated.
</returns>

### responseMessages

```csharp
public long responseMessages()
```

Number of response messages currently enqueued.

<returns>
Number of response messages (from receiver objects) currently
in the event queue, i.e., a snapshot. Configuration option
queue_count_enabled must be activated.
</returns>

### responseMessagesTotal

```csharp
public long responseMessagesTotal()
```

Total number of response messages enqueued since last reset.

<returns>
Total accumulated number of response messages that have been added to the
event queue (even if subsequently de-queued) since last reset.
</returns>

### responseMessagesMinimumServiceTime

```csharp
public long responseMessagesMinimumServiceTime()
```

Minimum service time for response messages (in microseconds).

<returns>
Minimum service time for response messages (in microseconds).
This is the low-water mark (i.e., the shortest so far) for response message
service durations, measured from the point of de-queuement until the
application has finished servicing the message. Configuration option
queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
</returns>

### responseMessagesMeanServiceTime

```csharp
public long responseMessagesMeanServiceTime()
```

Mean service time for response messages (in microseconds).

<returns>
Mean service time for response messages (in microseconds). This is an
exponentially weighted moving average (weighted to more recent) for
accumulated response message service durations, measured from the point of
de-queuement until the application has finished servicing the message.
Configuration option queue_service_time_enabled must be activated.
</returns>

### responseMessagesMaximumServiceTime

```csharp
public long responseMessagesMaximumServiceTime()
```

Maximum service time for response messages (in microseconds).

<returns>
Maximum service time for response messages (in microseconds). This is the
high-water mark (i.e., the longest so far) for response message service
durations measured from the point of de-queuement until the application has
finished servicing the message. Configuration option
queue_service_time_enabled must be activated.
</returns>

### topiclessImmediateMessages

```csharp
public long topiclessImmediateMessages()
```

Number of topic-less immediate messages currently enqueued.

<returns>
Number of topic-less Multicast Immediate Messaging (MIM) messages currently
in the event queue, i.e., a snapshot. Configuration option queue_count_enabled
must be activated.
</returns>

### topiclessImmediateMessagesTotal

```csharp
public long topiclessImmediateMessagesTotal()
```

Total number of topic-less immediate messages enqueued since last reset.

<returns>
Total accumulated number of topic-less Multicast Immediate Messaging (MIM)
messages that have been added to the event queue (even if subsequently
de-queued) since last reset. Configuration option queue_count_enabled must be
activated.
</returns>

### topiclessImmediateMessagesMinimumServiceTime

```csharp
public long topiclessImmediateMessagesMinimumServiceTime()
```

Minimum service time for topic-less immediate messages (in microseconds).

<returns>
Minimum service time for topic-less Multicast Immediate Messaging (MIM)
messages (in microseconds). This is the low-water mark (i.e., the shortest so
far) for topic-less MIM message service durations, measured from the point of
de-queuement until the application has finished servicing the message.
Configuration option queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
</returns>

### topiclessImmediateMessagesMeanServiceTime

```csharp
public long topiclessImmediateMessagesMeanServiceTime()
```

Mean service time for topic-less immediate messages (in microseconds).

<returns>
Mean service time for topic-less Multicast Immediate Messaging (MIM)
messages (in microseconds). This is an exponentially weighted moving average
(weighted to more recent) for accumulated topic-less MIM message service
durations, measured from the point of de-queuement until the application has
finished servicing the message. Configuration option
queue_service_time_enabled must be activated.
</returns>

### topiclessImmediateMessagesMaximumServiceTime

```csharp
public long topiclessImmediateMessagesMaximumServiceTime()
```

Maximum service time for topic-less immediate messages (in microseconds).

<returns>
Maximum service time for topic-less Multicast Immediate Messaging (MIM)
messages (in microseconds). This is the high-water mark (i.e., the longest so
far) for topic-less MIM message service durations measured from the point of
de-queuement until the application has finished servicing the message.
Configuration option queue_service_time_enabled must be activated.
</returns>

### wildcardReceiverMessages

```csharp
public long wildcardReceiverMessages()
```

Number of wildcard receiver messages currently enqueued.

<returns>
Number of wildcard receiver messages currently in the event queue, i.e., a
snapshot. Configuration option queue_count_enabled must be activated.
</returns>

### wildcardReceiverMessagesTotal

```csharp
public long wildcardReceiverMessagesTotal()
```

Total number of wildcard receiver messages enqueued since last reset.

<returns>
Total accumulated number of wildcard receiver messages that have been added
to the event queue (even if subsequently de-queued) since last reset.
Configuration option queue_count_enabled must be activated.
</returns>

### wildcardReceiverMessagesMinimumServiceTime

```csharp
public long wildcardReceiverMessagesMinimumServiceTime()
```

Minimum service time for wildcard receiver messages (in microseconds).

<returns>
Minimum service time for wildcard receiver messages (in microseconds).
This is the low-water mark (i.e., the shortest so far) for wildcard receiver
message service durations measured from the point of de-queuement until the
application has finished servicing the message. Configuration option
queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
</returns>

### wildcardReceiverMessagesMeanServiceTime

```csharp
public long wildcardReceiverMessagesMeanServiceTime()
```

Mean service time for wildcard receiver messages (in microseconds).

<returns>
Mean service time for wildcard receiver messages (in microseconds). This is
an exponentially weighted moving average (weighted to more recent) for
accumulated wildcard receiver message service durations, measured from the
point of de-queuement until the application has finished servicing the
message. Configuration option queue_service_time_enabled must be activated.
</returns>

### wildcardReceiverMessagesMaximumServiceTime

```csharp
public long wildcardReceiverMessagesMaximumServiceTime()
```

Maximum service time for wildcard receiver messages (in microseconds).

<returns>
Maximum service time for wildcard receiver messages (in microseconds). This
is the high-water mark (i.e., the longest so far) for wildcard receiver
message service durations measured from the point of de-queuement until the
application has finished servicing the message. Configuration option
queue_service_time_enabled must be activated.
</returns>

### ioEvents

```csharp
public long ioEvents()
```

Number of I/O events currently enqueued.

<returns>
Number of I/O events currently in the event queue, i.e., a snapshot.
Configuration option queue_count_enabled must be activated.
</returns>

### ioEventsTotal

```csharp
public long ioEventsTotal()
```

Total number of I/O events enqueued since last reset.

<returns>
Total accumulated number of I/O events that have been added to the event
queue (even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
</returns>

### ioEventsMinimumServiceTime

```csharp
public long ioEventsMinimumServiceTime()
```

Minimum service time for I/O events (in microseconds).

<returns>
Minimum service time for I/O events (in microseconds). This is the low-water
mark (i.e., the shortest so far) for I/O event service durations measured
from the point of de-queuement until the application has finished servicing
the event. Configuration option queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
</returns>

### ioEventsMeanServiceTime

```csharp
public long ioEventsMeanServiceTime()
```

Mean service time for I/O events (in microseconds).

<returns>
Mean service time for I/O events (in microseconds). This is an exponentially
weighted moving average (weighted to more recent) for accumulated I/O event
service durations, measured from the point of de-queuement until the
application has finished servicing the event. Configuration option
queue_service_time_enabled must be activated.
</returns>

### ioEventsMaximumServiceTime

```csharp
public long ioEventsMaximumServiceTime()
```

Maximum service time for I/O events (in microseconds).

<returns>
Maximum service time for I/O events (in microseconds). This is the
high-water mark (i.e., the longest so far) for I/O event service durations
measured from the point of de-queuement until the application has finished
servicing the event. Configuration option queue_service_time_enabled must be
activated.
</returns>

### timerEvents

```csharp
public long timerEvents()
```

Number of timer events currently enqueued.

<returns>
Number of timer events currently in the event queue, i.e., a snapshot.
Configuration option queue_count_enabled must be activated.
</returns>

### timerEventsTotal

```csharp
public long timerEventsTotal()
```

Total number of timer events enqueued since last reset.

<returns>
Total accumulated number of timer events that have been added to the event
queue (even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
</returns>

### timerEventsMinimumServiceTime

```csharp
public long timerEventsMinimumServiceTime()
```

Minimum service time for timer events (in microseconds).

<returns>
Minimum service time for timer events (in microseconds). This is the
low-water mark (i.e., the shortest so far) for timer event service durations
measured from the point of de-queuement until the application has finished
servicing the event. Configuration option queue_service_time_enabled must be
activated.

This field is initialized to all 1s (-1 if printed signed).
</returns>

### timerEventsMeanServiceTime

```csharp
public long timerEventsMeanServiceTime()
```

Mean service time for timer events (in microseconds).

<returns>
Mean service time for timer events (in microseconds). This is an
exponentially weighted moving average (weighted to more recent) for
accumulated timer event service durations, measured from the point of
de-queuement until the application has finished servicing the message.
Configuration option queue_service_time_enabled must be activated.
</returns>

### timerEventsMaximumServiceTime

```csharp
public long timerEventsMaximumServiceTime()
```

Maximum service time for timer events (in microseconds).

<returns>
Maximum service time for timer events (in microseconds). This is the
high-water mark (i.e., the longest so far) for timer event service durations
measured from the point of de-queuement until the application has finished
servicing the event. Configuration option queue_service_time_enabled must be
activated.
</returns>

### sourceEvents

```csharp
public long sourceEvents()
```

Number of source events currently enqueued.

<returns>
Number of source events currently in the event queue, i.e., a snapshot.
Configuration option queue_count_enabled must be activated.
</returns>

### sourceEventsTotal

```csharp
public long sourceEventsTotal()
```

Total number of source events enqueued since last reset.

<returns>
Total accumulated number of source events that have been added to the event
queue (even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
</returns>

### sourceEventsMinimumServiceTime

```csharp
public long sourceEventsMinimumServiceTime()
```

Minimum service time for source events (in microseconds).

<returns>
Minimum service time for source events (in microseconds). This is the
low-water mark (i.e., the shortest so far) for source event service durations
measured from the point of de-queuement until the application has finished
servicing the event. Configuration option queue_service_time_enabled must be
activated.

This field is initialized to all 1s (-1 if printed signed).
</returns>

### sourceEventsMeanServiceTime

```csharp
public long sourceEventsMeanServiceTime()
```

Mean service time for source events (in microseconds).

<returns>
Mean service time for source events (in microseconds). This is an
exponentially weighted moving average (weighted to more recent) for
accumulated source event service durations, measured from the point of
de-queuement until the application has finished servicing the message.
Configuration option queue_service_time_enabled must be activated.
</returns>

### sourceEventsMaximumServiceTime

```csharp
public long sourceEventsMaximumServiceTime()
```

Maximum service time for source events (in microseconds).

<returns>
Maximum service time for source events (in microseconds). This is the
high-water mark (i.e., the longest so far) for source event service durations
measured from the point of de-queuement until the application has finished
servicing the event. Configuration option queue_service_time_enabled must be
activated.
</returns>

### unblockEvents

```csharp
public long unblockEvents()
```

Number of unblock events currently enqueued.

<returns>
Number of unblock events currently in the event queue, i.e., a snapshot.
Configuration option queue_count_enabled must be activated.
</returns>

### unblockEventsTotal

```csharp
public long unblockEventsTotal()
```

Total number of unblock events enqueued since last reset.

<returns>
Total accumulated number of unblock events that have been added to the event
queue (even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
</returns>

### cancelEvents

```csharp
public long cancelEvents()
```

Number of cancel events currently enqueued.

<returns>
Number of cancel events currently in the event queue, i.e., a snapshot.
Configuration option queue_count_enabled must be activated.
</returns>

### cancelEventsTotal

```csharp
public long cancelEventsTotal()
```

Total number of cancel events enqueued since last reset.

<returns>
Total accumulated number of cancel events that have been added to the event
queue (even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
</returns>

### cancelEventsMinimumServiceTime

```csharp
public long cancelEventsMinimumServiceTime()
```

Minimum service time for cancel events (in microseconds).

<returns>
Minimum service time for cancel events. Cancel events as seen by the event
queue do not actually consume service time, so we do not recommend the general
use of this counter.

This field is initialized to all 1s (-1 if printed signed).
</returns>

### cancelEventsMeanServiceTime

```csharp
public long cancelEventsMeanServiceTime()
```

Mean service time for cancel events (in microseconds).

<returns>
Mean service time for cancel events. Cancel events as seen by the event
queue do not actually consume service time, so we do not recommend the general
use of this counter.
</returns>

### cancelEventsMaximumServiceTime

```csharp
public long cancelEventsMaximumServiceTime()
```

Maximum service time for cancel events (in microseconds).

<returns>
Maximum service time for cancel events. Cancel events as seen by the event
queue do not actually consume service time, so we do not recommend the general
use of this counter.
</returns>

### callbackEvents

```csharp
public long callbackEvents()
```

Number of callback events currently enqueued.

<returns>
Number of callback events currently in the event queue, i.e., a snapshot.
Configuration option queue_count_enabled must be activated.
</returns>

### callbackEventsTotal

```csharp
public long callbackEventsTotal()
```

Total number of callback events enqueued since last reset.

<returns>
Total accumulated number of callback events that have been added to the
event queue even if subsequently de-queued) since last reset. Configuration
option queue_count_enabled must be activated.
</returns>

### callbackEventsMinimumServiceTime

```csharp
public long callbackEventsMinimumServiceTime()
```

Minimum service time for callback events (in microseconds).

<returns>
Minimum service time for callback events (in microseconds). This is the
low-water mark (i.e., the shortest so far) for callback event service
durations measured from the point of de-queuement until the application has
finished servicing the event. Configuration option queue_service_time_enabled
must be activated.

This field is initialized to all 1s (-1 if printed signed).
</returns>

### callbackEventsMeanServiceTime

```csharp
public long callbackEventsMeanServiceTime()
```

Mean service time for callback events (in microseconds).

<returns>
Mean service time for callback events (in microseconds). This is an
exponentially weighted moving average (weighted to more recent) for
accumulated callback event service durations, measured from the point of
de-queuement until the application has finished servicing the message.
Configuration option queue_service_time_enabled must be activated.
</returns>

### callbackEventsMaximumServiceTime

```csharp
public long callbackEventsMaximumServiceTime()
```

Maximum service time for callback events (in microseconds).

<returns>
Maximum service time for callback events (in microseconds). This is the
high-water mark (i.e., the longest so far) for callback event service
durations measured from the point of de-queuement until the application has
finished servicing the event. Configuration option queue_service_time_enabled
must be activated.
</returns>

### contextSourceEvents

```csharp
public long contextSourceEvents()
```

Number of context source events currently enqueued.

<returns>
Number of context source events currently in the event queue, i.e., a
snapshot. Configuration option queue_count_enabled must be activated.
</returns>

### contextSourceEventsTotal

```csharp
public long contextSourceEventsTotal()
```

Total number of context source events enqueued since last reset.

<returns>
Total accumulated number of context source events that have been added to
the event queue (even if subsequently de-queued) since last reset.
Configuration option queue_count_enabled must be activated.
</returns>

### contextSourceEventsMinimumServiceTime

```csharp
public long contextSourceEventsMinimumServiceTime()
```

Minimum service time for context source events (in microseconds).

<returns>
Minimum service time for context source events (in microseconds). This is
the low-water mark (i.e., the shortest so far) for context source event
service durations measured from the point of de-queuement until the
application has finished servicing the event. Configuration option
queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
</returns>

### contextSourceEventsMeanServiceTime

```csharp
public long contextSourceEventsMeanServiceTime()
```

Mean service time for context source events (in microseconds).

<returns>
Mean service time for context source events (in microseconds). This is an
exponentially weighted moving average (weighted to more recent) for
accumulated context source event service durations, measured from the point of
de-queuement until the application has finished servicing the event.
Configuration option queue_service_time_enabled must be activated.
</returns>

### contextSourceEventsMaximumServiceTime

```csharp
public long contextSourceEventsMaximumServiceTime()
```

Maximum service time for context source events (in microseconds).

<returns>
Maximum service time for context source events (in microseconds). This is
the high-water mark (i.e., the longest so far) for context source event
service durations measured from the point of de-queuement until the
application has finished servicing the event. Configuration option
queue_service_time_enabled must be activated.
</returns>

### events

```csharp
public long events()
```

Number of events currently enqueued.

<returns>
Total number of events (including messages) currently in the event queue,
i.e., a snapshot. Configuration option queue_count_enabled must be activated.
</returns>

### eventsTotal

```csharp
public long eventsTotal()
```

Total number of events enqueued since last reset.

<returns>
Total accumulated number of events (including messages) that have been added
to the event queue (even if subsequently de-queued) since last reset.
Configuration option queue_count_enabled must be activated.
</returns>

### minimumAge

```csharp
public long minimumAge()
```

Minimum age of event queue entry when dequeued (in microseconds).

<returns>
Minimum age of event queue entry when dequeued (in microseconds). This is
the low-water mark for the measured age of any event or message (i.e., the
shortest one so far) from the point of enqueuement until de-queuement.
Configuration option queue_age_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
</returns>

### meanAge

```csharp
public long meanAge()
```

Mean age of event queue entry when dequeued (in microseconds).

<returns>
Mean age of event queue entries when dequeued (in microseconds). This is an
exponentially weighted moving average (weighted to more recent) for
accumulated event or message ages (measured from the point enqueuement until
de-queuement). Configuration option queue_age_enabled must be activated.
</returns>

### maximumAge

```csharp
public long maximumAge()
```

Maximum age of event queue entry when dequeued (in microseconds).

<returns>
Maximum age of event queue entry when dequeued (in microseconds). This is
the high-water mark for the measured age of any event or message (i.e., the
oldest one so far) from the point of enqueuement until de-queuement.
Configuration option queue_age_enabled must be activated.
</returns>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of statistics.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of statistics (same as Dispose()).
<seealso cref="Dispose"/>

## LBMException

*class* `com.latencybusters.lbm.LBMException`

### LBMException

```csharp
public LBMException(int errnum, string errorMessage) : base(errorMessage)
```

Instantiate an LBMException class

<param name="errnum">Exception error number</param>
<param name="errorMessage">Exception error message</param>

### errorNumber

```csharp
public int errorNumber()
```

Get LBM error number

<returns>LBM error number</returns>

## LBMHFX

*class* `com.latencybusters.lbm.LBMHFX`

### LBMHFX

```csharp
public LBMHFX(String topic, LBMReceiverCallback cb) : this(null, topic, cb, null)
```

Instantiate an LBMHFX object using default attributes.

<param name="topic">The topic to be used for receivers created using this HFX object.</param>
<param name="cb">The callback to be invoked for messages received by this HFX object.</param>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### LBMHFX

```csharp
public LBMHFX(String topic, LBMReceiverCallback cb, LBMEventQueue evq) : this(null, topic, cb, evq)
```

Instantiate an LBMHFX object using default attributes and specifying an event queue to be used to deliver messages.

<param name="topic">The topic to be used for receivers created using this HFX object.</param>
<param name="cb">The callback to be invoked for messages received by this HFX object.</param>
<param name="evq">LBM Event Queue to be used when delivering messages.</param>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### LBMHFX

```csharp
public LBMHFX(LBMHFXAttributes attr, String topic, LBMReceiverCallback cb) : this(attr, topic, cb, null)
```

Instantiate an LBMHFX object using user-specified attributes.

<param name="attr">A set of attributes that determine the behavior of the LBMHFX to be created</param>
<param name="topic">The topic to be used for receivers created using this HFX object.</param>
<param name="cb">The callback to be invoked for messages received by this HFX object.</param>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### LBMHFX

```csharp
public LBMHFX(LBMHFXAttributes attr, String topic, LBMReceiverCallback cb, LBMEventQueue evq)
```

Instantiate an LBMContext object using user-specified attributes, and specifying an event queue.

<param name="attr">A set of attributes that determine the behavior of the LBMHFX to be created</param>
<param name="topic">The topic to be used for receivers created using this HFX object.</param>
<param name="cb">The callback to be invoked for messages received by this HFX object.</param>
<param name="evq">LBM Event Queue to be used when delivering messages.</param>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Dump HFX configuration options

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>An array of LBMConfigOptions</returns>

### close

```csharp
public void close()
```

Close and dispose of this HFX object.  All HFXReceiver objects created using this HFX object should be closed before calling this method.
<para><b>Warning</b>: It is not safe to call this method from a context thread callback.</para>

<remarks>
The underlying objects may take some time to be deleted.  To be informed when deletion is complete, call <see cref="com.latencybusters.lbm.LBMHFX.close(com.latencybusters.lbm.LBMOperationCompleteCallback, System.Object)"/>
</remarks>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### close

```csharp
public void close(LBMOperationCompleteCallback cb, object cbArg)
```

Close and dispose of this HFX object.  All HFXReceiver objects created using this HFX object should be closed before calling this method.
<para><b>Warning</b>: It is not safe to call this method from a context thread callback.</para>

<param name="cb">A callback to be delivered when the close() operation is complete</param>
<param name="cbArg">A token to be delivered with the callback</param>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### createReceiver

```csharp
public LBMHFXReceiver createReceiver(LBMContext ctx, LBMReceiverAttributes rattr, object cbArg)
```

 Create a receiver on the specified context, with the specified attributes and callback token. A hot failover receiver is created on the specified context with the attributes passed in.  Some attributes related to message delivery may be overridden (e.g. duplicate delivery will be enabled if it is enabled on the HFX object.
<param name="ctx"> Context on which to create the receiver.</param>
<param name="rattr"> Attributes to be used for the receiver.</param>
<param name="cbArg"> Callback token to be associated with messages delivered through the newly created receiver.</param>
<returns>A new LBMHFXReceiver object associated with the given LBMContext.</returns>

### getAttributeValue

```csharp
public string getAttributeValue(string attributeName)
```

Returns the value of a HFX-related attribute for this HFX.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setAttributeValue

```csharp
public void setAttributeValue(string attributeName, string attributeValue)
```

Set the value of a HFX-related attribute for this HFX.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Note that this method bypasses the property list.
As such no attributes configured using this method will appear in
the property list.
</remarks>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

## LBMHFXAttributes

*class* `com.latencybusters.lbm.LBMHFXAttributes`

### LBMHFXAttributes

```csharp
unsafe public LBMHFXAttributes()
```

Instantiate LBMHFXAttributes class

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### LBMHFXAttributes

```csharp
unsafe public LBMHFXAttributes(string topicName)
```

Instantiate an LBMHFXAttributes class using a topic name from the xml configuration that
must have been previously loaded.

<param name="topicName">The topic name string that will be used to create the LBMHFX object.</param>
<exception ref="com.latencybusters.lbm.LBMException">The HFX topic name is not permitted by XML configuration or other unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of attributes.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of attributes (same as Dispose()).
<seealso cref="Dispose"/>

### setFromXml

```csharp
unsafe public void setFromXml(string topicName)
```

Set values in an LBMHFXAttributes class using a topic name from the xml configuration that
must have been previously loaded.

<param name="topicName">The topic name string that will be used to create the LBMHFX object.</param>
<exception ref="com.latencybusters.lbm.LBMException">The HFX topic name is not permitted by XML configuration or other unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Dump HFX configuration options

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>An array of LBMConfigOptions</returns>

### getValue

```csharp
unsafe public string getValue(string attributeName)
```

Returns the current value of an attribute from this set of
HFX attributes

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setValue

```csharp
unsafe public void setValue(string attributeName, string attributeValue)
```

Set the current value of an attribute in this set of
HFX attributes

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### setObjectRecycler

```csharp
public void setObjectRecycler(LBMObjectRecyclerBase objRec, Object objRecCbArg)
```

Set the LBM object recycler that can be used by the context to reuse LBMMessage objects as
well as LBM Context/Receiver/Source Statistics objects.

<param name="objRec">an LBM object recycler that will be called when objects need to be retrieved</param>
<param name="objRecCbArg">a callback object token that will be passed in the retrieve method</param>

## LBMHFXReceiver

*class* `com.latencybusters.lbm.LBMHFXReceiver`

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Dump receiver configuration options

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>An array of LBMConfigOptions</returns>

### getAttributeValue

```csharp
public string getAttributeValue(string attributeName)
```

Returns the value of a receiver-related attribute for this receiver

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setAttributeValue

```csharp
public void setAttributeValue(string attributeName, string attributeValue)
```

Set the value of a receiver-related attribute for this receiver

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### getStatistics

```csharp
public LBMReceiverStatistics getStatistics(String source)
```

Return the current set of receiver transport statistics for a particular
source.

<param name="source">Source string (as returned by LBMMesage source())
that specifies the set of statistics to return.
</param>
<returns> LBMReceiverStatistics object containing the statistics
corresponding to the specified source.
</returns>
<exception ref="com.latencybusters.lbm.LBMException">
An error occurred retrieving receiver statistics.
</exception>

### getStatistics

```csharp
public LBMReceiverStatistics getStatistics(int maxStats)
```

Return the current set of receiver transport statistics for all
sources.

<param name="maxStats"> Maxiumum number of sources </param>
<returns> LBMReceiverStatistics object containing the statistics
corresponding to the specified number of sources.
</returns>
<exception ref="com.latencybusters.lbm.LBMException">
An error occurred retrieving receiver statistics.
</exception>

### close

```csharp
public void close()
```

Close this receiver.
Call <see cref="com.latencybusters.lbm.LBMHFXReceiver.close(com.latencybusters.lbm.LBMOperationCompleteCallback, System.Object)" /> to be informed when the delete call has completed.

<remarks>
<para><b>Warning</b>: It is not safe to call this method from a context thread callback.</para>
</remarks>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function</exception>

### close

```csharp
public void close(LBMOperationCompleteCallback cb, object cbArg)
```

Close and dispose of this HFXReceiver object.
<para><b>Warning</b>: It is not safe to call this method from a context thread callback.</para>

<param name="cb">A callback to be delivered when the delete operation is complete.</param>
<param name="cbArg">A token to be delivered with the callback</param>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

## LBMHotFailoverReceiver

*class* `com.latencybusters.lbm.LBMHotFailoverReceiver`

### LBMHotFailoverReceiver

```csharp
public LBMHotFailoverReceiver(LBMContext lbmctx, LBMTopic lbmtopic, LBMReceiverCallback cb, object cbArg) : this(lbmctx, lbmtopic, cb, cbArg, null)
```

Instantiate an LBM Hot-Failover Receiver object associated with a given context
and topic, with an initial receiver callback and callback object set.

<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<param name="lbmctx">Context with which to associate the receiver</param>
<param name="lbmtopic">LBMTopic used to initialize the receiver</param>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>

### LBMHotFailoverReceiver

```csharp
public LBMHotFailoverReceiver(LBMContext lbmctx, LBMTopic lbmtopic, LBMReceiverCallback cb, object cbArg, LBMEventQueue lbmevq) : base(lbmtopic, cb, cbArg)
```

Instantiate an LBM Hot-Failover Receiver object associated with a given context,
topic, and event queue, with an initial receiver callback and callback object set.

<exception ref="com.latencybusters.lbm.LBMEInvalException">Topic is not a receiver topic</exception>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<param name="lbmctx">Context with which to associate the receiver</param>
<param name="lbmtopic">LBMTopic used to initialize the receiver</param>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>
<param name="lbmevq">Event queue with which to associate the receiver
(all receiver events will be posted to this event queue)</param>

### subscribeChannel

```csharp
public override void subscribeChannel(long channelNumber, LBMReceiverCallback cb, Object cbArg)
```

Channel functionality is not currently supported by hot failover receivers.  Calling this method will result in an exception.

<exception ref="com.latencybusters.lbm.LBMException">Thrown if this method is called on a Hot Failover receiver. </exception>

### unsubscribeChannel

```csharp
public override void unsubscribeChannel(long channelNumber)
```

Channel functionality is not currently supported by hot failover receivers.  Calling this method will result in an exception.

<exception ref="com.latencybusters.lbm.LBMException">Thrown if this method is called on a Hot Failover receiver. </exception>

## LBMHotFailoverSource

*class* `com.latencybusters.lbm.LBMHotFailoverSource`

### LBMHotFailoverSource

```csharp
public LBMHotFailoverSource(LBMContext lbmctx, LBMTopic lbmtopic) : this(lbmctx, lbmtopic, (LBMSourceEventCallback)null, null, null)
```

Instantiate an LBM Hot-Failover Source object associated with a given context
and topic.

<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<param name="lbmctx">Context with which to associate the source</param>
<param name="lbmtopic">LBMTopic used to initialize the source</param>

### LBMHotFailoverSource

```csharp
public LBMHotFailoverSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMSourceEventCallback cb, object cbArg) : this(lbmctx, lbmtopic, cb, cbArg, null)
```

Instantiate an LBM Hot-Failover Source object associated with a given context
and topic and initialize source event callback.

<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<param name="lbmctx">Context with which to associate the source</param>
<param name="lbmtopic">LBMTopic used to initialize the source</param>
<param name="cb">Callback implementing the LBMSourceEventCallback delegate interface</param>
<param name="cbArg">Callback token object</param>

### LBMHotFailoverSource

```csharp
public LBMHotFailoverSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMEventQueue lbmevq) : this(lbmctx, lbmtopic, (LBMSourceEventCallback)null, null, lbmevq)
```

Instantiate an LBM Hot-Failover Source object associated with a given context,
topic, and event queue.

<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<param name="lbmctx">Context with which to associate the source</param>
<param name="lbmtopic">LBMTopic used to initialize the source</param>
<param name="lbmevq">Event queue with which to associate the source
(all source events will be posted to this event queue)</param>

### LBMHotFailoverSource

```csharp
public LBMHotFailoverSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMSourceEventCallback cb, object cbArg, LBMEventQueue lbmevq)
```

Instantiate an LBM Hot-Failover Source object associated with a given context,
topic, and event queue and initialize source event callback.

<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Topic is not a source topic</exception>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="lbmctx">Context with which to associate the source</param>
<param name="lbmtopic">LBMTopic used to initialize the source</param>
<param name="cb">Callback implementing the LBMSourceEventCallback delegate interface</param>
<param name="cbArg">Callback token object</param>
<param name="lbmevq">Event queue with which to associate the source</param>

### send

```csharp
public void send(byte [] message, int messageLength, long sqn, int flags)
```

Send a message to the topic associated with the LBM source

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
<para>Possible OR'd set of flag value include:</para>
<see cref="LBM.SRC_NONBLOCK"/>,
<see cref="LBM.SRC_BLOCK"/>,
<see cref="LBM.MSG_START_BATCH"/>,
<see cref="LBM.MSG_END_BATCH"/>,
<see cref="LBM.MSG_COMPLETE_BATCH"/>, and
<see cref="LBM.MSG_FLUSH"/>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

</remarks>
<param name="message">Data to send in this message</param>
<param name="messageLength">Number of bytes of data to send in this message</param>
<param name="sqn">The application sequence number to associate with this message</param>
<param name="flags">Flags indicating various conditions</param>

### send

```csharp
public void send(byte[] message, int messageLength, long sqn, int flags, LBMSourceSendExInfo exinfo)
```

Send a message to the topic associated with the LBM source

<exception ref="com.latencybusters.lbm.LBMEInvalException">Confirmed delivery or message stability notifications are not enabled</exception>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
<para>
Possible OR'd set of flag value include:
</para>
<see cref="LBM.SRC_NONBLOCK"/>,
<see cref="LBM.SRC_BLOCK"/>,
<see cref="LBM.MSG_START_BATCH"/>,
<see cref="LBM.MSG_END_BATCH"/>,
<see cref="LBM.MSG_COMPLETE_BATCH"/>, and
<see cref="LBM.MSG_FLUSH"/>
<see cref="LBM.SRC_EVENT_UME_MESSAGE_STABLE"/>
<see cref="LBM.SRC_EVENT_UME_MESSAGE_STABLE_EX"/>
<see cref="LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION"/>
<see cref="LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX"/>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

</remarks>
<param name="message">Data to send in this message</param>
<param name="messageLength">Number of bytes of data to send in this message</param>
<param name="sqn">The application sequence number to associate with this message</param>
<param name="flags">Flags indicating various conditions</param>
<param name="exinfo">LBMSourceSendExInfo object, which includes flags to
change callback behavior and a client-supplied object to be passed back. (UME only)</param>

### sendReceiverReset

```csharp
public void sendReceiverReset(int flags, LBMSourceSendExInfo exinfo)
```

Send a message that instructs hot-failover receivers to reset their state. In, and only in, the case that hf receivers
cannot be manually restarted, this function can be used to allow delivering of previously sent sequence numbers. The
hot-failover receiver will deliver a message of type LBM.MSG_HF_RESET and will include the new expected sequence number.
The sequence number contained with the reset will be used as the next expected sequence number to be sent.

NOTE: The best way to reset a hot-failover receiver's state is to restart the receiver itself. This function should be used
only when that is impossible.

<remarks>
Hot failover send flags on the exinfo parameter
<see cref="LBM.SRC_SEND_EX_FLAG_HF_32"/>, or
<see cref="LBM.SRC_SEND_EX_FLAG_HF_64"/>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

</remarks>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Exinfo was null, Confirmed delivery or message stability notifications are not enabled</exception>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="flags">Flags indicating various send conditions</param>
<param name="exinfo">Send ex info containing hf reset sequence number</param>

## LBMImmediateMessageCallback

*delegate* `com.latencybusters.lbm.LBMImmediateMessageCallback`

### LBMImmediateMessageCallback

```csharp
public delegate int LBMImmediateMessageCallback(object cbArg, LBMMessage lbmmsg)
```

Received immediate message callback delegate.

<param name="cbArg">Callback object token</param>
<param name="lbmmsg">LBMMessage object encapsulating the received message</param>
<returns>-1 indicates that the message could not be received and should be redelivered.
(Note: if multiple callbacks are registered, a -1 return from any callback will cause the
message to be redelivered to all the callbacks.)</returns>

## LBMImmediateMessageReceiverStatistics

*class* `com.latencybusters.lbm.LBMImmediateMessageReceiverStatistics`

### LBMImmediateMessageReceiverStatistics

```csharp
public LBMImmediateMessageReceiverStatistics()
```

Instantiate an empty object containing no statistics.

<remarks>
<seealso cref="refresh"/>
</remarks>

### LBMImmediateMessageReceiverStatistics

```csharp
unsafe public LBMImmediateMessageReceiverStatistics(LBMContext lbmctx, int maxStats)
```

Instantiate object containing the aggregate set of statistics
for a particular context

<remarks>
This constructor will throw LBMEInvalException if maxStats is
less than the the available number of transport statistical
sets.
<seealso cref="refresh"/>
</remarks>
<param name="lbmctx">LBMContext object</param>
<param name="maxStats">Maximum number of sources</param>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of statistics.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of statistics (same as Dispose()).
<seealso cref="Dispose"/>

### refresh

```csharp
unsafe public void refresh(LBMContext lbmctx, int maxStats)
```

Refresh the aggregate set of statistics
for a particular context

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or
unexpected operational behavior has been encountered by unmanaged UM C layer function.</exception>
<remarks>
This method will throw LBMEInvalException if maxStats is
less than the the available number of transport statistical
sets.
</remarks>
<param name="lbmctx">LBMContext object</param>
<param name="maxStats">Maximum number of sources</param>

### size

```csharp
public int size()
```

Number of transport statistical sets encapsulated within this object

<returns>Statistical set size</returns>

### type

```csharp
public int type()
```

Transport type (TCP, LBT-RM, etc.)

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object.
<seealso cref="LBM"/>
</remarks>
<returns>Transport type</returns>

### type

```csharp
public int type(int n)
```

Transport type (TCP, LBT-RM, etc.)

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
<seealso cref="LBM"/>
</remarks>
<param name="n">Statistics set index</param>
<returns>Transport type</returns>

### typeName

```csharp
public string typeName()
```

Transport type name (TCP, LBT-RM, etc.).

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Transport type name</returns>

### typeName

```csharp
public string typeName(int n)
```

Transport type name (TCP, LBT-RM, etc.).

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Transport type name</returns>

### source

```csharp
public string source()
```

Source of transport as a string

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
</remarks>
<seealso cref="LBMTransportSourceInfo" />
<returns>Source of transport as a string</returns>

### source

```csharp
public string source(int n)
```

Source of transport as a string

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
</remarks>
<seealso cref="LBMTransportSourceInfo" />
<param name="n">Statistics set index</param>
<returns>Source of transport as a string</returns>

### bytesReceived

```csharp
public long bytesReceived()
```

Number of datagram bytes received (TCP, LBT-RM)

<remarks>
The total of
lengths of all transport packets, including UM header information.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of bytes received. </returns>

### bytesReceived

```csharp
public long bytesReceived(int n)
```

Number of datagram bytes received (TCP, LBT-RM)

<remarks>
The total of
lengths of all transport packets, including UM header information.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of bytes received.</returns>

### messagesReceived

```csharp
public long messagesReceived()
```

Number of datagrams received (LBT-RM only)

<remarks>
Depending on batching settings, a single LBT-RM datagram may contain one or
more messages, or a fragment of a larger message. With LBT-RM, larger messages
are split into fragment sizes limited by configuration option
transport_lbtrm_datagram_max_size (default 8KB).
This method returns a value from the first
set of statistics encapsulated within this object.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of datagrams received. </returns>

### messagesReceived

```csharp
public long messagesReceived(int n)
```

Number of datagrams received (LBT-RM only)

<remarks>
Depending on batching settings, a single LBT-RM datagram may contain one or
more messages, or a fragment of a larger message. With LBT-RM, larger messages
are split into fragment sizes limited by configuration option
transport_lbtrm_datagram_max_size (default 8KB).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams received.</returns>

### nakPacketsSent

```csharp
public long nakPacketsSent()
```

Number of NAK packets sent by the receiver transport (LBT-RM only)

<remarks>
UM batches NAKs into NAK packets to save network bandwidth. This should
always be less than or equal to the number of individual NAKs sent (naksSent,
below).
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of NAK packets sent. </returns>

### nakPacketsSent

```csharp
public long nakPacketsSent(int n)
```

Number of NAK packets sent by the receiver transport (LBT-RM only)

<remarks>
UM batches NAKs into NAK packets to save network bandwidth. This should
always be less than or equal to the number of individual NAKs sent (naksSent,
below).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NAK packets sent. </returns>

### naksSent

```csharp
public long naksSent()
```

Number of individual NAKs sent by the receiver transport (LBT-RM only)

<remarks>
This may differ from the tally of lost datagrams (below) due to reasons such as
<list type="bullet">
<item>
Other receiver transports may have already sent a NAK for the same lost
datagram, resulting in a retransmitted lost datagram (or an NCF) to arrive at
this receiver transport before it has a chance to issue a NAK, or
</item>
<item>
During periods of heavy loss, receiver transports may be forced to issue
multiple NAKs per lost datagram (controlled by configuration options
transport_lbtrm_nak_generation_interval and
transport_lbtrm_nak_backoff_interval) until either the retransmission is
received or the datagram is declared unrecovered (which may ultimately lead to
UM delivering an LBM_MSG_UNRECOVERABLE_LOSS notification to the receiver
application).
</item>
</list>
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>. Number of individual NAKs sent by the receiver. </returns>

### naksSent

```csharp
public long naksSent(int n)
```

Number of individual NAKs sent by the receiver transport (LBT-RM only)

<remarks>
This may differ from the tally of lost datagrams (below) due to reasons such as
<list type="bullet">
<item>
Other receiver transports may have already sent a NAK for the same lost
datagram, resulting in a retransmitted lost datagram (or an NCF) to arrive at
this receiver transport before it has a chance to issue a NAK, or
</item>
<item>
During periods of heavy loss, receiver transports may be forced to issue
multiple NAKs per lost datagram (controlled by configuration options
transport_lbtrm_nak_generation_interval and
transport_lbtrm_nak_backoff_interval) until either the retransmission is
received or the datagram is declared unrecovered (which may ultimately lead to
UM delivering an LBM_MSG_UNRECOVERABLE_LOSS notification to the receiver
application).
</item>
</list>
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of individual NAKs sent by the receiver. </returns>

### lost

```csharp
public long lost()
```

Number of datagrams detected as lost (LBT-RM only)

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of datagrams that have been detected as lost.</returns>

### lost

```csharp
public long lost(int n)
```

Number of datagrams detected as lost (LBT-RM only)

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams that have been detected as lost.</returns>

### ncfsIgnored

```csharp
public long ncfsIgnored()
```

Number of NCFs received from a source transport with reason code "ignored".
(LBT-RM only)

<remarks>
If a source transport receives a NAK for a datagram that it has recently
retransmitted, it sends an "NCF ignored" and does not retransmit. How
"recently" is determined by the configuration option source
transport_lbtrm_ignore_interval (default 500ms). If this count is high, a
receiver transport may be having trouble receiving retransmissions, or the
ignore interval may be set too long.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of NCFs received from a source transport with the reason
code set to "ignored". </returns>

### ncfsIgnored

```csharp
public long ncfsIgnored(int n)
```

Number of NCFs received from a source transport with reason code "ignored".
(LBT-RM only)

<remarks>
If a source transport receives a NAK for a datagram that it has recently
retransmitted, it sends an "NCF ignored" and does not retransmit. How
"recently" is determined by the configuration option source
transport_lbtrm_ignore_interval (default 500ms). If this count is high, a
receiver transport may be having trouble receiving retransmissions, or the
ignore interval may be set too long.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NCFs received from a source transport with the reason
code set to "ignored". </returns>

### ncfsShed

```csharp
public long ncfsShed()
```

Number of NCFs received with reason code "shed" (LBT-RM only)

<remarks>
When a source transport's retransmit queue and rate limiter are both at
maximum, it responds to a NAK by sending an "NCF shed", and does not
retransmit. The receiver transport should wait, then send another NAK. If this
count is high, one or more crybaby receiver transports may be clogging the
source transport's retransmit queue.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of NCFs that have been received with the reason
code set to "shed". </returns>

### ncfsShed

```csharp
public long ncfsShed(int n)
```

Number of NCFs received with reason code "shed" (LBT-RM only)

<remarks>
When a source transport's retransmit queue and rate limiter are both at
maximum, it responds to a NAK by sending an "NCF shed", and does not
retransmit. The receiver transport should wait, then send another NAK. If this
count is high, one or more crybaby receiver transports may be clogging the
source transport's retransmit queue.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NCFs that have been received with the reason
code set to "shed". </returns>

### ncfsRetransmissionDelay

```csharp
public long ncfsRetransmissionDelay()
```

Number of NCFs received with reason code "rx_delay" (LBT-RM only)

<remarks>
When a source transport's retransmit rate limiter prevents it from
immediately retransmitting any more lost datagrams, it responds to a NAK by
sending an "NCF rx_delay", then queues the retransmission for a later send.
The receiver transport should wait for the retransmission and not immediately
send another NAK. If this count is high, one or more crybaby receiver
transports may be clogging the source transport's retransmit queue.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of NCFs that have been received with the reason
code set to "rx_delay". </returns>

### ncfsRetransmissionDelay

```csharp
public long ncfsRetransmissionDelay(int n)
```

Number of NCFs received with reason code "rx_delay" (LBT-RM only)

<remarks>
When a source transport's retransmit rate limiter prevents it from
immediately retransmitting any more lost datagrams, it responds to a NAK by
sending an "NCF rx_delay", then queues the retransmission for a later send.
The receiver transport should wait for the retransmission and not immediately
send another NAK. If this count is high, one or more crybaby receiver
transports may be clogging the source transport's retransmit queue.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NCFs that have been received with the reason
code set to "rx_delay". </returns>

### ncfsUnknown

```csharp
public long ncfsUnknown()
```

Number of NCFs received with reason code "unknown" (LBT-RM only)

<remarks>
These are NCFs with a reason code this receiver transport does not
recognize. After a delay (set by configuration option
transport_lbtrm_nak_suppress_interval (default 1000ms), it resends the NAK.
This counter should never be greater than 0 unless applications linked with
different versions of Ultra Messaging software coexist on the same network.
This method returns a value from the first
set of statistics encapsulated within this object
</remarks>
<returns>Number of NCFs that have been received with the reason
code set to "unknown". </returns>

### ncfsUnknown

```csharp
public long ncfsUnknown(int n)
```

Number of NCFs received with reason code "unknown" (LBT-RM only)

<remarks>
These are NCFs with a reason code this receiver transport does not
recognize. After a delay (set by configuration option
transport_lbtrm_nak_suppress_interval (default 1000ms), it resends the NAK.
This counter should never be greater than 0 unless applications linked with
different versions of Ultra Messaging software coexist on the same network.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NCFs that have been received with the reason
code set to "unknown". </returns>

### minimumRecoveryTime

```csharp
public long minimumRecoveryTime()
```

Minimum time (in milliseconds) in which loss recovery
was accomplished (LBT-RM only)

<remarks>
If this time is greater than configuration option
transport_lbtrm_nak_backoff_interval, it may be taking multiple NAKs to
initiate retransmissions, indicating a lossy network.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>
Minimum time (in milliseconds), i.e., the shortest time recorded so far, for
a lost message to be recovered.
</returns>

### minimumRecoveryTime

```csharp
public long minimumRecoveryTime(int n)
```

Minimum time (in milliseconds) in which loss recovery
was accomplished (LBT-RM only)

<remarks>
If this time is greater than configuration option
transport_lbtrm_nak_backoff_interval, it may be taking multiple NAKs to
initiate retransmissions, indicating a lossy network.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Minimum time (in milliseconds), i.e., the shortest time recorded so far, for
a lost message to be recovered.
</returns>

### meanRecoveryTime

```csharp
public long meanRecoveryTime()
```

Mean time (in milliseconds) in which loss recovery was
accomplished (LBT-RM only)

<remarks>
This is an exponentially weighted moving average (weighted to more recent)
for accumulated measured recovery times. Ideally this field should be as close
to your minimum recovery time (nak_stm_min, above) as possible. High mean
recovery times indicate a lossy network.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Mean time (in milliseconds) in which loss recovery was
accomplished. </returns>

### meanRecoveryTime

```csharp
public long meanRecoveryTime(int n)
```

Mean time (in milliseconds) in which loss recovery was
accomplished (LBT-RM only)

<remarks>
This is an exponentially weighted moving average (weighted to more recent)
for accumulated measured recovery times. Ideally this field should be as close
to your minimum recovery time (nak_stm_min, above) as possible. High mean
recovery times indicate a lossy network.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Mean time (in milliseconds) in which loss recovery was
accomplished.</returns>

### maximumRecoveryTime

```csharp
public long maximumRecoveryTime()
```

Maximum time (in milliseconds) in which loss recovery
was accomplished (LBT-RM only)

<remarks>
If this time is near or equal to the configuration option
transport_lbtrm_nak_generation_interval setting, you have likely experienced
some level of unrecoverable loss.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>
Maximum time (in milliseconds), i.e., the longest time recorded so far, for a
lost message to be recovered.
</returns>

### maximumRecoveryTime

```csharp
public long maximumRecoveryTime(int n)
```

Maximum time (in milliseconds) in which loss recovery
was accomplished (LBT-RM only)

<remarks>
If this time is near or equal to the configuration option
transport_lbtrm_nak_generation_interval setting, you have likely experienced
some level of unrecoverable loss.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Maximum time (in milliseconds), i.e., the longest time recorded so far, for a
lost message to be recovered.
</returns>

### minimumNakTransmissions

```csharp
public long minimumNakTransmissions()
```

Minimum number of times per lost message that a receiver transport
transmitted a NAK. (LBT-RM only)

<remarks>
A value greater than 1 indicates a chronically lossy network.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>
Minimum number of times per lost message that a receiver transport
transmitted a NAK, i.e., the lowest value collected so far.
</returns>

### minimumNakTransmissions

```csharp
public long minimumNakTransmissions(int n)
```

Minimum number of times per lost message that a receiver transport
transmitted a NAK. (LBT-RM only)

<remarks>
A value greater than 1 indicates a chronically lossy network.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Minimum number of times per lost message that a receiver transport
transmitted a NAK, i.e., the lowest value collected so far.
</returns>

### meanNakTransmissions

```csharp
public long meanNakTransmissions()
```

Mean number of times per lost message that a receiver transport transmitted
a NAK. (LBT-RM only)

<remarks>
Ideally this should be at or near 1. A higher value indicates a lossy
network. This is an exponentially weighted moving average (weighted to more
recent) for accumulated NAKs per lost message.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Mean number of times per lost message that a receiver transport
transmitted a NAK.</returns>

### meanNakTransmissions

```csharp
public long meanNakTransmissions(int n)
```

Mean number of times per lost message that a receiver transport transmitted
a NAK. (LBT-RM only)

<remarks>
Ideally this should be at or near 1. A higher value indicates a lossy
network. This is an exponentially weighted moving average (weighted to more
recent) for accumulated NAKs per lost message.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Mean number of times per lost message that a receiver transport
transmitted a NAK.</returns>

### maximumNakTransmissions

```csharp
public long maximumNakTransmissions()
```

Maximum number of times per lost message that a receiver transport
transmitted a NAK. (LBT-RM only)

<remarks>
A value higher than 1 suggests that there may have been some unrecoverable
loss on the network during the sample period. A significantly high value
compared to the mean number) implies an isolated incident.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>
Maximum number of times per lost message that a receiver transport
transmitted a NAK, i.e., the highest value collected so far.
</returns>

### maximumNakTransmissions

```csharp
public long maximumNakTransmissions(int n)
```

Maximum number of times per lost message that a receiver transport
transmitted a NAK. (LBT-RM only)

<remarks>
A value higher than 1 suggests that there may have been some unrecoverable
loss on the network during the sample period. A significantly high value
compared to the mean number) implies an isolated incident.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Maximum number of times per lost message that a receiver transport
transmitted a NAK, i.e., the highest value collected so far.
</returns>

### duplicateMessages

```csharp
public long duplicateMessages()
```

Number of duplicate datagrams received (LBT-RM only)

<remarks>
A large number can indicate a lossy network, primarily due to other receiver
transports requesting retransmissions that this receiver transport has already
successfully received. Such duplicates require extra effort for filtering, and
this should be investigated.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of duplicate datagrams received. </returns>

### duplicateMessages

```csharp
public long duplicateMessages(int n)
```

Number of duplicate datagrams received (LBT-RM only)

<remarks>
A large number can indicate a lossy network, primarily due to other receiver
transports requesting retransmissions that this receiver transport has already
successfully received. Such duplicates require extra effort for filtering, and
this should be investigated.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of duplicate datagrams received. </returns>

### unrecoveredMessagesWindowAdvance

```csharp
public long unrecoveredMessagesWindowAdvance()
```

Number of datagrams unrecovered due to transmission window advance (LBT-RM only)

<remarks>
This means that the message was no longer in the source-side transmission
window and therefore not retransmitted. The window size is set by transport
configuration option lbtrm_transmission_window_size (default 24MB).
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>
Number of datagrams unrecovered (LBM_MSG_UNRECOVERABLE_LOSS delivered to
receiver application) due to transmission window advance.
</returns>

### unrecoveredMessagesWindowAdvance

```csharp
public long unrecoveredMessagesWindowAdvance(int n)
```

Number of datagrams unrecovered due to transmission window advance (LBT-RM only)

<remarks>
This means that the message was no longer in the source-side transmission
window and therefore not retransmitted. The window size is set by transport
configuration option lbtrm_transmission_window_size (default 24MB).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Number of datagrams unrecovered (LBM_MSG_UNRECOVERABLE_LOSS delivered to
receiver application) due to transmission window advance.
</returns>

### unrecoveredMessagesNakGenerationTimeout

```csharp
public long unrecoveredMessagesNakGenerationTimeout()
```

Number of LBT-RM datagrams unrecovered due to a retransmission not received
within the NAK generation interval (LBT-RM only)

<remarks>
This is set by configuration option transport_lbtrm_nak_generation_interval;
default 10,000ms. Note: Receivers for these messages' topics will also report
related messages as unrecoverable, with LBM_MSG_UNRECOVERABLE_LOSS for an
individual message and LBM_MSG_UNRECOVERABLE_LOSS_BURST for a burst loss
event. However, it is possible for these application-level message
declarations to occur even without increments to this counter, as the
transport is unaware of the topic content of messages and may still be trying
to deliver related lost packets.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>
Number of LBT-RM datagrams unrecovered due to a retransmission not received
within the NAK generation interval.
</returns>

### unrecoveredMessagesNakGenerationTimeout

```csharp
public long unrecoveredMessagesNakGenerationTimeout(int n)
```

Number of LBT-RM datagrams unrecovered due to a retransmission not received
within the NAK generation interval (LBT-RM only)

<remarks>
This is set by configuration option transport_lbtrm_nak_generation_interval;
default 10,000ms. Note: Receivers for these messages' topics will also report
related messages as unrecoverable, with LBM_MSG_UNRECOVERABLE_LOSS for an
individual message and LBM_MSG_UNRECOVERABLE_LOSS_BURST for a burst loss
event. However, it is possible for these application-level message
declarations to occur even without increments to this counter, as the
transport is unaware of the topic content of messages and may still be trying
to deliver related lost packets.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Number of LBT-RM datagrams unrecovered due to a retransmission not received
within the NAK generation interval.
</returns>

### lbmMessagesReceived

```csharp
public long lbmMessagesReceived()
```

Number of messages or message fragments received over a transport.
(TCP, LBM-RM)

<remarks>
A single datagram may contain one or more messages or a fragment of a larger
message. For fragmented messages larger than the transport's maximum size
configuration option, this count reflects the number of datagrams used to
constitute those messages. Thus, this number is equal to or greater than the
datagram counter (messagesReceived, above). This number also includes
messages received for which there was no interested receiver,
tallied in the noTopicMessagesReceived counter (below).
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>
Number of messages or message fragments received over a transport.
</returns>

### lbmMessagesReceived

```csharp
public long lbmMessagesReceived(int n)
```

Number of messages or message fragments received over a transport.
(TCP, LBM-RM)

<remarks>
A single datagram may contain one or more messages or a fragment of a larger
message. For fragmented messages larger than the transport's maximum size
configuration option, this count reflects the number of datagrams used to
constitute those messages. Thus, this number is equal to or greater than the
datagram counter (messagesReceived, above). This number also includes
messages received for which there was no interested receiver,
tallied in the noTopicMessagesReceived counter (below).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Number of messages or message fragments received over a transport.
</returns>

### lbmRequestsReceived

```csharp
public long lbmRequestsReceived()
```

Number of UM request messages received (message type LBM_MSG_REQUEST)
(TCP, LBT-RM)

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>
Number of UM request messages received (message type LBM_MSG_REQUEST)
</returns>

### lbmRequestsReceived

```csharp
public long lbmRequestsReceived(int n)
```

Number of UM request messages received (message type LBM_MSG_REQUEST)
(TCP, LBT-RM)

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Number of UM request messages received (message type LBM_MSG_REQUEST)
</returns>

### noTopicMessagesReceived

```csharp
public long noTopicMessagesReceived()
```

Number of messages received that were not for a
topic of interest to the receiver (TCP, LBT-RM)

<remarks>
A high value (relative to, or approaching lbmMessagesReceived above) indicates
more CPU time required to filter out uninteresting topics, in which case,
consider reconfiguring sources to filter more aggressively at the transport
layer.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>
Number of messages received that were not for a topic of interest to the
receiver.
</returns>

### noTopicMessagesReceived

```csharp
public long noTopicMessagesReceived(int n)
```

Number of messages received that were not for a
topic of interest to the receiver (TCP, LBT-RM)

<remarks>
A high value (relative to, or approaching lbmMessagesReceived above) indicates
more CPU time required to filter out uninteresting topics, in which case,
consider reconfiguring sources to filter more aggressively at the transport
layer.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Number of messages received that were not for a topic of interest to the
receiver.
</returns>

### datagramsDroppedIncorrectSize

```csharp
public long datagramsDroppedIncorrectSize()
```

Number of datagrams discarded due to size.

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
</remarks>
<returns>
Number of datagrams discarded due to being smaller than the size designated
in the datagram's size field.
</returns>

### datagramsDroppedIncorrectSize

```csharp
public long datagramsDroppedIncorrectSize(int n)
```

Number of datagrams discarded due to size.

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Number of datagrams discarded due to being smaller than the size designated
in the datagram's size field.
</returns>

### datagramsDroppedType

```csharp
public long datagramsDroppedType()
```

Number of datagrams discarded due to bad packet type.

<remarks>
The datagram's type field must match the expectations of the receiver
transport.
This method returns a value from the first
set of statistics encapsulated within this object
</remarks>
<returns>Number of datagrams discarded due to bad packet type.</returns>

### datagramsDroppedType

```csharp
public long datagramsDroppedType(int n)
```

Number of datagrams discarded due to bad packet type.

<remarks>
The datagram's type field must match the expectations of the receiver
transport.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams discarded due to bad packet type.</returns>

### datagramsDroppedVersion

```csharp
public long datagramsDroppedVersion()
```

Number of datagrams discarded due to version mismatch.

<remarks>
The datagram's version field must match the expectations of the receiver
transport.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of datagrams discarded due to version mismatch.</returns>

### datagramsDroppedVersion

```csharp
public long datagramsDroppedVersion(int n)
```

Number of datagrams discarded due to version mismatch.

<remarks>
The datagram's version field must match the expectations of the receiver
transport.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams discarded due to version mismatch.</returns>

### datagramsDroppedHeader

```csharp
public long datagramsDroppedHeader()
```

Number of datagrams discarded due to bad header type.

<remarks>
These datagrams appeared to be intact, but with an unrecognizable header
format.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of datagrams discarded due to bad header type.</returns>

### datagramsDroppedHeader

```csharp
public long datagramsDroppedHeader(int n)
```

Number of datagrams discarded due to bad header type.

<remarks>
These datagrams appeared to be intact, but with an unrecognizable header
format.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams discarded due to bad header type.</returns>

### datagramsDroppedSID

```csharp
public long datagramsDroppedSID()
```

Number of datagrams discarded due to session ID mismatch.

<remarks>
These datagrams appeared to be correctly formed, but with an
unmatched/unrecognized session ID field.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of datagrams discarded due to session ID mismatch.</returns>

### datagramsDroppedSID

```csharp
public long datagramsDroppedSID(int n)
```

Number of datagrams discarded due to session ID mismatch.

<remarks>
These datagrams appeared to be correctly formed, but with an
unmatched/unrecognized session ID field.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams discarded due to session ID mismatch.</returns>

### datagramsDroppedOther

```csharp
public long datagramsDroppedOther()
```

Number of datagrams discarded due to other reasons.

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>
Number of unrecognizable datagrams discarded due to reasons other than those
determined by the above counts. They could be garbled, or possibly be from
foreign or incompatible software at the other end.
</returns>

### datagramsDroppedOther

```csharp
public long datagramsDroppedOther(int n)
```

Number of datagrams discarded due to other reasons.

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Number of unrecognizable datagrams discarded due to reasons other than those
determined by the above counts. They could be garbled, or possibly be from
foreign or incompatible software at the other end.
</returns>

### outOfOrder

```csharp
public long outOfOrder()
```

Number of out-of-order datagrams received.

<remarks>
A datagram is counted as out of order if it fills a previously detected
sequence gap, but is not a retransmission. Note that if the duplicates counter
duplicate_data, above) increases along with this statistic, this implies the
arrivals of retransmitted datagrams before their originals.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of datagrams received out of order.</returns>

### outOfOrder

```csharp
public long outOfOrder(int n)
```

Number of out-of-order datagrams received.

<remarks>
A datagram is counted as out of order if it fills a previously detected
sequence gap, but is not a retransmission. Note that if the duplicates counter
duplicate_data, above) increases along with this statistic, this implies the
arrivals of retransmitted datagrams before their originals.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams received out of order.</returns>

## LBMImmediateMessageSourceStatistics

*class* `com.latencybusters.lbm.LBMImmediateMessageSourceStatistics`

### LBMImmediateMessageSourceStatistics

```csharp
public LBMImmediateMessageSourceStatistics()
```

Instantiate an empty object containing no statistics.

<remarks>
<seealso cref="refresh"/>
</remarks>

### LBMImmediateMessageSourceStatistics

```csharp
unsafe public LBMImmediateMessageSourceStatistics(LBMContext lbmctx, int maxStats)
```

Instantiate object containing the aggregate set of statistics
for a particular context

<remarks>
This constructor will throw LBMEInvalException if maxStats is
less than the the available number of transport statistical
sets.
<seealso cref="refresh"/>
</remarks>
<param name="lbmctx">LBMContext object associated with statistics to be retrieved</param>
<param name="maxStats">Maximum number of statistical sets to retrieve</param>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of statistics.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of statistics (same as Dispose()).
<seealso cref="Dispose"/>

### refresh

```csharp
unsafe public void refresh(LBMContext lbmctx, int maxStats)
```

Refresh the aggregate set of statistics for a particular context.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or
unexpected operational behavior has been encountered by unmanaged UM C layer function.</exception>
<param name="lbmctx">LBMContext object associated with statistics to be retrieved</param>
<param name="maxStats">Maximum number of statistical sets to retrieve</param>

### size

```csharp
public int size()
```

Number of statistical sets encapsulated within this object

<returns>Statistical set size</returns>

### type

```csharp
public int type()
```

Transport type (TCP, LBT-RM, etc.)

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object.
<seealso cref="LBM"/>
</remarks>
<returns>Transport type</returns>

### type

```csharp
public int type(int n)
```

Transport type (TCP, LBT-RM, etc.)

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
<seealso cref="LBM"/>
</remarks>
<param name="n">Statistics set index</param>
<returns>Transport type</returns>

### typeName

```csharp
public string typeName()
```

Transport type name (TCP, LBT-RM, etc.).

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
</remarks>
<returns>Transport type name</returns>

### typeName

```csharp
public string typeName(int n)
```

Transport type name (TCP, LBT-RM, etc.).

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Transport type name</returns>

### source

```csharp
public string source()
```

Source of transport as a string

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
</remarks>
<seealso cref="LBMTransportSourceInfo" />
<returns>Source of transport as a string</returns>

### source

```csharp
public string source(int n)
```

Source of transport as a string

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
</remarks>
<seealso cref="LBMTransportSourceInfo" />
<param name="n">Statistics set index</param>
<returns>Source of transport as a string</returns>

### numberOfClients

```csharp
public long numberOfClients()
```

Number of receiver clients currently connected over this transport (TCP only).

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
</remarks>
<returns>Number of receiver clients currently connected over this
transport.</returns>

### numberOfClients

```csharp
public long numberOfClients(int n)
```

Number of receiver clients currently connected over this transport (TCP only).

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of receiver clients currently connected over this
transport.</returns>

### bytesBuffered

```csharp
public long bytesBuffered()
```

Number of bytes currently in UM's TCP buffer (TCP only)

<remarks>
This count is affected by the number of receivers,and configuration options
transport_tcp_multiple_receiver_behavior and transport_session_maximum_buffer.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of bytes currently in UM's TCP buffer, i.e., a snapshot.</returns>

### bytesBuffered

```csharp
public long bytesBuffered(int n)
```

Number of bytes currently in UM's TCP buffer (TCP only)

<remarks>
This count is affected by the number of receivers,and configuration options
transport_tcp_multiple_receiver_behavior and transport_session_maximum_buffer.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of bytes currently in UM's TCP buffer, i.e., a snapshot.</returns>

### messagesSent

```csharp
public long messagesSent()
```

Number of datagrams sent (LBT-RM only).

<remarks>
Depending on batching settings, a single datagram may contain one or
more messages, or a fragment of a larger message. With LBT-RM, larger messages
are split into fragment sizes limited by configuration option
transport_lbtrm_datagram_max_size (default 8KB).
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of datagrams sent.</returns>

### messagesSent

```csharp
public long messagesSent(int n)
```

Number of datagrams sent (LBT-RM only).

<remarks>
Depending on batching settings, a single datagram may contain one or
more messages, or a fragment of a larger message. With LBT-RM, larger messages
are split into fragment sizes limited by configuration option
transport_lbtrm_datagram_max_size (default 8KB).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams sent.</returns>

### bytesSent

```csharp
public long bytesSent()
```

Number of datagram bytes sent (LBT-RM only).

<remarks>
Includes the total length of all LBT-RM packets,
including UM header information.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of datagram bytes sent, i.e., the total of lengths of all
packets including UM header information.</returns>

### bytesSent

```csharp
public long bytesSent(int n)
```

Number of datagram bytes sent (LBT-RM only).

<remarks>
Includes the total length of all LBT-RM packets,
including UM header information.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagram bytes sent, i.e., the total of lengths of all
packets including UM header information.</returns>

### transmissionWindowMessages

```csharp
public long transmissionWindowMessages()
```

Number of datagrams in the transmission window (LBT-RM only).

<remarks>
Each source transport session maintains a transmission window buffer (the
size of which is set by transport_lbtrm_transmission_window_size, default
24MB). When the source transport receives a NAK, the corresponding message for
retransmission must be found in this transmission window.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of datagrams in the transmission window.</returns>

### transmissionWindowMessages

```csharp
public long transmissionWindowMessages(int n)
```

Number of datagrams in the transmission window (LBT-RM only).

<remarks>
Each source transport session maintains a transmission window buffer (the
size of which is set by transport_lbtrm_transmission_window_size, default
24MB). When the source transport receives a NAK, the corresponding message for
retransmission must be found in this transmission window.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams in the transmission window.</returns>

### transmissionWindowBytes

```csharp
public long transmissionWindowBytes()
```

Number of bytes currently in the transmission window (LBT-RM only)

<remarks>
Number of bytes currently in the transmission window.
Typically, this count approaches its window size or exceeds it by a small
amount.
See transmissionWindowMessages for a description of the
transmission window.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of bytes currently in the transmission window</returns>

### transmissionWindowBytes

```csharp
public long transmissionWindowBytes(int n)
```

Number of bytes currently in the transmission window (LBT-RM only)

<remarks>
Number of bytes currently in the transmission window.
Typically, this count approaches its window size or exceeds it by a small
amount.
See transmissionWindowMessages for a description of the
transmission window.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of bytes currently in the transmission window</returns>

### nakPacketsReceived

```csharp
public long nakPacketsReceived()
```

Number of NAK packets received by this source transport (LBT-RM only).

<remarks>
UM batches NAKs into NAK packets to save network bandwidth. This should
always be less than or equal to naksReceived (below).
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of NAK packets received by this source transport.</returns>

### nakPacketsReceived

```csharp
public long nakPacketsReceived(int n)
```

Number of NAK packets received by this source transport (LBT-RM only).

<remarks>
UM batches NAKs into NAK packets to save network bandwidth. This should
always be less than or equal to naksReceived (below).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NAK packets received by this source transport.</returns>

### naksReceived

```csharp
public long naksReceived()
```

Number of individual NAKs received by the source transport (LBT-RM only).

<remarks>
When a source transport receives a NAK from a receiver transport, it may
respond by re-transmitting the requested LBT-RM datagram, or it may send an
NCF. The NAKing receiver transport responds to the NCF by waiting (timeout
set by transport_lbtrm_nak_suppress_interval, default 1000 ms), then
re-sending the NAK.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of individual NAKs received by the source transport.</returns>

### naksReceived

```csharp
public long naksReceived(int n)
```

Number of individual NAKs received by the source transport (LBT-RM only).

<remarks>
When a source transport receives a NAK from a receiver transport, it may
respond by re-transmitting the requested LBT-RM datagram, or it may send an
NCF. The NAKing receiver transport responds to the NCF by waiting (timeout
set by transport_lbtrm_nak_suppress_interval, default 1000 ms), then
re-sending the NAK.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of individual NAKs received by the source transport.</returns>

### naksIgnored

```csharp
public long naksIgnored()
```

Number of NAKs this source transport ignored and sent an NCF with reason
code "ignored" (LBT-RM only).

<remarks>
A source transport ignores a NAK for a datagram it has already recently
retransmitted. How "recently" is determined by the configuration option source
transport_lbtrm_ignore_interval (default 500ms). If this count is high, a
receiver transport may be having trouble receiving retransmissions, or the
ignore interval may be set too long.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of NAKs this source transport ignored and sent an NCF with
reason code set to "ignored".</returns>

### naksIgnored

```csharp
public long naksIgnored(int n)
```

Number of NAKs this source transport ignored and sent an NCF with reason
code "ignored" (LBT-RM only).

<remarks>
A source transport ignores a NAK for a datagram it has already recently
retransmitted. How "recently" is determined by the configuration option source
transport_lbtrm_ignore_interval (default 500ms). If this count is high, a
receiver transport may be having trouble receiving retransmissions, or the
ignore interval may be set too long.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NAKs this source transport ignored and sent an NCF with
reason code set to "ignored".</returns>

### naksShed

```csharp
public long naksShed()
```

Number of NAKs this source transport has shed and sent an NCF with reason
code "shed" (LBT-RM only).

<remarks>
When a source transport's retransmit rate limiter and retransmit queue are
both at maximum, it responds to a NAK by sending an "NCF shed", and does not
retransmit. The receiver transport should wait, then send another NAK. If this
count is high, one or more crybaby receiver transports may be clogging the
source transport's retransmit queue.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of NAKs this source transport has shed and sent an NCF with
the reason code set to "shed".</returns>

### naksShed

```csharp
public long naksShed(int n)
```

Number of NAKs this source transport has shed and sent an NCF with reason
code "shed" (LBT-RM only).

<remarks>
When a source transport's retransmit rate limiter and retransmit queue are
both at maximum, it responds to a NAK by sending an "NCF shed", and does not
retransmit. The receiver transport should wait, then send another NAK. If this
count is high, one or more crybaby receiver transports may be clogging the
source transport's retransmit queue.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NAKs this source transport has shed and sent an NCF with
the reason code set to "shed".</returns>

### naksIgnoredRetransmitDelay

```csharp
public long naksIgnoredRetransmitDelay()
```

Number of NAKs this source transport has not processed because it met its
retransmission rate limit (LBT-RM only).

<remarks>
This rate limit is set by configuration option
transport_lbtrm_retransmit_rate_limit (default 5Mbps).
For each of these NAKs, the source transport immediately sends an NFC
rx_delay, then queues the retransmission for a later send within the rate
limit. If this count is high, one or more crybaby receiver transports may be
clogging the source transport's retransmit queue.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of NAKs this source did not process because doing so would
exceed its retransmit rate limit.</returns>

### naksIgnoredRetransmitDelay

```csharp
public long naksIgnoredRetransmitDelay(int n)
```

Number of NAKs this source transport has not processed because it met its
retransmission rate limit (LBT-RM only).

<remarks>
This rate limit is controlled by the transport's retransmit_rate_limit,
default 5 Mbps. The source queues the retransmission and sends an
NCF with the reason code set to "rx_delay". If naksIgnoredRetransmitDelay
is high, one or more crybaby receivers may be clogging the source's
retransmission queue.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NAKs this source did not process because doing so would
exceed its retransmit rate limit.</returns>

### retransmissionsSent

```csharp
public long retransmissionsSent()
```

Number of datagrams retransmitted by this source transport (LBT-RM only).

<remarks>
This count is incremented under the same circumstances as
retransmissionBytesSent, below.
In a normal, light-loss scenario, most NAKs received induce a retransmission.
When losses become heavy and/or many receiver transports begin losing the
same datagrams, NCF-related no-retransmit counts (naksIgnored, naksShed and
naksIgnoredRetransmitDelay) may begin to inflate, and retransmissions
retransmissionsSent) may become significantly lower than NAKS
received (naksReceived).
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of datagrams retransmitted by this source transport.</returns>

### retransmissionsSent

```csharp
public long retransmissionsSent(int n)
```

Number of datagrams retransmitted by this source (LBT-RM only).

<remarks>
This count is incremented under the same circumstances as
retransmissionBytesSent, below.
In a normal, light-loss scenario, most NAKs received induce a retransmission.
When losses become heavy and/or many receiver transports begin losing the
same datagrams, NCF-related no-retransmit counts (naksIgnored, naksShed and
naksIgnoredRetransmitDelay) may begin to inflate, and retransmissions
retransmissionsSent) may become significantly lower than NAKS
received (naksReceived).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams retransmitted by this source transport.</returns>

### messagesQueued

```csharp
public long messagesQueued()
```

Number of datagrams currently queued by the rate limiter (LBT-RM only).

<remarks>
When a source transport attempts to send messages (any type) faster than its
data rate limiter allows (set by configuration option
transport_lbtrm_data_rate_limit, default 10Mbps), the data rate limiter queues
the messages until they can be sent within the data rate limit.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of datagrams currently queued by the rate limiter.</returns>

### messagesQueued

```csharp
public long messagesQueued(int n)
```

Number of datagrams currently queued by the rate limiter (LBT-RM only).

<remarks>
When a source transport attempts to send messages (any type) faster than its
data rate limiter allows (set by configuration option
transport_lbtrm_data_rate_limit, default 10Mbps), the data rate limiter queues
the messages until they can be sent within the data rate limit.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams currently queued by the rate limiter.</returns>

### retransmissionsQueued

```csharp
public long retransmissionsQueued()
```

Number of retransmission datagrams currently queued by the retransmit
rate limiter (LBT-RM only).

<remarks>
When a source transport attempts to send retransmissions faster that its
retransmit rate limiter allows (set by configuration option
transport_lbtrm_retransmit_rate_limit, default 5Mbps), the retransmit rate
limiter queues retransmissions until they can be sent within the rate limit.
naksIgnoredRetransmitDelay (above) will generally also rise if this count is high.
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns>Number of retransmission datagrams currently queued by the
retransmit rate limiter.</returns>

### retransmissionsQueued

```csharp
public long retransmissionsQueued(int n)
```

Number of retransmission datagrams currently queued by the retransmit
rate limiter (LBT-RM only).

<remarks>
When a source transport attempts to send retransmissions faster that its
retransmit rate limiter allows (set by configuration option
transport_lbtrm_retransmit_rate_limit, default 5Mbps), the retransmit rate
limiter queues retransmissions until they can be sent within the rate limit.
naksIgnoredRetransmitDelay (above) will generally also rise if this count is high.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of retransmission datagrams currently queued by the
retransmit rate limiter.</returns>

### retransmissionBytesSent

```csharp
public long retransmissionBytesSent()
```

Total number of bytes retransmitted by this source transport (LBT-RM only).

<remarks>
This count is triggered under the same circumstances as retransmissionsSent, above.
In a normal, light-loss scenario, most NAKs received induce a retransmission.
When losses become heavy and/or many receiver transports begin losing the
same datagrams, NCF-related no-retransmit counts (naksIgnored, naksShed and
naksIgnoredRetransmitDelay) may begin to inflate, and retransmissions
retransmissionsSent) may become significantly lower than NAKs
received (naksReceived).
This method returns a value from the first
set of statistics encapsulated within this object.
</remarks>
<returns> Total number of bytes retransmitted by this source transport.
</returns>

### retransmissionBytesSent

```csharp
public long retransmissionBytesSent(int n)
```

Total number of bytes retransmitted by this source transport (LBT-RM only).

<remarks>
This count is triggered under the same circumstances as retransmissionsSent, above.
In a normal, light-loss scenario, most NAKs received induce a retransmission.
When losses become heavy and/or many receiver transports begin losing the
same datagrams, NCF-related no-retransmit counts (naksIgnored, naksShed and
naksIgnoredRetransmitDelay) may begin to inflate, and retransmissions
retransmissionsSent) may become significantly lower than NAKs
received (naksReceived).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns> Total number of bytes retransmitted by this source transport.
</returns>

## LBMLogging

*delegate* `com.latencybusters.lbm.LBMLogging`

### LBMLogging

```csharp
public delegate void LBMLogging(int level, string message)
```

LBM logging callback delegate

<param name="level">Logging level, where values can be (in order of decreasing importance):
<list type="bullet">
<item>
<description>LBM.LOG_EMERG</description>
</item>
<item>
<description>LBM.LOG_ALERT</description>
</item>
<item>
<description>LBM.LOG_CRIT</description>
</item>
<item>
<description>LBM.LOG_ERR</description>
</item>
<item>
<description>LBM.LOG_WARNING</description>
</item>
<item>
<description>LBM.LOG_NOTICE</description>
</item>
<item>
<description>LBM.LOG_INFO</description>
</item>
<item>
<description>LBM.LOG_DEBUG</description>
</item>
</list>
</param>
<param name="message">Log message</param>

## LBMMessage

*class* `com.latencybusters.lbm.LBMMessage`

### LBMMessage

```csharp
public LBMMessage()
```

LBMMessage constructor.

### dataPointer

```csharp
public byte* dataPointer()
```

Pointer to the beginning of the unmanaged data buffer for this message. For ZOD, use in conjunction with
length() to determine how many bytes in the buffer are actually valid.

<returns>Pointer to the beginning of the unmanaged data buffer for this message.</returns>

### dataPointerSafe

```csharp
public IntPtr dataPointerSafe()
```

Return an IntPtr to the beginning of the unmanaged data buffer for this message. For ZOD, use in conjunction with
length() to determine how many bytes in the buffer are actually valid.

<returns>Pointer to the beginning of the unmanaged data buffer for this message.</returns>

### data

```csharp
public byte[] data()
```

Message data.  Calling this method causes the data to be copied to a
new byte array.  For better performance, use the dataPointer() method
to access the data directly.

<returns>byte array containing message data</returns>

### dataString

```csharp
public string dataString()
```

Message string data. Calling this method converts the data to a string and
returns that string.

<returns>Message data converted to a string</returns>

### length

```csharp
public uint length()
```

Message data length. For ZOD, use this in conjunction with dataPointer().

<returns>LBM message length</returns>

### type

```csharp
public int type()
```

LBM message type

<remarks>
<seealso cref="LBM"/>
</remarks>
<returns>LBM message type</returns>

### sequenceNumber

```csharp
public long sequenceNumber()
```

LBM message (or message fragment) sequence number

<remarks>
The sequence number of an LBM message is 32 bits. This field is a C#-style long
int (64 bits). Therefore, LBM only recognizes the lower 32 bits of this field.
When using hot-failover, this will be the hot failover sequence number when using 32 bit
and be zero when using 64 bit. To get the original sequence number when using hot-failover,
use the osqn() method.
</remarks>
<seealso cref="osqn()"/>
<returns>LBM message (or message fragment) sequence number</returns>

### hfSequenceNumber64

```csharp
public ulong hfSequenceNumber64()
```

Get the 64 bit hot failover sequence number.

<returns>64 bit hot failover sequence number</returns>

### hfSequenceNumber32

```csharp
public uint hfSequenceNumber32()
```

Get the 32 bit hot failover sequence number.

<returns>32 bit hot failover sequence number</returns>

### source

```csharp
public string source()
```

Message source

<returns>Message source string</returns>

### sourceAsCharArray

```csharp
public char[] sourceAsCharArray()
```

Message source

<returns>Message source char []</returns>

### flags

```csharp
public int flags()
```

LBM message flags

<remarks>
<seealso cref="LBM"/>
</remarks>
<returns>LBM message flags</returns>

### topicName

```csharp
public string topicName()
```

Topic on which the current message has been delivered.

<returns>Topic name string</returns>

### topicNameAsCharArray

```csharp
public char[] topicNameAsCharArray()
```

Topic on which the current message has been delivered.

<returns>Topic name char []</returns>

### channelInfo

```csharp
public LBMMessageChannelInfo channelInfo()
```

Holds information about any channel information included with the message.

<returns>Channel info object or null if no channel information is present.</returns>

### firstFragmentSequenceNumber

```csharp
public long firstFragmentSequenceNumber()
```

LBM sequence number of the first fragment of the current message

<returns>Sequence number of the first message fragment</returns>

### fragmentOffset

```csharp
public long fragmentOffset()
```

Byte offset of the current fragment within the associated message

<returns>Byte offset of the current fragment</returns>

### totalMessageLength

```csharp
public long totalMessageLength()
```

Total message size.

<remarks>
  This value may be larger than the length of the
  data byte array, if the current object represents a message fragment.
</remarks>
<returns>Total size (in bytes) of the current message</returns>

### isFragment

```csharp
public bool isFragment()
```

Determine if the current message is a single fragment of
a larger, multi-fragment message.
<para>
Note that this method will not return true unless:
<ul>
<li>\ref ordereddeliveryreceiver is set to "0" (zero), and
<li>the application message required UM fragmentation.
</ul>
</para>

<returns>true if the current object is a message fragment; otherwise, false.</returns>

### deregistrationSuccessInfo

```csharp
public UMEDeregistrationSuccessInfo deregistrationSuccessInfo()
```

Get an extended deregistration success info object from the message (only for
LBM.MSG_UME_DEREGISTRATION_SUCCESS_EX messages).

<returns>UMEDeregistrationSuccessInfo object holding extended deregistration success info.</returns>

### deregistrationCompleteInfo

```csharp
public UMEDeregistrationCompleteInfo deregistrationCompleteInfo()
```

Get an extended deregistration complete info object from the message
(only for LBM.MSG_UME_DEREGISTRATION_COMPLETE_EX messages).

<returns>UMEDeregistrationCompleteInfo object holding extended deregistration complete info.</returns>

### registrationSuccessInfo

```csharp
public UMERegistrationSuccessInfo registrationSuccessInfo()
```

Get an extended registration success info object from the message (only for
LBM.MSG_UME_REGISTRATION_SUCCESS_EX messages).

<returns>UMERegistrationSuccessInfo object holding extended registration success info.</returns>

### registrationCompleteInfo

```csharp
public UMERegistrationCompleteInfo registrationCompleteInfo()
```

Get an extended registration complete info object from the message
(only for LBM.MSG_UME_REGISTRATION_COMPLETE_EX messages).

<returns>UMERegistrationCompleteInfo object holding extended registration complete info.</returns>

### queueRegistrationCompleteInfo

```csharp
public UMQRegistrationCompleteInfo queueRegistrationCompleteInfo()
```

Get an extended queue registration complete info object from the message
(only for LBM.MSG_UMQ_REGISTRATION_COMPLETE_EX messages).

<returns>UMQRegistrationCompleteInfo object holding extended queue registration complete info.</returns>

### queueDeregistrationCompleteInfo

```csharp
public UMQDeregistrationCompleteInfo queueDeregistrationCompleteInfo()
```

Get an extended queue deregistration complete info object from the message
(only for LBM.MSG_UMQ_DEREGISTRATION_COMPLETE_EX messages).

<returns>UMQDeregistrationCompleteInfo object holding extended queue deregistration complete info.</returns>

### queueMessageId

```csharp
public UMQMessageId queueMessageId()
```

The message ID assigned by the queue (UMQ only)

<returns>The message ID assigned by the queue</returns>

### queueIndexInfo

```csharp
public UMQIndexInfo queueIndexInfo()
```

Retrieve index information from the message.
<returns>UMQIndexInfo object holding queue index information, or null if the message has no queue index information.</returns>

### queueIndexAssignedInfo

```csharp
public UMQIndexAssignedInfo queueIndexAssignedInfo()
```

Get a queue index assigned info object from the message
only for LBM.MSG_UMQ_INDEX_ASSIGNED_EX messages).
<returns>UMQIndexAssignedInfo object holding extended index assignment info.</returns>

### queueIndexReleasedInfo

```csharp
public UMQIndexReleasedInfo queueIndexReleasedInfo()
```

Get a queue index released info object from the message
only for LBM.MSG_UMQ_INDEX_RELEASED_EX messages).
<returns>UMQIndexReleasedInfo object holding extended index release info.</returns>

### queueIndexAssignmentEligibilityStartCompleteInfo

```csharp
public UMQIndexAssignmentEligibilityStartCompleteInfo queueIndexAssignmentEligibilityStartCompleteInfo()
```

Get a queue index assignment eligibility start complete info object from the message
(only for LBM.MSG_UMQ_INDEX_ASSIGNMENT_ELIGIBILITY_START_COMPLETE_EX messages).
<returns>UMQIndexAssignmentEligibilityStartCompleteInfo object holding extended index assignment eligibility start complete info.</returns>

### queueIndexAssignmentEligibilityStopCompleteInfo

```csharp
public UMQIndexAssignmentEligibilityStopCompleteInfo queueIndexAssignmentEligibilityStopCompleteInfo()
```

Get a queue index assignment eligibility stop complete info object from the message
(only for LBM.MSG_UMQ_INDEX_ASSIGNMENT_ELIGIBILITY_STOP_COMPLETE_EX messages).
<returns>UMQIndexAssignmentEligibilityStopCompleteInfo object holding extended index assignment eligibility stop complete info.</returns>

### timestampSeconds

```csharp
public UInt32 timestampSeconds()
```

Seconds portion of the timestamp indicating when the message was received.

<returns>Number of whole seconds since Midnight, January 1st 1970 UTC.</returns>

### timestampMicroseconds

```csharp
public UInt32 timestampMicroseconds()
```

Microsecondseconds portion of the timestamp indicating when the message was received.

<returns>
Number of fractional seconds since Midnight, January 1st 1970 UTC,
represented as an integer number of microseconds.
</returns>

### hrTimestampSeconds

```csharp
public UInt64 hrTimestampSeconds()
```

Seconds portion of the high resolution timestamp indicating when the message was received.
Note: Supported on Linux only

<returns>Linux only: Number of whole seconds since Midnight, January 1st 1970 UTC.
All other platforms: returns 0
</returns>

### hrTimestampNanoseconds

```csharp
public UInt64 hrTimestampNanoseconds()
```

Nanosecond portion of the high resolution timestamp indicating when the message was received.
Note: Supported on Linux only

<returns>Linux only: Number of fractional seconds since Midnight, January 1st 1970 UTC.
All other platforms: returns 0
</returns>
</returns>

### properties

```csharp
public LBMMessageProperties properties()
```

Retrieve the properties associated with this message.

<returns>An LBMMessageProperties object containing all properties associated with this message.</returns>

### respond

```csharp
public void respond(byte[] data, int dataLength, int flags)
```

Send a response for this request message.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.<br/>
<b>Warning</b>: You may be required to use GC.KeepAlive on the LBMMessage object after calling respond() in order to prevent premature garbage collection during execution of the respond() function call. Premature garbage collection can occur if there are no references made to the LBMMessage object following the respond() call.<br/>
Possible OR'd set of flag value include:
<see cref="LBM.SRC_NONBLOCK"/> and <see cref="LBM.SRC_BLOCK"/>.
</remarks>
<param name="data">Data to send in this response</param>
<param name="dataLength">Number of bytes of data to send in this response</param>
<param name="flags">Flags indicating various conditions</param>

### sendExplicitAck

```csharp
public void sendExplicitAck()
```

Send a consumption acknowledgement to the persistent Store.

This function is used in the
\ref explicitacknowledgments use case
to signal consumption of the supplied message,
and all unacknowledged messages sent before it.
\ref umeexplicitackonlyreceiver must be set to <b>1</b>.

\warning If explicit ACKs are used, the application must ensure
that messages are ACKed in the order received.
See \ref ackordering.

See \ref persistencemessageconsumption for a full explanation of
consumption acknowledgements.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### canSendExplicitAck

```csharp
public bool canSendExplicitAck()
```

Determine whether an explicit ACK can be used on this  message (UME).

### reassign

```csharp
public void reassign(int flags)
```

Do not acknowledge the given message and instead request that the message be reassigned.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="flags">Flags indicating various conditions. ORed set of values include:
<see cref="LBM.MSG_UMQ_REASSIGN_FLAG_DISCARD"/>
</param>

### sourceRegistrationId

```csharp
public long sourceRegistrationId()
```

The registration ID for the source (UME only).

<returns>The source registration ID</returns>

### receiverRegistrationId

```csharp
public long receiverRegistrationId()
```

The registration ID for the receiver (UME only).

<returns>The receiver registration ID</returns>

### isFromGateway

```csharp
public bool isFromGateway()
```

Whether or not the message arrived via a gateway.

<returns>boolean indicating if it arrived via a gateway.</returns>

### originalSequenceNumber

```csharp
public long originalSequenceNumber()
```

Original sequence number (if the message arrived via a gateway).

<returns>Original sequence number.</returns>

### originalSource

```csharp
public string originalSource()
```

Original message source (if the message arrived via a gateway).

<returns>Original message source.</returns>

### originalSourceAsCharArray

```csharp
public char[] originalSourceAsCharArray()
```

Original message source (if the message arrived via a gateway)
as character array

<returns>Original message source as character array.</returns>

### sourceClientObject

```csharp
public object sourceClientObject()
```

Get the source client object for this message's source, as set by an LBMSourceCreationCallback callback delegate.

<returns>Source client object.</returns>

### osqn

```csharp
public uint osqn()
```

Get the original message sequence number set by the UM library.

<returns>Message original sequence number</returns>

### extractUMEAck

```csharp
public UMEMessageAck extractUMEAck()
```

Retrieves the ack structure from a UME message.

<exception ref="com.latencybusters.lbm.LBMException"> Message already acked, disposed, or not a UME message </exception>
<returns>UMEMessageAck object that can be used to send explicit acks</returns>

### Dispose

```csharp
public void Dispose()
```

Dispose of this message immediately

### dispose

```csharp
public void dispose()
```

Dispose of memory associated with this message.

Every received message must be disposed after processing is complete.
See \ref netmessagereception.

If this message is delivered from a persistent receiver,
deleting the message might signal consumption of the message,
depending on the use case.
See \ref persistencemessageconsumption for a full explanation of
consumption acknowledgements.

<para>
<seealso cref="Dispose"/>
</para>

### promote

```csharp
public LBMMessage promote()
```

Inform UM that the application is going to retain ownership
of a UM message object after the receiver callback returns.

This function should be called from inside a receiver callback function to
prevent UM from automatically deleting the message when the callback
function returns.
This allows the message to be passed to a different part of the application,
perhaps a different thread,
for processing after the receiver callback returns.

Once promoted, the application has the responsibility to dispose of the
message when it is finished with it by calling dispose().
See \ref netmessagereception.

Note that this creates a new object, so delivery is no longer
"zero object".

\note the message must be promoted <i>before</i> being made available to
the other parts of the application.
For example, it would not be legal for a separate thread to start
processing the message before the receiver callback called promote.

\warning promote() is NOT thread safe;
do not call it on the same message from multiple threads at the same time.

<returns>
The promoted message. This will be a new message object, not
the message object passed into the receiver callback.
was called on.
</returns>

## LBMMessageChannelInfo

*class* `com.latencybusters.lbm.LBMMessageChannelInfo`

### channelFlags

```csharp
public int channelFlags()
```

LBM channel flags.

<seealso cfef="LBM.MSG_FLAG_NUMBERED_CHANNEL" />
<returns> LBM channel flags. </returns>

### channelNumber

```csharp
public long channelNumber()
```

Channel number on which the current message has been delivered.

## LBMMessageProperties

*class* `com.latencybusters.lbm.LBMMessageProperties`

### LBMMessageProperties

```csharp
public LBMMessageProperties()
```

Create an LBMMessageProperties object, used to associate properties with
an outgoing message

### clear

```csharp
public void clear()
```

Clear all properties from this object.

### clear

```csharp
public void clear(string key)
```

Clear the property with the specified key from this object.

### set

```csharp
public void set(string key, byte value)
```

 Set a property to the provided byte value.
<param name="key">The name of the property to be set</param>
<param name="value">The value to be set</param>

### set

```csharp
public void set(string key, short value)
```

 Set a property to the provided short value.
<param name="key">The name of the property to be set</param>
<param name="value">The value to be set</param>

### set

```csharp
public void set(string key, int value)
```

 Set a property to the provided int value.
<param name="key">The name of the property to be set</param>
<param name="value">The value to be set</param>

### set

```csharp
public void set(string key, long value)
```

 Set a property to the provided long value.
<param name="key">The name of the property to be set</param>
<param name="value">The value to be set</param>

### set

```csharp
public void set(string key, float value)
```

 Set a property to the provided float value.
<param name="key">The name of the property to be set</param>
<param name="value">The value to be set</param>

### set

```csharp
public void set(string key, double value)
```

 Set a property to the provided double value.
<param name="key">The name of the property to be set</param>
<param name="value">The value to be set</param>

### set

```csharp
public void set(string key, bool value)
```

 Set a property to the provided boolean value.
<param name="key">The name of the property to be set</param>
<param name="value">The value to be set</param>

### set

```csharp
public void set(string key, string value)
```

 Set a property to the provided string value.
<param name="key">The name of the property to be set</param>
<param name="value">The value to be set</param>

### containsKey

```csharp
public bool containsKey(string key)
```

 Test if the specified key is contained in the properties object.
<param name="key">The name of the property </param>
<returns>True if the property has been set, False if the property isn't set.</returns>

### getBoolean

```csharp
public bool getBoolean(string key)
```

Get the property with the specified key as a boolean.
<param name="key">The name of the property</param>
<returns>The value of the property, converted to a boolean if necessary.</returns>

### getByte

```csharp
public byte getByte(string key)
```

Get the property with the specified key as a byte.
<param name="key">The name of the property</param>
<returns>The value of the property, converted to a byte if necessary.</returns>

### getShort

```csharp
public short getShort(string key)
```

Get the property with the specified key as a short.
<param name="key">The name of the property</param>
<returns>The value of the property, converted to a short if necessary.</returns>

### getInteger

```csharp
public int getInteger(string key)
```

Get the property with the specified key as a integer.
<param name="key">The name of the property</param>
<returns>The value of the property, converted to a integer if necessary.</returns>

### getLong

```csharp
public long getLong(string key)
```

Get the property with the specified key as a long.
<param name="key">The name of the property</param>
<returns>The value of the property, converted to a long if necessary.</returns>

### getFloat

```csharp
public float getFloat(string key)
```

Get the property with the specified key as a float.
<param name="key">The name of the property</param>
<returns>The value of the property, converted to a float if necessary.</returns>

### getDouble

```csharp
public double getDouble(string key)
```

Get the property with the specified key as a double.
<param name="key">The name of the property</param>
<returns>The value of the property, converted to a double if necessary.</returns>

### getString

```csharp
public string getString(string key)
```

Get the property with the specified key as a string.
<param name="key">The name of the property</param>
<returns>The value of the property, converted to a string if necessary.</returns>

### GetEnumerator

```csharp
public IEnumerator<LBMMessageProperty> GetEnumerator()
```

Get an enumerator.

## LBMMessageProperty

*class* `com.latencybusters.lbm.LBMMessageProperty`

### key

```csharp
public string key()
```

Retrieve the name of the property represented by this object.

### type

```csharp
public int type()
```

Retrieve the type of the property represented by this object.

### getBoolean

```csharp
public bool getBoolean()
```

Retrieve the value stored in this object as a bool. Only properties of
 type LBM.MSG_PROPERTY_BOOLEAN and LBM.MSG_PROPERTY_STRING can be retrieved as
a bool.

### getByte

```csharp
public byte getByte()
```

 Retrieve the value stored in this object as a byte. Only properties of
 type LBM.MSG_PROPERTY_BYTE and LBM.MSG_PROPERTY_STRING can be retrieved as
a byte.
<returns>The stored value, converted to a System.Byte.</returns>

### getShort

```csharp
public short getShort()
```

 Retrieve the value stored in this object as a short. Only properties of
 type LBM.MSG_PROPERTY_BYTE, LBM.MSG_PROPERTY_SHORT, and LBM.MSG_PROPERTY_STRING can be retrieved as
a short.
<returns>The stored value, converted to a System.Short.</returns>

### getInteger

```csharp
public int getInteger()
```

 Retrieve the value stored in this object as a integer. Only properties of
 type LBM.MSG_PROPERTY_BYTE, LBM.MSG_PROPERTY_SHORT, LBM.MSG_PROPERTY_INT, and
LBM.MSG_PROPERTY_STRING can be retrieved as a integer.
<returns>The stored value, converted to a System.Integer.</returns>

### getLong

```csharp
public long getLong()
```

 Retrieve the value stored in this object as a long. Only properties of
 type LBM.MSG_PROPERTY_BYTE, LBM.MSG_PROPERTY_SHORT, LBM.MSG_PROPERTY_INT, LBM.MSG_PROPERTY_LONG and
LBM.MSG_PROPERTY_STRING can be retrieved as a long.
<returns>The stored value, converted to a System.Long.</returns>

### getFloat

```csharp
public float getFloat()
```

 Retrieve the value stored in this object as a float. Only properties of
type LBM.MSG_PROPERTY_FLOAT and LBM.MSG_PROPERTY_STRING can be retrieved as
a float.
<returns>The stored value, converted to a System.Float.</returns>

### getDouble

```csharp
public double getDouble()
```

 Retrieve the value stored in this object as a double. Only properties of
type LBM.MSG_PROPERTY_FLOAT, LBM.MSG_PROPERTY_DOUBLE and LBM.MSG_PROPERTY_STRING can be retrieved as
a double.
<returns>The stored value, converted to a System.Double.</returns>

### getString

```csharp
public string getString()
```

 Retrieve the value stored in this object as a string. Any type may be retrieved as a string.
<returns>The stored value, converted to a System.String.</returns>

## LBMMessageReclamationCallback

*delegate* `com.latencybusters.lbm.LBMMessageReclamationCallback`

### LBMMessageReclamationCallback

```csharp
public delegate void LBMMessageReclamationCallback(object cbArg, string topic, long seqnum)
```

Forced message reclamation callback delegate (UME only).

<remarks>
This callback is invoked when retained UME source messages
are forcibly reclaimed.
</remarks>
<param name="cbArg">Callback object token</param>
<param name="topic">Name of the topic for the reclaimed message</param>
<param name="seqnum">Sequence number of the message that is reclaimed</param>

## LBMMonitor

*class* `com.latencybusters.lbm.LBMMonitor`

### errorNumber

```csharp
public static int errorNumber()
```

Returns last LBM Monitor error number

<returns>LBM Monitor error number</returns>

### errorMessage

```csharp
public static string errorMessage()
```

Returns last LBM Monitor error message

<returns>LBM Monitor error message</returns>

## LBMMonitorContextStatisticsCallback

*delegate* `com.latencybusters.lbm.LBMMonitorContextStatisticsCallback`

### LBMMonitorContextStatisticsCallback

```csharp
public delegate void LBMMonitorContextStatisticsCallback(LBMContextStatistics lbmctxstats)
```

Received context statistics callback delegate

<param name="lbmctxstats">LBMContextStatistics object encapsulating
the received context statistics</param>

## LBMMonitorEAgainException

*class* `com.latencybusters.lbm.LBMMonitorEAgainException`

### LBMMonitorEAgainException

```csharp
public LBMMonitorEAgainException(string errorMessage) : base(LBMMonitor.EAGAIN, errorMessage)
```

Instantiate LBMMonitorEAgainException class

<param name="errorMessage">Exception error message</param>

## LBMMonitorEAlreadyException

*class* `com.latencybusters.lbm.LBMMonitorEAlreadyException`

### LBMMonitorEAlreadyException

```csharp
public LBMMonitorEAlreadyException(string errorMessage) : base(LBMMonitor.EALREADY, errorMessage)
```

Instantiate LBMMonitorEAlreadyException class

<param name="errorMessage">Exception error message</param>

## LBMMonitorEInvalException

*class* `com.latencybusters.lbm.LBMMonitorEInvalException`

### LBMMonitorEInvalException

```csharp
public LBMMonitorEInvalException(string errorMessage) : base(LBMMonitor.EINVAL, errorMessage)
```

Instantiate LBMMonitorEInvalException class

<param name="errorMessage">Exception error message</param>

## LBMMonitorELBMFailException

*class* `com.latencybusters.lbm.LBMMonitorELBMFailException`

### LBMMonitorELBMFailException

```csharp
public LBMMonitorELBMFailException(string errorMessage) : base(LBMMonitor.ELBMFAIL, errorMessage)
```

Instantiate LBMMonitorELBMFailException class

<param name="errorMessage">Exception error message</param>

## LBMMonitorEModFailException

*class* `com.latencybusters.lbm.LBMMonitorEModFailException`

### LBMMonitorEModFailException

```csharp
public LBMMonitorEModFailException(string errorMessage) : base(LBMMonitor.EMODFAIL, errorMessage)
```

Instantiate LBMMonitorEModFailException class

<param name="errorMessage">Exception error message</param>

## LBMMonitorENoMemException

*class* `com.latencybusters.lbm.LBMMonitorENoMemException`

### LBMMonitorENoMemException

```csharp
public LBMMonitorENoMemException(string errorMessage) : base(LBMMonitor.ENOMEM, errorMessage)
```

Instantiate LBMMonitorENoMemException class

<param name="errorMessage">Exception error message</param>

## LBMMonitorEventQueueStatisticsCallback

*delegate* `com.latencybusters.lbm.LBMMonitorEventQueueStatisticsCallback`

### LBMMonitorEventQueueStatisticsCallback

```csharp
public delegate void LBMMonitorEventQueueStatisticsCallback(LBMEventQueueStatistics lbmevqstats)
```

Received event queue statistics callback delegate

<param name="lbmevqstats">LBMEventQueueStatistics object encapsulating
the received event queue statistics</param>

## LBMMonitorImmediateMessageReceiverStatisticsCallback

*delegate* `com.latencybusters.lbm.LBMMonitorImmediateMessageReceiverStatisticsCallback`

### LBMMonitorImmediateMessageReceiverStatisticsCallback

```csharp
public delegate void LBMMonitorImmediateMessageReceiverStatisticsCallback(LBMImmediateMessageReceiverStatistics lbmimrcvstats)
```

Received immediate message receiver statistics callback delegate.

<param name="lbmimrcvstats">LBMImmediateMessageReceiverStatistics object
encapsulating the received immediate message receiver statistics.</param>

## LBMMonitorImmediateMessageSourceStatisticsCallback

*delegate* `com.latencybusters.lbm.LBMMonitorImmediateMessageSourceStatisticsCallback`

### LBMMonitorImmediateMessageSourceStatisticsCallback

```csharp
public delegate void LBMMonitorImmediateMessageSourceStatisticsCallback(LBMImmediateMessageSourceStatistics lbmimsrcstats)
```

Received immediate message source statistics callback delegate.

<param name="lbmimsrcstats">LBMImmediateMessageSourceStatistics object
encapsulating the received immediate message source statistics.</param>

## LBMMonitorReceiver

*class* `com.latencybusters.lbm.LBMMonitorReceiver`

### LBMMonitorReceiver

```csharp
public LBMMonitorReceiver(int formatter, string formatOpts, int transport, string transportOpts)
```

Create an LBM Monitoring Receiver Controller.
This creates an instance of an LBM Monitoring Receive
Controller.

<exception ref="com.latencybusters.lbm.LBMEInvalException">Unsupported format type</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Unsupported transport type</exception>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="formatter">Format module type</param>
<param name="formatOpts">A block of data which is passed to
the format module's initialization function. This may be
used to pass configuration options to the format module.
</param>
<param name="transport">Transport module type</param>
<param name="transportOpts">A block of data which is passed
to the transport module's initialization function. This may
be used to pass configuration options to the transport
module.
</param>

### LBMMonitorReceiver

```csharp
public LBMMonitorReceiver(int formatter, string formatOpts, int transport, string transportOpts, LBMObjectRecyclerBase recycler, Object objRecCbArg): this(formatter, formatOpts, transport, transportOpts)
```

Create an LBM Monitoring Receiver Controller.
This creates an instance of an LBM Monitoring Receive
Controller.

<exception ref="com.latencybusters.lbm.LBMEInvalException">Unsupported format type</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Unsupported transport type</exception>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="formatter">Format module type</param>
<param name="formatOpts">A block of data which is passed to
the format module's initialization function. This may be
used to pass configuration options to the format module.
</param>
<param name="transport">Transport module type</param>
<param name="transportOpts">A block of data which is passed
to the transport module's initialization function. This may
be used to pass configuration options to the transport
module.
</param>
<param name="recycler">an object recycler to handle recycling stats objects. Only the last callback
should call the doneWith method to return the stat object back to the recycler.</param>
<param name="objRecCbArg">a callback object token that will be passed to the recycler (normally null is used)</param>

### close

```csharp
public void close()
```

Close and dispose of this monitor receiver

### addStatisticsCallback

```csharp
public void addStatisticsCallback(LBMMonitorSourceStatisticsCallback cb)
```

Register source statistics callbacks

<remarks>
<seealso cref="LBMMonitorSourceStatisticsCallback"/>
<seealso cref="removeStatisticsCallback(LBMMonitorSourceStatisticsCallback)"/>
</remarks>
<param name="cb">Callback implementing the
LBMMonitorSourceStatisticsCallback delegate interface</param>

### addStatisticsCallback

```csharp
public void addStatisticsCallback(LBMMonitorReceiverStatisticsCallback cb)
```

Register receiver statistics callbacks

<remarks>
<seealso cref="LBMMonitorReceiverStatisticsCallback"/>
<seealso cref="removeStatisticsCallback(LBMMonitorReceiverStatisticsCallback)"/>
</remarks>
<param name="cb">Callback implementing the
LBMMonitorReceiverStatisticsCallback delegate interface</param>

### addStatisticsCallback

```csharp
public void addStatisticsCallback(LBMMonitorEventQueueStatisticsCallback cb)
```

Register event queue statistics callbacks

<remarks>
<seealso cref="LBMMonitorEventQueueStatisticsCallback"/>
<seealso cref="removeStatisticsCallback(LBMMonitorEventQueueStatisticsCallback)"/>
</remarks>
<param name="cb">Callback implementing the
LBMMonitorEventQueueStatisticsCallback delegate interface</param>

### addStatisticsCallback

```csharp
public void addStatisticsCallback(LBMMonitorContextStatisticsCallback cb)
```

Register context statistics callbacks

<remarks>
<seealso cref="LBMMonitorContextStatisticsCallback"/>
<seealso cref="removeStatisticsCallback(LBMMonitorContextStatisticsCallback)"/>
</remarks>
<param name="cb">Callback implementing the
LBMMonitorContextStatisticsCallback delegate interface</param>

### addStatisticsCallback

```csharp
public void addStatisticsCallback(LBMMonitorImmediateMessageSourceStatisticsCallback cb)
```

Register immediate message source statistics callbacks

<remarks>
<seealso cref="LBMMonitorImmediateMessageSourceStatisticsCallback"/>
<seealso cref="removeStatisticsCallback(LBMMonitorImmediateMessageSourceStatisticsCallback)"/>
</remarks>
<param name="cb">Callback implementing the
LBMMonitorImmediateMessageSourceStatisticsCallback delegate interface</param>

### addStatisticsCallback

```csharp
public void addStatisticsCallback(LBMMonitorImmediateMessageReceiverStatisticsCallback cb)
```

Register immediate message receiver statistics callbacks

<remarks>
<seealso cref="LBMMonitorImmediateMessageReceiverStatisticsCallback"/>
<seealso cref="removeStatisticsCallback(LBMMonitorImmediateMessageReceiverStatisticsCallback)"/>
</remarks>
<param name="cb">Callback implementing the
LBMMonitorImmediateMessageReceiverStatisticsCallback delegate interface</param>

### addStatisticsCallback

```csharp
public void addStatisticsCallback(LBMMonitorSourceStatisticsCallback scb, LBMMonitorReceiverStatisticsCallback rcb)
```

Register statistics callbacks

<remarks>
<seealso cref="LBMMonitorSourceStatisticsCallback"/>
<seealso cref="LBMMonitorReceiverStatisticsCallback"/>
<seealso cref="removeStatisticsCallback(LBMMonitorSourceStatisticsCallback, LBMMonitorReceiverStatisticsCallback)"/>
</remarks>
<param name="scb">Callback implementing the
LBMMonitorSourceStatisticsCallback delegate interface</param>
<param name="rcb">Callback implementing the
LBMMonitorReceiverStatisticsCallback delegate interface</param>

### addStatisticsCallback

```csharp
public void addStatisticsCallback(LBMMonitorSourceStatisticsCallback scb, LBMMonitorReceiverStatisticsCallback rcb, LBMMonitorEventQueueStatisticsCallback evqcb, LBMMonitorContextStatisticsCallback ctxcb)
```

Register statistics callbacks

<remarks>
<seealso cref="LBMMonitorSourceStatisticsCallback"/>
<seealso cref="LBMMonitorReceiverStatisticsCallback"/>
<seealso cref="LBMMonitorEventQueueStatisticsCallback"/>
<seealso cref="LBMMonitorContextStatisticsCallback"/>
<seealso cref="removeStatisticsCallback(LBMMonitorSourceStatisticsCallback, LBMMonitorReceiverStatisticsCallback, LBMMonitorEventQueueStatisticsCallback, LBMMonitorContextStatisticsCallback)"/>
</remarks>
<param name="scb">Callback implementing the
LBMMonitorSourceStatisticsCallback delegate interface</param>
<param name="rcb">Callback implementing the
LBMMonitorReceiverStatisticsCallback delegate interface</param>
<param name="evqcb">Callback implementing the
LBMMonitorEventQueueStatisticsCallback delegate interface</param>
<param name="ctxcb">Callback implementing the
LBMMonitorContextStatisticsCallback delegate interface</param>

### removeStatisticsCallback

```csharp
public void removeStatisticsCallback(LBMMonitorSourceStatisticsCallback cb)
```

Deregister a previously registered source statistics callback.

<remarks>
<seealso cref="LBMMonitorSourceStatisticsCallback"/>
<seealso cref="addStatisticsCallback(LBMMonitorSourceStatisticsCallback)"/>
</remarks>
<param name="cb">Previously registered callback implementing
the LBMMonitorSourceStatisticsCallback delegate interface
</param>

### removeStatisticsCallback

```csharp
public void removeStatisticsCallback(LBMMonitorReceiverStatisticsCallback cb)
```

Deregister a previously registered receiver statistics
callback.

<remarks>
<seealso cref="LBMMonitorReceiverStatisticsCallback"/>
<seealso cref="addStatisticsCallback(LBMMonitorReceiverStatisticsCallback)"/>
</remarks>
<param name="cb">Previously registered callback implementing
the LBMMonitorReceiverStatisticsCallback delegate interface
</param>

### removeStatisticsCallback

```csharp
public void removeStatisticsCallback(LBMMonitorEventQueueStatisticsCallback cb)
```

Deregister a previously registered event queue statistics
callback.

<remarks>
<seealso cref="LBMMonitorEventQueueStatisticsCallback"/>
<seealso cref="addStatisticsCallback(LBMMonitorEventQueueStatisticsCallback)"/>
</remarks>
<param name="cb">Previously registered callback implementing
the LBMMonitorEventQueueStatisticsCallback delegate interface
</param>

### removeStatisticsCallback

```csharp
public void removeStatisticsCallback(LBMMonitorContextStatisticsCallback cb)
```

Deregister a previously registered context statistics
callback.

<remarks>
<seealso cref="LBMMonitorContextStatisticsCallback"/>
<seealso cref="addStatisticsCallback(LBMMonitorContextStatisticsCallback)"/>
</remarks>
<param name="cb">Previously registered callback implementing
the LBMMonitorContextStatisticsCallback delegate interface
</param>

### removeStatisticsCallback

```csharp
public void removeStatisticsCallback(LBMMonitorImmediateMessageSourceStatisticsCallback cb)
```

Deregister a previously registered immediate message
source statistics callback.

<remarks>
<seealso cref="LBMMonitorImmediateMessageSourceStatisticsCallback"/>
<seealso cref="addStatisticsCallback(LBMMonitorImmediateMessageSourceStatisticsCallback)"/>
</remarks>
<param name="cb">Previously registered callback implementing
the LBMMonitorImmediateMessageSourceStatisticsCallback delegate interface
</param>

### removeStatisticsCallback

```csharp
public void removeStatisticsCallback(LBMMonitorImmediateMessageReceiverStatisticsCallback cb)
```

Deregister a previously registered immediate message
receiver statistics callback.

<remarks>
<seealso cref="LBMMonitorImmediateMessageReceiverStatisticsCallback"/>
<seealso cref="addStatisticsCallback(LBMMonitorImmediateMessageReceiverStatisticsCallback)"/>
</remarks>
<param name="cb">Previously registered callback implementing
the LBMMonitorImmediateMessageReceiverStatisticsCallback delegate interface
</param>

### removeStatisticsCallback

```csharp
public void removeStatisticsCallback(LBMMonitorSourceStatisticsCallback scb, LBMMonitorReceiverStatisticsCallback rcb)
```

Deregister previously registered statistics callbacks.

<remarks>
<seealso cref="LBMMonitorSourceStatisticsCallback"/>
<seealso cref="LBMMonitorReceiverStatisticsCallback"/>
<seealso cref="addStatisticsCallback(LBMMonitorSourceStatisticsCallback, LBMMonitorReceiverStatisticsCallback)"/>
</remarks>
<param name="scb">Previously registered callback implementing
the LBMMonitorSourceStatisticsCallback delegate interface
</param>
<param name="rcb">Previously registered callback implementing
the LBMMonitorReceiverStatisticsCallback delegate interface
</param>

### removeStatisticsCallback

```csharp
public void removeStatisticsCallback(LBMMonitorSourceStatisticsCallback scb, LBMMonitorReceiverStatisticsCallback rcb, LBMMonitorEventQueueStatisticsCallback evqcb, LBMMonitorContextStatisticsCallback ctxcb)
```

Deregister previously registered statistics callbacks.

<remarks>
<seealso cref="LBMMonitorSourceStatisticsCallback"/>
<seealso cref="LBMMonitorReceiverStatisticsCallback"/>
<seealso cref="LBMMonitorEventQueueStatisticsCallback"/>
<seealso cref="LBMMonitorContextStatisticsCallback"/>
<seealso cref="addStatisticsCallback(LBMMonitorSourceStatisticsCallback, LBMMonitorReceiverStatisticsCallback, LBMMonitorEventQueueStatisticsCallback, LBMMonitorContextStatisticsCallback)"/>
</remarks>
<param name="scb">Previously registered callback implementing
the LBMMonitorSourceStatisticsCallback delegate interface
</param>
<param name="rcb">Previously registered callback implementing
the LBMMonitorReceiverStatisticsCallback delegate interface
</param>
<param name="evqcb">Previously registered callback implementing
the LBMMonitorEventQueueStatisticsCallback delegate interface</param>
<param name="ctxcb">Previously registered callback implementing
the LBMMonitorContextStatisticsCallback delegate interface</param>

### Dispose

```csharp
public void Dispose()
```

Same as <see cref="close"/>

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks><seealso cref="close"/></remarks>

## LBMMonitorReceiverStatisticsCallback

*delegate* `com.latencybusters.lbm.LBMMonitorReceiverStatisticsCallback`

### LBMMonitorReceiverStatisticsCallback

```csharp
public delegate void LBMMonitorReceiverStatisticsCallback(LBMReceiverStatistics lbmrcvstats)
```

Received receiver statistics callback delegate

<param name="lbmrcvstats">LBMReceiverStatistics object encapsulating
the received receiver statistics</param>

## LBMMonitorSource

*class* `com.latencybusters.lbm.LBMMonitorSource`

### LBMMonitorSource

```csharp
public LBMMonitorSource(int formatter, string formatOpts, int transport, string transportOpts)
```

Create an LBM Monitoring Source Controller.
This creates an instance of an LBM Monitoring Source
Controller.

<exception ref="com.latencybusters.lbm.LBMEInvalException">Unsupported format type</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Unsupported transport type</exception>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="formatter">Format module type</param>
<param name="formatOpts">A block of data which is passed to
the format module's initialization function. This may be
used to pass configuration options to the format module.
</param>
<param name="transport">Transport module type</param>
<param name="transportOpts">A block of data which is passed
to the transport module's initialization function. This may
be used to pass configuration options to the transport
module.
</param>

### close

```csharp
public void close()
```

Close and dispose of this monitor source

### start

```csharp
public void start(LBMContext lbmctx, String appSourceId, int secs)
```

Register a context for monitoring.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Monitoring may be done at regular intervals, specified by
the secs parameter. As an alternative, passing zero for secs
will not automatically monitor the context, but instead
require an explicit call to the sample() method.
<para>
If monitoring is to be used as a form of heartbeat, the
preferred method is to call the sample() method from a
context thread or event queue timer callback. This ensures
that the object actually processing the messages is the
one generating the monitoring statistics, guaranteeing that
it is truly acting as a heartbeat mechanism.
</para>
</remarks>
<param name="lbmctx">LBMContext to be monitored</param>
<param name="appSourceId">String containing an
application-specified source identifier. If null or an
empty string is passed, the application name will be used.
</param>
<param name="secs">Interval (in seconds) at which monitoring
information will be gathered and sent. If zero, the context
will not be automatically monitored, but instead will be
monitored upon a call to the sample() method.</param>

### start

```csharp
public void start(LBMReceiver lbmrcv, String appSourceId, int secs)
```

Register a receiver for monitoring.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Monitoring may be done at regular intervals, specified by
the secs parameter. As an alternative, passing zero for
secs will not automatically monitor the context, but instead
require an explicit call to the sample() method.
<para>
If monitoring is to be used as a form of heartbeat, the
preferred method is to call the sample() method from a
context thread or event queue timer callback. This ensures
that the object actually processing the messages is the one
generating the monitoring statistics, guaranteeing that it
is truly acting as a heartbeat mechanism.
</para>
</remarks>
<param name="lbmrcv">LBMReceiver to be monitored</param>
<param name="appSourceId">String containing an
application-specified source identifier. If null or an empty
string is passed, the application name will be used.</param>
<param name="secs">Interval (in seconds) at which monitoring
information will be gathered and sent. If zero, the receiver
will not be automatically monitored, but instead will be
monitored upon a call to the sample() method.</param>

### start

```csharp
public void start(LBMHFXReceiver lbmrcv, String appSourceId, int secs)
```

Register a HFX receiver for monitoring.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Monitoring may be done at regular intervals, specified by
the secs parameter. As an alternative, passing zero for
secs will not automatically monitor the context, but instead
require an explicit call to the sample() method.
<para>
If monitoring is to be used as a form of heartbeat, the
preferred method is to call the sample() method from a
context thread or event queue timer callback. This ensures
that the object actually processing the messages is the one
generating the monitoring statistics, guaranteeing that it
is truly acting as a heartbeat mechanism.
</para>
</remarks>
<param name="lbmrcv">LBMHFXReceiver to be monitored</param>
<param name="appSourceId">String containing an
application-specified source identifier. If null or an empty
string is passed, the application name will be used.</param>
<param name="secs">Interval (in seconds) at which monitoring
information will be gathered and sent. If zero, the receiver
will not be automatically monitored, but instead will be
monitored upon a call to the sample() method.</param>

### start

```csharp
public void start(LBMSource lbmsrc, String appSourceId, int secs)
```

Register a source for monitoring.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Monitoring may be done at regular intervals, specified by
the secs parameter. As an alternative, passing zero for secs
will not automatically monitor the source, but instead
require an explicit call to the sample() method.
<para>
If monitoring is to be used as a form of heartbeat, the
preferred method is to call the sample() method from a
context thread or event queue timer callback. This ensures
that the object actually processing the messages is the one
generating the monitoring statistics, guaranteeing that it
is truly acting as a heartbeat mechanism.
</para>
</remarks>
<param name="lbmsrc">LBMSource to be monitored</param>
<param name="appSourceId">String containing an
application-specified source identifier. If null or an empty
string is passed, the application name will be used.</param>
<param name="secs">Interval (in seconds) at which monitoring
information will be gathered and sent. If zero, the source
will not be automatically monitored, but instead will be
monitored upon a call to the sample() method.</param>

### start

```csharp
public void start(LBMEventQueue lbmevq, String appSourceId, int secs)
```

Register an event queue for monitoring.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Monitoring may be done at regular intervals, specified by
the secs parameter. As an alternative, passing zero for secs
will not automatically monitor the event queue, but instead
require an explicit call to the sample() method.
<para>
If monitoring is to be used as a form of heartbeat, the
preferred method is to call the sample() method from a
context thread or event queue timer callback. This ensures
that the object actually processing the messages is the one
generating the monitoring statistics, guaranteeing that it
is truly acting as a heartbeat mechanism.
</para>
</remarks>
<param name="lbmevq">LBMEventQueue to be monitored</param>
<param name="appSourceId">String containing an
application-specified source identifier. If null or an empty
string is passed, the application name will be used.</param>
<param name="secs">Interval (in seconds) at which monitoring
information will be gathered and sent. If zero, the event queue
will not be automatically monitored, but instead will be
monitored upon a call to the sample() method.</param>

### stop

```csharp
public void stop(LBMContext lbmctx)
```

Terminate monitoring for a context.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Unregister a context to prevent further monitoring of that
context.
</remarks>
<param name="lbmctx">Previously registered LBMContext</param>

### stop

```csharp
public void stop(LBMReceiver lbmrcv)
```

Terminate monitoring for a receiver.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Unregister a receiver to prevent further monitoring of that
receiver.
</remarks>
<param name="lbmrcv">Previously registered LBMReceiver</param>

### stop

```csharp
public void stop(LBMSource lbmsrc)
```

Terminate monitoring for a source.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Unregister a source to prevent further monitoring of that
source.
</remarks>
<param name="lbmsrc">Previously registered LBMSource</param>

### stop

```csharp
public void stop(LBMEventQueue lbmevq)
```

Terminate monitoring for an event queue.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
Unregister an event queue to prevent further monitoring of that
source.
</remarks>
<param name="lbmevq">Previously registered LBMEventQueue</param>

### sample

```csharp
public void sample()
```

Gather statistics for on-demand objects.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### Dispose

```csharp
public void Dispose()
```

Same as <see cref="close"/>

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks><seealso cref="close"/></remarks>

## LBMMonitorSourceStatisticsCallback

*delegate* `com.latencybusters.lbm.LBMMonitorSourceStatisticsCallback`

### LBMMonitorSourceStatisticsCallback

```csharp
public delegate void LBMMonitorSourceStatisticsCallback(LBMSourceStatistics lbmsrcstats)
```

Received source statistics callback delegate

<param name="lbmsrcstats">LBMSourceStatistics object encapsulating
the received source statistics</param>

## LBMNewTransportInfo

*class* `com.latencybusters.lbm.LBMNewTransportInfo`

### LBMNewTransportInfo

```csharp
public LBMNewTransportInfo()
```

Creates an LBMNewTransportInfo object and initializes all values to 0.

### flags

```csharp
public uint flags()
```

Currently unused.

<returns>A uint representing an OR'd set of currently set flags.</returns>

### setFlags

```csharp
public void setFlags(uint flags)
```

Currently unused.

<param name="flags">Flags.</param>

### getTransportSourceInfo

```csharp
public LBMTransportSourceInfo getTransportSourceInfo()
```

Returns an object that contains a description of the transport.

<returns>An LBMTransportSourceInfo object</returns>

### setTransportSourceInfo

```csharp
public void setTransportSourceInfo(LBMTransportSourceInfo transportSourceInfo)
```

Sets the transport source information object.

<param name="transportSourceInfo">An LBMTransportSourceInfo object</param>

### getSourceString

```csharp
public String getSourceString()
```

Returns an object that contains a source string.

<returns>A string representing the source</returns>

### setSourceString

```csharp
public void setSourceString(String sourceString)
```

Sets the source string.

<param name="sourceString">A string representing the source</param>

## LBMObjectRecycler

*class* `com.latencybusters.lbm.LBMObjectRecycler`

### setLocalMsgPoolSize

```csharp
public void setLocalMsgPoolSize(int size)
```

Sets the size of the thread local pool of LBMMessages for all LBMObjectRecyclers
(defaults to 1000)

<param name="size">the size of the local pool</param>

### setSharedMsgPoolSize

```csharp
public void setSharedMsgPoolSize(int size)
```

Sets the size of the shared pool of LBMMessages for all LBMObjectRecyclers
(defaults to 2000)

<param name="size">the size of the shared pool</param>

### doneWithMessage

```csharp
public override void doneWithMessage(LBMMessage obj)
```

Call when finished with a LBMMessage object.  Call dispose on the message object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.

<param name="obj">The message object</param>

### retrieveMessage

```csharp
public override LBMMessage retrieveMessage(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>A valid stats object will be returned</returns>

### getLocalPoolMessageCount

```csharp
public int getLocalPoolMessageCount()
```

Gets the current number of objects in the local pool.

<returns>The number of objects</returns>

### returnAllMessagesToSharedPool

```csharp
public int returnAllMessagesToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).

<returns>The number of objects actually returned</returns>

### setLocalRcvStatsPoolSize

```csharp
public void setLocalRcvStatsPoolSize(int size)
```

Sets the size of the thread local pool of LBMReceiverStatistics for all LBMObjectRecyclers
(defaults to 10)

<param name="size">the size of the local pool</param>

### setSharedRcvStatsPoolSize

```csharp
public void setSharedRcvStatsPoolSize(int size)
```

Sets the size of the shared pool of LBMReceiverStatistics for all LBMObjectRecyclers
(defaults to 20)

<param name="size">the size of the shared pool</param>

### doneWithReceiverStatistics

```csharp
public override void doneWithReceiverStatistics(LBMReceiverStatistics obj)
```

Call when finished with a LBMReceiverStatistics object.  Do not call dispose on the stats object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.

<param name="obj">The stats object</param>

### retrieveReceiverStatistics

```csharp
public override LBMReceiverStatistics retrieveReceiverStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>A valid stats object will be returned></returns>

### getLocalPoolReceiverStatisticsCount

```csharp
public int getLocalPoolReceiverStatisticsCount()
```

Gets the current number of objects in the local pool.

<returns>The number of objects</returns>

### returnAllReceiverStatisticsToSharedPool

```csharp
public int returnAllReceiverStatisticsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).

<returns>The number of objects actually returned</returns>

### setLocalSrcStatsPoolSize

```csharp
public void setLocalSrcStatsPoolSize(int size)
```

Sets the size of the thread local pool of LBMSourceStatistics for all LBMObjectRecyclers
(defaults to 10)

<param name="size">the size of the local pool</param>

### setSharedSrcStatsPoolSize

```csharp
public void setSharedSrcStatsPoolSize(int size)
```

Sets the size of the shared pool of LBMSourceStatistics for all LBMObjectRecyclers
(defaults to 20)

<param name="size">the size of the shared pool</param>

### doneWithSourceStatistics

```csharp
public override void doneWithSourceStatistics(LBMSourceStatistics obj)
```

Call when finished with a LBMSourceStatistics object.  Do not call dispose on the stats object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.

<param name="obj">The stats object</param>

### retrieveSourceStatistics

```csharp
public override LBMSourceStatistics retrieveSourceStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>A valid stats object will be returned</returns>

### getLocalPoolSourceStatisticsCount

```csharp
public int getLocalPoolSourceStatisticsCount()
```

Gets the current number of objects in the local pool.

<returns>The number of objects</returns>

### returnAllSourceStatisticsToSharedPool

```csharp
public int returnAllSourceStatisticsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).

<returns>The number of objects actually returned</returns>

### setLocalCtxStatsPoolSize

```csharp
public void setLocalCtxStatsPoolSize(int size)
```

Sets the size of the thread local pool of LBMContextStatistics for all LBMObjectRecyclers
(defaults to 10)

<param name="size">the size of the local pool</param>

### setSharedCtxStatsPoolSize

```csharp
public void setSharedCtxStatsPoolSize(int size)
```

Sets the size of the shared pool of LBMContextStatistics for all LBMObjectRecyclers
(defaults to 20)

<param name="size">the size of the shared pool</param>

### doneWithContextStatistics

```csharp
public override void doneWithContextStatistics(LBMContextStatistics obj)
```

Call when finished with a LBMContextStatistics object.  Do not call dispose on the stats object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.

<param name="obj">The stats object</param>

### retrieveContextStatistics

```csharp
public override LBMContextStatistics retrieveContextStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>A valid stats object will be returned</returns>

### getLocalPoolContextStatisticsCount

```csharp
public int getLocalPoolContextStatisticsCount()
```

Gets the current number of objects in the local pool.

<returns>The number of objects</returns>

### returnAllContextStatisticsToSharedPool

```csharp
public int returnAllContextStatisticsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).

<returns>The number of objects actually returned</returns>

### setLocalIMRcvStatsPoolSize

```csharp
public void setLocalIMRcvStatsPoolSize(int size)
```

Sets the size of the thread local pool of LBMImmediateMessageReceiverStatistics for all LBMObjectRecyclers
(defaults to 10)

<param name="size">the size of the local pool</param>

### setSharedIMRcvStatsPoolSize

```csharp
public void setSharedIMRcvStatsPoolSize(int size)
```

Sets the size of the shared pool of LBMImmediateMessageReceiverStatistics for all LBMObjectRecyclers
(defaults to 20)

<param name="size">the size of the shared pool</param>

### doneWithImmediateMessageReceiverStatistics

```csharp
public override void doneWithImmediateMessageReceiverStatistics(LBMImmediateMessageReceiverStatistics obj)
```

Call when finished with a LBMImmediateMessageReceiverStatistics object.  Do not call dispose on the stats object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.

<param name="obj">The stats object</param>

### retrieveImmediateMessageReceiverStatistics

```csharp
public override LBMImmediateMessageReceiverStatistics retrieveImmediateMessageReceiverStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>A valid stats object will be returned</returns>

### getLocalPoolImmediateMessageReceiverStatisticsCount

```csharp
public int getLocalPoolImmediateMessageReceiverStatisticsCount()
```

Gets the current number of objects in the local pool.

<returns>The number of objects</returns>

### returnAllImmediateMessageReceiverStatisticsToSharedPool

```csharp
public int returnAllImmediateMessageReceiverStatisticsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).

<returns>The number of objects actually returned</returns>

### setLocalIMSrcStatsPoolSize

```csharp
public void setLocalIMSrcStatsPoolSize(int size)
```

Sets the size of the thread local pool of LBMImmediateMessageSourceStatistics for all LBMObjectRecyclers
(defaults to 10)

<param name="size">the size of the local pool</param>

### setSharedIMSrcStatsPoolSize

```csharp
public void setSharedIMSrcStatsPoolSize(int size)
```

Sets the size of the shared pool of LBMImmediateMessageSourceStatistics for all LBMObjectRecyclers
(defaults to 20)

<param name="size">the size of the shared pool</param>

### doneWithImmediateMessageSourceStatistics

```csharp
public override void doneWithImmediateMessageSourceStatistics(LBMImmediateMessageSourceStatistics obj)
```

Call when finished with a LBMImmediateMessageSourceStatistics object.  Do not call dispose on the stats object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.

<param name="obj">the stats object</param>

### retrieveImmediateMessageSourceStatistics

```csharp
public override LBMImmediateMessageSourceStatistics retrieveImmediateMessageSourceStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>A valid stats object will be returned</returns>

### getLocalPoolImmediateMessageSourceStatisticsCount

```csharp
public int getLocalPoolImmediateMessageSourceStatisticsCount()
```

Gets the current number of objects in the local pool.

<returns>The number of objects</returns>

### returnAllImmediateMessageSourceStatisticsToSharedPool

```csharp
public int returnAllImmediateMessageSourceStatisticsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).

<returns>The number of objects actually returned</returns>

### setLocalEvqStatsPoolSize

```csharp
public void setLocalEvqStatsPoolSize(int size)
```

Sets the size of the thread local pool of LBMEventQueueStatistics for all LBMObjectRecyclers
(defaults to 10)

<param name="size">the size of the local pool</param>

### setSharedEvqStatsPoolSize

```csharp
public void setSharedEvqStatsPoolSize(int size)
```

Sets the size of the shared pool of LBMEventQueueStatistics for all LBMObjectRecyclers
(defaults to 20)

<param name="size">the size of the shared pool</param>

### doneWithEventQueueStatistics

```csharp
public override void doneWithEventQueueStatistics(LBMEventQueueStatistics obj)
```

Call when finished with a LBMEventQueueStatistics object.  Do not call dispose on the stats object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.

<param name="obj">The stats object</param>

### retrieveEventQueueStatistics

```csharp
public override LBMEventQueueStatistics retrieveEventQueueStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>A valid stats object will be returned</returns>

### getLocalPoolEventQueueStatisticsCount

```csharp
public int getLocalPoolEventQueueStatisticsCount()
```

Gets the current number of objects in the local pool.

<returns>The number of objects</returns>

### returnAllEventQueueStatisticsToSharedPool

```csharp
public int returnAllEventQueueStatisticsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).

<returns>The number of objects actually returned</returns>

### setLocalSrcEvsPoolSize

```csharp
public void setLocalSrcEvsPoolSize(int size)
```

Sets the size of the thread local pool of LBMSourceEvents for all LBMObjectRecyclers
(defaults to 10)

<param name="size">the size of the local pool</param>

### setSharedSrcEvsPoolSize

```csharp
public void setSharedSrcEvsPoolSize(int size)
```

Sets the size of the shared pool of LBMSourceEvents for all LBMObjectRecyclers
(defaults to 20)

<param name="size">the size of the shared pool</param>

### doneWithSourceEvent

```csharp
public override void doneWithSourceEvent(LBMSourceEvent obj)
```

Call when finished with a LBMSourceEvent object. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.

<param name="obj">The source event object</param>

### retrieveSourceEvent

```csharp
public override LBMSourceEvent retrieveSourceEvent(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>A valid source event object will be returned</returns>

### getLocalPoolSourceEventCount

```csharp
public int getLocalPoolSourceEventCount()
```

Gets the current number of objects in the local pool.

<returns>The number of objects</returns>

### returnAllSourceEventsToSharedPool

```csharp
public int returnAllSourceEventsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).

<returns>The number of objects actually returned</returns>

### setLocalCtxSrcEvsPoolSize

```csharp
public void setLocalCtxSrcEvsPoolSize(int size)
```

Sets the size of the thread local pool of LBMContextSourceEvents for all LBMObjectRecyclers
(defaults to 10)

<param name="size">the size of the local pool</param>

### setSharedCtxSrcEvsPoolSize

```csharp
public void setSharedCtxSrcEvsPoolSize(int size)
```

Sets the size of the shared pool of LBMContextSourceEvents for all LBMObjectRecyclers
(defaults to 20)

<param name="size">the size of the shared pool</param>

### doneWithContextSourceEvent

```csharp
public override void doneWithContextSourceEvent(LBMContextSourceEvent obj)
```

Call when finished with a LBMContextSourceEvent object. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.

<param name="obj">The context source event object</param>

### retrieveContextSourceEvent

```csharp
public override LBMContextSourceEvent retrieveContextSourceEvent(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>A valid context source event object will be returned</returns>

### getLocalPoolContextSourceEventCount

```csharp
public int getLocalPoolContextSourceEventCount()
```

Gets the current number of objects in the local pool.

<returns>The number of objects</returns>

### returnAllContextSourceEventsToSharedPool

```csharp
public int returnAllContextSourceEventsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).

<returns>The number of objects actually returned</returns>

### close

```csharp
public override void close()
```

A method to clean up all objects referenced by the recycler when the application is closing
(which will dispose all of the stats objects in the recycler).

## LBMObjectRecyclerBase

*class* `com.latencybusters.lbm.LBMObjectRecyclerBase`

### doneWithMessage

```csharp
public virtual void doneWithMessage(LBMMessage obj)
```

If dispose is not called on an LBMMessage in the callback, it is retained for use in the application.
Once the application is finished with the LBMMessage, it should call dispose and then
pass it to this method to make it available for reuse, instead of letting it be garbage collected.

<param name="obj">The LBMMessage object that the application is done with and is ready for reuse</param>

### retrieveMessage

```csharp
public virtual LBMMessage retrieveMessage(Object cbObj)
```

LBM will call this method to attempt to retrieve a LBMMessage object instance that it can use
instead of creating a new instance to reduce garbage collection.  It will reset the state of
the LBMMessage once it is retrieved and then use it as if it were a new instance.  Returning null
causes LBM to create a new instance as if there were no recycler.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>Either null or a valid LBMMessage object will be returned</returns>

### doneWithReceiverStatistics

```csharp
public virtual void doneWithReceiverStatistics(LBMReceiverStatistics obj)
```

Once the application is finished with the stats object, it should NOT call dispose but rather
should pass it to this method to make the object instance available for reuse, instead of letting
it be garbage collected.

<param name="obj">The LBMReceiverStatistics object that the application is done with and is ready for reuse</param>

### retrieveReceiverStatistics

```csharp
public virtual LBMReceiverStatistics retrieveReceiverStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve a stats object instance that it can use instead of
creating a new instance to reduce garbage collection.  It will refresh the stats object and then use it
as if it were a new instance.  Returning null causes LBM to create a new instance as if there were
no recycler.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>Either null or a valid LBMReceiverStatistics object will be returned</returns>

### doneWithSourceStatistics

```csharp
public virtual void doneWithSourceStatistics(LBMSourceStatistics obj)
```

Once the application is finished with the stats object, it should NOT call dispose but rather
should pass it to this method to make the object instance available for reuse, instead of letting
it be garbage collected.

<param name="obj">The LBMSourceStatistics object that the application is done with and is ready for reuse</param>

### retrieveSourceStatistics

```csharp
public virtual LBMSourceStatistics retrieveSourceStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve a stats object instance that it can use instead of
creating a new instance to reduce garbage collection.  It will refresh the stats object and then use it
as if it were a new instance.  Returning null causes LBM to create a new instance as if there were
no recycler.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>Either null or a valid LBMSourceStatistics object will be returned</returns>

### doneWithContextStatistics

```csharp
public virtual void doneWithContextStatistics(LBMContextStatistics obj)
```

Once the application is finished with the stats object, it should NOT call dispose but rather
should pass it to this method to make the object instance available for reuse, instead of letting
it be garbage collected.

<param name="obj">The LBMContextStatistics object that the application is done with and is ready for reuse</param>

### retrieveContextStatistics

```csharp
public virtual LBMContextStatistics retrieveContextStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve a stats object instance that it can use instead of
creating a new instance to reduce garbage collection.  It will refresh the stats object and then use it
as if it were a new instance.  Returning null causes LBM to create a new instance as if there were
no recycler.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>Either null or a valid LBMContextStatistics object will be returned</returns>

### doneWithImmediateMessageReceiverStatistics

```csharp
public virtual void doneWithImmediateMessageReceiverStatistics(LBMImmediateMessageReceiverStatistics obj)
```

Once the application is finished with the stats object, it should NOT call dispose but rather
should pass it to this method to make the object instance available for reuse, instead of letting
it be garbage collected.

<param name="obj">The LBMImmediateMessageReceiverStatistics object that the application is done with
and is ready for reuse</param>

### retrieveImmediateMessageReceiverStatistics

```csharp
public virtual LBMImmediateMessageReceiverStatistics retrieveImmediateMessageReceiverStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve a stats object instance that it can use instead of
creating a new instance to reduce garbage collection.  It will refresh the stats object and then use it
as if it were a new instance.  Returning null causes LBM to create a new instance as if there were
no recycler.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>Either null or a valid LBMImmediateMessageReceiverStatistics object will be returned</returns>

### doneWithImmediateMessageSourceStatistics

```csharp
public virtual void doneWithImmediateMessageSourceStatistics(LBMImmediateMessageSourceStatistics obj)
```

Once the application is finished with the stats object, it should NOT call dispose but rather
should pass it to this method to make the object instance available for reuse, instead of letting
it be garbage collected.

<param name="obj">The LBMImmediateMessageSourceStatistics object that the application is done with
and is ready for reuse</param>

### retrieveImmediateMessageSourceStatistics

```csharp
public virtual LBMImmediateMessageSourceStatistics retrieveImmediateMessageSourceStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve a stats object instance that it can use instead of
creating a new instance to reduce garbage collection.  It will refresh the stats object and then use it
as if it were a new instance.  Returning null causes LBM to create a new instance as if there were
no recycler.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>Either null or a valid LBMImmediateMessageSourceStatistics object will be returned</returns>

### doneWithEventQueueStatistics

```csharp
public virtual void doneWithEventQueueStatistics(LBMEventQueueStatistics obj)
```

Once the application is finished with the stats object, it should NOT call dispose but rather
should pass it to this method to make the object instance available for reuse, instead of letting
it be garbage collected.

<param name="obj">The LBMEventQueueStatistics object that the application is done with
and is ready for reuse</param>

### retrieveEventQueueStatistics

```csharp
public virtual LBMEventQueueStatistics retrieveEventQueueStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve a stats object instance that it can use instead of
creating a new instance to reduce garbage collection.  It will refresh the stats object and then use it
as if it were a new instance.  Returning null causes LBM to create a new instance as if there were
no recycler.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>Either null or a valid LBMEventQueueStatistics object will be returned</returns>

### doneWithSourceEvent

```csharp
public virtual void doneWithSourceEvent(LBMSourceEvent obj)
```

If dispose is not called on an LBMSourceEvent in the callback, it is retained for use in the application.
Once the application is finished with the LBMSourceEvent, it should call dispose and then
pass it to this method to make it available for reuse, instead of letting it be garbage collected.

<param name="obj">The LBMSourceEvent object that the application is done with and is ready for reuse</param>

### retrieveSourceEvent

```csharp
public virtual LBMSourceEvent retrieveSourceEvent(Object cbObj)
```

LBM will call this method to attempt to retrieve an LBMSourceEvent object instance that it can use
instead of creating a new instance to reduce garbage collection.  It will reset the state of
the LBMSourceEvent once it is retrieved and then use it as if it were a new instance.  Returning null
causes LBM to create a new instance as if there were no recycler.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>Either null or a valid LBMSourceEvent object will be returned</returns>

### doneWithContextSourceEvent

```csharp
public virtual void doneWithContextSourceEvent(LBMContextSourceEvent obj)
```

If dispose is not called on an LBMContextSourceEvent in the callback, it is retained for use in the application.
Once the application is finished with the LBMContextSourceEvent, it should call dispose and then
pass it to this method to make it available for reuse, instead of letting it be garbage collected.

<param name="obj">The LBMContextSourceEvent object that the application is done with and is ready for reuse</param>

### retrieveContextSourceEvent

```csharp
public virtual LBMContextSourceEvent retrieveContextSourceEvent(Object cbObj)
```

LBM will call this method to attempt to retrieve an LBMContextSourceEvent object instance that it can use
instead of creating a new instance to reduce garbage collection.  It will reset the state of
the LBMContextSourceEvent once it is retrieved and then use it as if it were a new instance.  Returning null
causes LBM to create a new instance as if there were no recycler.

<param name="cbObj">The callback object token that was stored when setting LBMObjectRecycler in the attributes</param>
<returns>Either null or a valid LBMContextSourceEvent object will be returned</returns>

### close

```csharp
public virtual void close()
```

A method that should be overridden by derived classes, if needed, to provide a way to clean up objects
referenced by the recycler (like stats objects).

## LBMOperationCompleteCallback

*class* `com.latencybusters.lbm.LBMOperationCompleteCallback`

### LBMOperationComplete

```csharp
public delegate void LBMOperationComplete(object cbArg)
```

Operation Complete delegate.  A method matching this delegate may be
passed to the LBMOperationCompleteCallback constructor if a simple
callback is desired when an operation is complete.

### LBMOperationCompleteCallback

```csharp
public LBMOperationCompleteCallback()
```

Instantiate a default LBMOperationCompleteCallback.
This constructor should be called by subclasses that wish
to supress garbage collection until Dispose() is called.

### LBMOperationCompleteCallback

```csharp
public LBMOperationCompleteCallback(LBMOperationComplete cb)
```

Instantiate an LBMOperationCompleteCallback that invokes an
LBMOperationComplete delegate.

<param name="cb">Callback to be invoked when the operation is complete.</param>

### Dispose

```csharp
public void Dispose()
```

Dispose of a callback object.  Subclasses that wish to supress
garbage collection should call the default constructor and then
call this method when they no longer need the callback.

## LBMReceiver

*class* `com.latencybusters.lbm.LBMReceiver`

### LBMReceiver

```csharp
public LBMReceiver(LBMContext lbmctx, LBMTopic lbmtopic, LBMReceiverCallback cb, object cbArg) : this(lbmctx, lbmtopic, cb, cbArg, null)
```

Instantiate an LBM Receiver object associated with a given context
and topic, with an initial receiver callback and callback object set.

<exception ref="com.latencybusters.lbm.LBMEInvalException">Topic is not a receiver topic</exception>
<remarks>
<para><b>Warning</b>: It is not safe to call this constructor from a context thread callback.</para>
</remarks>
<param name="lbmctx">Context with which to associate the receiver</param>
<param name="lbmtopic">LBMTopic used to initialize the receiver</param>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>

### LBMReceiver

```csharp
public LBMReceiver(LBMContext lbmctx, LBMTopic lbmtopic, LBMReceiverCallback cb, object cbArg, LBMEventQueue lbmevq)
```

Instantiate an LBM Receiver object associated with a given context,
topic, and event queue, with an initial receiver callback and callback object set.

<remarks>
<para><b>Warning</b>: It is not safe to call this constructor from a context thread callback.</para>
</remarks>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Topic is not a receiver topic</exception>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="lbmctx">Context with which to associate the receiver</param>
<param name="lbmtopic">LBMTopic used to initialize the receiver</param>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>
<param name="lbmevq">Event queue with which to associate the receiver
(all receiver events will be posted to this event queue)</param>

### close

```csharp
public void close()
```

Close and dispose of this receiver

<remarks>
<para><b>Warning</b>: It is not safe to call this method from a context thread callback.</para>
</remarks>

### receiverCount

```csharp
public int receiverCount()
```

Returns the number of receiver callbacks registered to this receiver

<returns>The number of receiver callbacks registered to this receiver.</returns>

### addReceiver

```csharp
public void addReceiver(LBMReceiverCallback cb)
```

Register a receiver callback

<remarks>
If the single receiver callback mode is enabled, this API has no effect
and will log a warning if invoked.
<seealso cref="LBMReceiverCallback"/>
<seealso cref="removeReceiver"/>
</remarks>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>

### addReceiver

```csharp
public void addReceiver(LBMReceiverCallback cb, object cbArg)
```

Register a receiver callback

<remarks>
If the single receiver callback mode is enabled, this API has no effect
and will log a warning if invoked.
<seealso cref="LBMReceiverCallback"/>
<seealso cref="removeReceiver"/>
</remarks>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>
<param name="cbArg">Callback token object</param>

### removeReceiver

```csharp
public void removeReceiver(LBMReceiverCallback cb)
```

Deregister a receiver callback

<remarks>
If the single receiver callback mode is enabled, this API has no effect
and will log a warning if invoked.
<seealso cref="LBMReceiverCallback"/>
<seealso cref="addReceiver"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMReceiverCallback delegate interface</param>

### removeReceiver

```csharp
public void removeReceiver(LBMReceiverCallback cb, object cbArg)
```

Deregister a receiver callback (and callback token)

<remarks>
If the single receiver callback mode is enabled, this API has no effect
and will log a warning if invoked.
<seealso cref="LBMReceiverCallback"/>
<seealso cref="addReceiver"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMReceiverCallback delegate interface</param>
<param name="cbArg">Callback token for previously registered callback</param>

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Dump source configuration options

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>An array of LBMConfigOptions</returns>

### getAttributeValue

```csharp
public string getAttributeValue(string attributeName)
```

Returns the value of a receiver-related attribute for this receiver

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setAttributeValue

```csharp
public void setAttributeValue(string attributeName, string attributeValue)
```

Set the value of a receiver-related attribute for this receiver

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### getStatistics

```csharp
public LBMReceiverStatistics getStatistics(string source)
```

Return the current set of receiver transport statistics for a particular source

<param name="source">Source string (as returned by LBMMesage source())
that specifies the set of statistics to return</param>
<returns>LBMReceiverStatistics object containing the statistics
corresponding to the specified source</returns>

### resetStatistics

```csharp
public void resetStatistics(string source)
```

Reset the current set of receiver transport statistics for a particular source.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="source">The string version of the source to reset statistics for.</param>

### getStatistics

```csharp
public LBMReceiverStatistics getStatistics(int maxStats)
```

Return the current set of receiver transport statistics for all sources

<param name="maxStats">Maximum number of sources</param>
<returns>LBMReceiverStatistics object containing the statistics
corresponding to the specified number of sources</returns>

### resetStatistics

```csharp
public void resetStatistics()
```

Reset the receiver transport statistics for all sources.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### subscribeChannel

```csharp
public virtual void subscribeChannel(long channelNumber, LBMReceiverCallback cb, Object cbArg)
```

Subscribe to the given channel, with an optional callback and token object.
The specified callback will be called to deliver messages sent with the
specified channel number.  If null is specified for the callback, messages
sent with the specified channel number will be delivered to the receiver's
normal callback.

Only one callback may be registered for a given channel.  If this method is called
twice with the same channel number, an error will result.

<param name="channelNumber">A positive integer indicating the channel to subscribe to</param>
<param name="cb">An option callback to be called for messages on the specified channel</param>
<param name="cbArg">A token to be passed to the specified callback. If null is specified for the cb argument, this argument will be ignored.</param>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.  Most likely due to attempting to subscribe to a channel for which a subscription already exists.</exception>

### unsubscribeChannel

```csharp
public virtual void unsubscribeChannel(long channelNumber)
```

 Discontinue an existing channel subscription.
<param name="channelNumber">A positive integer indicating that channel to unsubscribe from</param>
<exception ref="com.latencybusters.lbm.LBMException">Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.  Most likely due to attempting to unsubscribe from a channel that was not previously subscribed to</exception>

### umederegister

```csharp
public void umederegister()
```

 Deregister from all stores.
<exception ref="com.latencybusters.lbm.LBMException"> An error occurred while attempting to deregister </exception>

### deregister

```csharp
public void deregister()
```

 Deregister from all queues.
<exception ref="com.latencybusters.lbm.LBMException"> An error occurred while attempting to deregister </exception>

### deregister

```csharp
public void deregister(String queue)
```

 Deregister from a single queue, specified by name.
<param name="queue">The queue to deregister from </param>
<exception ref="com.latencybusters.lbm.LBMException"> An error occurred while attempting to deregister </exception>

### indexStopAssignment

```csharp
public void indexStopAssignment(String queue)
```

Stops this receiver's eligibility for new index assignments from a queue.
<param name="queue">The name of the queue to stop new index assignment from, or null for all queues.</param>

### indexStartAssignment

```csharp
public void indexStartAssignment(String queue)
```

Starts this receiver's eligibility for new index assignments from a queue.
<param name="queue">The name of the queue to start new index assignment from, or null for all queues.</param>

### indexRelease

```csharp
public void indexRelease(String queue, UMQIndexInfo index)
```

Instruct the given UMQ queue(s) to release the given UMQ index that is assigned to the given receiver.
<param name="queue">Name of the queue at which to release the index, or null for all queues.</param>
<param name="index">The index to release, or null for all indices.</param>

### Dispose

```csharp
public void Dispose()
```

Same as <see cref="close"/>

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks><seealso cref="close"/></remarks>

## LBMReceiverAttributes

*class* `com.latencybusters.lbm.LBMReceiverAttributes`

### LBMReceiverAttributes

```csharp
unsafe public LBMReceiverAttributes()
```

Instantiate LBMReceiverAttributes class

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### LBMReceiverAttributes

```csharp
unsafe public LBMReceiverAttributes(string contextName, string topicName)
```

Instantiate an LBMReceiverAttributes class using a context name and topic name from the xml configuration that
must have been previously loaded.

<param name="contextName">The context name under which this receiver is to be created</param>
<param name="topicName">The receiver topic name under which this receiver is to be created</param>
<exception ref="com.latencybusters.lbm.LBMException">The context name or receiver topic name is not permitted by XML configuration or other unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of attributes.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of attributes (same as Dispose()).
<seealso cref="Dispose"/>

### setFromXml

```csharp
unsafe public void setFromXml(string contextName, string topicName)
```

Set values in an LBMReceiverAttributes class using a context name and topic name from the xml configuration that
must have been previously loaded.

<param name="contextName">The context name under which this receiver is to be created</param>
<param name="topicName">The receiver topic name under which this receiver is to be created</param>
<exception ref="com.latencybusters.lbm.LBMException">The context name or receiver topic name is not permitted by XML configuration or other unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Dump source configuration options

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>An array of LBMConfigOptions</returns>

### getValue

```csharp
unsafe public string getValue(string attributeName)
```

Returns the current value of an attribute from this set of
receiver-related attributes

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setValue

```csharp
unsafe public void setValue(string attributeName, string attributeValue)
```

Set the current value of an attribute in this set of
receiver-related attributes

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### setRegistrationIdCallback

```csharp
public void setRegistrationIdCallback(LBMRegistrationIdCallback cb, object cbArg)
```

 Register a callback interface (and a callback handle argument) to be
 called to enable a receiver to set the registration ID it uses for a
 given source (UME only).

<remarks> This callback is called directly in line and does not use the event queue;
therefore, the callback function used should not block or it will block the
context thread processing.
This API may not be called from a wildcard receiver create callback.
Doing so will not result in the callbacks being called.
<seealso cref="LBMRegistrationIdCallback"/>
<seealso cref="LBMWildcardReceiverCreateCallback"/>
</remarks>
<param name="cb">An object implementing the LBMRegistrationIdCallback delegate interface</param>
<param name="cbArg">Callback object passed as a token to the callback interface</param>

### setRegistrationIdCallback

```csharp
public void setRegistrationIdCallback(UMERegistrationIdExCallback cb, object cbArg)
```

 Register a callback interface (and a callback handle argument) to be
 called to enable a receiver to set the registration ID it uses for a
 given source (UME only).

<remarks> This callback is called directly in line and does not use the event queue;
therefore, the callback function used should not block or it will block the
context thread processing.
This API may not be called from a wildcard receiver create callback.
Doing so will not result in the callbacks being called.
<seealso cref="UMERegistrationIdExCallback"/>
<seealso cref="LBMWildcardReceiverCreateCallback"/>
</remarks>
<param name="cb">An object implementing the UMERegistrationIdExCallback delegate interface</param>
<param name="cbArg">Callback object passed as a token to the callback interface</param>

### setRecoverySequenceNumberCallback

```csharp
public void setRecoverySequenceNumberCallback(UMERecoverySequenceNumberCallback cb, object cbArg)
```

Register an extended callback interface (and a callback handle argument) to be
called to enable a receiver to set the low sequence number it uses for
recovery events (including late joins and durable subscriptions).

<remarks>
This callback is called directly in line and does not use the event queue;
therefore, the callback function used should not block or it will block the
context thread processing.
This API may not be called from a wildcard receiver create callback.
Doing so will not result in the callbacks being called.
<seealso cref="LBMWildcardReceiverCreateCallback"/>
</remarks>
<param name="cb">An object implementing the UMERecoverySequenceNumberCallback delegate interface</param>
<param name="cbArg">Callback object passed as a token to the callback interface</param>

### setSourceNotificationCallbacks

```csharp
public void setSourceNotificationCallbacks(LBMSourceCreationCallback creationCb, LBMSourceDeletionCallback deletionCb, object cbArg)
```

Set per-topic source creation and deletion notification callback functions.

<remarks>
This API may not be called from a wildcard receiver create callback.
Doing so will not result in the callbacks being called.
<seealso cref="LBMWildcardReceiverCreateCallback"/>
</remarks>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Both source notification callbacks must be set or cleared at once.</exception>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="creationCb">Source creation callback delegate.</param>
<param name="deletionCb">Source deletion callback delegate.</param>
<param name="cbArg">Client-supplied callback object, returned to source creation and deletion callback methods.</param>

### setObjectRecycler

```csharp
public void setObjectRecycler(LBMObjectRecyclerBase objRec, Object objRecCbArg)
```

Set the LBM object recycler that can be used by the context to reuse LBMMessage objects as
well as LBM Context/Receiver/Source Statistics objects.

<param name="objRec">an LBM object recycler that will be called when objects need to be retrieved</param>
<param name="objRecCbArg">a callback object token that will be passed in the retrieve method</param>

### enableSingleReceiverCallback

```csharp
public void enableSingleReceiverCallback(bool enabled)
```

If set to true, LBMReceivers, LBMHotFailoverReceivers, and
LBMWildcardReceivers will only accept a single LBMReceiverCallback.
The addReceiver and removeReceiver APIs will become defunct and log
a warning if used. This reduces the amount of syncronization work
done per message and results in lower latencies. Set to false by
default.

<param name="enabled">Set to true to enable single receiver callback mode. Set to false to disable.</param>

## LBMReceiverCallback

*delegate* `com.latencybusters.lbm.LBMReceiverCallback`

### LBMReceiverCallback

```csharp
public delegate int LBMReceiverCallback(object cbArg, LBMMessage lbmmsg)
```

Received message callback delegate

<param name="cbArg">Callback object token</param>
<param name="lbmmsg">LBMMessage object encapsulating the received message</param>
<returns>all return values are ignored</returns>

## LBMReceiverCreationCallback

*delegate* `com.latencybusters.lbm.LBMReceiverCreationCallback`

### LBMReceiverCreationCallback

```csharp
public delegate object LBMReceiverCreationCallback(string receiverName, object cbArg)
```

Application callback for notification of creation of a receiver for a topic.

<param name="receiverName">The unique receiver name string (e.g., "TCP:192.168.0.4:45789").</param>
<param name="cbArg">Callback object token.</param>
<returns>User-supplied callback object to pass in to corresponding <see cref="LBMSourceDeletionCallback"/> callback.</returns>

## LBMReceiverStatistics

*class* `com.latencybusters.lbm.LBMReceiverStatistics`

### LBMReceiverStatistics

```csharp
public LBMReceiverStatistics()
```

Instantiate an empty object containing no statistics.

<remarks>
<seealso cref="refresh"/>
</remarks>

### LBMReceiverStatistics

```csharp
unsafe public LBMReceiverStatistics(LBMReceiver lbmrcv, int maxStats)
```

Instantiate object containing the aggregate set of statistics
for a particular receiver.

<remarks>
This constructor will throw LBMEInvalException if maxStats is
less than the the available number of transport statistical
sets.
<seealso cref="refresh"/>
</remarks>
<param name="lbmrcv">LBMReceiver object</param>
<param name="maxStats">Maximum number of sources</param>

### LBMReceiverStatistics

```csharp
unsafe public LBMReceiverStatistics(LBMHFXReceiver lbmrcv, int maxStats)
```

Instantiate object containing the aggregate set of statistics
for a particular receiver.

<remarks>
This constructor will throw LBMEInvalException if maxStats is
less than the the available number of transport statistical
sets.
<seealso cref="refresh"/>
</remarks>
<param name="lbmrcv">LBMHFXReceiver object</param>
<param name="maxStats">Maximum number of sources</param>

### LBMReceiverStatistics

```csharp
unsafe public LBMReceiverStatistics(LBMContext lbmctx, int maxStats)
```

Instantiate object containing the aggregate set of statistics
for a particular context

<remarks>
This constructor will throw LBMEInvalException if maxStats is
less than the the available number of transport statistical
sets.
<seealso cref="refresh"/>
</remarks>
<param name="lbmctx">LBMContext object</param>
<param name="maxStats">Maximum number of sources</param>

### LBMReceiverStatistics

```csharp
unsafe public LBMReceiverStatistics(LBMReceiver lbmrcv, string source)
```

Instantiate object containing the current set of statistics
for a particular receiver and source

<remarks>
<seealso cref="refresh"/>
</remarks>
<param name="lbmrcv">LBMReceiver object</param>
<param name="source">Source string (as returned by LBMMesage source())
that specifies the set of statistics to retrieve</param>

### LBMReceiverStatistics

```csharp
unsafe public LBMReceiverStatistics(LBMHFXReceiver lbmrcv, string source)
```

Instantiate object containing the current set of statistics
for a particular receiver and source

<remarks>
<seealso cref="refresh"/>
</remarks>
<param name="lbmrcv">LBMHFXReceiver object</param>
<param name="source">Source string (as returned by LBMMesage source())
that specifies the set of statistics to retrieve</param>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of statistics.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of statistics (same as Dispose()).
<seealso cref="Dispose"/>

### refresh

```csharp
unsafe public void refresh(LBMReceiver lbmrcv, int maxStats)
```

Refresh the aggregate set of statistics
for a particular receiver.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
This method will throw LBMEInvalException if maxStats is
less than the the available number of transport statistical
sets.
</remarks>
<param name="lbmrcv">LBMReceiver object</param>
<param name="maxStats">Maximum number of sources</param>

### refresh

```csharp
unsafe public void refresh(LBMHFXReceiver lbmrcv, int maxStats)
```

Refresh the aggregate set of statistics
for a particular receiver.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
This method will throw LBMEInvalException if maxStats is
less than the the available number of transport statistical
sets.
</remarks>
<param name="lbmrcv">LBMHFXReceiver object</param>
<param name="maxStats">Maximum number of sources</param>

### refresh

```csharp
unsafe public void refresh(LBMContext lbmctx, int maxStats)
```

Refresh the aggregate set of statistics
for a particular context

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
This method will throw LBMEInvalException if maxStats is
less than the the available number of transport statistical
sets.
</remarks>
<param name="lbmctx">LBMContext object</param>
<param name="maxStats">Maximum number of sources</param>

### refresh

```csharp
unsafe public void refresh(LBMReceiver lbmrcv, string source)
```

Refresh the current set of statistics
for a particular receiver and source

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<exception ref="com.latencybusters.lbm.LBMEOPException">Unknown transport</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Statistics not found</exception>
<param name="lbmrcv">LBMReceiver object</param>
<param name="source">Source string (as returned by LBMMesage source())
that specifies the set of statistics to retrieve</param>

### refresh

```csharp
unsafe public void refresh(LBMHFXReceiver lbmrcv, string source)
```

Refresh the current set of statistics
for a particular receiver and source

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<exception ref="com.latencybusters.lbm.LBMEOPException">Unknown transport</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Statistics not found</exception>
<param name="lbmrcv">LBMHFXReceiver object</param>
<param name="source">Source string (as returned by LBMMesage source())
that specifies the set of statistics to retrieve</param>

### size

```csharp
public int size()
```

Number of transport statistical sets encapsulated within this object

<returns>Statistical set size</returns>

### type

```csharp
public int type()
```

Transport type (TCP, LBT-RM, LBT-RU, etc.)

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
<seealso cref="LBM"/>
</remarks>
<returns>Transport type</returns>

### type

```csharp
public int type(int n)
```

Transport type (TCP, LBT-RM, LBT-RU, etc.)

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
<seealso cref="LBM"/>
</remarks>
<param name="n">Statistics set index</param>
<returns>Transport type</returns>

### typeName

```csharp
public string typeName()
```

Transport type name (TCP, LBT-RM, LBT-RU, etc.).

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Transport type name</returns>

### typeName

```csharp
public string typeName(int n)
```

Transport type name (TCP, LBT-RM, LBT-RU, etc.).

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Transport type name</returns>

### source

```csharp
public string source()
```

Source of transport as a string

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
</remarks>
<seealso cref="LBMTransportSourceInfo" />
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
<returns>Source of transport as a string</returns>

### source

```csharp
public string source(int n)
```

Source of transport as a string

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
</remarks>
<seealso cref="LBMTransportSourceInfo" />
<param name="n">Statistics set index</param>
<returns>Source of transport as a string</returns>

### bytesReceived

```csharp
public long bytesReceived()
```

Number of datagram bytes received (TCP, LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA) or complete message bytes received (BROKER)

<remarks>
The total of
lengths of all transport packets, including UM header information.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of bytes received. </returns>

### bytesReceived

```csharp
public long bytesReceived(int n)
```

Number of datagram bytes received (TCP, LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA) or complete message bytes received (BROKER)

<remarks>
The total of
lengths of all transport packets, including UM header information.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of bytes received.</returns>

### messagesReceived

```csharp
public long messagesReceived()
```

Number of datagrams received (LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA) or complete messages received (BROKER)

<remarks>
Depending on batching settings, a single datagram may contain one or
more messages, or a fragment of a larger message. Larger messages
are split into fragment sizes limited by the transport's configuration
option transport_xxxx_datagram_max_size.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of datagrams received. </returns>

### messagesReceived

```csharp
public long messagesReceived(int n)
```

Number of datagrams received (LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA) or complete messages received (BROKER)

<remarks>
Depending on batching settings, a single datagram may contain one or
more messages, or a fragment of a larger message. Larger messages
are split into fragment sizes limited by the transport's configuration
option transport_xxxx_datagram_max_size.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams received.</returns>

### nakPacketsSent

```csharp
public long nakPacketsSent()
```

Number of NAK packets sent by the receiver transport (LBT-RM, LBT-RU)

<remarks>
UM batches NAKs into NAK packets to save network bandwidth. This should
always be less than or equal to the number of individual NAKs sent (naksSent,
below).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of NAK packets sent. </returns>

### nakPacketsSent

```csharp
public long nakPacketsSent(int n)
```

Number of NAK packets sent by the receiver transport (LBT-RM, LBT-RU)

<remarks>
UM batches NAKs into NAK packets to save network bandwidth. This should
always be less than or equal to the number of individual NAKs sent (naksSent,
below).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NAK packets sent. </returns>

### naksSent

```csharp
public long naksSent()
```

Number of individual NAKs sent by the receiver transport (LBT-RM, LBT-RU)

<remarks>
This may differ from the tally of lost datagrams (below) due to reasons such as
<list type="bullet">
<item>
Other receiver transports may have already sent a NAK for the same lost
datagram, resulting in a retransmitted lost datagram (or an NCF) to arrive at
this receiver transport before it has a chance to issue a NAK, or
</item>
<item>
During periods of heavy loss, receiver transports may be forced to issue
multiple NAKs per lost datagram (controlled by the transport's configuration
options for NAK generation interval and NAK backoff interval)
until either the retransmission is
received or the datagram is declared unrecovered (which may ultimately lead to
UM delivering an LBM_MSG_UNRECOVERABLE_LOSS notification to the receiver
application).
</item>
</list>
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>. Number of individual NAKs sent by the receiver transport. </returns>

### naksSent

```csharp
public long naksSent(int n)
```

Number of individual NAKs sent by the receiver transport (LBT-RM, LBT-RU)

<remarks>
This may differ from the tally of lost datagrams (below) due to reasons such as
<list type="bullet">
<item>
Other receiver transports may have already sent a NAK for the same lost
datagram, resulting in a retransmitted lost datagram (or an NCF) to arrive at
this receiver transport before it has a chance to issue a NAK, or
</item>
<item>
During periods of heavy loss, receiver transports may be forced to issue
multiple NAKs per lost datagram (controlled by the transport's configuration
options for NAK generation interval and NAK backoff interval)
until either the retransmission is
received or the datagram is declared unrecovered (which may ultimately lead to
UM delivering an LBM_MSG_UNRECOVERABLE_LOSS notification to the receiver
application).
</item>
</list>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of individual NAKs sent by the receiver transport. </returns>

### lost

```csharp
public long lost()
```

Number of datagrams detected as lost (LBT-RM, LBT-RU)

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of datagrams that have been detected as lost.</returns>

### lost

```csharp
public long lost(int n)
```

Number of datagrams detected as lost (LBT-RM, LBT-RU)

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams that have been detected as lost.</returns>

### ncfsIgnored

```csharp
public long ncfsIgnored()
```

Number of NCFs received from a source transport with reason code "ignored"
(LBT-RM, LBT-RU)

<remarks>
If a source transport receives a NAK for a datagram that it has recently
retransmitted, it sends an "NCF ignored" and does not retransmit. How
recently" is determined by the configuration option for ignore interval.
If this count is high, a
receiver transport may be having trouble receiving retransmissions, or the
ignore interval may be set too long.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of NCFs received from a source with the reason
code set to "ignored". </returns>

### ncfsIgnored

```csharp
public long ncfsIgnored(int n)
```

Number of NCFs received from a source transport with reason code "ignored"
(LBT-RM, LBT-RU)

<remarks>
If a source transport receives a NAK for a datagram that it has recently
retransmitted, it sends an "NCF ignored" and does not retransmit. How
recently" is determined by the configuration option for ignore interval.
If this count is high, a
receiver transport may be having trouble receiving retransmissions, or the
ignore interval may be set too long.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NCFs received from a source with the reason
code set to "ignored". </returns>

### ncfsShed

```csharp
public long ncfsShed()
```

Number of NCFs received with reason set to "shed" (LBT-RM, LBT-RU)

<remarks>
When a source transport's retransmit queue and rate limiter are both at
maximum, it responds to a NAK by sending an "NCF shed", and does not
retransmit. The receiver transport should wait, then send another NAK. If this
count is high, one or more crybaby receiver transports may be clogging the
source transport's retransmit queue.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of NCFs that have been received with the reason
code set to "shed". </returns>

### ncfsShed

```csharp
public long ncfsShed(int n)
```

Number of NCFs received with reason set to "shed" (LBT-RM, LBT-RU)

<remarks>
When a source transport's retransmit queue and rate limiter are both at
maximum, it responds to a NAK by sending an "NCF shed", and does not
retransmit. The receiver transport should wait, then send another NAK. If this
count is high, one or more crybaby receiver transports may be clogging the
source transport's retransmit queue.
retransmission queue.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NCFs that have been received with the reason
code set to "shed". </returns>

### ncfsRetransmissionDelay

```csharp
public long ncfsRetransmissionDelay()
```

Number of NCFs received with reason code "rx_delay" (LBT-RM, LBT-RU)

<remarks>
When a source transport's retransmit rate limiter prevents it from
immediately retransmitting any more lost datagrams, it responds to a NAK by
sending an "NCF rx_delay", then queues the retransmission for a later send.
The receiver transport should wait for the retransmission and not immediately
send another NAK. If this count is high, one or more crybaby receiver
transports may be clogging the source transport's retransmit queue.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of NCFs that have been received with the reason
code set to "rx_delay". </returns>

### ncfsRetransmissionDelay

```csharp
public long ncfsRetransmissionDelay(int n)
```

Number of NCFs received with reason code "rx_delay" (LBT-RM, LBT-RU)

<remarks>
When a source transport's retransmit rate limiter prevents it from
immediately retransmitting any more lost datagrams, it responds to a NAK by
sending an "NCF rx_delay", then queues the retransmission for a later send.
The receiver transport should wait for the retransmission and not immediately
send another NAK. If this count is high, one or more crybaby receiver
transports may be clogging the source transport's retransmit queue.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NCFs that have been received with the reason
code set to "rx_delay". </returns>

### ncfsUnknown

```csharp
public long ncfsUnknown()
```

Number of NCFs received with reason code "unknown" (LBT-RM, LBT-RU)

<remarks>
These are NCFs with a reason code this receiver transport does not
recognize. After a delay (set by configuration option for NAK suppress
interval), it resends the NAK.
This counter should never be greater than 0 unless applications linked with
different versions of Ultra Messaging software coexist on the same network.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of NCFs that have been received with the reason
code set to "unknown". </returns>

### ncfsUnknown

```csharp
public long ncfsUnknown(int n)
```

Number of NCFs received with reason code "unknown" (LBT-RM, LBT-RU)

<remarks>
These are NCFs with a reason code this receiver transport does not
recognize. After a delay (set by configuration option for NAK suppress
interval), it resends the NAK.
This counter should never be greater than 0 unless applications linked with
different versions of Ultra Messaging software coexist on the same network.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NCFs that have been received with the reason
code set to "unknown". </returns>

### minimumRecoveryTime

```csharp
public long minimumRecoveryTime()
```

Minimum time (in milliseconds) in which loss recovery
was accomplished (LBT-RM, LBT-RU)

<remarks>
If this time is greater than configuration option for NAK backoff interval,
it may be taking multiple NAKs to
initiate retransmissions, indicating a lossy network.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>
Minimum time (in milliseconds), i.e., the shortest time recorded so far for
a lost message to be recovered.
</returns>

### minimumRecoveryTime

```csharp
public long minimumRecoveryTime(int n)
```

Minimum time (in milliseconds) in which loss recovery
was accomplished (LBT-RM, LBT-RU)

<remarks>
If this time is greater than configuration option for NAK backoff interval,
it may be taking multiple NAKs to
initiate retransmissions, indicating a lossy network.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Minimum time (in milliseconds), i.e., the shortest time recorded so far for
a lost message to be recovered.
</returns>

### meanRecoveryTime

```csharp
public long meanRecoveryTime()
```

Mean time (in milliseconds) in which loss recovery was
accomplished (LBT-RM, LBT-RU)

<remarks>
This is an exponentially weighted moving average (weighted to more recent)
for accumulated measured recovery times. Ideally this field should be as close
to your minimum recovery time (nak_stm_min, above) as possible. High mean
recovery times indicate a lossy network.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Mean time (in milliseconds) in which loss recovery was
accomplished. </returns>

### meanRecoveryTime

```csharp
public long meanRecoveryTime(int n)
```

Mean time (in milliseconds) in which loss recovery was
accomplished (LBT-RM, LBT-RU)

<remarks>
This is an exponentially weighted moving average (weighted to more recent)
for accumulated measured recovery times. Ideally this field should be as close
to your minimum recovery time (nak_stm_min, above) as possible. High mean
recovery times indicate a lossy network.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Mean time (in milliseconds) in which loss recovery was
accomplished.</returns>

### maximumRecoveryTime

```csharp
public long maximumRecoveryTime()
```

Maximum time (in milliseconds) in which loss recovery
was accomplished (LBT-RM, LBT-RU)

<remarks>
If this time is near or equal to the configuration option setting for NAK
generation interval, you have likely experienced
some level of unrecoverable loss.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>
Maximum time (in milliseconds), i.e., the longest time recorded so far for a
lost message to be recovered.
</returns>

### maximumRecoveryTime

```csharp
public long maximumRecoveryTime(int n)
```

Maximum time (in milliseconds) in which loss recovery
was accomplished (LBT-RM, LBT-RU)

<remarks>
If this time is near or equal to the configuration option setting for NAK
generation interval, you have likely experienced
some level of unrecoverable loss.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Maximum time (in milliseconds), i.e., the longest time recorded so far for a
lost message to be recovered.
</returns>

### minimumNakTransmissions

```csharp
public long minimumNakTransmissions()
```

Minimum number of times per lost message that a receiver transport
transmitted a NAK. (LBT-RM, LBT-RU)

<remarks>
A value greater than 1 indicates a chronically lossy network.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>
Minimum number of times per lost message that a receiver transport
transmitted a NAK, i.e., the lowest value collected so far.
</returns>

### minimumNakTransmissions

```csharp
public long minimumNakTransmissions(int n)
```

Minimum number of times per lost message that a receiver transport
transmitted a NAK. (LBT-RM, LBT-RU)

<remarks>
A value greater than 1 indicates a chronically lossy network.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Minimum number of times per lost message that a receiver transport
transmitted a NAK, i.e., the lowest value collected so far.
</returns>

### meanNakTransmissions

```csharp
public long meanNakTransmissions()
```

Mean number of times per lost message that a receiver transport transmitted
a NAK. (LBT-RM, LBT-RU)

<remarks>
Ideally this should be at or near 1. A higher value indicates a lossy
network. This is an exponentially weighted moving average (weighted to more
recent) for accumulated NAKs per lost message.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Mean number of times per lost message that a receiver transport
transmitted a NAK.</returns>

### meanNakTransmissions

```csharp
public long meanNakTransmissions(int n)
```

Mean number of times per lost message that a receiver transport transmitted
a NAK. (LBT-RM, LBT-RU)

<remarks>
Ideally this should be at or near 1. A higher value indicates a lossy
network. This is an exponentially weighted moving average (weighted to more
recent) for accumulated NAKs per lost message.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Mean number of times per lost message that a receiver transport
transmitted a NAK.</returns>

### maximumNakTransmissions

```csharp
public long maximumNakTransmissions()
```

Maximum number of times per lost message that a receiver transport
transmitted a NAK. (LBT-RM, LBT-RU)

<remarks>
A value higher than 1 suggests that there may have been some unrecoverable
loss on the network during the sample period. A significantly high value
compared to the mean number) implies an isolated incident.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
</remarks>
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
<returns>
Maximum number of times per lost message that a receiver transport
transmitted a NAK, i.e., the highest value collected so far.
</returns>

### maximumNakTransmissions

```csharp
public long maximumNakTransmissions(int n)
```

Maximum number of times per lost message that a receiver transport
transmitted a NAK. (LBT-RM, LBT-RU)

<remarks>
A value higher than 1 suggests that there may have been some unrecoverable
loss on the network during the sample period. A significantly high value
compared to the mean number) implies an isolated incident.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Maximum number of times per lost message that a receiver transport
transmitted a NAK, i.e., the highest value collected so far.
</returns>

### duplicateMessages

```csharp
public long duplicateMessages()
```

Number of duplicate datagrams received (LBT-RM, LBT-RU)

<remarks>
A large number can indicate a lossy network, primarily due to other receiver
transports requesting retransmissions that this receiver transport has already
successfully received. Such duplicates require extra effort for filtering, and
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of duplicate datagrams received. </returns>

### duplicateMessages

```csharp
public long duplicateMessages(int n)
```

Number of duplicate datagrams received (LBT-RM, LBT-RU)

<remarks>
A large number can indicate a lossy network, primarily due to other receiver
transports requesting retransmissions that this receiver transport has already
successfully received. Such duplicates require extra effort for filtering, and
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of duplicate datagrams received. </returns>

### unrecoveredMessagesWindowAdvance

```csharp
public long unrecoveredMessagesWindowAdvance()
```

Number of datagrams unrecovered
due to transmission window advance (LBT-RM, LBT-RU)

<remarks>
This means that the message was no longer in the source-side transmission
window and therefore not retransmitted. The window size is set by the transport
configuration option for transmission window size.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>
Number of datagrams unrecovered (LBM_MSG_UNRECOVERABLE_LOSS delivered to
receiver application) due to transmission window advance.
</returns>

### unrecoveredMessagesWindowAdvance

```csharp
public long unrecoveredMessagesWindowAdvance(int n)
```

Number of datagrams unrecovered
due to transmission window advance (LBT-RM, LBT-RU)

<remarks>
This means that the message was no longer in the source-side transmission
window and therefore not retransmitted. The window size is set by the transport
configuration option for transmission window size.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Number of datagrams unrecovered (LBM_MSG_UNRECOVERABLE_LOSS delivered to
receiver application) due to transmission window advance.
</returns>

### unrecoveredMessagesNakGenerationTimeout

```csharp
public long unrecoveredMessagesNakGenerationTimeout()
```

Number of messages unrecoverable due to NAK generation expiration (LBT-RM, LBT-RU)

<remarks>
This is controlled by the transport's
nak_generation_interval, with a default of 10000ms. This field
also includes messages declared unrecoverable due to a burst loss
event (LBM_MSG_UNRECOVERABLE_LOSS_BURST).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of datagrams that were unrecovered
(LBM_MSG_UNRECOVERABLE_LOSS message was delivered) because a
retransmission was not successfully received within the NAK
generation interval. </returns>

### unrecoveredMessagesNakGenerationTimeout

```csharp
public long unrecoveredMessagesNakGenerationTimeout(int n)
```

Number of messages unrecoverable due to NAK generation expiration (LBT-RM, LBT-RU)

<remarks>
This is controlled by the transport's
nak_generation_interval, with a default of 10000ms. This field
also includes messages declared unrecoverable due to a burst loss
event (LBM_MSG_UNRECOVERABLE_LOSS_BURST).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams that were unrecovered
(LBM_MSG_UNRECOVERABLE_LOSS message was delivered) because a
retransmission was not successfully received within the NAK
generation interval.</returns>

### lbmMessagesReceived

```csharp
public long lbmMessagesReceived()
```

Number of messages or message fragments received by the transport (TCP,
LBM-RM, LBT-RU, LBT-IPC, LBT-RDMA)

<remarks>
A single datagram may contain one or more messages or a fragment of a larger
message. For fragmented messages larger than the transport's configuration option
transport_xxxxx_datagram_max_size, this count reflects the
number of datagrams used to constitute those messages. Thus, this number is
equal to or greater than the datagram counter (messagesReceived, above).
This number
also includes messages received for which there was no interested receiver,
which is tallied in the noTopicMessagesReceived counter (below).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>
Number of messages or message fragments received by the transport.
</returns>

### lbmMessagesReceived

```csharp
public long lbmMessagesReceived(int n)
```

Number of messages or message fragments received by the transport (TCP,
LBM-RM, LBT-RU, LBT-IPC, LBT-RDMA)

<remarks>
A single datagram may contain one or more messages or a fragment of a larger
message. For fragmented messages larger than the transport's configuration option
transport_xxxxx_datagram_max_size, this count reflects the
number of datagrams used to constitute those messages. Thus, this number is
equal to or greater than the datagram counter (messagesReceived, above).
This number
also includes messages received for which there was no interested receiver,
which is tallied in the noTopicMessagesReceived counter (below).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Number of messages or message fragments received by the transport.
</returns>

### lbmRequestsReceived

```csharp
public long lbmRequestsReceived()
```

Number of UM requests received (message type LBM_MSG_REQUEST)
(TCP, LBM-RM, LBT-RU, LBT-IPC, LBT-RDMA)

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of UM request messages received (message type
LBM_MSG_REQUEST).</returns>

### lbmRequestsReceived

```csharp
public long lbmRequestsReceived(int n)
```

Number of UM requests received (message type LBM_MSG_REQUEST)
(TCP, LBM-RM, LBT-RU, LBT-IPC, LBT-RDMA)

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of UM request messages received (message type
LBM_MSG_REQUEST).</returns>

### noTopicMessagesReceived

```csharp
public long noTopicMessagesReceived()
```

Number of messages received that were not for a
a topic of interest to the receiver (TCP, LBM-RM, LBT-RU, LBT-IPC, LBT-RDMA)

<remarks>
A high value (relative to, or approaching lbmMessagesReceived above) indicates
more CPU time required to filter out uninteresting topics, in which case,
consider reconfiguring sources to filter more aggressively at the transport
layer.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMReceiverStatistics(LBMReceiver, string)" />
</remarks>
<returns>Number of application messages received that were not sent
on a topic of interest to the receiver. </returns>

### noTopicMessagesReceived

```csharp
public long noTopicMessagesReceived(int n)
```

Number of messages received that were not for a
a topic of interest to the receiver (TCP, LBM-RM, LBT-RU, LBT-IPC, LBT-RDMA)

<remarks>
A high value (relative to, or approaching lbmMessagesReceived above) indicates
more CPU time required to filter out uninteresting topics, in which case,
consider reconfiguring sources to filter more aggressively at the transport
layer.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of application messages received that were not sent
on a topic of interest to the receiver.</returns>

### datagramsDroppedIncorrectSize

```csharp
public long datagramsDroppedIncorrectSize()
```

Number of datagrams discarded due to size.

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
</remarks>
<returns>
Number of datagrams discarded due to being smaller than the size designated
in the datagram's size field.
</returns>

### datagramsDroppedIncorrectSize

```csharp
public long datagramsDroppedIncorrectSize(int n)
```

Number of datagrams discarded due to size.

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Number of datagrams discarded due to being smaller than the size designated
in the datagram's size field.
</returns>

### datagramsDroppedType

```csharp
public long datagramsDroppedType()
```

Number of datagrams discarded due to bad packet type.

<remarks>
The datagram's type field must match the expectations of the receiver
transport.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
</remarks>
<returns>Number of datagrams discarded due to bad packet type.</returns>

### datagramsDroppedType

```csharp
public long datagramsDroppedType(int n)
```

Number of datagrams discarded due to bad packet type.

<remarks>
The datagram's type field must match the expectations of the receiver
transport.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams discarded due to bad packet type.</returns>

### datagramsDroppedVersion

```csharp
public long datagramsDroppedVersion()
```

Number of datagrams discarded due to version mismatch.

<remarks>
The datagram's version field must match the expectations of the receiver
transport.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
</remarks>
<returns>Number of datagrams discarded due to version mismatch.</returns>

### datagramsDroppedVersion

```csharp
public long datagramsDroppedVersion(int n)
```

Number of datagrams discarded due to version mismatch.

<remarks>
The datagram's version field must match the expectations of the receiver
transport.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams discarded due to version mismatch.</returns>

### datagramsDroppedHeader

```csharp
public long datagramsDroppedHeader()
```

Number of datagrams discarded due to bad header type.

<remarks>
These datagrams appeared to be intact, but with an unrecognizable header
format.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
</remarks>
<returns>Number of datagrams discarded due to bad header type.</returns>

### datagramsDroppedHeader

```csharp
public long datagramsDroppedHeader(int n)
```

Number of datagrams discarded due to bad header type.

<remarks>
These datagrams appeared to be intact, but with an unrecognizable header
format.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams discarded due to bad header type.</returns>

### datagramsDroppedSID

```csharp
public long datagramsDroppedSID()
```

Number of datagrams discarded due to session ID mismatch.

<remarks>
These datagrams appeared to be correctly formed, but with an
unmatched/unrecognized session ID field.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
</remarks>
<returns>Number of datagrams discarded due to session ID mismatch.</returns>

### datagramsDroppedSID

```csharp
public long datagramsDroppedSID(int n)
```

Number of datagrams discarded due to session ID mismatch.

<remarks>
These datagrams appeared to be correctly formed, but with an
unmatched/unrecognized session ID field.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams discarded due to session ID mismatch.</returns>

### datagramsDroppedOther

```csharp
public long datagramsDroppedOther()
```

Number of datagrams discarded due to other reasons.

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
</remarks>
<returns>
Number of unrecognizable datagrams discarded due to reasons other than those
determined by the above counts. They could be garbled, or possibly be from
foreign or incompatible software at the other end.
</returns>

### datagramsDroppedOther

```csharp
public long datagramsDroppedOther(int n)
```

Number of datagrams discarded due to other reasons.

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>
Number of unrecognizable datagrams discarded due to reasons other than those
determined by the above counts. They could be garbled, or possibly be from
foreign or incompatible software at the other end.
</returns>

### outOfOrder

```csharp
public long outOfOrder()
```

Number of out-of-order datagrams received.

<remarks>
A datagram is counted as out of order if it fills a previously detected
sequence gap, but is not a retransmission. Note that if the duplicates counter
duplicate_data, above) increases along with this statistic, this implies the
arrivals of retransmitted datagrams before their originals.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
</remarks>
<returns>Number of datagrams received out of order.</returns>

### outOfOrder

```csharp
public long outOfOrder(int n)
```

Number of out-of-order datagrams received.

<remarks>
A datagram is counted as out of order if it fills a previously detected
sequence gap, but is not a retransmission. Note that if the duplicates counter
duplicate_data, above) increases along with this statistic, this implies the
arrivals of retransmitted datagrams before their originals.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams received out of order.</returns>

## LBMRegistrationIdCallback

*delegate* `com.latencybusters.lbm.LBMRegistrationIdCallback`

### LBMRegistrationIdCallback

```csharp
public delegate long LBMRegistrationIdCallback(object cbArg, string source, long sourceRegId)
```

Receiver registration ID callback delegate (UME only)

<param name="cbArg">Callback object token</param>
<param name="source">Name of the source for the ID</param>
<param name="sourceRegId">Registration ID for the source</param>
<returns>Registration ID to be used by the receiver</returns>

## LBMRequest

*class* `com.latencybusters.lbm.LBMRequest`

### LBMRequest

```csharp
public LBMRequest()
```

Instantiate an LBM Request object

### LBMRequest

```csharp
public LBMRequest(byte [] data, int dataLength) : this()
```

Instantiate an LBM Request object

<param name="data">Data to be sent with the request</param>
<param name="dataLength">Data length</param>

### close

```csharp
public void close()
```

Close and dispose of this request

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### data

```csharp
public byte [] data()
```

Get request data

<returns>Byte array associated with this request</returns>

### dataLength

```csharp
public int dataLength()
```

Get request data length

<returns>Length of data array associated with this request</returns>

### data

```csharp
public void data(byte [] data, int dataLength)
```

Set request data

<param name="data">Data byte array</param>
<param name="dataLength">Length of data byte array</param>

### addResponseCallback

```csharp
public void addResponseCallback(LBMResponseCallback cb)
```

Register a callback to be invoked when a response is received for this request

<remarks>
<seealso cref="LBMResponseCallback"/>
<seealso cref="removeResponseCallback"/>
</remarks>
<param name="cb">Callback implementing the LBMResponseCallback delegate interface</param>

### addResponseCallback

```csharp
public void addResponseCallback(LBMResponseCallback cb, Object cbArg)
```

Register a callback to be invoked when a response is received for this request

<remarks>
<seealso cref="LBMResponseCallback"/>
<seealso cref="removeResponseCallback"/>
</remarks>
<param name="cb">Callback implementing the LBMResponseCallback delegate interface</param>
<param name="cbArg">Callback token object</param>

### removeResponseCallback

```csharp
public void removeResponseCallback(LBMResponseCallback cb)
```

Deregister a request response callback

<remarks>
<seealso cref="LBMResponseCallback"/>
<seealso cref="addResponseCallback"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMResponseCallback delegate interface</param>

### removeResponseCallback

```csharp
public void removeResponseCallback(LBMResponseCallback cb, object cbArg)
```

Deregister a request response callback

<remarks>
<seealso cref="LBMResponseCallback"/>
<seealso cref="addResponseCallback"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMResponseCallback delegate interface</param>
<param name="cbArg">Token for previously registered callback</param>

### setObjectRecycler

```csharp
public void setObjectRecycler(LBMObjectRecyclerBase objRec, Object objRecCbArg)
```

Set the LBM object recycler that can be used by the context to reuse LBMMessage objects as
well as LBM Context/Receiver/Source Statistics objects.

<param name="objRec">an LBM object recycler that will be called when objects need to be retrieved</param>
<param name="objRecCbArg">a callback object token that will be passed in the retrieve method</param>

### Dispose

```csharp
public void Dispose()
```

Same as <see cref="close"/>

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks><seealso cref="close"/></remarks>

## LBMResolverEventCallback

*delegate* `com.latencybusters.lbm.LBMResolverEventCallback`

### LBMResolverEventCallback

```csharp
public delegate int LBMResolverEventCallback(object cbArg, LBMResolverEvent resolverEvent)
```

Resolver event callback.
<param name="cbArg">Callback object token </param>
<param name="resolverEvent">LBMResolverEvent object encapsulating event </param>
<returns> an int, which should always be 0. </returns>

## LBMResponseCallback

*delegate* `com.latencybusters.lbm.LBMResponseCallback`

### LBMResponseCallback

```csharp
public delegate int LBMResponseCallback(object cbArg, LBMRequest lbmreq, LBMMessage lbmmsg)
```

Request response callback delegate

<param name="cbArg">Callback object token</param>
<param name="lbmreq">LBMRequest object corresponding to the original request</param>
<param name="lbmmsg">LBMMessage object encapsulating the received message response</param>
<returns>-1 indicates that the response could not be received and should be redelivered.
(Note: if multiple callbacks are registered, a -1 return from any callback will cause the
message to be redelivered to all the callbacks.)</returns>

## LBMSource

*class* `com.latencybusters.lbm.LBMSource`

### LBMSource

```csharp
public LBMSource(LBMContext lbmctx, LBMTopic lbmtopic) : this(lbmctx, lbmtopic, (LBMSourceEventCallback)null, null, null)
```

Instantiate an LBM Source object associated with a given context
and topic

<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<param name="lbmctx">Context with which to associate the source</param>
<param name="lbmtopic">LBMTopic used to initialize the source</param>

### LBMSource

```csharp
public LBMSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMSourceEventCallback cb, object cbArg) : this(lbmctx, lbmtopic, cb, cbArg, null)
```

Instantiate an LBM Source object associated with a given context
and topic and initialize source event callback

<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<param name="lbmctx">Context with which to associate the source</param>
<param name="lbmtopic">LBMTopic used to initialize the source</param>
<param name="cb">Callback implementing the LBMSourceEventCallback delegate interface</param>
<param name="cbArg">Callback token object</param>

### LBMSource

```csharp
public LBMSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMEventQueue lbmevq) : this(lbmctx, lbmtopic, (LBMSourceEventCallback)null, null, lbmevq)
```

Instantiate an LBM Source object associated with a given context,
topic, and event queue

<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<param name="lbmctx">Context with which to associate the source</param>
<param name="lbmtopic">LBMTopic used to initialize the source</param>
<param name="lbmevq">Event queue with which to associate the source
(all source events will be posted to this event queue)</param>

### LBMSource

```csharp
public LBMSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMSourceEventCallback cb, object cbArg, LBMEventQueue lbmevq)
```

Instantiate an LBM Source object associated with a given context,
topic, and event queue and initialize source event callback

<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Topic is not a source topic</exception>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="lbmctx">Context with which to associate the source</param>
<param name="lbmtopic">LBMTopic used to initialize the source</param>
<param name="cb">Callback implementing the LBMSourceEventCallback delegate interface</param>
<param name="cbArg">Callback token object</param>
<param name="lbmevq">Event queue with which to associate the source</param>

### close

```csharp
public void close()
```

Close and dispose of this source

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>

### umederegister

```csharp
public void umederegister()
```

Deregister the UME Source

<returns>
Void
</returns>

### isClosed

```csharp
public bool isClosed()
```

Check if a source has been closed

<returns>
A bool that is true if the source no longer points to a valid C reference
</returns>

### createChannel

```csharp
public LBMSourceChannelInfo createChannel(long channelNumber)
```

Create a channel object to send messages with the given channel number.

<param name="channelNumber">Channel number in the range 0-4294967295</param>
<returns>A new LBMSourceChannelInfo object</returns>

### deleteChannel

```csharp
public void deleteChannel(LBMSourceChannelInfo channelInfo)
```

Deletea channel object

<param name="channelInfo">A channelInfo object</param>

### addSourceCallback

```csharp
public void addSourceCallback(LBMSourceEventCallback cb)
```

Register a source event callback

<remarks>
<seealso cref="LBMSourceEventCallback"/>
<seealso cref="removeSourceCallback"/>
</remarks>
<param name="cb">Callback implementing the LBMSourceEventCallback delegate interface</param>

### addSourceCallback

```csharp
public void addSourceCallback(LBMSourceEventCallback cb, object cbArg)
```

Register a source event callback (and callback token)

<remarks>
<seealso cref="LBMSourceEventCallback"/>
<seealso cref="removeSourceCallback"/>
</remarks>
<param name="cb">Callback implementing the LBMSourceEventCallback delegate interface</param>
<param name="cbArg">Callback token object</param>

### removeSourceCallback

```csharp
public void removeSourceCallback(LBMSourceEventCallback cb)
```

Deregister a source event callback

<remarks>
<seealso cref="LBMSourceEventCallback"/>
<seealso cref="addSourceCallback"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMSourceEventCallback delegate interface</param>

### removeSourceCallback

```csharp
public void removeSourceCallback(LBMSourceEventCallback cb, object cbArg)
```

Deregister a source event callback

<remarks>
<seealso cref="LBMSourceEventCallback"/>
<seealso cref="addSourceCallback"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMSourceEventCallback delegate interface</param>
<param name="cbArg">Callback token object</param>

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Dump source configuration options

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>An array of LBMConfigOptions</returns>

### getAttributeValue

```csharp
public string getAttributeValue(string attributeName)
```

Returns the value of a source-related attribute for this source

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setAttributeValue

```csharp
public void setAttributeValue(string attributeName, string attributeValue)
```

Set the value of a source-related attribute for this source

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### getStatistics

```csharp
public LBMSourceStatistics getStatistics()
```

Return the current set of source transport statistics for this source

<returns>LBMSourceStatistics object containing the statistics
corresponding to this source</returns>

### resetStatistics

```csharp
public void resetStatistics()
```

This will reset the transport statistics for this source.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### getInflight

```csharp
public int getInflight(int type)
```

Get the current inflight value for this source
<param name="type">The type of flight size</param>
<returns>the inflight value</returns>
<exception ref="com.latencybusters.lbm.LBMException">if an error occurs while retrieving the inflight value</exception>

### setInflight

```csharp
public int setInflight(int type, LBMSetInflightCallback cb, object cbObj)
```

Set the current inflight value for this source
<param name="type">The type of flight size</param>
<param name="cb">LBMSetInflightCallback delegate</param>
<param name="cbObj">Client object passed into callback</param>
<returns>the new inflight value</returns>
<exception ref="com.latencybusters.lbm.LBMException">if an error occurs while setting the inflight value</exception>

### getInflight

```csharp
public void getInflight(int type, out int messages, out ulong bytes)
```

Get the current inflight values for message and bytes.

<param name="type">The type of flight size</param>
<param name="messages">This reference will be set to the current number of inflight messages.</param>
<param name="bytes">This reference will be set to the current number of inflight bytes.</param>

### setInflight

```csharp
public void setInflight(int type, out int messages, out ulong bytes, LBMSetInflightCallbackEx cb, object cbObj)
```

Set the current inflight messages and bytes for this source. Note that increasing one value while decreasing the other is not allowed.
If you need to do this, call setInflight twice using 0 as the value for the one you are not changing.

<param name="type">The type of flight size</param>
<param name="messages">This reference will be set to the new number of inflight messages</param>
<param name="bytes">This reference will be set to the new number of inflight bytes</param>
<param name="cb">Delegate called when appropriate locking is held to let the application safely set set values</param>
<param name="cbObj">Client object passed into the callback</param>

### setUMEMessageStable

```csharp
public void setUMEMessageStable(long sqn)
```

Mark a specific sqn as stable, triggering an event if configured to do so, and adjusting the inflight if necessary
<param name="sqn">Sqn of the fragment to mark stable</param>
<exception ref="com.latencybusters.lbm.LBMException">if an error occurs while marking the fragment stable</exception>

### send

```csharp
public void send(byte[] message, int messageLength, int flags)
```

Send a message to the topic associated with the LBM source

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

<para>
Possible OR'd set of flag value include:
</para>
<see cref="LBM.SRC_NONBLOCK"/>,
<see cref="LBM.SRC_BLOCK"/>,
<see cref="LBM.MSG_START_BATCH"/>,
<see cref="LBM.MSG_END_BATCH"/>,
<see cref="LBM.MSG_COMPLETE_BATCH"/>, and
<see cref="LBM.MSG_FLUSH"/>
<see cref="LBM.SRC_EVENT_UME_MESSAGE_STABLE"/>
<see cref="LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION"/>
</remarks>
<param name="message">Data to send in this message</param>
<param name="messageLength">Number of bytes of data to send in this message</param>
<param name="flags">Flags indicating various conditions</param>

### send

```csharp
public void send(byte[] message, int messageLength, int flags, object cbArg)
```

Send a message to the topic associated with the LBM source

<exception ref="com.latencybusters.lbm.LBMEInvalException">Certified delivery notification is not enabled</exception>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

<para>
Possible OR'd set of flag value include:
</para>
<see cref="LBM.SRC_NONBLOCK"/>,
<see cref="LBM.SRC_BLOCK"/>,
<see cref="LBM.MSG_START_BATCH"/>,
<see cref="LBM.MSG_END_BATCH"/>,
<see cref="LBM.MSG_COMPLETE_BATCH"/>, and
<see cref="LBM.MSG_FLUSH"/>
<see cref="LBM.SRC_EVENT_UME_MESSAGE_STABLE"/>
<see cref="LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION"/>
</remarks>
<param name="message">Data to send in this message</param>
<param name="messageLength">Number of bytes of data to send in this message</param>
<param name="flags">Flags indicating various conditions</param>
<param name="cbArg">Client object to be passed back in stability or
confirmation events related to this message (UME only)</param>

### send

```csharp
public void send(byte[] message, int messageLength, int flags, LBMSourceSendExInfo exinfo)
```

Send a message to the topic associated with the LBM source

<exception ref="com.latencybusters.lbm.LBMEInvalException">Confirmed delivery or message stability notifications are not enabled</exception>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

<para>
Possible OR'd set of flag value include:
</para>
<see cref="LBM.SRC_NONBLOCK"/>,
<see cref="LBM.SRC_BLOCK"/>,
<see cref="LBM.MSG_START_BATCH"/>,
<see cref="LBM.MSG_END_BATCH"/>,
<see cref="LBM.MSG_COMPLETE_BATCH"/>, and
<see cref="LBM.MSG_FLUSH"/>
<see cref="LBM.SRC_EVENT_UME_MESSAGE_STABLE"/>
<see cref="LBM.SRC_EVENT_UME_MESSAGE_STABLE_EX"/>
<see cref="LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION"/>
<see cref="LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX"/>
</remarks>
<param name="message">Data to send in this message</param>
<param name="messageLength">Number of bytes of data to send in this message</param>
<param name="flags">Flags indicating various conditions</param>
<param name="exinfo">LBMSourceSendExInfo object, which includes flags to
change callback behavior and a client-supplied object to be passed back. (UME only)</param>

### send

```csharp
public void send(LBMRequest lbmreq, int flags)
```

Send a request message to the topic associated with the LBM source

<remarks>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

<para>Possible OR'd set of flag value include:</para>
<see cref="LBM.SRC_NONBLOCK"/>,
<see cref="LBM.SRC_BLOCK"/>,
<see cref="LBM.MSG_START_BATCH"/>,
<see cref="LBM.MSG_END_BATCH"/>,
<see cref="LBM.MSG_COMPLETE_BATCH"/>, and
<see cref="LBM.MSG_FLUSH"/>
</remarks>
<param name="lbmreq">LBMRequest object</param>
<param name="flags">Flags indicating various conditions</param>

### send

```csharp
public void send(LBMRequest lbmreq, LBMEventQueue lbmevq, int flags)
```

Send a request message to the topic associated with the LBM source
using a designated event queue for responses

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

<para>Possible OR'd set of flag value include:</para>
<see cref="LBM.SRC_NONBLOCK"/>,
<see cref="LBM.SRC_BLOCK"/>,
<see cref="LBM.MSG_START_BATCH"/>,
<see cref="LBM.MSG_END_BATCH"/>,
<see cref="LBM.MSG_COMPLETE_BATCH"/>, and
<see cref="LBM.MSG_FLUSH"/>
</remarks>
<param name="lbmreq">LBMRequest object</param>
<param name="lbmevq">LBMEventQueue used to handle response messages</param>
<param name="flags">Flags indicating various conditions</param>

### send

```csharp
public void send(LBMRequest lbmreq, int flags, LBMSourceSendExInfo exinfo)
```

Send a request message to the topic associated with the LBM source
using an designated event queue for responses

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

<para>Possible OR'd set of flag value include:</para>
<see cref="LBM.SRC_NONBLOCK"/>,
<see cref="LBM.SRC_BLOCK"/>,
<see cref="LBM.MSG_START_BATCH"/>,
<see cref="LBM.MSG_END_BATCH"/>,
<see cref="LBM.MSG_COMPLETE_BATCH"/>, and
<see cref="LBM.MSG_FLUSH"/>
</remarks>
<param name="lbmreq">LBMRequest object</param>
<param name="flags">Flags indicating various conditions</param>
<param name="exinfo">LBMSourceSendExInfo object, which includes flags to
change callback behavior and a client-supplied object to be passed back. (UME only)</param>

### send

```csharp
public void send(LBMRequest lbmreq, LBMEventQueue lbmevq, int flags, LBMSourceSendExInfo exinfo)
```

Send a request message to the topic associated with the LBM source
using an designated event queue for responses

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
 handle any LBM_EWOULDBLOCK errors internally.
 \warning Do not call this function from a context thread callback for persistence stability
          or persistence confirmation events.  It can result in deadlock.

<para>Possible OR'd set of flag value include:</para>
<see cref="LBM.SRC_NONBLOCK"/>,
<see cref="LBM.SRC_BLOCK"/>,
<see cref="LBM.MSG_START_BATCH"/>,
<see cref="LBM.MSG_END_BATCH"/>,
<see cref="LBM.MSG_COMPLETE_BATCH"/>, and
<see cref="LBM.MSG_FLUSH"/>
</remarks>
<param name="lbmreq">LBMRequest object</param>
<param name="lbmevq">LBMEventQueue used to handle response messages</param>
<param name="flags">Flags indicating various conditions</param>
<param name="exinfo">LBMSourceSendExInfo object, which includes flags to
change callback behavior and a client-supplied object to be passed back. (UME only)</param>

### flush

```csharp
public void flush()
```

Send messages from both the explicit and implicit batches ASAP.

<remarks>

\note calling lbm_src_flush() for a given source effectively flushes the
 implicit batcher for \a all sources on the same transport session.

 \warning Do not call this function from a context thread callback.
          It can result in deadlock.
</remarks>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### buffAcquire

```csharp
public int buffAcquire(out IntPtr bufp, uint len, int flags)
```

Acquire a pointer to a buffer of the specified length, to be filled in and sent later.
<b>Warning</b>: this API is NOT thread safe between sources on the same transport session.
For thread safety, use the <see cref="send"/> api.

<param name="bufp">A pointer to the location in memory availble for writing to.</param>
<param name="len">The request length of the buffer in bytes</param>
<param name="flags">Set to <see cref="LBM.SRC_NONBLOCK"/> for non-blocking behavior. Default is blocking.</param>
<returns>0 if successful, -1 if send would block and non-blocking sends were requested.</returns>

### buffsComplete

```csharp
public void buffsComplete()
```

Sends all buffers on a transport session that had ben previously acquired.
<b>Warning</b>: this API is NOT thread safe between sources on the same transport session.

### buffsCompleteAndAcquire

```csharp
public int buffsCompleteAndAcquire(out IntPtr bufp, uint len, int flags)
```

First sends all buffers on a transport session that had ben previously acquired, and
then acquires a pointer to a buffer of the specified length, to be filled in and sent later.
<b>Warning</b>: this API is NOT thread safe between sources on the same transport session.

<param name="bufp">A pointer to the location in memory availble for writing to.</param>
<param name="len">The request length of the buffer in bytes</param>
<param name="flags">Set to <see cref="LBM.SRC_NONBLOCK"/> for non-blocking behavior. Default is blocking.</param>
<returns>0 if successful, -1 if send would block and non-blocking sends were requested.</returns>

### buffsCancel

```csharp
public void buffsCancel()
```

Cancels all outstanding (not yet completed) buffers previously acquired using <see cref="buffAcquire"/>
or <see cref="buffsCompleteAndAcquire"/>. All such acquired but not completed buffers for this source (only)
will no longer be received by any receives.

### Dispose

```csharp
public void Dispose()
```

Same as <see cref="close"/>

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks><seealso cref="close"/></remarks>

## LBMSourceAttributes

*class* `com.latencybusters.lbm.LBMSourceAttributes`

### LBMSourceAttributes

```csharp
unsafe public LBMSourceAttributes()
```

Instantiate LBMSourceAttributes class

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### LBMSourceAttributes

```csharp
unsafe public LBMSourceAttributes(string contextName, string topicName)
```

Instantiate an LBMSourceAttributes class using a context name and topic name from the xml configuration that
must have been previously loaded.

<param name="contextName">The context name under which this source is to be created</param>
<param name="topicName">The source topic name under which this source is to be created</param>
<exception ref="com.latencybusters.lbm.LBMException">The context name or source topic name is not permitted by XML configuration or other unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of attributes.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of attributes (same as Dispose()).
<seealso cref="Dispose"/>

### setFromXml

```csharp
unsafe public void setFromXml(string contextName, string topicName)
```

Set values in an LBMSourceAttributes class using a context name and topic name from the xml configuration that
must have been previously loaded.

<param name="contextName">The context name under which this source is to be created</param>
<param name="topicName">The source topic name under which this source is to be created</param>
<exception ref="com.latencybusters.lbm.LBMException">The context name or source topic name is not permitted by XML configuration or other unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Dump source configuration options

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>An array of LBMConfigOptions</returns>

### getValue

```csharp
unsafe public string getValue(string attributeName)
```

Returns the current value of an attribute from this set of
source-related attributes

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setValue

```csharp
unsafe public void setValue(string attributeName, string attributeValue)
```

Set the current value of an attribute in this set of
source-related attributes

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### setObjectRecycler

```csharp
public void setObjectRecycler(LBMObjectRecyclerBase objRec, Object objRecCbArg)
```

Set the LBM object recycler that can be used by the context to reuse LBMMessage objects as
well as LBM Context/Receiver/Source Statistics objects.

<param name="objRec">an LBM object recycler that will be called when objects need to be retrieved</param>
<param name="objRecCbArg">a callback object token that will be passed in the retrieve method</param>

### getStores

```csharp
unsafe public UMEStoreEntry[] getStores()
```

Gets an array of the UME stores this source has configuration entries for.

<returns>An array of UMEStoreEntry objects. Each member of the array
contains information about a different UME store.</returns>

### getStoreGroups

```csharp
unsafe public UMEStoreGroupEntry[] getStoreGroups()
```

Gets an array of the UME store groups this source has configured.

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>An array of UMEStoreGroupEntry objects. Each member of the array
contains information about a different UME store group.</returns>

### setMessageReclamationCallback

```csharp
public void setMessageReclamationCallback(LBMMessageReclamationCallback cb, object cbArg)
```

Register a callback interface (and a callback handle argument) to be
called when a message is forcibly reclaimed from the collection of
retained messages on a UME source (UME only).

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
This callback is called directly in line and does not use the event queue;
therefore, the callback function used should not block or it will block the
context thread processing.
<seealso cref="LBMMessageReclamationCallback"/>
</remarks>
<param name="cb">An object implementing the LBMMessageReclamationCallback delegate interface</param>
<param name="cbArg">Callback object passed as a token to the callback interface</param>

## LBMSourceChannelInfo

*class* `com.latencybusters.lbm.LBMSourceChannelInfo`

### LBMSourceChannelInfo

```csharp
public LBMSourceChannelInfo(LBMSource source, long channel_number)
```

 Instantiate an LBM Source Channel Info object associated with a given source.
<param name="source">The LBMSource object that will be used to send messages on the channel to be created.</param>
<param name="channel_number">A channel number in the range 0-4294967295.</param>
<exception ref="com.latencybusters.lbm.LBMException"></exception>

### close

```csharp
public void close()
```

Reclaim resources associated with the underlying LBM data structures
once the channel info object will no longer be used.

## LBMSourceCostCallback

*delegate* `com.latencybusters.lbm.LBMSourceCostCallback`

### LBMSourceCostCallback

```csharp
public delegate uint LBMSourceCostCallback(object cbArg, string topic, LBMTransportSourceInfo transport, uint hop_count, uint cost)
```

Application callback to evaluate the cost of a newly discovered source.  Set via the context attributes
setSourceCostCallback function.

<param name="cbArg">Callback object token</param>
<param name="topic">Topic for which the new source was discovered</param>
<param name="transport">LBMTransportSourceInfo object describing the transport session</param>
<param name="hop_count">Current hop count for the transport session</param>
<param name="cost">Current cumulative cost for the transport session</param>
<returns>Application-determined cost for this source as an unsigned 32-bit number.
To permanently reject this source, return LBM.LBM_SRC_COST_FUNCTION_REJECT</returns>

## LBMSourceCreationCallback

*delegate* `com.latencybusters.lbm.LBMSourceCreationCallback`

### LBMSourceCreationCallback

```csharp
public delegate object LBMSourceCreationCallback(string sourceName, object cbArg)
```

Application callback for notification of creation of sources for a topic.

<param name="sourceName">The unique source name string (e.g., "TCP:192.168.0.4:45789").</param>
<param name="cbArg">Callback object token.</param>
<returns>User-supplied callback object to pass in to corresponding <see cref="LBMSourceDeletionCallback"/> callback.</returns>

## LBMSourceDeletionCallback

*delegate* `com.latencybusters.lbm.LBMSourceDeletionCallback`

### LBMSourceDeletionCallback

```csharp
public delegate int LBMSourceDeletionCallback(string sourceName, object cbArg, object sourceCbArg)
```

Application callback for notification of deletion of sources for a topic.

<param name="sourceName">The unique source name string (e.g., "TCP:192.168.0.4:45789").</param>
<param name="cbArg">Callback object token.</param>
<param name="sourceCbArg">Callback object token returned by the corresponding <see cref="LBMSourceCreationCallback"/>.</param>
<returns></returns>

## LBMSourceEvent

*class* `com.latencybusters.lbm.LBMSourceEvent`

### type

```csharp
public int type()
```

LBM Source Event type.

<returns>LBM Source Event type</returns>
<remarks>
<seealso cref="LBM"/>
</remarks>

### registrationId

```csharp
public long registrationId()
```

Registration ID associated with this event.

<remarks>This value may not be valid for all event types.
</remarks>
<returns>Registration ID.</returns>

### sequenceNumber

```csharp
public long sequenceNumber()
```

Sequence number associated with this event.

<remarks>This value may not be valid for all event types.
</remarks>
<returns>Sequence number.</returns>

### dataString

```csharp
public string dataString()
```

String data associated with this event.

<remarks>This value may not be valid for all event types.
</remarks>
<returns>Event string data</returns>

### clientObject

```csharp
public object clientObject()
```

Client callback object.

<remarks>
This object is specified by the application using another API method.
<seealso cref="LBMSource.send(byte[],int,int,object)"/>
</remarks>
<returns>Client callback object</returns>

### sourceWakeupInfo

```csharp
public LBMSourceEventWakeupInfo sourceWakeupInfo()
```

Source wakeup info object.

<remarks>Contains extended information about a source wakeup event.</remarks>
<returns>Source wakeup info object.</returns>

### registrationSuccessInfo

```csharp
public UMESourceEventRegistrationSuccessInfo registrationSuccessInfo()
```

Registration success info object.

<remarks>Contains extended registration information.</remarks>
<returns>Extended registration success info object.</returns>

### registrationCompleteInfo

```csharp
public UMESourceEventRegistrationCompleteInfo registrationCompleteInfo()
```

Registration complete info.

<remarks>
Contains extended registration complete information.
</remarks>
<returns>Registration complete info.</returns>

### ackInfo

```csharp
public UMESourceEventAckInfo ackInfo()
```

Gets extended ACK info.

<returns>Ack info.</returns>

### deregistrationSuccessInfo

```csharp
public UMESourceEventDeregistrationSuccessInfo deregistrationSuccessInfo()
```

Gets deregistration success info

<returns>UMESourceDeregistrationSuccess Info</returns>

### deregistrationCompleteInfo

```csharp
public UMESourceEventDeregistrationCompleteInfo deregistrationCompleteInfo()
```

Gets deregistration complete info

<returns>UMESourceDeregistrationComplete Info</returns>

### sequenceNumberInfo

```csharp
public LBMSourceEventSequenceNumberInfo sequenceNumberInfo()
```

Gets extended sequence number info.

<returns>Sequence number info.</returns>

### messageIdInfo

```csharp
public UMQSourceEventMessageIdInfo messageIdInfo()
```

Gets an object describing teh message ID assigned to a message (UMQ only)

<returns>A UMQSourceEventMessageIdInfo object containing message ID information</returns>

### queueAckInfo

```csharp
public UMQSourceEventAckInfo queueAckInfo()
```

Gets an object containing extended information about a stability acknowledgement event. (UMQ only)

<returns>A UMQSourceEventAckInfo object with additional information about a stability ack event.</returns>

### queueRegistrationCompleteInfo

```csharp
public UMQSourceEventRegistrationCompleteInfo queueRegistrationCompleteInfo()
```

Queue registration complete info. (UMQ only)

<remarks>
Contains extended queue registration complete information.
</remarks>
<returns>A UMQSourceVentRegistrationCompleteInfo object containing registration complete info.</returns>

### ulbReceiverInfo

```csharp
public UMQSourceEventULBReceiverInfo ulbReceiverInfo()
```

Gets an object containing extended information about a ULB receiver event. (UMQ only)

<returns>A UMQSourceEventULBReceiverInfo object with additional information about a ULB receiver event.</returns>

### ulbMessageInfo

```csharp
public UMQSourceEventULBMessageInfo ulbMessageInfo()
```

Gets an object containing extended information about a ULB message event. (UMQ only)

<returns>A UMQSourceEventULBMessageInfo object with additional information about a ULB message event.</returns>

### flightSizeNotification

```csharp
public LBMSourceEventFlightSizeNotification flightSizeNotification()
```

Gets an object containing flight size information.

<returns>An LBMSourceEventFlightSizeNotification object with information about the current inflight.</returns>

### timestampInfo

```csharp
public LBMSourceEventTimestampInfo timestampInfo()
```

Gets an object containing timestamp information.

<returns>An LBMSourceEventTimestamp object with information about the timestamp of a sent message.</returns>

### promote

```csharp
public LBMSourceEvent promote()
```

This method should be called if the application wishes to continue
processing the source event on another thread, or after the source event callback returns.

<returns>the promoted LBMSourceEvent</returns>

### dispose

```csharp
public void dispose()
```

This method should be called before the source event callback returns
to indicate that the application is finished with the source event allowing it
to be reused when processing a future source event

## LBMSourceEventCallback

*delegate* `com.latencybusters.lbm.LBMSourceEventCallback`

### LBMSourceEventCallback

```csharp
public delegate void LBMSourceEventCallback(object cbArg, LBMSourceEvent sourceEvent)
```

Source event callback delegate

<param name="cbArg">Callback object token</param>
<param name="sourceEvent">LBMSourceEvent object encapsulating source event information</param>

## LBMSourceEventFlightSizeNotification

*class* `com.latencybusters.lbm.LBMSourceEventFlightSizeNotification`

### LBMSourceEventFlightSizeNotification

```csharp
public LBMSourceEventFlightSizeNotification(int type, int state)
```

Creates an LBMSourceEventFlightSizeNotification object and initializes fields to the give values.

<param name="type">type of flight size in question.
</param>
<param name="state">current state (over or under).
</param>

### type

```csharp
public virtual int type()
```

 Get type.
<returns> type of flight size.</returns>

### state

```csharp
public virtual int state()
```

 Get state.
<returns> state of flight size.</returns>

## LBMSourceEventSequenceNumberInfo

*class* `com.latencybusters.lbm.LBMSourceEventSequenceNumberInfo`

### LBMSourceEventSequenceNumberInfo

```csharp
public LBMSourceEventSequenceNumberInfo()
```

Creates an LBMSourceEventSequenceNumberInfo object with all fields initialized to 0/null.

### LBMSourceEventSequenceNumberInfo

```csharp
public LBMSourceEventSequenceNumberInfo(int flags, uint firstSeqNum, uint lastSeqNum, object clientd)
```

Creates an LBMSourceEventSequenceNumberInfo with fields initialized to the given values.

<exception ref="com.latencybusters.lbm.LBMEInvalException">First sequence number was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Last sequence number was &lt; 0.</exception>
<param name="flags">Flags concerning when sequence number messages are sent.</param>
<param name="firstSeqNum">First sequence number (must be &gt;= 0).</param>
<param name="lastSeqNum">Last sequence number (must be &gt;= 0).</param>
<param name="clientd">Client-supplied callback object.</param>

### flags

```csharp
public int flags()
```

Get sequence number message flags.

<returns>Flags indicating when sequence number messages are sent.</returns>

### firstSequenceNumber

```csharp
public uint firstSequenceNumber()
```

Get the first sequence number.

<returns>The first sequence number.</returns>

### lastSequenceNumber

```csharp
public uint lastSequenceNumber()
```

Get the last sequence number.

<returns>The last sequence number.</returns>

### clientObject

```csharp
public object clientObject()
```

Get the client-supplied callback object.

<returns>Client-supplied object.</returns>

## LBMSourceEventTimestampInfo

*class* `com.latencybusters.lbm.LBMSourceEventTimestampInfo`

### LBMSourceEventTimestampInfo

```csharp
public LBMSourceEventTimestampInfo(UInt64 tvSec, UInt64 tvNsec, uint sequenceNumber)
```

Construct a LBMSourceEventTimestampInfo object and initialize its fields to the given values.

<exception ref="com.latencybusters.lbm.LBMEInvalException">Sequence number was &lt; 0.</exception>
<param name="tvSec">High-resolution timestamp, seconds.</param>
<param name="tvNsec">High-resolution timestamp, nanoseconds.</param>
<param name="sequenceNumber">Sequence number (must be &gt;= 0).</param>

### sequenceNumber

```csharp
public uint sequenceNumber()
```

Get the sequence number of the message the event was received for.

<returns>Sequence number.</returns>

### tvSec

```csharp
public UInt64 tvSec()
```

Get the seconds portion of the high-resolution timestamp of the sent message.

<returns>High-resolution timestamp seconds.</returns>

### tvNsec

```csharp
public UInt64 tvNsec()
```

Get the nanoseconds portion of the high-resolution timestamp of the sent message.

<returns>High-resolution timestamp nanoseconds.</returns>

## LBMSourceEventWakeupInfo

*class* `com.latencybusters.lbm.LBMSourceEventWakeupInfo`

### flags

```csharp
public int flags()
```

Retrieve flags indicating what type of source(s) (normal, MIM, etc.) has woken up.

<returns>Flags indicating what type of source(s) this wakeup event is for.</returns>
<see cref="LBM.SRC_EVENT_WAKEUP_FLAG_NORMAL"/>
<see cref="LBM.SRC_EVENT_WAKEUP_FLAG_MIM"/>
<see cref="LBM.SRC_EVENT_WAKEUP_FLAG_UIM"/>
<see cref="LBM.SRC_EVENT_WAKEUP_FLAG_REQUEST"/>
<see cref="LBM.SRC_EVENT_WAKEUP_FLAG_RESPONSE"/>

## LBMSourceNotification

*delegate* `com.latencybusters.lbm.LBMSourceNotification`

### LBMSourceNotification

```csharp
public delegate void LBMSourceNotification(string topic, string source, object cbArg)
```

New source notification callback delegate

<param name="topic">Topic string for available</param>
<param name="source">String identifing source advertising on this topic</param>
<param name="cbArg">Callback object token</param>

## LBMSourceSendExInfo

*class* `com.latencybusters.lbm.LBMSourceSendExInfo`

### LBMSourceSendExInfo

```csharp
public LBMSourceSendExInfo() :this(0, null, null, null, null, null)
```

Create an empty LBMSourceSendExInfo object.

### LBMSourceSendExInfo

```csharp
public LBMSourceSendExInfo(int flags, object cbArg) :this(flags, cbArg, null, null, null, null)
```

Create an LBMSourceSendExInfo object with flags and callback object set.

<param name="flags">Flags to control callback behavior.</param>
<param name="cbArg">User-supplied object passed back with any callbacks.</param>

### LBMSourceSendExInfo

```csharp
public LBMSourceSendExInfo(int flags, object cbArg, LBMSourceChannelInfo channelInfo) :this(flags, cbArg, channelInfo, null, null, null)
```

Create an LBMSourceSendExInfo object with flags and callback object set
as well as channel information included.

<param name="flags">Flags to control callback behavior.</param>
<param name="cbArg">User-supplied object passed back with any callbacks.</param>
<param name="channelInfo">Channel information to be included with messages.</param>

### LBMSourceSendExInfo

```csharp
public LBMSourceSendExInfo(int flags, object cbArg, LBMSourceChannelInfo channelInfo, UMQIndexInfo umqIndex) :this(flags, cbArg, channelInfo, umqIndex, null, null)
```

Create an LBMSourceSendExInfo object with flags and callback object set
as well as channel information included.

<param name="flags">Flags to control callback behavior.</param>
<param name="cbArg">User-supplied object passed back with any callbacks.</param>
<param name="channelInfo">Channel information to be included with messages.</param>
<param name="umqIndex">UMQ index to send on.</param>

### LBMSourceSendExInfo

```csharp
public LBMSourceSendExInfo(int flags, object cbArg, LBMSourceChannelInfo channelInfo, UMQIndexInfo umqIndex, UMQMessageTotalLifetimeInfo lifetimeInfo) :this(flags, cbArg, channelInfo, umqIndex, lifetimeInfo, null)
```

Create an LBMSourceSendExInfo object with flags and callback object set

<param name="flags">Flags to control callback behavior.</param>
<param name="cbArg">User-supplied object passed back with any callbacks.</param>
<param name="channelInfo">Channel information to be included with messages.</param>
<param name="umqIndex">UMQ index to send on.</param>
<param name="lifetimeInfo">UMQ total lifetime info to send with messages.</param>

### LBMSourceSendExInfo

```csharp
public LBMSourceSendExInfo(int flags, object cbArg, LBMSourceChannelInfo channelInfo, UMQIndexInfo umqIndex, UMQMessageTotalLifetimeInfo lifetimeInfo, LBMMessageProperties properties)
```

Create an LBMSourceSendExInfo object with flags and callback object set

<param name="flags">Flags to control callback behavior.</param>
<param name="cbArg">User-supplied object passed back with any callbacks.</param>
<param name="channelInfo">Channel information to be included with messages.</param>
<param name="umqIndex">UMQ index to send on.</param>
<param name="properties">Message properties to be included in message.</param>
<param name="lifetimeInfo">UMQ total lifetime info to send with messages.</param>

### setClientObject

```csharp
public void setClientObject(object cbArg)
```

Set the user-supplied callback object.

<param name="cbArg">User-supplied object passed back with any callbacks.</param>

### setFlags

```csharp
public void setFlags(int flags)
```

Sets flags that control callback behavior.

<param name="flags">Flags.</param>

### setChannelInfo

```csharp
public void setChannelInfo(LBMSourceChannelInfo channelInfo)
```

Sets channel information to be included with messages, or removes the channel info if
NULL is passed. Also, updates the LBM.SRC_SEND_EX_FLAG_CHANNEL bit in flags as appropriate.

### setMessageProperties

```csharp
public void setMessageProperties(LBMMessageProperties properties)
```

Sets properties to be included with messages, or removes the properties if
NULL is passed. Also, updates the LBM.SRC_SEND_EX_FLAG_PROPERTIES bit in flags as appropriate.

<param name="properties">A properties object to be associated with this object.</param>

### flags

```csharp
public int flags()
```

Returns currently set flags.

<returns>An int representing an OR'd set of currently set flags.</returns>

### clientObject

```csharp
public object clientObject()
```

Returns the client-supplied callback object.

<returns>The current client-supplied callback object.</returns>

### channelInfo

```csharp
public LBMSourceChannelInfo channelInfo()
```

Returns the currently set channel information.

<returns>The current channel information</returns>

### properties

```csharp
public LBMMessageProperties properties()
```

Returns the currently set properties information.

<returns>The current properties information</returns>

### setIndexInfo

```csharp
public void setIndexInfo(UMQIndexInfo indexInfo)
```

Sets the index info to be included with messages, or removes the index info if
NULL is passed. Also, updates the LBM.SRC_SEND_EX_FLAG_UMQ_INDEX bit in flags as appropriate.

<param name="indexInfo">An index info object</param>

### indexInfo

```csharp
public UMQIndexInfo indexInfo()
```

<remarks>Returns the currently set index info.</remarks>
<returns>The current index info.</returns>

### setTotalLifetimeInfo

```csharp
public void setTotalLifetimeInfo(UMQMessageTotalLifetimeInfo lifetimeInfo)
```

Sets the total lifetime info to be included with messages, or removes the total lifetime info if
NULL is passed. Also, updates the LBM.SRC_SEND_EX_FLAG_UMQ_TOTAL_LIFETIME bit in flags as appropriate.

<param name="lifetimeInfo">A total lifetime info object</param>

### totalLifetimeInfo

```csharp
public UMQMessageTotalLifetimeInfo totalLifetimeInfo()
```

<remarks>Returns the currently set total lifetime info.</remarks>
<returns>The current total lifetime info.</returns>

### setHfSequenceNumber32

```csharp
public void setHfSequenceNumber32(uint hfsqn)
```

Set the 32 bit hot failover sequence number to send

<param name="hfsqn">Unsigned 32 bit HF sequence number</param>

### setHfSequenceNumber64

```csharp
public void setHfSequenceNumber64(ulong hfsqn)
```

Set the 64 bit hot failover sequence number to send

<param name="hfsqn">Unsigned 64 bit HF sequence number</param>

### getHfSequenceNumber32

```csharp
public uint getHfSequenceNumber32()
```

Get the currently set 32 bit hot failover sequence number.

<returns>32 bit hot failover sequence number</returns>

### getHfSequenceNumber64

```csharp
public ulong getHfSequenceNumber64()
```

Get the currently set 64 bit hot failover sequence number

<returns>64 bit hot failover sequence number</returns>

## LBMSourceStatistics

*class* `com.latencybusters.lbm.LBMSourceStatistics`

### LBMSourceStatistics

```csharp
public LBMSourceStatistics()
```

Instantiate an empty object containing no statistics.

<remarks>
<seealso cref="refresh"/>
</remarks>

### LBMSourceStatistics

```csharp
unsafe public LBMSourceStatistics(LBMContext lbmctx, int maxStats)
```

Instantiate object containing the current set of
source transport statistics for a given LBM source

<remarks>
This constructor will throw LBMEInvalException if maxStats is
less than the the available number of transport statistical
sets.
<seealso cref="refresh"/>
</remarks>
<param name="lbmctx">LBMContext object associated with statistics to be retrieved</param>
<param name="maxStats">Maximum number of statistical sets to retrieve</param>

### LBMSourceStatistics

```csharp
unsafe public LBMSourceStatistics(LBMSource lbmsrc)
```

Instantiate object containing the current set of
source transport statistics for a given LBM source

<remarks>
<seealso cref="refresh"/>
</remarks>
<param name="lbmsrc">LBMSource object</param>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of statistics.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of statistics (same as Dispose()).
<seealso cref="Dispose"/>

### refresh

```csharp
unsafe public void refresh(LBMContext lbmctx, int maxStats)
```

Refresh the current set of
source transport statistics for a given LBM source

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
This method will throw LBMEInvalException if maxStats is
less than the the available number of transport statistical
sets.
</remarks>
<param name="lbmctx">LBMContext object associated with statistics to be retrieved</param>
<param name="maxStats">Maximum number of statistical sets to retrieve</param>

### refresh

```csharp
unsafe public void refresh(LBMSource lbmsrc)
```

Refresh the current set of
source transport statistics for a given LBM source

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<exception ref="com.latencybusters.lbm.LBMEOPException">Unknown transport</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Statistics not found</exception>
<param name="lbmsrc">LBMSource object</param>

### size

```csharp
public int size()
```

Number of statistical sets encapsulated within this object

<returns>Statistical set size</returns>

### type

```csharp
public int type()
```

Transport type (TCP, LBT-RM, LBT-RU, etc.)

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
<seealso cref="LBM"/>
</remarks>
<returns>Transport type</returns>

### type

```csharp
public int type(int n)
```

Transport type (TCP, LBT-RM, LBT-RU, etc.)

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
<seealso cref="LBM"/>
</remarks>
<param name="n">Statistics set index</param>
<returns>Transport type</returns>

### typeName

```csharp
public string typeName()
```

Transport type name (TCP, LBT-RM, LBT-RU, etc.).

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Transport type name</returns>

### typeName

```csharp
public string typeName(int n)
```

Transport type name (TCP, LBT-RM, LBT-RU, etc.).

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Transport type name</returns>

### source

```csharp
public string source()
```

Source of transport as a string

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Source of transport as a string</returns>

### source

```csharp
public string source(int n)
```

Source of transport as a string

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
</remarks>
<seealso cref="LBMTransportSourceInfo" />
<param name="n">Statistics set index</param>
<returns>Source of transport as a string</returns>

### numberOfClients

```csharp
public long numberOfClients()
```

Number of receiver clients currently connected over this transport
(TCP, LBT-RU, LBT-IPC, LBT-RDMA).

<remarks>
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of receiver clients currently connected over this
transport.</returns>

### numberOfClients

```csharp
public long numberOfClients(int n)
```

Number of receiver clients currently connected over this transport
(TCP, LBT-RU, LBT-IPC, LBT-RDMA).

<remarks>
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of receiver clients currently connected over this
transport.</returns>

### bytesBuffered

```csharp
public long bytesBuffered()
```

Number of bytes currently in UM's TCP buffer (TCP only)

<remarks>
This count is affected by the number of receivers,and configuration options
transport_tcp_multiple_receiver_behavior and transport_session_maximum_buffer.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of bytes currently in UM's TCP buffer, i.e., a snapshot.</returns>

### bytesBuffered

```csharp
public long bytesBuffered(int n)
```

Number of bytes currently in UM's TCP buffer (TCP only)

<remarks>
This count is affected by the number of receivers,and configuration options
transport_tcp_multiple_receiver_behavior and transport_session_maximum_buffer.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of bytes currently in UM's TCP buffer, i.e., a snapshot.</returns>

### messagesSent

```csharp
public long messagesSent()
```

Number of datagrams sent (LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA) or complete messages sent (BROKER).

<remarks>
Depending on batching settings, a single datagram may contain one or
more messages, or a fragment of a larger message. Larger messages
are split into fragment sizes limited by their transport's configuration option
setting.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of datagrams sent.</returns>

### messagesSent

```csharp
public long messagesSent(int n)
```

Number of datagrams sent (LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA) or complete messages sent (BROKER).

<remarks>
Depending on batching settings, a single datagram may contain one or
more messages, or a fragment of a larger message. Larger messages
are split into fragment sizes limited by their transport's configuration option
setting.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams sent.</returns>

### bytesSent

```csharp
public long bytesSent()
```

Number of datagram bytes sent (LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA) or complete message bytes sent (BROKER).

<remarks>
Includes the total length of all transport packets,
including UM header information (except BROKER).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of datagram bytes sent, i.e., the total of lengths of all
packets including UM header information.</returns>

### bytesSent

```csharp
public long bytesSent(int n)
```

Number of datagram bytes sent (LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA) or complete message bytes sent (BROKER).

<remarks>
Includes the total length of all transport packets,
including UM header information (except BROKER).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagram bytes sent, i.e., the total of lengths of all
packets including UM header information.</returns>

### transmissionWindowMessages

```csharp
public long transmissionWindowMessages()
```

Number of datagrams in the transmission window (LBT-RM only).

<remarks>
Each source transport session maintains a transmission window buffer (the
size of which is set by transport_lbtrm_transmission_window_size, default
24MB). When the source transport receives a NAK, the corresponding message for
retransmission must be found in this transmission window.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of datagrams in the transmission window.</returns>

### transmissionWindowMessages

```csharp
public long transmissionWindowMessages(int n)
```

Number of datagrams in the transmission window (LBT-RM only).

<remarks>
Each source transport session maintains a transmission window buffer (the
size of which is set by transport_lbtrm_transmission_window_size, default
24MB). When the source transport receives a NAK, the corresponding message for
retransmission must be found in this transmission window.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams in the transmission window.</returns>

### transmissionWindowBytes

```csharp
public long transmissionWindowBytes()
```

Number of bytes currently in the transmission window (LBT-RM only)

<remarks>
Number of bytes currently in the transmission window.
Typically, this count approaches its window size or exceeds it by a small
amount.
See transmissionWindowMessages for a description of the
transmission window.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of bytes currently in the transmission window</returns>

### transmissionWindowBytes

```csharp
public long transmissionWindowBytes(int n)
```

Number of bytes currently in the transmission window (LBT-RM only)

<remarks>
Number of bytes currently in the transmission window.
Typically, this count approaches its window size or exceeds it by a small
amount.
See transmissionWindowMessages for a description of the
transmission window.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of bytes currently in the transmission window</returns>

### nakPacketsReceived

```csharp
public long nakPacketsReceived()
```

Number of NAK packets received by this source transport (LBT-RM, LBT-RU).

<remarks>
UM batches NAKs into NAK packets to save network bandwidth. This should
always be less than or equal to naksReceived (below).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of NAK packets received by this source transport.</returns>

### nakPacketsReceived

```csharp
public long nakPacketsReceived(int n)
```

Number of NAK packets received by this source transport (LBT-RM, LBT-RU).

<remarks>
UM batches NAKs into NAK packets to save network bandwidth. This should
always be less than or equal to naksReceived (below).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NAK packets received by this source transport.</returns>

### naksReceived

```csharp
public long naksReceived()
```

Number of individual NAKs received by the source transport (LBT-RM, LBT-RU).

<remarks>
When a source transport receives a NAK from a receiver transport, it may
respond by re-transmitting the requested datagram, or it may send an
NCF. The NAKing receiver transport responds to the NCF by waiting (timeout
set by the transport's NAK suppress interval option, default 1000 ms), then
re-sending the NAK.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of individual NAKs received by the source transport.</returns>

### naksReceived

```csharp
public long naksReceived(int n)
```

Number of individual NAKs received by the source transport (LBT-RM, LBT-RU).

<remarks>
When a source transport receives a NAK from a receiver transport, it may
respond by re-transmitting the requested datagram, or it may send an
NCF. The NAKing receiver transport responds to the NCF by waiting (timeout
set by the transport's NAK suppress interval option, default 1000 ms), then
re-sending the NAK.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of individual NAKs received by the source transport.</returns>

### naksIgnored

```csharp
public long naksIgnored()
```

Number of NAKs this source transport ignored and sent an NCF with reason
code "ignored" (LBT-RM, LBT-RU).

<remarks>
A source transport ignores a NAK for a datagram it has already recently
retransmitted. How "recently" is determined by the configuration option source
transport_lbtrm_ignore_interval (default 500ms). If this count is high, a
receiver transport may be having trouble receiving retransmissions, or the
ignore interval may be set too long.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of NAKs this source transport ignored and sent an NCF with
reason code set to "ignored".</returns>

### naksIgnored

```csharp
public long naksIgnored(int n)
```

Number of NAKs this source transport ignored and sent an NCF with reason
code "ignored" (LBT-RM, LBT-RU).

<remarks>
A source transport ignores a NAK for a datagram it has already recently
retransmitted. How "recently" is determined by the configuration option source
transport_lbtrm_ignore_interval (default 500ms). If this count is high, a
receiver transport may be having trouble receiving retransmissions, or the
ignore interval may be set too long.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NAKs this source transport ignored and sent an NCF with
reason code set to "ignored".</returns>

### naksShed

```csharp
public long naksShed()
```

Number of NAKs this source transport has shed and sent an NCF with reason
code "shed" (LBT-RM, LBT-RU).

<remarks>
When a source transport's retransmit rate limiter and retransmit queue are
both at maximum, it responds to a NAK by sending an "NCF shed", and does not
retransmit. The receiver transport should wait, then send another NAK. If this
count is high, one or more crybaby receiver transports may be clogging the
source transport's retransmit queue.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of NAKs this source transport has shed and sent an NCF with
the reason code set to "shed".</returns>

### naksShed

```csharp
public long naksShed(int n)
```

Number of NAKs this source transport has shed and sent an NCF with reason
code "shed" (LBT-RM, LBT-RU).

<remarks>
When a source transport's retransmit rate limiter and retransmit queue are
both at maximum, it responds to a NAK by sending an "NCF shed", and does not
retransmit. The receiver transport should wait, then send another NAK. If this
count is high, one or more crybaby receiver transports may be clogging the
source transport's retransmit queue.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NAKs this source transport has shed and sent an NCF with
the reason code set to "shed".</returns>

### naksIgnoredRetransmitDelay

```csharp
public long naksIgnoredRetransmitDelay()
```

Number of NAKs this source transport has not processed because it met its
retransmission rate limit (LBT-RM, LBT-RU).

<remarks>
This rate limit is set by configuration option
transport_lbtrm_retransmit_rate_limit (default 5Mbps).
For each of these NAKs, the source transport immediately sends an NFC
rx_delay, then queues the retransmission for a later send within the rate
limit. If this count is high, one or more crybaby receiver transports may be
clogging the source transport's retransmit queue.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of NAKs this source did not process because doing so would
exceed its retransmit rate limit.</returns>

### naksIgnoredRetransmitDelay

```csharp
public long naksIgnoredRetransmitDelay(int n)
```

Number of NAKs this source transport has not processed because it met its
retransmission rate limit (LBT-RM, LBT-RU).

<remarks>
This rate limit is set by configuration option
transport_lbtrm_retransmit_rate_limit (default 5Mbps).
For each of these NAKs, the source transport immediately sends an NFC
rx_delay, then queues the retransmission for a later send within the rate
limit. If this count is high, one or more crybaby receiver transports may be
clogging the source transport's retransmit queue.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of NAKs this source did not process because doing so would
exceed its retransmit rate limit.</returns>

### retransmissionsSent

```csharp
public long retransmissionsSent()
```

Number of datagrams retransmitted by this source (LBT-RM, LBT-RU).

<remarks>
This count is incremented under the same circumstances as
retransmissionBytesSent, below.
In a normal, light-loss scenario, most NAKs received induce a retransmission.
When losses become heavy and/or many receiver transports begin losing the
same datagrams, NCF-related no-retransmit counts (naksIgnored, naksShed and
naksIgnoredRetransmitDelay) may begin to inflate, and retransmissions
retransmissionsSent) may become significantly lower than NAKS
received (naksReceived).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of datagrams retransmitted by this source.</returns>

### retransmissionsSent

```csharp
public long retransmissionsSent(int n)
```

Number of datagrams retransmitted by this source (LBT-RM, LBT-RU).

<remarks>
This count is incremented under the same circumstances as
retransmissionBytesSent, below.
In a normal, light-loss scenario, most NAKs received induce a retransmission.
When losses become heavy and/or many receiver transports begin losing the
same datagrams, NCF-related no-retransmit counts (naksIgnored, naksShed and
naksIgnoredRetransmitDelay) may begin to inflate, and retransmissions
retransmissionsSent) may become significantly lower than NAKS
received (naksReceived).
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams retransmitted by this source.</returns>

### messagesQueued

```csharp
public long messagesQueued()
```

Number of datagrams currently queued by the rate limiter (LBT-RM only).

<remarks>
When a source transport attempts to send messages (any type) faster than its
data rate limiter allows (set by configuration option
transport_lbtrm_data_rate_limit, default 10Mbps), the data rate limiter queues
the messages until they can be sent within the data rate limit.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of datagrams currently queued by the rate limiter.</returns>

### messagesQueued

```csharp
public long messagesQueued(int n)
```

Number of datagrams currently queued by the rate limiter (LBT-RM only).

<remarks>
When a source transport attempts to send messages (any type) faster than its
data rate limiter allows (set by configuration option
transport_lbtrm_data_rate_limit, default 10Mbps), the data rate limiter queues
the messages until they can be sent within the data rate limit.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of datagrams currently queued by the rate limiter.</returns>

### retransmissionsQueued

```csharp
public long retransmissionsQueued()
```

Number of retransmission datagrams currently queued by the retransmit
rate limiter (LBT-RM only).

<remarks>
When a source transport attempts to send retransmissions faster that its
retransmit rate limiter allows (set by configuration option
transport_lbtrm_retransmit_rate_limit, default 5Mbps), the retransmit rate
limiter queues retransmissions until they can be sent within the rate limit.
naksIgnoredRetransmitDelay (above) will generally also rise if this count is high.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns>Number of retransmission datagrams currently queued by the
retransmit rate limiter.</returns>

### retransmissionsQueued

```csharp
public long retransmissionsQueued(int n)
```

Number of retransmission datagrams currently queued by the retransmit
rate limiter (LBT-RM only).

<remarks>
When a source transport attempts to send retransmissions faster that its
retransmit rate limiter allows (set by configuration option
transport_lbtrm_retransmit_rate_limit, default 5Mbps), the retransmit rate
limiter queues retransmissions until they can be sent within the rate limit.
naksIgnoredRetransmitDelay (above) will generally also rise if this count is high.
This method returns a value from the nth set of statistics
encapsulated within this object.
</remarks>
<param name="n">Statistics set index</param>
<returns>Number of retransmission datagrams currently queued by the
retransmit rate limiter.</returns>

### retransmissionBytesSent

```csharp
public long retransmissionBytesSent()
```

Number of bytes retransmitted by this source transport (LBT-RU, LBT-RM).

<remarks>
This count is triggered under the same circumstances as retransmissionsSent, above.
In a normal, light-loss scenario, most NAKs received induce a retransmission.
When losses become heavy and/or many receiver transports begin losing the
same datagrams, NCF-related no-retransmit counts (naksIgnored, naksShed and
naksIgnoredRetransmitDelay) may begin to inflate, and retransmissions
retransmissionsSent) may become significantly lower than NAKs
received (naksReceived).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<returns> Total number of bytes retransmitted by this source transport.
</returns>

### retransmissionBytesSent

```csharp
public long retransmissionBytesSent(int n)
```

Number of bytes retransmitted by this source transport (LBT-RU, LBT-RM).

<remarks>
This count is triggered under the same circumstances as retransmissionsSent, above.
In a normal, light-loss scenario, most NAKs received induce a retransmission.
When losses become heavy and/or many receiver transports begin losing the
same datagrams, NCF-related no-retransmit counts (naksIgnored, naksShed and
naksIgnoredRetransmitDelay) may begin to inflate, and retransmissions
retransmissionsSent) may become significantly lower than NAKs
received (naksReceived).
This method returns a value from the nth set of statistics
encapsulated within this object.
<seealso cref="LBMSourceStatistics(LBMSource)" />
</remarks>
<param name="n">Statistics set index</param>
<returns> Total number of bytes retransmitted by this source transport.
</returns>

## LBMStatistics

*class* `com.latencybusters.lbm.LBMStatistics`

### getApplicationSourceId

```csharp
public string getApplicationSourceId()
```

Retrieve the application source identifier associated with
this set of statistics.

<remarks>
This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
</remarks>
<returns>Application source ID</returns>

### getSender

```csharp
public IPAddress getSender()
```

Retrieve the IP sender address associated with this set of
statistics.

<remarks>
This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
</remarks>
<returns>IPAddress object corresponding to the statistics'
sender IP address</returns>

### getTimestamp

```csharp
public DateTime getTimestamp()
```

Retrieve the timestamp associated with this set of
statistics.

<remarks>
This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
</remarks>
<returns>DateTime object</returns>

### getProcessId

```csharp
public long getProcessId()
```

Retrieve the sender process ID associated with
this set of statistics.

<remarks>
This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
</remarks>
<returns>Sender process ID</returns>

### getContextId

```csharp
public long getContextId()
```

Retrieve the sender context ID associated with
this set of statistics.

<remarks>
This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
</remarks>
<returns>Sender context ID</returns>

### getObjectId

```csharp
public long getObjectId()
```

Retrieve the sender object ID associated with
this set of statistics.

<remarks>
This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
</remarks>
<returns>Sender object ID</returns>

### getSource

```csharp
public long getSource()
```

Retrieve the source attribute from the statistics attribute block
associated with this set of statistics.

<remarks>
This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.

Compare return value to
LBMMonitor.ATTR_SOURCE_NORMAL and LBMMonitor.ATTR_SOURCE_IM.
</remarks>
<returns>Sender source flag</returns>

## LBMTimer

*class* `com.latencybusters.lbm.LBMTimer`

### LBMTimer

```csharp
public LBMTimer(LBMContext lbmctx, long milliseconds) : this(lbmctx, milliseconds, null, IntPtr.Zero, null)
```

Creates a timer associated with a specific context that expires with
a specified delay.

<remarks>
A zero duration timer is legal and causes the associated callback
to be called as soon as possible on the context thread.
</remarks>
<param name="lbmctx">LBMContext object with which to associate this timer
(determines which LBM thread will execute the timer function)</param>
<param name="milliseconds">Number of milliseconds until the timer expires</param>

### LBMTimer

```csharp
public LBMTimer(LBMContext lbmctx, long milliseconds, LBMEventQueue lbmevq) : this(lbmctx, milliseconds, null, IntPtr.Zero, lbmevq)
```

Creates a timer associated with a specific context and event queue
that expires with a specified delay.

<remarks>
A zero duration timer is legal and causes the associated callback
to be called as soon as possible on the context thread or to be
enqueued as an event on the associated event queue. In this case,
the event queue dispatching thread calls the associated callback
after all currently pending events have been dispatched.
</remarks>
<param name="lbmctx">LBMContext object with which to associate this timer
(determines which LBM thread will execute the timer function)</param>
<param name="milliseconds">Number of milliseconds until the timer expires</param>
<param name="lbmevq">Event queue with which to associate this timer
(the timer events will be posted to this event queue)</param>

### LBMTimer

```csharp
public LBMTimer(LBMContext lbmctx, long milliseconds, LBMTimerCallback cb, Object cbArg) : this(lbmctx, milliseconds, cb, cbArg, null)
```

Creates a timer associated with a specific context that expires with
a specified delay.

<remarks>
A zero duration timer is legal and causes the associated callback
to be called as soon as possible on the context thread.
</remarks>
<param name="lbmctx">LBMContext object with which to associate this timer
(determines which LBM thread will execute the timer function)</param>
<param name="milliseconds">Number of milliseconds until the timer expires</param>
<param name="cb">Callback implementing the LBMTimerCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>

### LBMTimer

```csharp
public LBMTimer(LBMContext lbmctx, long milliseconds, LBMTimerCallback cb, Object cbArg, LBMEventQueue lbmevq)
```

Creates a timer associated with a specific context and event queue
that expires with a specified delay.

<remarks>
A zero duration timer is legal and causes the associated callback
to be called as soon as possible on the context thread or to be
enqueued as an event on the associated event queue. In this case,
the event queue dispatching thread calls the associated callback
after all currently pending events have been dispatched.
</remarks>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="lbmctx">LBMContext object with which to associate this timer
(determines which LBM thread will execute the timer function)</param>
<param name="milliseconds">Number of milliseconds until the timer expires</param>
<param name="cb">Callback implementing the LBMTimerCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>
<param name="lbmevq">Event queue with which to associate this timer</param>

### addTimerCallback

```csharp
public void addTimerCallback(LBMTimerCallback cb)
```

Register a timer callback

<remarks>
<seealso cref="LBMTimerCallback"/>
<seealso cref="removeTimerCallback"/>
</remarks>
<param name="cb">Callback implementing the LBMTimerCallback delegate interface</param>

### addTimerCallback

```csharp
public void addTimerCallback(LBMTimerCallback cb, Object cbArg)
```

Register a timer callback (and callback token)

<remarks>
<seealso cref="LBMTimerCallback"/>
<seealso cref="removeTimerCallback"/>
</remarks>
<param name="cb">Callback implementing the LBMTimerCallback delegate interface</param>
<param name="cbArg">Callback token object</param>

### removeTimerCallback

```csharp
public void removeTimerCallback(LBMTimerCallback cb)
```

Deregister a timer callback

<remarks>
<seealso cref="LBMTimerCallback"/>
<seealso cref="addTimerCallback"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMTimerCallback delegate interface</param>

### removeTimerCallback

```csharp
public void removeTimerCallback(LBMTimerCallback cb, Object cbArg)
```

Deregister a timer callback

<remarks>
<seealso cref="LBMTimerCallback"/>
<seealso cref="addTimerCallback"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMTimerCallback delegate interface</param>
<param name="cbArg">Callback token for previously registered callback</param>

### cancel

```csharp
public void cancel()
```

Cancel timer

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### reschedule

```csharp
public void reschedule(long milliseconds)
```

Reschedule this timer to expire in a specified number of milliseconds

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="milliseconds">Number of milliseconds until this timer should expire</param>

### Dispose

```csharp
public void Dispose()
```

Dispose of this timer object

## LBMTimerCallback

*delegate* `com.latencybusters.lbm.LBMTimerCallback`

### LBMTimerCallback

```csharp
public delegate void LBMTimerCallback(object cbArg)
```

LBM Timer callback delegate

<param name="cbArg">Callback object token</param>

## LBMTopic

*class* `com.latencybusters.lbm.LBMTopic`

### LBMTopic

```csharp
public LBMTopic(LBMContext lbmctx, string symbol) : this(lbmctx, symbol, (LBMReceiverAttributes)null)
```

Turn a Topic string into an LBMTopic object usable by receivers.
It is recommended that topic objects be instantiated from the context
factory methods <see cref="LBMContext.allocTopic">allocTopic()</see>
and <see cref="LBMContext.lookupTopic">lookupTopic()</see> (for
sources and receivers respectively).

<remarks>
<para>Note: This constructor cannot be used to initialize a source topic.</para>
<para><b>Warning</b>: It is not safe to call this constructor from a context thread callback.</para>
<seealso cref="LBMReceiver"/>
</remarks>
<param name="lbmctx">LBMContext object for the topic</param>
<param name="symbol">Topic string (Topic strings should be limited in length to 246 characters, not including the final null).</param>

### LBMTopic

```csharp
public LBMTopic(LBMContext lbmctx, string symbol, LBMReceiverAttributes lbmrattr)
```

Turn a Topic string into an LBMTopic object usable by receivers
It is recommended that topic objects be instantiated from the context
factory methods <see cref="LBMContext.allocTopic">allocTopic()</see>
and <see cref="LBMContext.lookupTopic">lookupTopic()</see> (for
sources and receivers respectively).

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
<seealso cref="LBMReceiver"/>
<para><b>Warning</b>: It is not safe to call this constructor from a context thread callback.</para>
</remarks>
<param name="lbmctx">LBMContext object for the topic</param>
<param name="symbol">Topic string (Topic strings should be limited in length to 246 characters, not including the final null).</param>
<param name="lbmrattr">LBMReceiverAttributes object used to initialize the
topic object</param>

### LBMTopic

```csharp
public LBMTopic(LBMContext lbmctx, string symbol, LBMSourceAttributes lbmsattr)
```

Turn a Topic string into an LBMTopic object usable by sources
It is recommended that topic objects be instantiated from the context
factory methods <see cref="LBMContext.allocTopic">allocTopic()</see>
and <see cref="LBMContext.lookupTopic">lookupTopic()</see> (for
sources and receivers respectively).

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>
<seealso cref="LBMSource"/>
<para><b>Warning</b>: It is not safe to call this constructor from a context thread callback.</para>
</remarks>
<param name="lbmctx">LBMContext object for the topic</param>
<param name="symbol">Topic string (Topic strings should be limited in length to 246 characters, not including the final null).</param>
<param name="lbmsattr">LBMSourceAttributes object used to initialize the
topic object</param>

## LBMTransportMappingCallback

*delegate* `com.latencybusters.lbm.LBMTransportMappingCallback`

### LBMTransportMappingCallback

```csharp
public delegate LBMXSP LBMTransportMappingCallback(LBMContext context, LBMNewTransportInfo newTransportInfo, Object cbArg)
```

XSP Transport mapping callback delegate.

<param name="context">LBMContext object</param>
<param name="newTransportInfo">LBMNewTransportInfo object containing transport information</param>
<param name="cbArg">Callback object token</param>
<returns>LBMXSP object</returns>

## LBMTransportSourceInfo

*class* `com.latencybusters.lbm.LBMTransportSourceInfo`

### getType

```csharp
public int getType()
```

Type of transport

<returns>the type of transport</returns>

### getSrcIp

```csharp
public uint getSrcIp()
```

Source IP address. Applicable only to LBT-RM, LBT-RU, TCP, and LBT-RDMA. Stored in network order.

<returns>the source ip address</returns>

### getSrcPort

```csharp
public ushort getSrcPort()
```

Source port. Applicable only to LBT-RM, LBT-RU, TCP, and LBT-RDMA. Stored in host order.

<returns>the source port</returns>

### getDestPort

```csharp
public ushort getDestPort()
```

Destination port. Applicable only to LBT-RM. Stored in host order.

<returns>the destination port</returns>

### getMCGroup

```csharp
public uint getMCGroup()
```

Multicast group. Applicable only to LBT-RM. Stored in network order.

<returns>the multicast group</returns>

### getTransportId

```csharp
public uint getTransportId()
```

Transport ID. Applicable only to LBT-IPC. Stored in host order.

<returns>the transport id</returns>

### getSessionId

```csharp
public uint getSessionId()
```

Session ID. Applicable only to LBT-RM, LBT-RU, and LBT-IPC. Stored in host order.

<returns>the session id</returns>

### getTopicIdx

```csharp
public uint getTopicIdx()
```

Topic index. Applicable to all transports. Stored in host order.

<returns>the topic index</returns>

## LBMUMMInfo

*class* `com.latencybusters.lbm.LBMUMMInfo`

### LBMUMMInfo

```csharp
public LBMUMMInfo(string _applicationName, string _userName, string _password, string[] _servers)
```

Instantiate an LBM UMM Info object.

<param name="_applicationName">The application name. Must not exceed LBM.LBM_UMM_APP_NAME_LENGTH_MAX length.</param>
<param name="_userName">The UMM user name. Must not exceed LBM.LBM_UMM_USER_NAME_LENGTH_MAX length.</param>
<param name="_password">The UMM password. Must not exceed LBM.LBM_UMM_PASSWORD_LENGTH_MAX length.</param>
<param name="_servers">The list of servers to attempt connections to. Servers are specified with a string in "ip:port" format. The servers are tried in round-robin fashion starting with index 0. Number of servers must not exceed LBM.LBM_UMM_NUM_SERVERS_MAX.</param>

### LBMUMMInfo

```csharp
public LBMUMMInfo(string _applicationName, string _userName, string _password, string[] _servers, uint _flags)
```

Instantiate an LBM UMM Info object.

<param name="_applicationName">The application name. Must not exceed LBM.LBM_UMM_APP_NAME_LENGTH_MAX length.</param>
<param name="_userName">The UMM user name. Must not exceed LBM.LBM_UMM_USER_NAME_LENGTH_MAX length.</param>
<param name="_password">The UMM password. Must not exceed LBM.LBM_UMM_PASSWORD_LENGTH_MAX length.</param>
<param name="_servers">The list of servers to attempt connections to. Servers are specified with a string in "ip:port" format. The servers are tried in round-robin fashion starting with index 0. Number of servers must not exceed LBM.LBM_UMM_NUM_SERVERS_MAX.</param>
<param name="_flags">Flags to enable usage of SSL.</param>

### LBMUMMInfo

```csharp
public LBMUMMInfo(string _applicationName, string _userName, string _password, string[] _servers, uint _flags, string _certFile)
```

Instantiate an LBM UMM Info object.

<param name="_applicationName">The application name. Must not exceed LBM.LBM_UMM_APP_NAME_LENGTH_MAX length.</param>
<param name="_userName">The UMM user name. Must not exceed LBM.LBM_UMM_USER_NAME_LENGTH_MAX length.</param>
<param name="_password">The UMM password. Must not exceed LBM.LBM_UMM_PASSWORD_LENGTH_MAX length.</param>
<param name="_servers">The list of servers to attempt connections to. Servers are specified with a string in "ip:port" format. The servers are tried in round-robin fashion starting with index 0. Number of servers must not exceed LBM.LBM_UMM_NUM_SERVERS_MAX.</param>
<param name="_flags">Flags to enable usage of SSL.</param>
<param name="_certFile">Path to a pem-encoded certificate file. If specified, SSL is enabled and certificate is used to validate the UMM daemon identity.</param>

### LBMUMMInfo

```csharp
public LBMUMMInfo(string _applicationName, string _userName, string _password, string[] _servers, uint _flags, string _certFile, string _certFilePassword)
```

Instantiate an LBM UMM Info object.

<param name="_applicationName">The application name. Must not exceed LBM.LBM_UMM_APP_NAME_LENGTH_MAX length.</param>
<param name="_userName">The UMM user name. Must not exceed LBM.LBM_UMM_USER_NAME_LENGTH_MAX length.</param>
<param name="_password">The UMM password. Must not exceed LBM.LBM_UMM_PASSWORD_LENGTH_MAX length.</param>
<param name="_servers">The list of servers to attempt connections to. Servers are specified with a string in "ip:port" format. The servers are tried in round-robin fashion starting with index 0. Number of servers must not exceed LBM.LBM_UMM_NUM_SERVERS_MAX.</param>
<param name="_flags">Flags to enable usage of SSL.</param>
<param name="_certFile">Path to a pem-encoded certificate file. If specified, SSL is enabled and certificate is used to validate the UMM daemon identity.</param>
<param name="_certFilePassword">Certificate file password. Required only if certificate file is password-protected.</param>

### validate

```csharp
public void validate()
```

Validate an LBM UMM Info object.

## LBMWildcardPatternCallback

*delegate* `com.latencybusters.lbm.LBMWildcardPatternCallback`

### LBMWildcardPatternCallback

```csharp
public delegate int LBMWildcardPatternCallback(string topic, object cbArg)
```

LBM wildcard pattern match callback delegate

<param name="topic">Candidate topic string</param>
<param name="cbArg">Callback object token</param>
<returns>0 indicates a match</returns>

## LBMWildcardReceiver

*class* `com.latencybusters.lbm.LBMWildcardReceiver`

### LBMWildcardReceiver

```csharp
public LBMWildcardReceiver(LBMContext lbmctx, string pattern, LBMReceiverAttributes lbmrcvattr, LBMWildcardReceiverAttributes lbmwrcvattr) : this(lbmctx, pattern, lbmrcvattr, lbmwrcvattr, null, null, null)
```

Instantiate an LBM Wildcard Receiver object that will receive messages
sent to any topic matching the given pattern

<remarks>ATTENTION: An application should have at least one receiver callback
registered per receiver object.  Use of this constructor creates a window
after receiver creation and before adding a callback in which
messages may be lost; therefore, its using this constructor is not recommended.
Use a constructor that specifies at least one initial callback instead.
<para><b>Warning</b>: It is not safe to call this constructor from a context thread callback.</para>
</remarks>
<param name="lbmctx">Context with which to associate the wildcard receiver</param>
<param name="pattern">Pattern used to match topic strings</param>
<param name="lbmrcvattr">LBMReceiverAttributes to be associated with this
wildcard receiver</param>
<param name="lbmwrcvattr">LBMWildcardReceiverAttributes to be associated with
this wildcard receiver</param>

### LBMWildcardReceiver

```csharp
public LBMWildcardReceiver(LBMContext lbmctx, string pattern, LBMReceiverAttributes lbmrcvattr, LBMWildcardReceiverAttributes lbmwrcvattr, LBMEventQueue lbmevq) : this(lbmctx, pattern, lbmrcvattr, lbmwrcvattr, null, null, lbmevq)
```

Instantiate an LBM Wildcard Receiver object (associated with a specified
event queue) that will receive messages sent to any topic matching the
given pattern

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks>ATTENTION: An application should have at least one receiver callback
registered per receiver object.  Use of this constructor creates a window
after receiver creation and before adding a callback in which
messages may be lost; therefore, its using this constructor is not recommended.
Use a constructor that specifies at least one initial callback instead.
<para><b>Warning</b>: It is not safe to call this constructor from a context thread callback.</para>
</remarks>
<param name="lbmctx">Context with which to associate the wildcard receiver</param>
<param name="pattern">Pattern used to match topic strings</param>
<param name="lbmrcvattr">LBMReceiverAttributes to be associated with this
wildcard receiver</param>
<param name="lbmwrcvattr">LBMWildcardReceiverAttributes to be associated with
this wildcard receiver</param>
<param name="lbmevq">Event queue with which to associate the receiver
(all receiver events will be posted to this event queue)</param>

### LBMWildcardReceiver

```csharp
public LBMWildcardReceiver(LBMContext lbmctx, String pattern, LBMReceiverAttributes lbmrcvattr, LBMWildcardReceiverAttributes lbmwrcvattr, LBMReceiverCallback cb, object cbArg) : this(lbmctx, pattern, lbmrcvattr, lbmwrcvattr, cb, cbArg, null)
```

Instantiate an LBM Wildcard Receiver object
that will receive messages sent to any topic matching the
given pattern, with an initial callback and callback object set.

<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<param name="lbmctx">Context with which to associate the receiver</param>
<param name="pattern">Pattern used to match topic strings</param>
<param name="lbmrcvattr">LBMReceiverAttributes to be associated with this
wildcard receiver</param>
<param name="lbmwrcvattr">LBMWildcardReceiverAttributes to be associated with
this wildcard receiver</param>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>

### LBMWildcardReceiver

```csharp
public LBMWildcardReceiver(LBMContext lbmctx, String pattern, LBMReceiverAttributes lbmrcvattr, LBMWildcardReceiverAttributes lbmwrcvattr, LBMReceiverCallback cb, object cbArg, LBMEventQueue lbmevq)
```

Instantiate an LBM Wildcard Receiver object (associated with a specified
event queue) that will receive messages sent to any topic matching the
given pattern, with an initial callback and callback object set.

<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="lbmctx">Context with which to associate the receiver</param>
<param name="pattern">Pattern used to match topic strings</param>
<param name="lbmrcvattr">LBMReceiverAttributes to be associated with this
wildcard receiver</param>
<param name="lbmwrcvattr">LBMWildcardReceiverAttributes to be associated with
this wildcard receiver</param>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>
<param name="cbArg">Callback object passed as token to callback interface</param>
<param name="lbmevq">Event queue with which to associate the receiver
(all receiver events will be posted to this event queue)</param>

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Dump source configuration options

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>An array of LBMConfigOptions</returns>

### getAttributeValue

```csharp
public string getAttributeValue(string attributeName)
```

Returns the value of a wildcard receiver-related attribute for this wildcard receiver

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setAttributeValue

```csharp
public void setAttributeValue(string attributeName, string attributeValue)
```

Set the value of a wildcard receiver-related attribute for this wildcard receiver

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### umederegister

```csharp
public void umederegister()
```

Deregister this wildcard receiver

### receiverCount

```csharp
public int receiverCount()
```

Returns the number of receiver callbacks registered to this receiver

<returns>The number of receiver callbacks registered to this receiver</returns>

### addReceiver

```csharp
public void addReceiver(LBMReceiverCallback cb)
```

Register a receiver callback

<remarks>
<seealso cref="LBMReceiverCallback"/>
<seealso cref="removeReceiver"/>
</remarks>
<param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>

### addReceiver

```csharp
public void addReceiver(LBMReceiverCallback cb, Object cbArg)
```

Register a receiver callback (and callback token)

<remarks>
<seealso cref="LBMReceiverCallback"/>
<seealso cref="removeReceiver"/>
</remarks>
 <param name="cb">Callback implementing the LBMReceiverCallback delegate interface</param>
 <param name="cbArg">Callback object token</param>

### removeReceiver

```csharp
public void removeReceiver(LBMReceiverCallback cb)
```

Deregister a receiver callback

<remarks>
<seealso cref="LBMReceiverCallback"/>
<seealso cref="addReceiver"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMReceiverCallback delegate interface</param>

### removeReceiver

```csharp
public void removeReceiver(LBMReceiverCallback cb, object cbArg)
```

Deregister a receiver callback (and callback token)

<remarks>
<seealso cref="LBMReceiverCallback"/>
<seealso cref="addReceiver"/>
</remarks>
<param name="cb">Previously registered callback implementing the
LBMReceiverCallback delegate interface</param>
<param name="cbArg">Token for previously registered callback</param>

### subscribeChannel

```csharp
public virtual void subscribeChannel(long channelNumber, LBMReceiverCallback cb, Object cbArg)
```

Subscribe to the given channel, with an optional callback and token object.
The specified callback will be called to deliver messages sent with the
specified channel number.  If null is specified for the callback, messages
sent with the specified channel number will be delivered to the receiver's
normal callback.

Only one callback may be registered for a given channel.  If this method is called
twice with the same channel number, an error will result.

<param name="channelNumber">A positive integer indicating the channel to subscribe to</param>
<param name="cb">An option callback to be called for messages on the specified channel</param>
<param name="cbArg">A token to be passed to the specified callback. If null is specified for the cb argument, this argument will be ignored.</param>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.  Most likely due to attempting to subscribe to a channel for which a subscription already exists.</exception>

### unsubscribeChannel

```csharp
public virtual void unsubscribeChannel(long channelNumber)
```

 Discontinue an existing channel subscription.
<param name="channelNumber">A positive integer indicating that channel to unsubscribe from</param>
<exception ref="com.latencybusters.lbm.LBMException">Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.  Most likely due to attempting to unsubscribe from a channel that was not previously subscribed to</exception>

### indexStopAssignment

```csharp
public void indexStopAssignment(String queue)
```

Stops this wildcard receiver's eligibility for new index assignments from a queue.
<param name="queue">The name of the queue to stop new index assignment from, or null for all queues.</param>

### indexStartAssignment

```csharp
public void indexStartAssignment(String queue)
```

Starts this wildcard receiver's eligibility for new index assignments from a queue.
<param name="queue">The name of the queue to start new index assignment from, or null for all queues.</param>

### indexRelease

```csharp
public void indexRelease(String queue, UMQIndexInfo index)
```

Instruct the given UMQ queue(s) to release the given UMQ index that is assigned to the given wildcard receiver.
<param name="queue">Name of the queue at which to release the index, or null for all queues.</param>
<param name="index">The index to release, or null for all indices.</param>

### deregister

```csharp
public void deregister()
```

 Deregister from all queues.
<exception ref="com.latencybusters.lbm.LBMException"> An error occurred while attempting to deregister </exception>

### deregister

```csharp
public void deregister(String queue)
```

 Deregister from a single queue, specified by name.
<param name="queue">The queue to deregister from </param>
<exception ref="com.latencybusters.lbm.LBMException"> An error occurred while attempting to deregister </exception>

### close

```csharp
public void close()
```

Close and dispose of this receiver

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>

### Dispose

```csharp
public void Dispose()
```

Same as <see cref="close"/>

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks><seealso cref="close"/></remarks>

## LBMWildcardReceiverAttributes

*class* `com.latencybusters.lbm.LBMWildcardReceiverAttributes`

### LBMWildcardReceiverAttributes

```csharp
unsafe public LBMWildcardReceiverAttributes()
```

Instantiate LBMWildcardReceiverAttributes class

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### LBMWildcardReceiverAttributes

```csharp
unsafe public LBMWildcardReceiverAttributes(string contextName, string pattern, int patternType)
```

Instantiate an LBMWildcardReceiverAttributes class using a context name, pattern, and pattern type
from the xml configuration that must have been previously loaded.

<param name="contextName">The context name under which this wildcard receiver is to be created.</param>
<param name="pattern">The pattern string which will be used to create the LBMWildcardReceiver.</param>
<param name="patternType">The pattern_type which will be used to create the LBMWildcardReceiver. The pattern_type is written into the attributes object.</param>
<exception ref="com.latencybusters.lbm.LBMException">The context name or pattern and pattern_type combination is not permitted by XML configuration or other unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of attributes.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of attributes (same as Dispose()).
<seealso cref="Dispose"/>

### setFromXml

```csharp
unsafe public void setFromXml(string contextName, string pattern, int patternType)
```

Set values in an LBMWildcardReceiverAttributes class using a context name, pattern, and pattern type
from the xml configuration that must have been previously loaded.

<param name="contextName">The context name under which this wildcard receiver is to be created.</param>
<param name="pattern">The pattern string which will be used to create the LBMWildcardReceiver.</param>
<param name="patternType">The pattern_type which will be used to create the LBMWildcardReceiver. The pattern_type is written into the attributes object.</param>
<exception ref="com.latencybusters.lbm.LBMException">The context name or pattern and pattern_type combination is not permitted by XML configuration or other unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### dumpAttributeList

```csharp
unsafe public List<LBMConfigOption> dumpAttributeList()
```

Dump source configuration options

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<returns>An array of LBMConfigOptions</returns>

### getValue

```csharp
unsafe public string getValue(string attributeName)
```

Returns the current value of an attribute from this set of
wildcard receiver-related attributes

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setValue

```csharp
unsafe public void setValue(string attributeName, string attributeValue)
```

Set the current value of an attribute in this set of
wildcard receiver-related attributes

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### setPatternCallback

```csharp
public void setPatternCallback(LBMWildcardPatternCallback cb, Object cbArg)
```

Set the callback interface (and a callback handle argument) to be called
when a pattern match is desired for a topic discovered for a wildcard
receiver if the pattern type is set to "appcb"

<param name="cb">Callback implementing the LBMWildcardPatternCallback delegate interface</param>
<param name="cbArg">Callback object passed as a token to the callback interface</param>

### setReceiverCreateCallback

```csharp
public void setReceiverCreateCallback(LBMWildcardReceiverCreateCallback cb, Object cbArg)
```

Set the callback method (and a callback handle argument) to be called
when a receiver is created for a topic discovered for a wildcard
receiver

<param name="cb">Callback of type LBMWildcardReceiverCreateCallback</param>
<param name="cbArg">Callback object passed as a token to the callback</param>

### setReceiverDeleteCallback

```csharp
public void setReceiverDeleteCallback(LBMWildcardReceiverDeleteCallback cb, Object cbArg)
```

Set the callback method (and a callback handle argument) to be called
when a receiver created by a wildcard receiver is deleted

<param name="cb">Callback of type LBMWildcardReceiverDeleteCallback</param>
<param name="cbArg">Callback object passed as a token to the callback</param>

## LBMWildcardReceiverCreateCallback

*delegate* `com.latencybusters.lbm.LBMWildcardReceiverCreateCallback`

### LBMWildcardReceiverCreateCallback

```csharp
public delegate int LBMWildcardReceiverCreateCallback(string topic, LBMReceiverAttributes attr, object cbArg)
```

LBM wildcard receiver create callback delegate

<param name="topic">Receiver topic string</param>
<param name="attr">Receiver attributes</param>
<param name="cbArg">Callback object token</param>
<returns>0 indicates a match</returns>

## LBMWildcardReceiverDeleteCallback

*delegate* `com.latencybusters.lbm.LBMWildcardReceiverDeleteCallback`

### LBMWildcardReceiverDeleteCallback

```csharp
public delegate int LBMWildcardReceiverDeleteCallback(string topic, object cbArg)
```

LBM wildcard receiver delete callback delegate

<param name="topic">Receiver topic string</param>
<param name="cbArg">Callback object token</param>
<returns>Always 0</returns>

## LBMXSP

*class* `com.latencybusters.lbm.LBMXSP`

### LBMXSP

```csharp
public LBMXSP(LBMContext lbmctx, LBMContextAttributes ctxAttr, LBMXSPAttributes xspAttr)
```

Instantiate an LBM Source object associated with a given context
and topic

<remarks>
<b>Warning</b>: It is not safe to call this constructor from a context thread callback.
</remarks>
<param name="lbmctx">Context with which to associate the source</param>
<param name="ctxAttr">LBMContextAttributes that this XSP will use.</param>
<param name="xspAttr">LBMXSPAttributes that this XSP will use.</param>

### close

```csharp
public void close()
```

Close and dispose of this XSP

<remarks>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
</remarks>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### Dispose

```csharp
public void Dispose()
```

Same as <see cref="close"/>

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<remarks><seealso cref="close"/></remarks>

### processEvents

```csharp
public void processEvents(ulong msec)
```

Allow the xsp to process events

/// <param name="msec">Milliseconds to wait for events before returning</param>
<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### unblockProcessEvents

```csharp
public void unblockProcessEvents()
```

unblock a previous call to processEvents

## LBMXSPAttributes

*class* `com.latencybusters.lbm.LBMXSPAttributes`

### LBMXSPAttributes

```csharp
unsafe public LBMXSPAttributes()
```

Instantiate LBMXSPAttributes class

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>

### Dispose

```csharp
public void Dispose()
```

Free memory associated with this set of attributes.

### dispose

```csharp
public void dispose()
```

Free memory associated with this set of attributes (same as Dispose()).
<seealso cref="Dispose"/>

### getValue

```csharp
unsafe public string getValue(string attributeName)
```

Returns the current value of an attribute from this set of
xsp attributes

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to retrieve</param>
<returns>Value corresponding to the specified attribute name</returns>

### setValue

```csharp
unsafe public void setValue(string attributeName, string attributeValue)
```

Set the current value of an attribute in this set of
xsp attributes

<exception ref="com.latencybusters.lbm.LBMException"> Invalid argument or unexpected operational behavior has been encountered by unmanaged LBM C layer function.</exception>
<param name="attributeName">Name of the attribute to set</param>
<param name="attributeValue">New attribute value</param>

### setZeroTransportsCallback

```csharp
public void setZeroTransportsCallback(LBMZeroTransportsCallback cb, object cbArg)
```

Set the zero transports callback for an LBMXSP.

<param name="cb">
A delegate of type LBMZeroTransportsCallback
</param>
<param name="cbArg">
A user-supplied callback object to be passed back in the zero transports callback
</param>

### setZeroTransportsCallback

```csharp
public void setZeroTransportsCallback(LBMZeroTransportsCallback cb)
```

Set the zero transports callback for an LBMXSP.

<param name="cb">
A delegate of type LBMZeroTransportsCallback
</param>

## LBMZeroTransportsCallback

*delegate* `com.latencybusters.lbm.LBMZeroTransportsCallback`

### LBMZeroTransportsCallback

```csharp
public delegate int LBMZeroTransportsCallback(LBMXSP xsp, object cbArg)
```

XSP Zero transports callback.
<param name="xsp">XSP object</param>
<param name="cbArg">Callback object token </param>
<returns> an int, which should always be 0. </returns>

## UMEDeregistrationCompleteInfo

*class* `com.latencybusters.lbm.UMEDeregistrationCompleteInfo`

### UMEDeregistrationCompleteInfo

```csharp
public UMEDeregistrationCompleteInfo()
```

Creates a UMEDeregistrationCompleteInfo object and initializes fields to 0.

### UMEDeregistrationCompleteInfo

```csharp
public UMEDeregistrationCompleteInfo(int flags, uint sequenceNumber)
```

Creates a UMEDeregistrationCompleteInfo object and initializes fields to the
supplied values

<exception ref="com.latencybusters.lbm.LBMEInvalException">UME registration sequence number was &lt; 0.</exception>
<param name="flags">Informational flags.</param>
<param name="sequenceNumber">Starting sequence number (must be &gt;= 0).</param>

### flags

```csharp
public int flags()
```

Get informational flags for this deregistration complete message.

<returns>Flags.</returns>

### sequenceNumber

```csharp
public uint sequenceNumber()
```

Get starting sequence number for this deregistration complete message.

<returns>Sequence number.</returns>

## UMEDeregistrationSuccessInfo

*class* `com.latencybusters.lbm.UMEDeregistrationSuccessInfo`

### UMEDeregistrationSuccessInfo

```csharp
public UMEDeregistrationSuccessInfo()
```

Creates a UMEDeregistrationSuccessInfo object and initializes all fields to 0/null.

### UMEDeregistrationSuccessInfo

```csharp
public UMEDeregistrationSuccessInfo(int flags, uint sourceRegId, uint receiverRegId, uint sequenceNumber, ushort storeIndex, string store)
```

Creates a UMEDeregistrationSuccessInfo object and initializes fields to supplied values.

<exception ref="com.latencybusters.lbm.LBMEInvalException">UME source registration ID was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">UME receiver registration ID was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">UME sequence number was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">UME store index was &lt; 0.</exception>
<param name="flags">Flags concerning the type of deregistration.</param>
<param name="sourceRegId">Source registration ID (must be &gt;= 0).</param>
<param name="receiverRegId">Receiver registration ID (must be &gt;= 0).</param>
<param name="sequenceNumber">Starting sequence number.</param>
<param name="storeIndex">Index of store registered with (must be &gt;= 0).</param>
<param name="store">Name (IP address) of store registered with.</param>

### flags

```csharp
public int flags()
```

Get deregistration success flags.

<returns>Flags.</returns>

### sourceRegistrationId

```csharp
public uint sourceRegistrationId()
```

Get source registration ID.

<returns>Source registration ID.</returns>

### receiverRegistrationId

```csharp
public uint receiverRegistrationId()
```

Get receiver registration ID.

<returns>Receiver registration ID.</returns>

### sequenceNumber

```csharp
public uint sequenceNumber()
```

Get starting sequence number.

<returns>Starting sequence number.</returns>

### storeIndex

```csharp
public ushort storeIndex()
```

Get index of the store successfully registered with.

<returns>Index of the store.</returns>

### store

```csharp
public string store()
```

Get name (IP address) of the store successfully registered with.

<returns>Name (IP address) of the store.</returns>

## UMEMessageAck

*class* `com.latencybusters.lbm.UMEMessageAck`

### sendExplicitAck

```csharp
public void sendExplicitAck(uint sqn)
```

Sends an explicit ack up to the sequence number provided

<exception ref="com.latencybusters.lbm.LBMException"> Unexpected operational behavior has been encountered by unmanaged LBM C layer function. </exception>
<param name="sqn">The sequence number up to which to send the explicit ack.</param>

### markNotOutstanding

```csharp
public void markNotOutstanding(uint sqn)
```

Marks that up to the sequence number provided should no longer be considered outstanding for throttled recovery which will free up additional requests.

<exception ref="com.latencybusters.lbm.LBMException"> Unexpected operational behavior has been encountered by unmanaged LBM C layer function. </exception>
<param name="sqn">The sequence number up to which to mark as no longer outstanding.</param>

### Dispose

```csharp
public void Dispose()
```

Delete the underlying ack structure

<exception ref="com.latencybusters.lbm.LBMException"> Unexpected operational behavior has been encountered by unmanaged LBM C layer function. </exception>

## UMENoQueueException

*class* `com.latencybusters.lbm.UMENoQueueException`

### UMENoQueueException

```csharp
public UMENoQueueException(string errorMessage) : base(11, errorMessage)
```

Instantiate  UMENoQueueException class

<param name="errorMessage">Exception error message</param>

## UMENoRegException

*class* `com.latencybusters.lbm.UMENoRegException`

### UMENoRegException

```csharp
public UMENoRegException(string errorMessage) : base(8, errorMessage)
```

Instantiate UMENoRegException class

<param name="errorMessage">Exception error message</param>

## UMENoStoreException

*class* `com.latencybusters.lbm.UMENoStoreException`

### UMENoStoreException

```csharp
public UMENoStoreException(string errorMessage) : base(11, errorMessage)
```

Instantiate UMENoRegException class

<param name="errorMessage">Exception error message</param>

## UMEReceiverLivenessCallbackInfo

*class* `com.latencybusters.lbm.UMEReceiverLivenessCallbackInfo`

### getFlags

```csharp
public int getFlags()
```

Why receiver is being deleted (TIMEOUT or EOF)

<returns>the flags</returns>

### getUserRcvRegId

```csharp
public long getUserRcvRegId()
```

The receiving application context's configured user rcv regid.

<returns>receiving application context's configured user rcv regid.</returns>

### getSessionId

```csharp
public long getSessionId()
```

The receiving application's configured session id.

<returns>receiving application's configured session id</returns>

## UMEReceiverLivenessCreationCallback

*delegate* `com.latencybusters.lbm.UMEReceiverLivenessCreationCallback`

### UMEReceiverLivenessCreationCallback

```csharp
public delegate object UMEReceiverLivenessCreationCallback(UMEReceiverLivenessCallbackInfo info, object cbArg)
```

Application callback to attain information about a new "connected" receiver.

<param name="info">Information about the receiver whom has been declared "alive"</param>
<param name="cbArg">Callback object token</param>
<returns>User-supplied callback object passed in to corresponding <see cref="UMEReceiverLivenessDeletionCallback"/> callback.</returns>

## UMEReceiverLivenessDeletionCallback

*delegate* `com.latencybusters.lbm.UMEReceiverLivenessDeletionCallback`

### UMEReceiverLivenessDeletionCallback

```csharp
public delegate int UMEReceiverLivenessDeletionCallback(UMEReceiverLivenessCallbackInfo info, object cbArg, object srcCbArg)
```

Application callback to attain information about a previously "connected" receiver that has gone away.

<param name="info">Information about the receiver whom has been declared "dead"</param>
<param name="cbArg">Callback object token</param>
<param name="srcCbArg">Callback object token returned by the corresponding <see cref="UMEReceiverLivenessCreationCallback"/>.</param>
<returns></returns>

## UMERecoverySequenceNumberCallback

*delegate* `com.latencybusters.lbm.UMERecoverySequenceNumberCallback`

### UMERecoverySequenceNumberCallback

```csharp
public delegate int UMERecoverySequenceNumberCallback(object cbArg, UMERecoverySequenceNumberCallbackInfo cbInfo)
```

Receiver recovery sequence number callback delegate

<remarks>Sets the lowest sequence number to be requested during recovery.</remarks>
<param name="cbArg">Callback object token.</param>
<param name="cbInfo">Recovery sequence number info.  See <see cref="UMERecoverySequenceNumberCallbackInfo"/></param>
<returns>This callback should always return 0.  The lowest requested sequence number should be set, if desired, by <see cref="UMERecoverySequenceNumberCallbackInfo.setLowSequenceNumber"/> before returning.</returns>

## UMERecoverySequenceNumberCallbackInfo

*class* `com.latencybusters.lbm.UMERecoverySequenceNumberCallbackInfo`

### UMERecoverySequenceNumberCallbackInfo

```csharp
public UMERecoverySequenceNumberCallbackInfo()
```

Default constructor; initializes all fields to 0.

### UMERecoverySequenceNumberCallbackInfo

```csharp
public UMERecoverySequenceNumberCallbackInfo(int flags, uint lowSeqNum, uint lowRxReqMaxSeqNum, uint highSeqNum, object sourceCbArg, string source)
```

Constructor, initializes fields to the given values.

<exception ref="com.latencybusters.lbm.LBMEInvalException">Low sequence number was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Low RX req max sequence number was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">High sequence number was &lt; 0.</exception>
<param name="flags">Informational flags.</param>
<param name="lowSeqNum">Low sequence number (can be changed by the application, must be &gt;= 0).</param>
<param name="lowRxReqMaxSeqNum">Low retransmission request maximum sequence number (must be &gt;= 0).</param>
<param name="highSeqNum">High sequence number (must be &gt;= 0).</param>
<param name="source">Source string (e.g., "TCP:192.168.0.4:45789").</param>
<param name="sourceCbArg">Client-supplied source callback object if using the <see cref="LBMSourceCreationCallback"/> callback.</param>

### flags

```csharp
public int flags()
```

Get recovery sequence number info informational flags.

<returns>Informational flags.</returns>

### lowSequenceNumber

```csharp
public uint lowSequenceNumber()
```

Get low sequence number.

<returns>Low sequence number.</returns>

### lowRxReqMaxSequenceNumber

```csharp
public uint lowRxReqMaxSequenceNumber()
```

Get low retransmission request maximum sequence number.

<returns>Low rxreq max sequence number.</returns>

### highSequenceNumber

```csharp
public uint highSequenceNumber()
```

Get high sequence number.

<returns>High sequence number.</returns>

### sourceClientObject

```csharp
public object sourceClientObject()
```

Get source client object.

<returns>Source client object.</returns>

### source

```csharp
public string source()
```

Get the source string.

<returns>Source string.</returns>

### setLowSequenceNumber

```csharp
public void setLowSequenceNumber(uint lowSeqNum)
```

Set the desired starting low sequence number for recovery events.

<remarks>Used in UMERecoverySequenceNumberCallback callbacks.</remarks>
<param name="lowSeqNum">Desired starting sequence number for recovery (must be >= 0).</param>

### sourceSessionId

```csharp
public UInt64 sourceSessionId()
```

Get the session ID of the source.

<returns>Source Session ID</returns>

## UMERegistrationCompleteInfo

*class* `com.latencybusters.lbm.UMERegistrationCompleteInfo`

### UMERegistrationCompleteInfo

```csharp
public UMERegistrationCompleteInfo()
```

Creates a UMERegistrationCompleteInfo object and initializes fields to 0.

### UMERegistrationCompleteInfo

```csharp
public UMERegistrationCompleteInfo(int flags, uint sequenceNumber)
```

Creates a UMERegistrationCompleteInfo object and initializes fields to the
supplied values

<exception ref="com.latencybusters.lbm.LBMEInvalException">UME registration sequence number was &lt; 0.</exception>
<param name="flags">Informational flags.</param>
<param name="sequenceNumber">Starting sequence number (must be &gt;= 0).</param>

### flags

```csharp
public int flags()
```

Get informational flags for this registration complete message.

<returns>Flags.</returns>

### sequenceNumber

```csharp
public uint sequenceNumber()
```

Get starting sequence number for this registration complete message.

<returns>Sequence number.</returns>

### sourceSessionId

```csharp
public UInt64 sourceSessionId()
```

Get the session ID of the source.

<returns>Source Session ID</returns>

## UMERegistrationIdExCallback

*delegate* `com.latencybusters.lbm.UMERegistrationIdExCallback`

### UMERegistrationIdExCallback

```csharp
public delegate uint UMERegistrationIdExCallback(object cbArg, UMERegistrationIdExCallbackInfo cbInfo)
```

Receiver registration ID callback delegate, extended version (UME only)

<param name="cbArg">Callback object token</param>
<param name="cbInfo">Registration ID callback info; see <see cref="UMERegistrationIdExCallbackInfo"/></param>
<returns>Registration ID to be used by the receiver.</returns>

## UMERegistrationIdExCallbackInfo

*class* `com.latencybusters.lbm.UMERegistrationIdExCallbackInfo`

### UMERegistrationIdExCallbackInfo

```csharp
public UMERegistrationIdExCallbackInfo()
```

Creates a UMERegistrationIdExCallbackInfo object and sets all fields to 0/null.

### UMERegistrationIdExCallbackInfo

```csharp
public UMERegistrationIdExCallbackInfo(string source, uint sourceRegId, string store, ushort storeIndex, int flags, object srcCbArg)
```

Creates a UMERegistrationIdExCallbackInfo object and initializes fields to the given values.

<exception ref="com.latencybusters.lbm.LBMEInvalException">Source registration ID must be &gt;= 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Store index must be &gt;= 0.</exception>
<param name="source">Name (IP address) of the source.</param>
<param name="sourceRegId">Reg ID of the source.</param>
<param name="store">Name (IP address) of the store.</param>
<param name="storeIndex">Index of the store.</param>
<param name="flags">Informational flags.</param>
<param name="srcCbArg">Client-supplied source callback object if using the <see cref="LBMSourceCreationCallback"/> callback.</param>

### sourceRegistrationId

```csharp
public uint sourceRegistrationId()
```

Get the source's registration ID.

<returns>Source registration ID.</returns>

### storeIndex

```csharp
public ushort storeIndex()
```

Get the store's index.

<returns>Store index.</returns>

### store

```csharp
public string store()
```

Get the store name (IP address).

<returns>Store name (IP address).</returns>

### source

```csharp
public string source()
```

Get the source name (IP address).

<returns>Source name (IP address).</returns>

### flags

```csharp
public int flags()
```

Get informational flags.

<returns>Flags.</returns>

### sourceClientObject

```csharp
public object sourceClientObject()
```

Get per-source client object.

<returns>Per-source client object.</returns>

## UMERegistrationSuccessInfo

*class* `com.latencybusters.lbm.UMERegistrationSuccessInfo`

### UMERegistrationSuccessInfo

```csharp
public UMERegistrationSuccessInfo()
```

Creates a UMERegistrationSuccessInfo object and initializes all fields to 0/null.

### UMERegistrationSuccessInfo

```csharp
public UMERegistrationSuccessInfo(int flags, uint sourceRegId, uint receiverRegId, uint sequenceNumber, ushort storeIndex, string store)
```

Creates a UMERegistrationSuccessInfo object and initializes fields to supplied values.

<exception ref="com.latencybusters.lbm.LBMEInvalException">UME source registration ID was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">UME receiver registration ID was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">UME sequence number was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">UME store index was &lt; 0.</exception>
<param name="flags">Flags concerning the type of registration.</param>
<param name="sourceRegId">Source registration ID (must be &gt;= 0).</param>
<param name="receiverRegId">Receiver registration ID (must be &gt;= 0).</param>
<param name="sequenceNumber">Starting sequence number.</param>
<param name="storeIndex">Index of store registered with (must be &gt;= 0).</param>
<param name="store">Name (IP address) of store registered with.</param>

### flags

```csharp
public int flags()
```

Get registration success flags.

<returns>Flags.</returns>

### sourceRegistrationId

```csharp
public uint sourceRegistrationId()
```

Get source registration ID.

<returns>Source registration ID.</returns>

### receiverRegistrationId

```csharp
public uint receiverRegistrationId()
```

Get receiver registration ID.

<returns>Receiver registration ID.</returns>

### sequenceNumber

```csharp
public uint sequenceNumber()
```

Get starting sequence number.

<returns>Starting sequence number.</returns>

### storeIndex

```csharp
public ushort storeIndex()
```

Get index of the store successfully registered with.

<returns>Index of the store.</returns>

### store

```csharp
public string store()
```

Get name (IP address) of the store successfully registered with.

<returns>Name (IP address) of the store.</returns>

### sourceSessionId

```csharp
public UInt64 sourceSessionId()
```

Get the session ID of the source.

<returns>Source Session Id</returns>

## UMESourceEventAckInfo

*class* `com.latencybusters.lbm.UMESourceEventAckInfo`

### UMESourceEventAckInfo

```csharp
public UMESourceEventAckInfo(int flags, uint sequenceNumber, uint rcvRegId, ushort storeIndex, string store, object clientd)
```

Construct a UMESourceEventAckInfo object and initialize its fields to the given values.

<exception ref="com.latencybusters.lbm.LBMEInvalException">Sequence number was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Receiver Reg ID was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Store index was &lt; 0.</exception>
<param name="flags">Informational flags.</param>
<param name="sequenceNumber">Sequence number (must be &gt;= 0).</param>
<param name="rcvRegId">Receiver registration ID (must be &gt;= 0).</param>
<param name="storeIndex">Store index (must be &gt;= 0).</param>
<param name="store">Store name (IP address and port).</param>
<param name="clientd">Application-supplied callback object.</param>

### sequenceNumber

```csharp
public uint sequenceNumber()
```

Get the sequence number of the message the event was received for.

<returns>Sequence number.</returns>

### receiverRegistrationId

```csharp
public uint receiverRegistrationId()
```

Get the receiver registration ID.

<returns>Receiver registration ID.</returns>

### flags

```csharp
public int flags()
```

Get informational flags associated with the source event.

<returns>Flags.</returns>

### clientObject

```csharp
public object clientObject()
```

Get the client-supplied callback object.

<returns>Client-supplied object.</returns>

### store

```csharp
public string store()
```

Get the name (IP address) of the store the event came from.

<returns>Store name (IP address).</returns>

### storeIndex

```csharp
public ushort storeIndex()
```

Get the index of the store the source event came from.

<returns>Store index.</returns>

## UMESourceEventDeregistrationCompleteInfo

*class* `com.latencybusters.lbm.UMESourceEventDeregistrationCompleteInfo`

### UMESourceEventDeregistrationCompleteInfo

```csharp
public UMESourceEventDeregistrationCompleteInfo()
```

Creates a UMESourceEventDeregistrationCompleteInfo object and initializes all fields to 0.

### UMESourceEventDeregistrationCompleteInfo

```csharp
public UMESourceEventDeregistrationCompleteInfo(int flags, uint sequenceNumber)
```

Creates a UMESourcEventDeregistrationCompleteInfo object and initializes fields to the supplied values.

<exception ref="com.latencybusters.lbm.LBMEInvalException">UME registration sequence number was &lt; 0.</exception>
<param name="flags">Informational flags.</param>
<param name="sequenceNumber">Starting sequence number (must be &gt;= 0).</param>

### flags

```csharp
public int flags()
```

Get flags concerning this deregistration complete message.

<returns>Flags.</returns>

### sequenceNumber

```csharp
public uint sequenceNumber()
```

Get the starting sequence number.

<returns>Sequence number.</returns>

## UMESourceEventDeregistrationSuccessInfo

*class* `com.latencybusters.lbm.UMESourceEventDeregistrationSuccessInfo`

### UMESourceEventDeregistrationSuccessInfo

```csharp
public UMESourceEventDeregistrationSuccessInfo()
```

Creates a UMESourceEventDeregistrationSuccessInfo object and initializes all fields to 0/null.

### UMESourceEventDeregistrationSuccessInfo

```csharp
public UMESourceEventDeregistrationSuccessInfo(int flags, uint registrationId, uint sequenceNumber, ushort storeIndex, string store)
```

Creates a UMESourceEventDeregistrationSuccessInfo object and initializes fields to the given values.

<exception ref="com.latencybusters.lbm.LBMEInvalException">UME source registration ID was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">UME sequence number was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">UME store index was &lt; 0.</exception>
<param name="flags">Informational flags concerning the type of store deregistration.</param>
<param name="registrationId">The source's registration ID with this store (must be &gt;= 0).</param>
<param name="sequenceNumber">Starting sequence number.</param>
<param name="storeIndex">Index of the store (must be &gt;= 0).</param>
<param name="store">Name of the store.</param>

### flags

```csharp
public int flags()
```

Returns store registration type flags.

<returns>Informational flags about the source's registration.</returns>

### registrationId

```csharp
public uint registrationId()
```

Returns the source's registration ID.

<returns>Source's registration ID with this store.</returns>

### sequenceNumber

```csharp
public uint sequenceNumber()
```

Returns the source's starting sequence number.

<returns>Source's starting sequence number.</returns>

### storeIndex

```csharp
public ushort storeIndex()
```

Returns the index of the store this source successfully registered to.

<returns>Index of the store.</returns>

### store

```csharp
public string store()
```

Returns the name (IP address) of the store registered with.

<returns>Name of the store.</returns>

## UMESourceEventRegistrationCompleteInfo

*class* `com.latencybusters.lbm.UMESourceEventRegistrationCompleteInfo`

### UMESourceEventRegistrationCompleteInfo

```csharp
public UMESourceEventRegistrationCompleteInfo()
```

Creates a UMESourceEventRegistrationCompleteInfo object and initializes all fields to 0.

### UMESourceEventRegistrationCompleteInfo

```csharp
public UMESourceEventRegistrationCompleteInfo(int flags, uint sequenceNumber)
```

Creates a UMESourcEventRegistrationCompleteInfo object and initializes fields to the supplied values.

<exception ref="com.latencybusters.lbm.LBMEInvalException">UME registration sequence number was &lt; 0.</exception>
<param name="flags">Informational flags.</param>
<param name="sequenceNumber">Starting sequence number (must be &gt;= 0).</param>

### flags

```csharp
public int flags()
```

Get flags concerning this registration complete message.

<returns>Flags.</returns>

### sequenceNumber

```csharp
public uint sequenceNumber()
```

Get the starting sequence number.

<returns>Sequence number.</returns>

## UMESourceEventRegistrationSuccessInfo

*class* `com.latencybusters.lbm.UMESourceEventRegistrationSuccessInfo`

### UMESourceEventRegistrationSuccessInfo

```csharp
public UMESourceEventRegistrationSuccessInfo()
```

Creates a UMESourceEventRegistrationSuccessInfo object and initializes all fields to 0/null.

### UMESourceEventRegistrationSuccessInfo

```csharp
public UMESourceEventRegistrationSuccessInfo(int flags, uint registrationId, uint sequenceNumber, ushort storeIndex, string store)
```

Creates a UMESourceEventRegistrationSuccessInfo object and initializes fields to the given values.

<exception ref="com.latencybusters.lbm.LBMEInvalException">UME source registration ID was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">UME sequence number was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">UME store index was &lt; 0.</exception>
<param name="flags">Informational flags concerning the type of store registration.</param>
<param name="registrationId">The source's registration ID with this store (must be &gt;= 0).</param>
<param name="sequenceNumber">Starting sequence number.</param>
<param name="storeIndex">Index of the store (must be &gt;= 0).</param>
<param name="store">Name of the store.</param>

### flags

```csharp
public int flags()
```

Returns store registration type flags.

<returns>Informational flags about the source's registration.</returns>

### registrationId

```csharp
public uint registrationId()
```

Returns the source's registration ID.

<returns>Source's registration ID with this store.</returns>

### sequenceNumber

```csharp
public uint sequenceNumber()
```

Returns the source's starting sequence number.

<returns>Source's starting sequence number.</returns>

### storeIndex

```csharp
public ushort storeIndex()
```

Returns the index of the store this source successfully registered to.

<returns>Index of the store.</returns>

### store

```csharp
public string store()
```

Returns the name (IP address) of the store registered with.

<returns>Name of the store.</returns>

## UMEStoreEntry

*class* `com.latencybusters.lbm.UMEStoreEntry`

### UMEStoreEntry

```csharp
public UMEStoreEntry()
```

Creates a UMEStoreEntry object and initializes all values to 0.

### UMEStoreEntry

```csharp
public UMEStoreEntry(IPEndPoint address, ushort groupIndex, uint registrationId)
```

Creates a UMEStoreEntry object and uses supplied values for initialization. The domain ID is set to 0.

<param name="address">The address (IP and port) of the store.</param>
<param name="groupIndex">The group the store belongs to (must be &gt;= 0).</param>
<param name="registrationId">The source's registration ID (must be &gt;= 0).</param>

### UMEStoreEntry

```csharp
public UMEStoreEntry(IPEndPoint address, ushort groupIndex, uint registrationId, uint domainId)
```

Creates a UMEStoreEntry object and uses supplied values for initialization.

<param name="address">The address (IP and port) of the store.</param>
<param name="groupIndex">The group the store belongs to (must be &gt;= 0).</param>
<param name="registrationId">The source's registration ID (must be &gt;= 0).</param>
<param name="domainId">The store's domain ID (must be &gt;= 0).</param>

### UMEStoreEntry

```csharp
public UMEStoreEntry(IPEndPoint address, ushort groupIndex, uint registrationId, uint domainId, string name) : this(address, groupIndex, registrationId, domainId)
```

Creates a UMEStoreEntry and uses supplied values for initialization.

<param name="address">The address (IP and port) of the store</param>
<param name="groupIndex">The group the store belongs to</param>
<param name="registrationId">The sources's registration ID at the store</param>
<param name="domainId">The store's domain ID</param>
<param name="name">The configured store name.</param>

### address

```csharp
public IPEndPoint address()
```

Accessor function to get the store's address.

<returns>The store's address (IP and port).</returns>

### groupIndex

```csharp
public ushort groupIndex()
```

Accessor function to get the store's group index.

<returns>The store's group index.</returns>

### registrationId

```csharp
public uint registrationId()
```

Accessor function to return the source's registration ID with this store.

<returns>The source's registration ID.</returns>

### domainId

```csharp
public uint domainId()
```

Accessor function to return the store's domain ID.

<returns>The store's domain ID.</returns>

### isNamed

```csharp
public bool isNamed()
```

Returns true if the store representy by this entry was specified by name.

<returns>True for named stores, false otherwise.</returns>

### name

```csharp
public string name()
```

Returns the name of the store represented by this entry.

<returns>The name of the store if it is a named store, null otherwise.</returns>

## UMEStoreGroupEntry

*class* `com.latencybusters.lbm.UMEStoreGroupEntry`

### UMEStoreGroupEntry

```csharp
public UMEStoreGroupEntry()
```

Creates a UMEStoreGroupEntry object and initializes index and group size to 0.

### UMEStoreGroupEntry

```csharp
public UMEStoreGroupEntry(ushort index, ushort groupSize)
```

Creates a UMEStoreGroupEntry object and initializes the index and group size.

<exception ref="com.latencybusters.lbm.LBMEInvalException">Store group index was &lt; 0.</exception>
<exception ref="com.latencybusters.lbm.LBMEInvalException">Store group size was &lt; 0.</exception>
<param name="index">Index of the store group (must be &gt;= 0).</param>
<param name="groupSize">Size of the store group (must be &gt;= 0).</param>

### index

```csharp
public ushort index()
```

Returns this store group's index.

<returns>The UME store group index.</returns>

### groupSize

```csharp
public ushort groupSize()
```

Returns this store group's size.

<returns>Group size.</returns>

## UMQContextEventRegistrationCompleteInfo

*class* `com.latencybusters.lbm.UMQContextEventRegistrationCompleteInfo`

### UMQContextEventRegistrationCompleteInfo

```csharp
public UMQContextEventRegistrationCompleteInfo(int flags, long queueId, String queue, UInt64 regId):base(flags, queueId, queue)
```

  Creates a UMQContextEventRegistrationCompleteInfo object,
and initializes fields to the supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="queue">The name of the queue the receiver registered with.
</param>
<param name="regId">64-bit unsigned registration Ids.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

### registrationId

```csharp
public UInt64 registrationId()
```

 Get the registration Id associated with this registration complete info object.
<returns> Registration Id associated with this registration complete info object.
</returns>

## UMQContextEventRegistrationSuccessInfo

*class* `com.latencybusters.lbm.UMQContextEventRegistrationSuccessInfo`

### UMQContextEventRegistrationSuccessInfo

```csharp
public UMQContextEventRegistrationSuccessInfo(int flags, long queueId, String queue, long index, String queueInstance, UInt64 regId) :base(flags, queueId, queue, index, queueInstance)
```

  Creates a UMQContextEventRegistrationSuccessInfo object,
and initializes fields to the supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="queue">The name of the queue the receiver registered with.
</param>
<param name="index">The index of the instance of the queue.
</param>
<param name="queueInstance">The instance of the queue.
</param>
<param name="regId">64-bit unsigned registration Ids.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

### registrationId

```csharp
public UInt64 registrationId()
```

 Get the registration Id associated with this registration success info object.
<returns> Registration Id associated with this registration success info object.
</returns>

## UMQDeregistrationCompleteInfo

*class* `com.latencybusters.lbm.UMQDeregistrationCompleteInfo`

### UMQDeregistrationCompleteInfo

```csharp
public UMQDeregistrationCompleteInfo(int flags, long queueId, String queue):base(flags, queueId, queue)
```

 Creates a UMQDeregistrationCompleteInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="queue">The name of the queue the receiver registered with.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

## UMQIndexAssignedInfo

*class* `com.latencybusters.lbm.UMQIndexAssignedInfo`

### UMQIndexAssignedInfo

```csharp
public UMQIndexAssignedInfo(int flags, long queueId, String queue, UMQIndexInfo indexInfo) : base(flags, queueId, queue, indexInfo)
```

 Creates a UMQIndexAssignedInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="queue">The name of the queue at which the receiver was assigned the index.
</param>
<param name="indexInfo">UMQ Index information object.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

## UMQIndexAssignmentEligibilityStartCompleteInfo

*class* `com.latencybusters.lbm.UMQIndexAssignmentEligibilityStartCompleteInfo`

### UMQIndexAssignmentEligibilityStartCompleteInfo

```csharp
public UMQIndexAssignmentEligibilityStartCompleteInfo(int flags, long queueId, String queue) : base(flags, queueId, queue)
```

 Creates a UMQIndexAssignmentEligibilityStartCompleteInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="queue">The name of the queue the receiver is now eligible to receive index assignments from.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

## UMQIndexAssignmentEligibilityStopCompleteInfo

*class* `com.latencybusters.lbm.UMQIndexAssignmentEligibilityStopCompleteInfo`

### UMQIndexAssignmentEligibilityStopCompleteInfo

```csharp
public UMQIndexAssignmentEligibilityStopCompleteInfo(int flags, long queueId, String queue) : base(flags, queueId, queue)
```

 Creates a UMQIndexAssignmentEligibilityStopCompleteInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="queue">The name of the queue the receiver is now no longer eligible to receive index assignments from.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

## UMQIndexInfo

*class* `com.latencybusters.lbm.UMQIndexInfo`

### UMQIndexInfo

```csharp
public UMQIndexInfo(byte[] index, int length)
```

Creates a UMQIndexInfo object using specified (arbitrary, user-specified) data.

<param name="index">Index data.</param>
<param name="length">Length of index data (must be greater than 0 and less than or equal to LBM.UMQ_MAX_INDEX_LEN)</param>

### UMQIndexInfo

```csharp
public UMQIndexInfo(UInt64 index)
```

Creates a numeric UMQIndexInfo object using the specified 64-bit unsigned index number.

<param name="index">Numeric index.</param>

### UMQIndexInfo

```csharp
public UMQIndexInfo()
```

Default constructor

### flags

```csharp
public int flags()
```

Returns flags for this UMQIndexInfo object.

<returns>Flags.</returns>

### index

```csharp
public byte[] index()
```

Returns data index for this UMQIndexInfo object.  Throws an LBMEInvalException if the UMQIndexInfo object is numeric.

<returns>Index data.</returns>

### numericIndex

```csharp
public UInt64 numericIndex()
```

Returns 64-bit unsigned numeric index for this UMQIndexInfo object. Throws an LBMEInvalException if the index is not numeric.

<returns>64-bit unsigned index.</returns>

### indexLength

```csharp
public int indexLength()
```

Returns length of non-numeric index. Throws an LBMEInvalException if index is numeric.

<returns>Length of index data.</returns>

### setIndex

```csharp
public void setIndex(byte[] index, int length)
```

Sets data index to specified data.  Index length must be greater than 0 and less than or equal to LBM.UMQ_MAX_INDEX_LEN.

<param name="index">Index data.</param>
<param name="length">Length of index data.</param>

### setNumericIndex

```csharp
public void setNumericIndex(UInt64 index)
```

Sets index to specified numeric index.

<param name="index">Numeric index (unsigned 64-bit integer)</param>

## UMQIndexReleasedInfo

*class* `com.latencybusters.lbm.UMQIndexReleasedInfo`

### UMQIndexReleasedInfo

```csharp
public UMQIndexReleasedInfo(int flags, long queueId, String queue, UMQIndexInfo indexInfo) : base(flags, queueId, queue, indexInfo)
```

 Creates a UMQIndexReleasedInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="queue">The name of the queue releasing the receiver's index assignment.
</param>
<param name="indexInfo">UMQ Index information object.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

## UMQMessageId

*class* `com.latencybusters.lbm.UMQMessageId`

### UMQMessageId

```csharp
public UMQMessageId(UInt64 regId, UInt64 stamp)
```

 Creates a UMQMessageId object and initializes fields to the
supplied values.

<param name="regId">The 64-bit registration Id of the source context where the message originated.
</param>
<param name="stamp">A 64-bit identifier that indicates the individual message from the given source context.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

### registrationId

```csharp
public UInt64 registrationId()
```

 Get the registration Id associated with this message id.
<returns> Registration Id associated with this message id.
</returns>

### msgStamp

```csharp
public UInt64 msgStamp()
```

 Get the message stamp associated with this message id.
<returns> Message stamp associated with this message id.
</returns>

## UMQMessageTotalLifetimeInfo

*class* `com.latencybusters.lbm.UMQMessageTotalLifetimeInfo`

### UMQMessageTotalLifetimeInfo

```csharp
public UMQMessageTotalLifetimeInfo(UInt32 totalLifetime)
```

Creates a UMQMessageTotalLifetimeInfo with the specified total lifetime
<param name="totalLifetime">Total lifetime of the message</param>

### UMQMessageTotalLifetimeInfo

```csharp
public UMQMessageTotalLifetimeInfo()
```

Creates a UMQMessageTotalLifetimeInfo with the total lifetime set to 0

### totalLifetime

```csharp
public UInt32 totalLifetime()
```

Returns the specified total lifetime

### setTotalLifetime

```csharp
public void setTotalLifetime(UInt32 totalLifetime)
```

Sets the total lifetime
<param name="totalLifetime">the new total lifetime</param>

## UMQQueueIndexInfo

*class* `com.latencybusters.lbm.UMQQueueIndexInfo`

### UMQQueueIndexInfo

```csharp
public UMQQueueIndexInfo(int flags, long queueId, String queue, UMQIndexInfo indexInfo) : base(flags, queueId, queue)
```

 Creates a UMQQueueIndexInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="queue">The name of the queue the receiver is receiving this event from.
</param>
<param name="indexInfo">UMQ Index information object.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

### indexInfo

```csharp
public UMQIndexInfo indexInfo()
```

Get UMQ index information for this info object.

## UMQQueueInfo

*class* `com.latencybusters.lbm.UMQQueueInfo`

### UMQQueueInfo

```csharp
public UMQQueueInfo(int flags, long queueId, String queue)
```

 Creates a UMQQueueInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="queue">The name of the queue the receiver registered with.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

### flags

```csharp
public int flags()
```

 Get informational flags for this info object.
<returns> Flags.
</returns>

### queueId

```csharp
public long queueId()
```

 Get Queue Id for the queue associated with this info object.
<returns> Queue Id for the queue associated with this info object.
</returns>

### queueName

```csharp
public String queueName()
```

 Get Queue name for the queue associated with this info object.
<returns> Queue name for the queue associated with this info object.
</returns>

## UMQQueueInstanceInfo

*class* `com.latencybusters.lbm.UMQQueueInstanceInfo`

### UMQQueueInstanceInfo

```csharp
public UMQQueueInstanceInfo(int flags, long queueId, String queue, long index, String queueInstance):base(flags, queueId, queue)
```

 Creates a UMQQueueInstanceInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="queue">The name of the queue the receiver registered with.
</param>
<param name="index">The index of the instance of the queue.
</param>
<param name="queueInstance">The instance of the queue.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

### queueInstanceIndex

```csharp
public long queueInstanceIndex()
```

 Gets the index of the queue instance associated with this info object.
<returns> Index of the queue instance associated with this info object.
</returns>

### queueInstanceName

```csharp
public String queueInstanceName()
```

 Gets the name of the queue instance associated with this info object.
<returns> Name of the queue instance associated with this info object.
</returns>

## UMQRegistrationCompleteInfo

*class* `com.latencybusters.lbm.UMQRegistrationCompleteInfo`

### UMQRegistrationCompleteInfo

```csharp
public UMQRegistrationCompleteInfo(int flags, long queueId, long assignmentId, String queue):base(flags, queueId, queue)
```

 Creates a UMQRegistrationCompleteInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="assignmentId">The generated Assignment ID for the receiver with the queue.
</param>
<param name="queue">The name of the queue the receiver registered with.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

### assignmentId

```csharp
public virtual long assignmentId()
```

 Get generated Assignment ID for this registration complete message.
<returns> The generated Assignment ID for the receiver with the queue.
</returns>

## UMQSourceEventAckInfo

*class* `com.latencybusters.lbm.UMQSourceEventAckInfo`

### UMQSourceEventAckInfo

```csharp
public UMQSourceEventAckInfo(int flags, long queueId, String queue, long index, String queueInstance, UMQMessageId msgId, uint firstSequenceNumber, uint lastSequenceNumber, Object clientObject) :base(flags, queueId, queue, index, queueInstance)
```

 Creates a UMQSourceEventAckInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="queue">The name of the queue the receiver registered with.
</param>
<param name="index">The index of the instance of the queue.
</param>
<param name="queueInstance">The instance of the queue.
</param>
<param name="msgId">The registration Id of the source context where the message
being acknowledged originated.
</param>
<param name="firstSequenceNumber">The sequence number of the first fragment associated with the acknowledgment message.
</param>
<param name="lastSequenceNumber">The sequence number of the last fragment associated with the acknowledgment message.
</param>
<param name="clientObject">The client object associated with the acknowledgment message.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

### firstSequenceNumber

```csharp
public virtual uint firstSequenceNumber()
```

 Get the sequence number of the first fragment of the message being acknowledged.
<returns> Sequence number of the first fragment of the message being acknowledged.
</returns>

### lastSequenceNumber

```csharp
public virtual uint lastSequenceNumber()
```

 Get the sequence number of the last fragment of the message being acknowledged.
<returns> Sequence number of the last fragment of the message being acknowledged.
</returns>

### messageIdInfo

```csharp
public virtual UMQMessageId messageIdInfo()
```

 Get the message Id object identifying the message being acknowledged.
<returns> A UMQMessageId object identifying the message being acknowledged.
</returns>

### clientObject

```csharp
public virtual Object clientObject()
```

 Get the client-supplied callback object.
<returns> Client-supplied object.
</returns>

## UMQSourceEventMessageIdInfo

*class* `com.latencybusters.lbm.UMQSourceEventMessageIdInfo`

### UMQSourceEventMessageIdInfo

```csharp
public UMQSourceEventMessageIdInfo(int flags, UMQMessageId msgId, Object clientObject)
```

 Creates a UMQSourceEventMessageIdInfo object and initializes fields to the
supplied values.

<exception>  LBMEInvalException An invalid parameter was specified. </exception>

### flags

```csharp
public int flags()
```

 Get informational flags for this info object.
<returns> Flags.
</returns>

### messageId

```csharp
public virtual UMQMessageId messageId()
```

 Get the message Id object identifying the message.
<returns> A UMQMessageId object identifying the message.
</returns>

### clientObject

```csharp
public Object clientObject()
```

 Get the client object provided when the message was sent.
<returns> The object provided when sending the message associated with this message info.
</returns>
<since> UME 3.0
</since>

## UMQSourceEventRegistrationCompleteInfo

*class* `com.latencybusters.lbm.UMQSourceEventRegistrationCompleteInfo`

### UMQSourceEventRegistrationCompleteInfo

```csharp
public UMQSourceEventRegistrationCompleteInfo(int flags, long queueId, String queue):base(flags, queueId, queue)
```

 Creates a UMQSourceEventRegistrationCompleteInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="queueId">Queue Id of the queue.
</param>
<param name="queue">The name of the queue the receiver registered with.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

## UMQSourceEventULBMessageInfo

*class* `com.latencybusters.lbm.UMQSourceEventULBMessageInfo`

### UMQSourceEventULBMessageInfo

```csharp
public UMQSourceEventULBMessageInfo(int flags, UMQMessageId msgId, UInt64 regId, uint firstSequenceNumber, uint lastSequenceNumber, uint assignId, uint appSetIdx, Object clientObject, String receiver) :base(flags, regId, assignId, appSetIdx, receiver)
```

 Creates a UMQSourceEventULBMessageInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="msgId">The Message ID of the message.
</param>
<param name="regId">The Registration ID of the receiver.
</param>
<param name="firstSequenceNumber">The sequence number of the first fragment associated with the message.
</param>
<param name="lastSequenceNumber">The sequence number of the last fragment associated with the message.
</param>
<param name="assignId">The Assignment ID of the receiver.
</param>
<param name="appSetIdx">The Application Set Index the receiver is in.
</param>
<param name="clientObject">The client object associated with the message.
</param>
<param name="receiver">The immediate message target string for the receiver.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

### firstSequenceNumber

```csharp
public virtual uint firstSequenceNumber()
```

 Get the sequence number of the first fragment of the message.
<returns> Sequence number of the first fragment of the message.
</returns>

### lastSequenceNumber

```csharp
public virtual uint lastSequenceNumber()
```

 Get the sequence number of the last fragment of the message.
<returns> Sequence number of the last fragment of the message.
</returns>

### messageId

```csharp
public virtual UMQMessageId messageId()
```

 Get the message Id object identifying the message.
<returns> A UMQMessageId object identifying the message.
</returns>

### clientObject

```csharp
public virtual Object clientObject()
```

 Get the client-supplied callback object.
<returns> Client-supplied object.
</returns>

## UMQSourceEventULBReceiverInfo

*class* `com.latencybusters.lbm.UMQSourceEventULBReceiverInfo`

### UMQSourceEventULBReceiverInfo

```csharp
public UMQSourceEventULBReceiverInfo(int flags, UInt64 regId, uint assignId, uint appSetIdx, String receiver)
```

 Creates a UMQSourceEventULBReceiverInfo object and initializes fields to the
supplied values.

<param name="flags">Informational flags.
</param>
<param name="regId">Registration ID of the receiver.
</param>
<param name="assignId">The assignment ID of the receiver.
</param>
<param name="appSetIdx">The application set index the receiver is in.
</param>
<param name="receiver">The receivers immediate message target string.
</param>
<exception>  LBMEInvalException An invalid parameter was specified. </exception>

### flags

```csharp
public int flags()
```

 Get informational flags for this info object.
<returns> Flags.
</returns>

### registrationId

```csharp
public UInt64 registrationId()
```

 Get Registration ID for the receiver.
<returns> Registration ID for the receiver associated with this info object.
</returns>

### assignmentId

```csharp
public uint assignmentId()
```

 Get Assignment ID for the receiver.
<returns> Assignment ID for the receiver associated with this info object. </returns>

### applicationSetIndex

```csharp
public uint applicationSetIndex()
```

 Get Application Set Index the receiver is in.
<returns> Application Set Index for the receiver associated with this info object. </returns>

### receiver

```csharp
public String receiver()
```

 Get receivers immediate message target string for the receiver associated with this info object.
<returns> Receivers immediate message target string for the receiver associated with this info object.
</returns>

## lbmdump

*class* `com.latencybusters.util.lbmdump`

### toHexString

```csharp
public static System.String toHexString(byte[] buf, int offset, int len)
```

Get a string of hex formatted characters
<param name="buf">The buffer containing the data to be converted to hex
</param>
<param name="offset">The offset in to the buffer to start processing
</param>
<param name="len">The number of bytes to be formatted
</param>
<returns> A string of hex formatted characters
</returns>

### toHexString

```csharp
public static System.String toHexString(byte[] buf)
```

Get a string of hex formatted characters - the entire buffer is Xi
processed

<param name="buf">The buffer containing the data to be converted to hex
</param>
<returns> A string of hex formatted characters
</returns>

### dump

```csharp
public static void dump(byte[] buf)
```

Dump a buffer to stdout
<param name="buf">The buffer containing the data to be converted to hex
</param>

### dump

```csharp
public static void dump(byte[] buf, int start, int end)
```

Dump a buffer to stdout
<param name="buf">The buffer containing the data to be converted to hex
</param>
<param name="start">The offset in to the buffer to start processing
</param>
<param name="end">The penultimate byte to be formatted
</param>
