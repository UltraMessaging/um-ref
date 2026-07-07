# Java API Reference

Auto-generated from Javadoc-documented public API in the `com.latencybusters.lbm` package.

## JMSMessageId

*class* `com.latencybusters.lbm.JMSMessageId`

### JMSMessageId

```java
public JMSMessageId(String topic)
```

Instantiate an JMSMessageId object

## LBM

*class* `com.latencybusters.lbm.LBM`

### LBM

```java
public LBM() throws LBMException
```

Instantiate LBM utility class
(initializes log)
@throws LBMException if any initialization error occurs.

### setLicenseFile

```java
public static void setLicenseFile(String licenseFile) throws LBMException
```

Initialize the LBM license from the contents of a disk file.
This method will only be effective if it is called before
any other LBM API method.
@param licenseFile String containing the name of a file
that contains the LBM license.  This string is the same as that
which would otherwise be specified as the  value of the
LBM_LICENSE_FILENAME environmental variable.
@throws LBMException if <code>licenseFile</code> doesn't contain a valid filename,
    doesn't exist, or contains an invalid LBM license.

### setLicenseString

```java
public static void setLicenseString(String licenseString) throws LBMException
```

Initialize the LBM license from a string.
This method will only be effective if it is called before
any other LBM API method.
@param licenseString String containing LBM license.
This string is the same as that which would otherwise be specified
as the  value of the LBM_LICENSE_INFO environmental variable.
@throws LBMException if <code>licenseString</code> doesn't contain a valid LBM license.

### getLicenseUMMNMValid

```java
public static boolean getLicenseUMMNMValid() throws LBMException
```

Determines whether UMMNM is licensed for use.
@return true if licensed
@throws LBMException if <code>licenseString</code> doesn't contain a valid LBM license.

### getLicenseVDSValid

```java
public static boolean getLicenseVDSValid() throws LBMException
```

Determines whether VDS is licensed for use.
@return true if licensed
@throws LBMException if <code>licenseString</code> doesn't contain a valid LBM license.

### setConfiguration

```java
public static void setConfiguration(String fileName) throws LBMException
```

Configure LBM attributes from a file, tftp or http URL.
@param fileName String containing a file name or URL (tftp or http). File names
    ending with a ".xml" extension will be processed by the setConfigurationXml API
    with a null applicationName.
@throws LBMException if <code>fileName</code> contains an invalid filename,
    doesn't exist, or doesn't contain a valid LBM configuration file.

### setConfigurationXml

```java
public static void setConfigurationXml(String fileName, String applicationName) throws LBMException
```

Configure LBM attributes from a file, tftp or http URL.
@param fileName String containing the path or URL (tftp or http) to the XML
    configuraton file.
@param applicationName String containing the name of this applicaiton which must match an
    application tag in the XML configuration file. This parameter may be null,
    in which case the application tag with no name is matched.
@throws LBMException if <code>fileName</code> contains an invalid filename,
    doesn't exist, doesn't contain a valid LBM XML configuration file, or
    LBM XML configuration has already been loaded.

### setConfigurationXmlString

```java
public static void setConfigurationXmlString(String xmlString, String applicationName) throws LBMException
```

Configure LBM attributes from a String
@param xmlString String containing LBM XML configuration data.
@param applicationName String containing the name of this applicaiton which must match an
    application tag in the XML configuration string. This parameter may be null,
    in which case the application tag with no name is matched.
@throws LBMException if <code>xmlString</code> is empty,
    doesn't exist, doesn't contain valid LBM XML configuration data, or
    LBM XML configuration has already been loaded.

### setUmmInfo

```java
public static void setUmmInfo(LBMUMMInfo info) throws LBMException
```

Connect to and retrieve configuration from a UMM daemon.
This method will only be effective if it is called before
any other LBM API method.
@param info UMM daemon connection options
@throws LBMException if UMM info has already been loaded, or if some other error was encountered.

### version

```java
public static String version()
```

Get LBM version information.
@return LBM version

### legalInfo

```java
public static String legalInfo()
```

Get LBM legal information.
@return LBM legalInfo

### setLogger

```java
public void setLogger(LBMLogging logger)
```

Inform LBM to use a specific logger for logging
@param logger Logging object implementing the LBMLogging interface

### setDebugFilename

```java
public static void setDebugFilename(String filename) throws LBMException
```

Set the LBM debug filename.
@param filename The name of the file to be written with debug data.
@throws LBMException if out of memory.

### setDebugMask

```java
public static void setDebugMask(long mask)
```

Set the LBM debug mask, as suggested by the support team.
@param mask The mask used for debugging purposes.

### lbmLogDebugMessage

```java
public static void lbmLogDebugMessage(long mask, String message)
```

Write debug message to debug file.
This method is for internal use only.
@param mask The mask used for debugging purposes.
@param message The debug message to write.

### setUimLossRate

```java
public static void setUimLossRate(int rate)
```

Set the UIM receiver-side loss rate.
@param rate The percentage (0-100) loss to be simulated.

### setLbtrmLossRate

```java
public static void setLbtrmLossRate(int rate)
```

Set the LBTRM receiver-side loss rate.
@param rate The percentage (0-100) loss to be simulated.

### setLbtrmSrcLossRate

```java
public static void setLbtrmSrcLossRate(int rate)
```

Set the LBTRM source-side loss rate.
@param rate The percentage (0-100) loss to be simulated.

### setLbtruLossRate

```java
public static void setLbtruLossRate(int rate)
```

Set the LBTRU receiver-side loss rate.
@param rate The percentage (0-100) loss to be simulated.

### setLbtruSrcLossRate

```java
public static void setLbtruSrcLossRate(int rate)
```

Set the LBTRU source-side loss rate.
@param rate The percentage (0-100) loss to be simulated.

### setDebugLogCallback

```java
public static void setDebugLogCallback(boolean enable)
```

Enable logging of debug messages to the application logging callback set by LBM.setLogger().
By default, if lbm debug logging is enabled it is sent to the filename
specified by setDebugFilename(), or stderr. Calling setDebugLogCallback() with
a value of true will redirect debug logging to the application logger set by
setLogger(), or stderr if no logger is set.
@param enable true enables, false disables.

### dumpDebugLog

```java
public static void dumpDebugLog(String filename, boolean append) throws LBMException
```

Dump the in-memory LBM debug log to a specified file.
@param filename Name of the file to dump debug log events to.
@param append Set to true to append the debug log to the file; otherwise, the file is overwritten.

### asyncOperationCancel

```java
public static void asyncOperationCancel(long handle) throws LBMException
```

 Cancel the asynchronous operation referred to by the given handle.

Calling this function will cause the associated asynchronous operation's
async operation callback function to be called with a canceled status.
If the operation could not be canceled (either it has already completed,
an exception is thrown.  Otherwise, the operation was found and guaranteed
to have been truly canceled.
It is generally not safe to call this function from within an asynchronous operation callback for the same handle that is being canceled.
There is one exception: it is safe to call cancel on a handle from within the initial LBM_ASYNC_OP_STATUS_IN_PROGRESS that
delivers the handle; this is in fact a reasonable way to simulate a non-blocking synchronous call.
@param handle The handle to the asynchronous operation.
@throws LBMException if the operation could not be canceled.

### asyncOperationCancel

```java
public static void asyncOperationCancel(long handle, int flags) throws LBMEWouldBlockException, LBMException
```

 Cancel the asynchronous operation referred to by the given handle.

Calling this function will cause the associated asynchronous operation's
async operation callback function to be called with a canceled status.
If the operation could not be canceled (either it has already completed,
an exception is thrown.  Otherwise, the operation was found and guaranteed
to have been truly canceled.
It is generally not safe to call this function from within an asynchronous operation callback for the same handle that is being canceled.
There is one exception: it is safe to call cancel on a handle from within the initial LBM_ASYNC_OP_STATUS_IN_PROGRESS that
delivers the handle; this is in fact a reasonable way to simulate a non-blocking synchronous call.
@param handle The handle to the asynchronous operation.
@param flags Flags affecting the behavior of the cancel call; pass 0 if no flags desired.
@throws LBMEWouldBlockException if the non-block flag was passed and the operation would block.
@throws LBMException if the operation could not be canceled.
@see LBM#ASYNC_OPERATION_CANCEL_FLAG_NONBLOCK

### asyncOperationStatus

```java
public static void asyncOperationStatus(long handle) throws LBMException
```

 Query the status of the asynchronous operation referred to by the given handle.

Calling this function will cause the associated asynchronous operation's
async operation callback function to be called with current status information.
This is a merely a polling mechanism, and the information returned is guaranteed
to be correct only for the duration of the async operation callback function.
It may change immediately afterwards.
It is not safe to (nor should it be necessary to) call this function from within an asynchronous operation callback for the same handle that status is being requested for.
@param handle The handle to the asynchronous operation.
@throws LBMException if the operation could not be found.

### asyncOperationStatus

```java
public static void asyncOperationStatus(long handle, int flags) throws LBMEWouldBlockException, LBMException
```

 Query the status of the asynchronous operation referred to by the given handle.

Calling this function will cause the associated asynchronous operation's
async operation callback function to be called with current status information.
This is a merely a polling mechanism, and the information returned is guaranteed
to be correct only for the duration of the async operation callback function.
It may change immediately afterwards.
It is not safe to (nor should it be necessary to) call this function from within an asynchronous operation callback for the same handle that status is being requested for.
@param handle The handle to the asynchronous operation.
@param flags Flags affecting the behavior of the status call; pass 0 if no flags desired.
@throws LBMEWouldBlockException if the non-block flag was passed and the operation would block.
@throws LBMException if the operation could not be found.
@see LBM#ASYNC_OPERATION_STATUS_FLAG_NONBLOCK

## LBMApplicationException

*class* `com.latencybusters.lbm.LBMApplicationException`

### LBMApplicationException

```java
public LBMApplicationException(String errorMessage)
```

Default constructor.
@param errorMessage holds the error string.

## LBMApplicationHeaderChain

*class* `com.latencybusters.lbm.LBMApplicationHeaderChain`

### LBMApplicationHeaderChain

```java
public LBMApplicationHeaderChain() throws LBMException
```

Create an LBMApplicationHeaderChain object used to attach application headers to a send.
@return A new, empty application header chain.
@since UMQ 1.1

### dispose

```java
public void dispose() throws LBMException
```

Cleans up memory associated with this LBMApplicationHeaderChain.  A chain should
not be used again once dispose() has been called.  Calling dispose() is optional,
but recommended.
@since UMQ 1.1

### iterator

```java
public Iterator<LBMApplicationHeaderChainElement> iterator()
```

Returns an iterator that can be used to iterate over each {@link LBMApplicationHeaderChainElement} in this LBMApplicationHeaderChain.
@return Iterator for {@link LBMApplicationHeaderChainElement} items in this application chain.
@since UMQ 1.1

### add

```java
public void add(LBMApplicationHeaderChainElement element) throws LBMException
```

Add a new {@link LBMApplicationHeaderChainElement} to the end of this application header chain.
@param element The element to add.
@throws LBMException if the add fails for any reason.

## LBMApplicationHeaderChainElement

*class* `com.latencybusters.lbm.LBMApplicationHeaderChainElement`

### LBMApplicationHeaderChainElement

```java
public LBMApplicationHeaderChainElement()
```

Create a new LBMApplicationHeaderChainElement object that can be added to a {@link LBMApplicationHeaderChain}.
@return the new LBMApplicationHeaderChainElement object.
@since UMQ 1.1

### getType

```java
public byte getType()
```

Returns the application header element's type.  The only currently supported type is {@link LBM#CHAIN_ELEM_USER_DATA}.
@return A byte representing the type of application header element.
@since UMQ 1.1

### setType

```java
public void setType(byte type) throws LBMEInvalException
```

Sets this application header element's type.  The only currently supported type is {@link LBM#CHAIN_ELEM_USER_DATA}.
Setting this to any other type will cause an exception to be thrown.
@param type The type of the application header element.  This should always be set to {@link LBM#CHAIN_ELEM_USER_DATA}.
@throws LBMEInvalException if the type is not supported.
@since UMQ 1.1

### getSubtype

```java
public short getSubtype()
```

Get the user-settable subtype of the application header element.
@return A short representing the user-settable subtype of the application header element.
@since UMQ 1.1

### setSubtype

```java
public void setSubtype(short subtype)
```

Sets the subtype of the application header element.  Subtypes can be any positive number representable
by a short.  It's up to the user application to assign meaning to and interpret the subtype field.
@param subtype The subtype to set this application header element to.
@since UMQ 1.1

### getData

```java
public byte[] getData()
```

Get the data associated with this application header element.
@return Application header element data. The length of the data array is always a multiple of four. For example, if [57,57] is sent, the received byte array is [57,57,0,0].
@since UMQ 1.1

### setData

```java
public void setData(byte[] data)
```

Set the data byte array to be sent with this application header element.
<p>
<b>NOTE:</b> Application header element data payloads are currently limited in length to 196 bytes or less.
@param data The data byte array to send with this application header element.
@since UMQ 1.1

## LBMApplicationHeaderChainIterator

*class* `com.latencybusters.lbm.LBMApplicationHeaderChainIterator`

### hasNext

```java
public boolean hasNext()
```

Returns true if one or more application header chain elements remain in an LBMApplicationHeaderChain, false otherwise.
@since UMQ 1.1

### next

```java
public LBMApplicationHeaderChainElement next()
```

Gets the next {@link LBMApplicationHeaderChainElement} in an {@link LBMApplicationHeaderChain}.
@since UMQ 1.1

### remove

```java
public void remove() throws UnsupportedOperationException
```

Removes the current {@link LBMApplicationHeaderChainElement} from an {@link LBMApplicationHeaderChain}.
<p>
<b>NOTE:</b> remove() is currently unsupported - calling remove will throw an UnsupportedOperationException.
@throws UnsupportedOperationException Always - remove is not currently implemented.

### dispose

```java
public void dispose() throws LBMException
```

Cleans up memory associated with this LBMApplicationHeaderChainIterator immediately.  An iterator should
not be used again once dispose() has been called.  Calling dispose() is optional.
@since UMQ 1.1

## LBMAsyncOperationCallback

*interface* `com.latencybusters.lbm.LBMAsyncOperationCallback`

### onAsyncOperation

```java
int onAsyncOperation(Object cbArg, LBMAsyncOperationInfo opinfo)
```

Asynchronous operation callback method.
@param cbArg Client object supplied by call to asynchronous API method.
@param opinfo Object containing information about the delivered async operation update (status, results, operation type, etc.).

## LBMAsyncOperationInfo

*class* `com.latencybusters.lbm.LBMAsyncOperationInfo`

### type

```java
public int type()
```

 Gets the type of the asynchronous operation.
@see LBM#ASYNC_OP_TYPE_CTX_UMQ_QUEUE_TOPIC_LIST
@see LBM#ASYNC_OP_TYPE_RCV_UMQ_QUEUE_MSG_LIST
@see LBM#ASYNC_OP_TYPE_RCV_UMQ_QUEUE_MSG_RETRIEVE
@return the operation type.

### status

```java
public int status()
```

 Gets the status of the asynchronous operation.
@see LBM#ASYNC_OP_STATUS_IN_PROGRESS
@see LBM#ASYNC_OP_STATUS_COMPLETE
@see LBM#ASYNC_OP_STATUS_ERROR
@see LBM#ASYNC_OP_STATUS_CANCELED
@return the operation's current status.

### flags

```java
public int flags()
```

 Gets informational flags about this particular asynchronous operation update.
@see LBM#ASYNC_OP_INFO_FLAG_INLINE
@see LBM#ASYNC_OP_INFO_FLAG_FIRST
@see LBM#ASYNC_OP_INFO_FLAG_LAST
@see LBM#ASYNC_OP_INFO_FLAG_ONLY
@return the flags.

### handle

```java
public long handle()
```

 Gets the asynchronous operation's opaque handle (a long value), which can be used to query the operation's status
or to cancel it.  The handle will only be valid if the asynchronous operation was able to be started; otherwise it
will be set to LBM#ASYNC_OP_INVALID_HANDLE .
@see LBM#ASYNC_OP_INVALID_HANDLE
@return The operation's handle.

### contextQueueTopicListInfo

```java
public UMQContextQueueTopicListInfo contextQueueTopicListInfo() throws LBMEInvalException
```

 Gets the results of an LBMContext#queueTopicList asynchronous operation.
@return the results.
@throws LBMEInvalException if the async operation information was for an operation type other than LBM#ASYNC_OP_TYPE_CTX_UMQ_QUEUE_TOPIC_LIST.

### receiverQueueMessageListInfo

```java
public UMQReceiverQueueMessageListInfo receiverQueueMessageListInfo() throws LBMEInvalException
```

 Gets the results of an LBMReceiverBase#queueMessageList asynchronous operation.
@return the results.
@throws LBMEInvalException if the async operation information was for an operation type other than LBM#ASYNC_OP_TYPE_RCV_UMQ_QUEUE_MSG_LIST.

### receiverQueueMessageRetrieveInfo

```java
public UMQReceiverQueueMessageRetrieveInfo receiverQueueMessageRetrieveInfo() throws LBMEInvalException
```

 Gets the results of an LBMReceiverBase#queueMessageRetrieve asynchronous operation.
@return the results.
@throws LBMEInvalException if the async operation information was for an operation type other than LBM#ASYNC_OP_TYPE_RCV_UMQ_QUEUE_MSG_RETRIEVE.

## LBMAuthCredentialsCallback

*interface* `com.latencybusters.lbm.LBMAuthCredentialsCallback`

### onAuthRequest

```java
LBMAuthUserInfo onAuthRequest(Object cbArg, LBMAuthUserInfo userInfo)
```

Callback function called when an action is attempted that requires
different authentication credentials than what were previously provided.
@param cbArg Callback object token
@param userInfo The user credentials the action was attempted with, but were insufficient.
@return A new LBMAuthUserInfo object containing new (sufficient) username and password credentials that will be used to re-try the action.

## LBMAuthUserInfo

*class* `com.latencybusters.lbm.LBMAuthUserInfo`

### username

```java
public String username()
```

Returns the user name.
@return username.

### password

```java
public String password()
```

Returns the password.
@return password.

### setUsername

```java
public void setUsername(String username)
```

 Sets username.

@param username to set.

### setPassword

```java
public void setPassword(String password)
```

 Sets password.

@param password to set.

## LBMConfigOption

*class* `com.latencybusters.lbm.LBMConfigOption`

### LBMConfigOption

```java
public LBMConfigOption(String t, String o, String v)
```

Instantiate an LBMConfigObjection using given attributes. This structure is populated and
returned via configDump() calls.
@param t The type of option it will be (context, source, etc...).
@param o The option name.
@param v The assigned value of the option.

### setType

```java
public void setType(String t)
```

Set the type value of this configuration option.
@param t The type value to set.

### setOptionName

```java
public void setOptionName(String o)
```

Set the option name value of this configuration option.
@param o The type value to set.

### setValue

```java
public void setValue(String v)
```

FOR INTERNAL INFORMATICA USE ONLY - NOT FOR DIRECT APPLICATION USEAGE.
Applications should use setProperty() instead.
Set the configuration option valuen.
@param v The value to set.

### getType

```java
public String getType()
```

Get the configuration type of this object.
@return Returns the configuration type of the object.

### getOptionName

```java
public String getOptionName()
```

Get the configuration option of this object.
@return Returns the configuration option of the object.

### getValue

```java
public String getValue()
```

Get the configuration vlaue of this object.
@return Returns the configuration value of the object.

## LBMContext

*class* `com.latencybusters.lbm.LBMContext`

### LBMContext

```java
public LBMContext() throws LBMException
```

Instantiate an LBMContext object using default attributes.
@throws LBMException if any error occurs creating the context.

### LBMContext

```java
public LBMContext(LBMContextAttributes lbmcattr) throws LBMException
```

Instantiate an LBMContext object using given attributes.
@param lbmcattr LBMContextAttributes used to initialize the context
@throws LBMException if any error occurs creating the context.

### setAuthCredentials

```java
public void setAuthCredentials(LBMAuthUserInfo userInfo, LBMAuthCredentialsCallback authCallback, Object cbArg) throws LBMException
```

 Sets the initial authentication credentials for this context as well as a callback
to call if for new credentials if authentication fails.
@param userInfo Initial user credentials.
@param authCallback Callback that will be called to obtain different user credentials if authentication fails.  Can be null, in which case the same credentials as originally given will be tried each time.
@param cbArg User-supplied callback object.
@throws LBMException if setting credentials or the callback fails.

### close

```java
public void close()
```

Close this context.  All sources and receivers associated with this context should be closed first.
    <p>
    <b>Warning</b>: It is not safe to close() from a context thread callback.

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions.
@return Array of LBMConfigOption

### getAttributeValue

```java
public String getAttributeValue(String attributeName) throws LBMException
```

Returns the value of a context-related attribute for this context.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setAttributeValue

```java
public void setAttributeValue(String attributeName, String attributeValue) throws LBMException
```

Set the value of a context-related attribute for this context.
Note that this method bypasses the property list.
As such no attributes configured using this method will appear in
the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.
@see #setProperty

### setProperty

```java
public Object setProperty(String attributeName, String attributeValue)
```

Set the current value of an attribute in this set of context attributes.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMRuntimeException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.
@return an Object.

### load

```java
public void load(InputStream inStream) throws IOException
```

Reads a property (attribute) list (key and element pairs) from the
input stream.
@param inStream Input stream of bytes
@throws IOException if any I/O error occurs.
@throws LBMRuntimeException if any invalid attribute is detected in <code>inStream</code>.

### processEvents

```java
public void processEvents(long msec) throws LBMException
```

Process internal events in the given LBM context object.

When the operational mode is set to "sequential",
it is the responsibility of the application to explicitly process
events for the LBM context. This method will process timers and
file descriptor/socket events for internal processing as well as
API timer and file descriptor/socket events.
<p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param msec Continue event processing loop for at least msec milliseconds before returning.
@throws LBMException if any error occurs.

### processEvents

```java
public void processEvents(long msec, int flags) throws LBMException
```

Process internal events in the given LBM context object.

When the operational mode is set to "sequential",
it is the responsibility of the application to explicitly process
events for the LBM context. This method will process timers and
file descriptor/socket events for internal processing as well as
API timer and file descriptor/socket events.
<p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param msec Continue event processing loop for at least msec milliseconds before returning.
@param flags Flags to select various features.
See next section for possible OR'd set of values.
@throws LBMException if any error occurs.
@see LBM#PROC_EVENT_EX_FLAG_NO_MAIN_LOOP_MUTEX

### processEvents

```java
public void processEvents(long msec, int flags, long tv_sec, long tv_usec) throws LBMException
```

Process internal events in the given LBM context object.

When the operational mode is set to "sequential",
it is the responsibility of the application to explicitly process
events for the LBM context. This method will process timers and
file descriptor/socket events for internal processing as well as
API timer and file descriptor/socket events.
<p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param msec Continue event processing loop for at least msec milliseconds before returning.
@param flags Flags to select various features.
See next section for possible OR'd set of values.
@param tv_sec User supplies time when the LBM#PROC_EVENT_EX_FLAG_USER_TIME flag is set.
@param tv_usec User supplies time when the LBM#PROC_EVENT_EX_FLAG_USER_TIME flag is set.
@throws LBMException if any error occurs.
@see LBM#PROC_EVENT_EX_FLAG_NO_MAIN_LOOP_MUTEX
@see LBM#PROC_EVENT_EX_FLAG_USER_TIME

### unblockProcessEvents

```java
public void unblockProcessEvents() throws LBMException
```

Unblock processEvents call.

When the operational mode is set to "sequential",
this API forces a call to processEvents to return immediately after
completing the current set of I/O operations instead of waiting.
<p>
@throws LBMException if any error occurs.

### lookupTopic

```java
public LBMTopic lookupTopic(String symbol) throws LBMException
```

Create an LBMTopic object (useable for an LBM receiver)
for a given topic name.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param symbol Topic name string. Topic strings should be limited in length
            to 246 characters (not including the final null).
@return LBMTopic object for specified topic name
@throws LBMException if any error occurs looking up the topic.

### lookupTopic

```java
public LBMTopic lookupTopic(String symbol, LBMReceiverAttributes lbmrattr) throws LBMException
```

Create an LBMTopic object (useable for an LBM receiver)
for given topic name and attributes.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param symbol Topic name string. Topic strings should be limited in length
            to 246 characters (not including the final null).
@param lbmrattr LBMReceiverAttributes object
@return LBMTopic object for specified topic name and attributes
@throws LBMException if any error occurs looking up the topic.

### allocTopic

```java
public LBMTopic allocTopic(String symbol) throws LBMException
```

Create an LBMTopic object (useable for an LBM source)
for given topic name and attributes.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param symbol Topic name string. Topic strings should be limited in length
            to 246 characters (not including the final null).
@return LBMTopic object for specified topic name and attributes
@throws LBMException if any error occurs allocating up the topic.

### allocTopic

```java
public LBMTopic allocTopic(String symbol, LBMSourceAttributes lbmsattr) throws LBMException
```

Create an LBMTopic object (useable for an LBM source)
for given topic name and attributes.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param symbol Topic name string. Topic strings should be limited in length
            to 246 characters (not including the final null).
@param lbmsattr LBMSourceAttributes object
@return LBMTopic object for specified topic name and attributes
@throws LBMException if any error occurs allocating up the topic.

### enableImmediateMessageReceiver

```java
public void enableImmediateMessageReceiver() throws LBMException
```

Enable LBM to receive non-topic immediate messages.
This method does not establish a callback handler.
@throws LBMException if any error occurs enabling an immediate message receiver.
@see #addImmediateMessageReceiver

### enableImmediateMessageReceiver

```java
public void enableImmediateMessageReceiver(LBMEventQueue lbmevq) throws LBMException
```

Enable LBM to receive non-topic immediate messages (using an event
queue).  This method does not establish a callback handler.
@param lbmevq LBMEventQueue on which to process responses (may be null
if not using an event queue)
@throws LBMException if any error occurs enabling an immediate message receiver.
@see #addImmediateMessageReceiver

### addImmediateMessageReceiver

```java
public void addImmediateMessageReceiver(LBMImmediateMessageCallback cb)
```

Register a callback for handling of non-topic
immediate messages
@param cb Object implementing the LBMImmediateMessageCallback interface
@see #enableImmediateMessageReceiver
@see #removeImmediateMessageReceiver
@see LBMImmediateMessageCallback

### addImmediateMessageReceiver

```java
public void addImmediateMessageReceiver(LBMImmediateMessageCallback cb, Object cbArg)
```

Register a callback (and callback token) for handling of non-topic
immediate messages
@param cb Object implementing the LBMImmediateMessageCallback interface
@param cbArg Callback token object
@see #enableImmediateMessageReceiver
@see #removeImmediateMessageReceiver
@see LBMImmediateMessageCallback

### removeImmediateMessageReceiver

```java
public void removeImmediateMessageReceiver(LBMImmediateMessageCallback cb)
```

Deregister a non-topic, immediate message callback
@param cb Object implementing the LBMImmediateMessageCallback interface
@see #enableImmediateMessageReceiver
@see #addImmediateMessageReceiver
@see LBMImmediateMessageCallback

### removeImmediateMessageReceiver

```java
public void removeImmediateMessageReceiver(LBMImmediateMessageCallback cb, Object cbArg)
```

Deregister a non-topic immediate message callback (and callback token)
@param cb Previously registered object implementing the
LBMImmediateMessageCallback interface
@param cbArg Callback token for previously registered object
@see #enableImmediateMessageReceiver
@see #addImmediateMessageReceiver
@see LBMImmediateMessageCallback

### send

```java
public void send(String target, String topic, byte [] data, int dataLength, int flags) throws LBMException
```

  Send a unicast immediate message to the target and topic.

         The target is a string of one of the following forms:
         <ul>
         <li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
             the ID of the destination topic resolution domain, <i>ip</i> is the IP address
             of the destination host, and <i>port</i> is the request port for
             the context of the destination application.
         <li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
             of the destination host and <i>port</i> is the request port for
             the context of the destination application. This usage assumes
             the destination is in the same topic resolution domain as the sender.
         <li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
             string associated with a source's transport session. This allows
             a subscriber to send a unicast immediate message directly to a
             publishing application.  See \ref sendingtosources for details.
         </ul>

         Note that immediate messages are processed somewhat less efficiently
         than source-based messages.

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param target Destination address string.
  @param topic Topic name to send message to or null for non-topic
  @param data Data to send in this message
  @param dataLength Length (in bytes) of the data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate message.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK

### sendTopicless

```java
public void sendTopicless(String target, byte [] data, int dataLength, int flags) throws LBMException
```

  Send a topicless unicast immediate message to the target.

         The target is a string of one of the following forms:
         <ul>
         <li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
             the ID of the destination topic resolution domain, <i>ip</i> is the IP address
             of the destination host, and <i>port</i> is the request port for
             the context of the destination application.
         <li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
             of the destination host and <i>port</i> is the request port for
             the context of the destination application. This usage assumes
             the destination is in the same topic resolution domain as the sender.
         <li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
             string associated with a source's transport session. This allows
             a subscriber to send a unicast immediate message directly to a
             publishing application.  See \ref sendingtosources for details.
         </ul>

         Note that immediate messages are processed somewhat less efficiently
         than source-based messages.

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param target Destination address string.
  @param data Data to send in this message
  @param dataLength Length (in bytes) of the data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate message.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK

### sendc

```java
public void sendc(char [] target, char [] topic, byte [] data, int dataLength, int flags) throws LBMException
```

  Send a unicast immediate message to the target and topic.

         The target is a string of one of the following forms:
         <ul>
         <li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
             the ID of the destination topic resolution domain, <i>ip</i> is the IP address
             of the destination host, and <i>port</i> is the request port for
             the context of the destination application.
         <li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
             of the destination host and <i>port</i> is the request port for
             the context of the destination application. This usage assumes
             the destination is in the same topic resolution domain as the sender.
         <li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
             string associated with a source's transport session. This allows
             a subscriber to send a unicast immediate message directly to a
             publishing application.  See \ref sendingtosources for details.
         </ul>

         Note that immediate messages are processed somewhat less efficiently
         than source-based messages.

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param target Destination address string.
  @param topic Topic name to send message to or null for non-topic
  @param data Data to send in this message
  @param dataLength Length (in bytes) of the data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate message.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK

### sendTopicless

```java
public void sendTopicless(char [] target, byte [] data, int dataLength, int flags) throws LBMException
```

  Send a topicless unicast immediate message to the target.

         The target is a string of one of the following forms:
         <ul>
         <li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
             the ID of the destination topic resolution domain, <i>ip</i> is the IP address
             of the destination host, and <i>port</i> is the request port for
             the context of the destination application.
         <li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
             of the destination host and <i>port</i> is the request port for
             the context of the destination application. This usage assumes
             the destination is in the same topic resolution domain as the sender.
         <li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
             string associated with a source's transport session. This allows
             a subscriber to send a unicast immediate message directly to a
             publishing application.  See \ref sendingtosources for details.
         </ul>

         Note that immediate messages are processed somewhat less efficiently
         than source-based messages.

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param target Destination address string.
  @param data Data to send in this message
  @param dataLength Length (in bytes) of the data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate message.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK

### send

```java
public LBMRequest send(String target, String topic, byte [] data, int dataLength, LBMResponseCallback cb, Object cbArg, LBMEventQueue lbmevq, int flags) throws LBMException
```

  Send a unicast immediate request message to the target and topic.

         The target is a string of one of the following forms:
         <ul>
         <li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
             the ID of the destination topic resolution domain, <i>ip</i> is the IP address
             of the destination host, and <i>port</i> is the request port for
             the context of the destination application.
         <li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
             of the destination host and <i>port</i> is the request port for
             the context of the destination application. This usage assumes
             the destination is in the same topic resolution domain as the sender.
         <li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
             string associated with a source's transport session. This allows
             a subscriber to send a unicast immediate message directly to a
             publishing application.  See \ref sendingtosources for details.
         </ul>

         Note that immediate messages are processed somewhat less efficiently
         than source-based messages.

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param target Destination address string.
  @param topic Topic name to send message to or null for non-topic
  @param data Data to send in this request
  @param dataLength Length (in bytes) of the data to send in this request
  @param cb LBMResponseCallback interface to handle response callback
  @param cbArg Callback token object
  @param lbmevq LBMEventQueue on which to process responses (may be
  null if not using an event queue)
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate request.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @return an LBMRequest object.

### send

```java
public LBMRequest send(String target, String topic, byte [] data, int dataLength, LBMResponseCallback cb, Object cbArg, int flags) throws LBMException
```

  Send a unicast immediate request message to the target and topic.

         The target is a string of one of the following forms:
         <ul>
         <li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
             the ID of the destination topic resolution domain, <i>ip</i> is the IP address
             of the destination host, and <i>port</i> is the request port for
             the context of the destination application.
         <li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
             of the destination host and <i>port</i> is the request port for
             the context of the destination application. This usage assumes
             the destination is in the same topic resolution domain as the sender.
         <li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
             string associated with a source's transport session. This allows
             a subscriber to send a unicast immediate message directly to a
             publishing application.  See \ref sendingtosources for details.
         </ul>

         Note that immediate messages are processed somewhat less efficiently
         than source-based messages.

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param target Destination address string.
  @param topic Topic name to send message to or null for non-topic
  @param data Data to send in this request
  @param dataLength Length (in bytes) of the data to send in this request
  @param cb LBMResponseCallback interface to handle response callback
  @param cbArg Callback token object
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate request.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @return an LBMRequest object.

### send

```java
public void send(String target, String topic, LBMRequest lbmreq, LBMEventQueue lbmevq, int flags) throws LBMException
```

  Send a unicast immediate request message to the target and topic.

         The target is a string of one of the following forms:
         <ul>
         <li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
             the ID of the destination topic resolution domain, <i>ip</i> is the IP address
             of the destination host, and <i>port</i> is the request port for
             the context of the destination application.
         <li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
             of the destination host and <i>port</i> is the request port for
             the context of the destination application. This usage assumes
             the destination is in the same topic resolution domain as the sender.
         <li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
             string associated with a source's transport session. This allows
             a subscriber to send a unicast immediate message directly to a
             publishing application.  See \ref sendingtosources for details.
         </ul>

         Note that immediate messages are processed somewhat less efficiently
         than source-based messages.

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param target Destination address string.
  @param topic Topic name to send message to or null for non-topic
  @param lbmreq LBMRequest object
  @param lbmevq LBMEventQueue on which to process responses (may be
  null if not using an event queue)
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate request.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK

### send

```java
public void send(String target, String topic, LBMRequest lbmreq, int flags) throws LBMException
```

  Send a unicast immediate request message to the target and topic.

         The target is a string of one of the following forms:
         <ul>
         <li>\"TCP:<i>domain</i>:<i>ip</i>:<i>port</i>\" - where <i>domain</i> is
             the ID of the destination topic resolution domain, <i>ip</i> is the IP address
             of the destination host, and <i>port</i> is the request port for
             the context of the destination application.
         <li>\"TCP:<i>ip</i>:<i>port</i>\" - where <i>ip</i> is the IP address
             of the destination host and <i>port</i> is the request port for
             the context of the destination application. This usage assumes
             the destination is in the same topic resolution domain as the sender.
         <li>\"SOURCE:<i>source-string</i>\" - where <i>source-string</i> is the
             string associated with a source's transport session. This allows
             a subscriber to send a unicast immediate message directly to a
             publishing application.  See \ref sendingtosources for details.
         </ul>

         Note that immediate messages are processed somewhat less efficiently
         than source-based messages.

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param target Destination address string.
  @param topic Topic name to send message to or null for non-topic
  @param lbmreq LBMRequest object
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate request.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK

### send

```java
public void send(String topic, byte [] data, int dataLength, int flags) throws LBMException
```

  Send a multicast immediate message to a specific topic.
      <p>
\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param topic Topic name to send message to or null for non-topic
  @param data Data to send in this message
  @param dataLength Length (in bytes) of the data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate message.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#MSG_FLUSH

### sendc

```java
public void sendc(char [] topic, byte [] data, int dataLength, int flags) throws LBMException
```

  Send a multicast immediate message to a specific topic.
      <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param topic Topic name to send message to or null for non-topic
  @param data Data to send in this message
  @param dataLength Length (in bytes) of the data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate message.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#MSG_FLUSH

### sendTopicless

```java
public void sendTopicless(byte [] data, int dataLength, int flags) throws LBMException
```

  Send a topicless multicast immediate message.
      <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param data Data to send in this message
  @param dataLength Length (in bytes) of the data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate message.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#MSG_FLUSH

### send

```java
public LBMRequest send(String topic, byte [] data, int dataLength, LBMResponseCallback cb, Object cbArg, LBMEventQueue lbmevq, int flags) throws LBMException
```

  Send a multicast immediate request to a specific topic (specifying an
  Event Queue for processing of the response(s))

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param topic Topic name to send message to or null for non-topic
  @param data Data to send in this request
  @param dataLength Length (in bytes) of the data to send in this request
  @param cb LBMResponseCallback interface to handle response callback
  @param cbArg Callback token object
  @param lbmevq LBMEventQueue on which to process responses (may be
  null if not using an event queue)
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate request.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#MSG_FLUSH
  @return an LBMRequest object.

### send

```java
public LBMRequest send(String topic, byte [] data, int dataLength, LBMResponseCallback cb, Object cbArg, int flags) throws LBMException
```

  Send a multicast immediate request to a specific topic

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param topic Topic name to send message to or null for non-topic
  @param data Data to send in this request
  @param dataLength Length (in bytes) of the data to send in this request
  @param cb LBMResponseCallback interface to handle response callback
  @param cbArg Callback token object
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate request.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#MSG_FLUSH
  @return an LBMRequest object.

### send

```java
public void send(String topic, LBMRequest lbmreq, LBMEventQueue lbmevq, int flags) throws LBMException
```

  Send a multicast immediate request to a specific topic (specifying an
  Event Queue for processing of the response(s)).
      <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param topic Topic name to send message to or null for non-topic
  @param lbmreq LBMRequest object
  @param lbmevq LBMEventQueue on which to process responses (may be
  null if not using an event queue)
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate request.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#MSG_FLUSH

### send

```java
public void send(String topic, LBMRequest lbmreq, int flags) throws LBMException
```

  Send a multicast immediate request to a specific topic.
      <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param topic Topic name to send message to or null for non-topic
  @param lbmreq LBMRequest object
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the immediate request.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#MSG_FLUSH

### send

```java
public void send(String queue, String topic, byte[] data, int datalength, int flags, LBMSourceSendExInfo exinfo) throws LBMException
```

      Send an immediate message on a specific topic to a queue (UMQ only).
      <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

      @param queue Queue to submit message to
  @param topic Topic name to send message to or null for non-topic
      @param data Data to send in this message.
      @param datalength Length (in bytes) of the data to send in this message.
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
      @param exinfo LBMSourceSendExInfo object; used to set callback behavior flags
      and pass back a user-supplied object.
  @throws LBMException if any error occurs sending the immediate request.
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#MSG_FLUSH
      @see LBMSourceSendExInfo
      @since UME 3.0

### getStatistics

```java
public LBMContextStatistics getStatistics() throws LBMException
```

Return the current set of statistics for this context.
@return LBMContextStatistics object containing the statistics
corresponding to this context.
@throws LBMException if any error occurred retrieving context statistics.

### resetStatistics

```java
public void resetStatistics() throws LBMException
```

Reset the context statistics for this instance.
@throws LBMException if any error occurred during resetting of statistics.

### getSourceStatistics

```java
public LBMSourceStatistics getSourceStatistics(int maxStats) throws LBMException
```

Return the aggregate set of source transport statistics for this context.
@param maxStats Maximum number of sources.
@return LBMSourceStatistics object containing the statistics
corresponding to the specified number of sources.
@throws LBMException if any error occurred retrieving source transport statistics.

### resetSourceStatistics

```java
public void resetSourceStatistics() throws LBMException
```

Reset the transport statistics for all sources in this context.
@throws LBMException if any error occurred resetting source transport statistics.

### getReceiverStatistics

```java
public LBMReceiverStatistics getReceiverStatistics(int maxStats) throws LBMException
```

Return the aggregate set of receiver transport statistics for this context.
@param maxStats Maximum number of receivers.
@return LBMReceiverStatistics object containing the statistics
corresponding to the specified number of receivers.
@throws LBMException if any error occurred retrieving receiver transport statistics.

### resetReceiverStatistics

```java
public void resetReceiverStatistics() throws LBMException
```

Reset the transport statistics for all receivers in this context.
@throws LBMException if any error occurred resetting receiver transport statistics.

### getImmediateMessageSourceStatistics

```java
public LBMImmediateMessageSourceStatistics getImmediateMessageSourceStatistics(int maxStats) throws LBMException
```

Return the immediate message source transport statistics for this context.
@param maxStats Maximum number of sources.
@return LBMImmediateMessageSourceStatistics object containing the statistics
corresponding to this context.
@throws LBMException if any error occurred retrieving source transport statistics.

### resetImmediateMessageSourceStatistics

```java
public void resetImmediateMessageSourceStatistics() throws LBMException
```

Reset the immediate message source transport statistics for this context.
@throws LBMException if any error occurred resetting source transport statistics.

### getImmediateMessageReceiverStatistics

```java
public LBMImmediateMessageReceiverStatistics getImmediateMessageReceiverStatistics(int maxStats) throws LBMException
```

Return the immediate message receiver transport statistics for this context.
@param maxStats Maximum number of receivers.
@return LBMImmediateMessageReceiverStatistics object containing the statistics
corresponding to this context.
@throws LBMException if any error occurred retrieving receiver transport statistics.

### resetImmediateMessageReceiverStatistics

```java
public void resetImmediateMessageReceiverStatistics() throws LBMException
```

Reset the immediate message receiver transport statistics for this context.
@throws LBMException if any error occurred resetting receiver transport statistics.

### serializeLbmmonControlMessage

```java
public int serializeLbmmonControlMessage(ByteBuffer message, int command, String data, int nodeType, String applicationID) throws LBMException
```

Serialize the LBMMON control message
@param message Direct Byte Buffer to hold serialized message
@param command LBMMON control command
@param data LBMMON control data
@param nodeType LBMMON node type for control message
@param applicationID LBMMON Application ID for control message
@return int Size of serialized message
@throws LBMException if any error occurs serializing the message.

### createTimer

```java
public LBMTimer createTimer(long milliseconds) throws LBMException
```

Create an LBM Timer object
@param milliseconds Number of milliseconds until the timer expires
@return LBMTimer object
@throws LBMException if any error occurs creating the timer.

### createTimer

```java
public LBMTimer createTimer(long milliseconds, LBMEventQueue lbmevq) throws LBMException
```

Creates a timer associated with this context and a specified event queue
that expires with a specified delay.
@param milliseconds Number of milliseconds until the timer expires
@param lbmevq Event queue with with which to associate this timer
(the timer events will be posted to this event queue)
@return LBMTimer object
@throws LBMException if any error occurs creating the timer.

### createTimer

```java
public LBMTimer createTimer(long milliseconds, LBMTimerCallback cb, Object cbArg) throws LBMException
```

Creates a timer associated with this context that expires with
a specified delay.
@param milliseconds Number of milliseconds until the timer expires
@param cb An object implementing the LBMTimerCallback interface
@param cbArg Callback object passed as token to callback interface
@return LBMTimer object
@throws LBMException if any error occurs creating the timer.

### createTimer

```java
public LBMTimer createTimer(long milliseconds, LBMTimerCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Creates a timer associated with this context and a specified event queue
that expires with a specified delay.
@param milliseconds Number of milliseconds until the timer expires
@param lbmevq Event queue with which to associate this timer
@param cb An object implementing the LBMTimerCallback interface
@param cbArg Callback object passed as token to callback interface
(the timer events will be posted to this event queue)
@return LBMTimer object
@throws LBMException if any error occurs creating the timer.

### scheduleTimer

```java
public LBMTimer scheduleTimer(long milliseconds) throws LBMException
```

Creates a timer associated with this context that expires with the
specified delay, and maintains a reference to it within the context.
@param milliseconds Number of milliseconds until the timer expires
@return LBMTimer object
@throws LBMException if any error occurs creating the timer.

### scheduleTimer

```java
public LBMTimer scheduleTimer(long milliseconds, LBMEventQueue lbmevq) throws LBMException
```

Creates a timer associated with this context that expires with the
specified delay, associated with the specified event queue, and
maintains a reference to it within the context.
@param milliseconds Number of milliseconds until the timer expires
@param lbmevq Event queue with with which to associate this timer
(the timer events will be posted to this event queue)
@return LBMTimer object
@throws LBMException if any error occurs creating the timer.

### scheduleTimer

```java
public LBMTimer scheduleTimer(long milliseconds, LBMTimerCallback cb, Object cbArg) throws LBMException
```

Creates a timer associated with this context that expires with
a specified delay, and maintains a reference to it within the context.
@param milliseconds Number of milliseconds until the timer expires
@param cb An object implementing the LBMTimerCallback interface
@param cbArg Callback object passed as token to callback interface
@return LBMTimer object
@throws LBMException if any error occurs creating the timer.

### scheduleTimer

```java
public LBMTimer scheduleTimer(long milliseconds, LBMTimerCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Creates a timer associated with this context and a specified event queue
that expires with a specified delay, and maintains a reference to it
within the context.
@param milliseconds Number of milliseconds until the timer expires
@param lbmevq Event queue with which to associate this timer
@param cb An object implementing the LBMTimerCallback interface
@param cbArg Callback object passed as token to callback interface
(the timer events will be posted to this event queue)
@return LBMTimer object
@throws LBMException if any error occurs creating the timer.

### createSource

```java
public LBMSource createSource(LBMTopic lbmtopic) throws LBMException
```

Create an LBM Source object associated with this context
and a given topic.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param lbmtopic LBMTopic used to initialize the source.
@return LBMSource object
@throws LBMException if any error occurs creating the source.

### createSource

```java
public LBMSource createSource(LBMTopic lbmtopic, LBMSourceEventCallback cb, Object cbArg) throws LBMException
```

Create an LBM Source object associated with this context
and a given topic.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param lbmtopic LBMTopic used to initialize the source.
@param cb An object implementing the LBMSourceEventCallback interface
@param cbArg Callback token object
@return LBMSource object
@throws LBMException if any error occurs creating the source.

### createSource

```java
public LBMSource createSource(LBMTopic lbmtopic, LBMEventQueue lbmevq) throws LBMException
```

Create an LBM Source object associated with this context
and a given topic and event queue.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param lbmtopic LBMTopic used to initialize the source.
@param lbmevq Event queue with which to associate the source
(all source events will be posted to this event queue).
@return LBMSource object
@throws LBMException if any error occurs creating the source.

### createSource

```java
public LBMSource createSource(LBMTopic lbmtopic, LBMSourceEventCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Create an LBM Source object associated with this context
and a given topic and event queue.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param lbmtopic LBMTopic used to initialize the source.
@param cb An object implementing the LBMSourceEventCallback interface
@param cbArg Callback token object
@param lbmevq Event queue with which to associate the source
(all source events will be posted to this event queue).
@return LBMSource object
@throws LBMException if any error occurs creating the source.

### createHotFailoverSource

```java
public LBMHotFailoverSource createHotFailoverSource(LBMTopic lbmtopic) throws LBMException
```

Create an LBM Hot-Failover Source object associated with this context
and a given topic.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param lbmtopic LBMTopic used to initialize the source.
@return LBMHotFailoverSource object
@throws LBMException if any error occurs creating the hot failover source.

### createHotFailoverSource

```java
public LBMHotFailoverSource createHotFailoverSource(LBMTopic lbmtopic, LBMSourceEventCallback cb, Object cbArg) throws LBMException
```

Create an LBM Hot-Failover Source object associated with this context
and a given topic.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param lbmtopic LBMTopic used to initialize the source.
@param cb An object implementing the LBMSourceEventCallback interface
@param cbArg Callback token object
@return LBMHotFailoverSource object
@throws LBMException if any error occurs creating the hot failover source.

### createHotFailoverSource

```java
public LBMHotFailoverSource createHotFailoverSource(LBMTopic lbmtopic, LBMEventQueue lbmevq) throws LBMException
```

Create an LBM Hot-Failover Source object associated with this context
and a given topic and event queue.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param lbmtopic LBMTopic used to initialize the source.
@param lbmevq Event queue with which to associate the source
(all source events will be posted to this event queue).
@return LBMHotFailoverSource object
@throws LBMException if any error occurs creating the hot failover source.

### createHotFailoverSource

```java
public LBMHotFailoverSource createHotFailoverSource(LBMTopic lbmtopic, LBMSourceEventCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Create an LBM Hot-Failover Source object associated with this context
and a given topic and event queue.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param lbmtopic LBMTopic used to initialize the source.
@param cb An object implementing the LBMSourceEventCallback interface
@param cbArg Callback token object
@param lbmevq Event queue with which to associate the source
(all source events will be posted to this event queue).
@return LBMHotFailoverSource object
@throws LBMException if any error occurs creating the hot failover source.

### createReceiver

```java
public LBMReceiver createReceiver(LBMTopic lbmtopic) throws LBMException
```

Create an LBM Receiver object associated with this context
and a given topic.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@deprecated After LBM 4.0, use
    {@link #createReceiver(LBMTopic,LBMReceiverCallback,Object)}
@param lbmtopic LBMTopic used to initialize the receiver.
@return LBMReceiver object
@throws LBMException if any error occurs creating the receiver.

### createReceiver

```java
public LBMReceiver createReceiver(LBMTopic lbmtopic, LBMEventQueue lbmevq) throws LBMException
```

Create an LBM Receiver object associated with this context
and a given topic and event queue.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@deprecated After LBM 4.0, use
    {@link #createReceiver(LBMTopic,LBMReceiverCallback,Object,LBMEventQueue)}
@param lbmtopic LBMTopic used to initialize the receiver.
@param lbmevq Event queue with which to associate the receiver
(all receiver events will be posted to this event queue).
@return LBMReceiver object
@throws LBMException if any error occurs creating the receiver.

### createReceiver

```java
public LBMReceiver createReceiver(LBMTopic lbmtopic, LBMReceiverCallback cb, Object cbArg) throws LBMException
```

Create an LBM Receiver object associated with this context
and a given topic.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param lbmtopic LBMTopic used to initialize the receiver.
@param cb An object implementing the LBMReceiverCallback interface
@param cbArg Callback object passed as token to callback interface
@return LBMReceiver object
@throws LBMException if any error occurs creating the receiver.

### createReceiver

```java
public LBMReceiver createReceiver(LBMTopic lbmtopic, LBMReceiverCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Create an LBM Receiver object associated with this context
and a given topic and event queue.
@param lbmtopic LBMTopic used to initialize the receiver.
@param cb An object implementing the LBMReceiverCallback interface
@param cbArg Callback object passed as token to callback interface
@param lbmevq Event queue with which to associate the receiver
(all receiver events will be posted to this event queue).
@return LBMReceiver object
@throws LBMException if any error occurs creating the receiver.

### createHotFailoverReceiver

```java
public LBMHotFailoverReceiver createHotFailoverReceiver(LBMTopic lbmtopic) throws LBMException
```

Create an LBM Hot-Failover Receiver object associated with this context
and a given topic.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@deprecated After LBM 4.0, use
    {@link #createHotFailoverReceiver(LBMTopic,LBMReceiverCallback,Object)}
@param lbmtopic LBMTopic used to initialize the receiver.
@return LBMHotFailoverReceiver object
@throws LBMException if any error occurs creating the hot failover receiver.

### createHotFailoverReceiver

```java
public LBMHotFailoverReceiver createHotFailoverReceiver(LBMTopic lbmtopic, LBMEventQueue lbmevq) throws LBMException
```

Create an LBM Hot-Failover Receiver object associated with this context
and a given topic and event queue.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@deprecated After LBM 4.0, use
    {@link #createHotFailoverReceiver(LBMTopic,LBMReceiverCallback,Object,LBMEventQueue)}
@param lbmtopic LBMTopic used to initialize the receiver.
@param lbmevq Event queue with which to associate the receiver
(all receiver events will be posted to this event queue).
@return LBMHotFailoverReceiver object
@throws LBMException if any error occurs creating the hot failover receiver.

### createHotFailoverReceiver

```java
public LBMHotFailoverReceiver createHotFailoverReceiver(LBMTopic lbmtopic, LBMReceiverCallback cb, Object cbArg) throws LBMException
```

Create an LBM Hot-Failover Receiver object associated with this context
and a given topic.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param lbmtopic LBMTopic used to initialize the receiver.
@param cb An object implementing the LBMReceiverCallback interface
@param cbArg Callback object passed as token to callback interface
@return LBMHotFailoverReceiver object
@throws LBMException if any error occurs creating the hot failover receiver.

### createHotFailoverReceiver

```java
public LBMHotFailoverReceiver createHotFailoverReceiver(LBMTopic lbmtopic, LBMReceiverCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Create an LBM Hot-Failover Receiver object associated with this context
and a given topic and event queue.
    <p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param lbmtopic LBMTopic used to initialize the receiver.
@param cb An object implementing the LBMReceiverCallback interface
@param cbArg Callback object passed as token to callback interface
@param lbmevq Event queue with which to associate the receiver
(all receiver events will be posted to this event queue).
@return LBMHotFailoverReceiver object
@throws LBMException if any error occurs creating the hot failover receiver.

### addSourceNotifyCallback

```java
public void addSourceNotifyCallback(LBMSourceNotification cb) throws LBMException
```

Register a callback interface (and a callback handle argument) to be
called when a new source is seen for any topic. This callback is
called directly in line and does not use the event queue; therefore,
the callback function used should not block or it will block the
context thread processing.  This facility is disabled by default
and may be enabled by calling the
{@link LBMContextAttributes#enableSourceNotification} method prior to
instantiation of LBMContext.
@param cb An object implementing the LBMSourceNotification interface
@throws LBMException if any error occurs.
@see LBMSourceNotification
@see LBMContextAttributes#enableSourceNotification
@see #removeSourceNotifyCallback

### addSourceNotifyCallback

```java
public void addSourceNotifyCallback(LBMSourceNotification cb, Object cbArg) throws LBMException
```

Register a callback interface (and a callback handle argument) to be
called when a new source is seen for any topic. This callback is
called directly in line and does not use the event queue; therefore,
the callback function used should not block or it will block the
context thread processing.  This facility is disabled by default
and may be enabled by calling the
{@link LBMContextAttributes#enableSourceNotification} method prior to
instantiation of LBMContext.
@param cb An object implementing the LBMSourceNotification interface
@param cbArg Callback object passed as a token to the callback interface
@throws LBMException if any error occurs.
@see LBMSourceNotification
@see #removeSourceNotifyCallback

### removeSourceNotifyCallback

```java
public void removeSourceNotifyCallback(LBMSourceNotification cb)
```

Deregister a source notification callback
@param cb Previously registered object implementing the
LBMSourceNotification interface
@see LBMSourceNotification
@see #addSourceNotifyCallback

### removeSourceNotifyCallback

```java
public void removeSourceNotifyCallback(LBMSourceNotification cb, Object cbArg)
```

Deregister a source notification callback
@param cb Previously registered object implementing the
LBMSourceNotification interface
@param cbArg Callback token for previously registered object
@see LBMSourceNotification
@see #addSourceNotifyCallback

### getUMQInflight

```java
public int getUMQInflight(String queue) throws LBMException
```

Get the current UMQ inflight value for this context
@param queue Name of the queue
@return the inflight value
@throws LBMException if an error occurs while retrieving the inflight value

### setUMQInflight

```java
public int setUMQInflight(String queue, LBMSetInflightCallback setInflightCb, Object clientd) throws LBMException
```

Set the current UMQ inflight value for this context.
@deprecated
@param queue Name of the queue
@param setInflightCb Object that implements the LBMSetInflightCallback interface
@param clientd Clientd object passed into the setInflight callback
@return the new inflight value
@throws LBMException if an error occurs while setting the inflight value

### setUMQMessageStable

```java
public void setUMQMessageStable(String queue, UMQMessageId msg_id) throws LBMException
```

Mark a specific msg_id as stable, triggering an event if configured to do so, and adjusting the inflight if necessary.
@deprecated
@param queue Name of the queue
@param msg_id MessageId of the message to mark stable
@throws LBMException if an error occurs while marking the message stable

### requestTopicResolution

```java
public void requestTopicResolution(short flags, long interval_msec, long duration_sec) throws LBMException
```

Request Topic Advertisements (sources), Topic Queries (receivers),
and/or Wildcard Topic Queries (wildcard receivers) in the configured topic
resolution address domain.
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
@param flags Flags indicating desired requests.  ORed set of values.
    @see LBM#TOPIC_RES_REQUEST_ADVERTISEMENT - Request advertisements from quiescent sources.
    @see LBM#TOPIC_RES_REQUEST_QUERY - Request queries from quiescent receivers.
    @see LBM#TOPIC_RES_REQUEST_WILDCARD_QUERY - Request queries from quiescent wildcard receivers.
    @see LBM#TOPIC_RES_REQUEST_CONTEXT_ADVERTISEMENT - Request context advertisements from quiescent contexts.
    @see LBM#TOPIC_RES_REQUEST_CONTEXT_QUERY - Request context queries from quiescent contexts.
@param interval_msec Interval between requests in milliseconds.  Less than 10 should be used with caution.  Less than 5 is not recommended.
@param duration_sec Minimum duration of requests in seconds.  Actual duration can be longer depending on the interval.  A value of zero will result in 1 request and the interval will be meaningless.

### queueTopicList

```java
public void queueTopicList(String queue, LBMAsyncOperationCallback asyncOpCb) throws LBMException
```

Retrieves a list of currently available topics from a queue (asynchronous operation).
@deprecated
@param queue Name of the queue to retrieve topic list from.
@param asyncOpCb Object implementing the LBMAsyncOperationCallback interface that will receive updates and results for the asynchronous operation.
@throws LBMException if queue or asyncObCb parameters are invalid, or if an error occurs.

### queueTopicList

```java
public void queueTopicList(String queue, LBMAsyncOperationCallback asyncOpCb, Object cbArg) throws LBMException
```

Retrieves a list of currently available topics from a queue (asynchronous operation).
@deprecated
@param queue Name of the queue to retrieve topic list from.
@param asyncOpCb Object implementing the LBMAsyncOperationCallback interface that will receive updates and results for the asynchronous operation.
@param cbArg User-supplied callback object which will be passed back when asyncOpCb's onAsyncOperation method is called.
@throws LBMException if queue or asyncObCb parameters are invalid, or if an error occurs.

### respond

```java
public void respond(LBMSerializedResponse serializedResponse, byte[] data, int dataLength, int flags) throws LBMException
```

Send a response message using the serialized response that was pulled from a separate message.
<p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param serializedResponse The serialized response object that should already have been populated by calling the LBMMessage getSerializedResponse method
@param data Data to send in this response
@param dataLength Number of bytes of data to send in this response
@param flags Flags indicating various conditions.
See next section for possible OR'd set of values.
@throws LBMException if any error occurs sending the response.
@see LBM#SRC_NONBLOCK
@see LBM#SRC_BLOCK
@see LBMMessage#getSerializedResponse

### setNakCutoff

```java
public void setNakCutoff(int flag) throws LBMException
```

A special mode which suppresses subscriptions from sending NAKs for the LBT-RM protocol.
@param flag A flag indicating either disabling or enabling nak cutoff (Do not supply both).
@see LBM#LBM_NAK_CUTOFF_FLAG_DISABLE_NAKS
@see LBM#LBM_NAK_CUTOFF_FLAG_ENABLE_NAKS

## LBMContextAttributes

*class* `com.latencybusters.lbm.LBMContextAttributes`

### LBMContextAttributes

```java
public LBMContextAttributes(String contextName) throws LBMException
```

Create and fill an LBMContextAttributes object with the current default values for the given context name.
@param contextName Context name string. Is written into the attributes object.
@throws LBMException if the contextName is not permitted by the configuration or other operational failure.

### LBMContextAttributes

```java
public LBMContextAttributes() throws LBMException
```

Create and fill an LBMContextAttributes object with the current default values
@throws LBMException

### setFromXml

```java
public void setFromXml(String contextName) throws LBMException
```

Fill an LBMContextAttributes object with the default values for the given context name specified by the XML configuration.
@param contextName Context name string. Is written into the attributes object.
@throws LBMException if the contextName is not permitted by the configuration or other operational failure.

### dispose

```java
public void dispose()
```

Free memory associated with this set of attributes.

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions.
@return Array of LBMConfigOption

### getValue

```java
public String getValue(String attributeName) throws LBMException
```

Returns the current value of an attribute from this set of
context attributes.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setValue

```java
public void setValue(String attributeName, String attributeValue) throws LBMException
```

FOR INTERNAL INFORMATICA USE ONLY - NOT FOR DIRECT APPLICATION USEAGE.
Applications should use setProperty() instead.
Set the current value of an attribute in this set of
context attributes.  Note that this method bypasses the property list.
As such no attributes configured using this method will appear in
the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.
@see #setProperty

### setProperty

```java
public Object setProperty(String attributeName, String attributeValue)
```

Set the current value of an attribute in this set of context attributes.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMRuntimeException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### load

```java
public void load(InputStream inStream) throws IOException
```

Reads a property (attribute) list (key and element pairs) from the
input stream.
@param inStream Input stream of bytes
@throws IOException if any I/O error occurs.
@throws LBMRuntimeException if any invalid attribute is detected in <code>inStream</code>.

### setObjectRecycler

```java
public void setObjectRecycler(LBMObjectRecyclerBase objRec, Object objRecCbArg)
```

Set the LBM object recycler that can be used by the context to reuse LBMMessage objects as
well as LBM Context/Receiver/Source Statistics objects.
@param objRec an LBM object recycler that will be called when objects need to be retrieved
@param objRecCbArg a callback object token that will be passed in the retrieve method

### setSourceNotification

```java
public void setSourceNotification(LBMSourceNotification cb, Object cbarg)
```

Set the callback and token to be used for source notifications.

### clearSourceNotification

```java
public void clearSourceNotification()
```

Clear the currently stored source notification callback and token

### enableSourceNotification

```java
public void enableSourceNotification()
```

Enable new source notifications.
New source notifications are delivered via the source notification
callback set by {@link LBMContext#addSourceNotifyCallback}.
@see LBMContext#addSourceNotifyCallback
@see #disableSourceNotification

### disableSourceNotification

```java
public void disableSourceNotification()
```

Disable new source notifications.

### setContextSourceEventCallback

```java
public void setContextSourceEventCallback( LBMContextSourceEventCallback cb)
```

Set the context-level source event callback for an LBMContext.
@param cb An object implementing the LBMContextSourceEventCallback interface.

### setContextSourceEventCallback

```java
public void setContextSourceEventCallback(LBMContextSourceEventCallback cb, Object cbArg)
```

Set the context-level source event callback for an LBMContext and associated callback object.
@param cb An object implementing the LBMContextSourceEventCallback interface.
@param cbArg A user-supplied callback object to be passed back in context source event callbacks.

### setContextSourceEventCallback

```java
public void setContextSourceEventCallback(LBMContextSourceEventCallback cb, LBMEventQueue evq)
```

Set the context-level source event callback for an LBMContext and associated callback object.
@param cb An object implementing the LBMContextSourceEventCallback interface.
@param evq An LBMEventQueue on which to place context source events.

### setContextSourceEventCallback

```java
public void setContextSourceEventCallback(LBMContextSourceEventCallback cb, Object cbArg, LBMEventQueue evq)
```

Set the context-level source event callback for an LBMContext and associated callback object.
@param cb An object implementing the LBMContextSourceEventCallback interface.
@param cbArg A user-supplied callback object to be passed back in context source event callbacks.
@param evq An LBMEventQueue on which to place context source events.

### setContextEventCallback

```java
public void setContextEventCallback( LBMContextEventCallback cb)
```

Set the context event callback for an LBMContext.
@param cb An object implementing the LBMContextEventCallback interface.

### setContextEventCallback

```java
public void setContextEventCallback(LBMContextEventCallback cb, Object cbArg)
```

Set the context event callback for an LBMContext and associated callback object.
@param cb An object implementing the LBMContextEventCallback interface.
@param cbArg A user-supplied callback object to be passed back in context event callbacks.

### setContextEventCallback

```java
public void setContextEventCallback(LBMContextEventCallback cb, LBMEventQueue evq)
```

Set the context event callback for an LBMContext and associated callback object.
@param cb An object implementing the LBMContextEventCallback interface.
@param evq An LBMEventQueue on which to place context events.

### setContextEventCallback

```java
public void setContextEventCallback(LBMContextEventCallback cb, Object cbArg, LBMEventQueue evq)
```

Set the context event callback for an LBMContext and associated callback object.
@param cb An object implementing the LBMContextEventCallback interface.
@param cbArg A user-supplied callback object to be passed back in context event callbacks.
@param evq An LBMEventQueue on which to place context events.

### setImmediateMessageCallback

```java
public void setImmediateMessageCallback(LBMImmediateMessageCallback cb)
```

Set (and enable) the context callback for topic-less immediate mode messages.
@param cb An object implementing the LBMImmediateMessageCallback interface.

### setImmediateMessageCallback

```java
public void setImmediateMessageCallback(LBMImmediateMessageCallback cb, LBMEventQueue evq)
```

Set (and enable) the context callback for topic-less immediate mode messages.
@param cb An object implementing the LBMImmediateMessageCallback interface.
@param evq LBMEventQueue on which to place received topic-less immediate-mode messages (can be null).

### setImmediateMessageCallback

```java
public void setImmediateMessageCallback(LBMImmediateMessageCallback cb, Object cbArg)
```

Set (and enable) the context callback for topic-less immediate mode messages.
@param cb An object implementing the LBMImmediateMessageCallback interface.
@param cbArg A user-supplied callback object to be passed back in to the immediate message receiver callback.

### setImmediateMessageCallback

```java
public void setImmediateMessageCallback(LBMImmediateMessageCallback cb, Object cbArg, LBMEventQueue evq)
```

Set (and enable) the context callback for topic-less immediate mode messages.
@param cb An object implementing the LBMImmediateMessageCallback interface.
@param cbArg A user-supplied callback object to be passed back in to the immediate message receiver callback.
@param evq LBMEventQueue on which to place received topic-less immediate-mode messages (can be null).

### setSourceCostCallback

```java
public void setSourceCostCallback(LBMSourceCostCallback cb)
```

Set the source cost callback function for an LBMContext,
which is an application callback to evaluate the cost of a newly discovered source
@param cb LBMSourceCostCallback callback implementation

### setSourceCostCallback

```java
public void setSourceCostCallback(LBMSourceCostCallback cb, Object cbArg)
```

Set the source cost callback function for an LBMContext,
which is an application callback to evaluate the cost of a newly discovered source
@param cb LBMSourceCostCallback callback implementation
@param cbArg Callback object token

### setTransportMappingCallback

```java
public void setTransportMappingCallback(LBMTransportMappingCallback cb)
```

Set the transport mapping callback function for an LBMContext,
which is an application callback to provide the user an opportunity to map a new
transport session to an XSP
@param cb LBMTransportMappingCallback callback implementation

### setTransportMappingCallback

```java
public void setTransportMappingCallback(LBMTransportMappingCallback cb, Object cbArg)
```

Set the transport mapping callback function for an LBMContext,
which is an application callback to provide the user an opportunity to map a new
transport session to an XSP
@param cb LBMTransportMappingCallback callback implementation
@param cbArg Callback object token

### setReceiverLivenessNotificationCallbacks

```java
public void setReceiverLivenessNotificationCallbacks(UMEReceiverLivenessCreationCallback creationCb, UMEReceiverLivenessDeletionCallback deletionCb, Object cbArg) throws LBMException
```

Register callbacks for new receiver liveness notifications and receiver deletion notifications.

## LBMContextEvent

*class* `com.latencybusters.lbm.LBMContextEvent`

### type

```java
public int type()
```

LBM Context Event Type
@return LBM Context Event type
@see LBM
@since UME 3.0

### dataString

```java
public String dataString()
```

Data string associated with this event.
This event may not be valid for all event types.
@return Data string
@see LBM
@since UME 3.0

### registrationSuccessInfo

```java
public UMQContextEventRegistrationSuccessInfo registrationSuccessInfo()
```

Registration success info object associated with this event.
This event may not be valid for all event types.
@return UMQContextEventRegistrationSuccessInfo object
@see LBM
@since UME 3.0

### registrationCompleteInfo

```java
public UMQContextEventRegistrationCompleteInfo registrationCompleteInfo()
```

Registration complete info object associated with this event.
This event may not be valid for all event types.
@return UMQContextEventRegistrationCompleteInfo object
@see LBM
@since UME 3.0

## LBMContextEventCallback

*interface* `com.latencybusters.lbm.LBMContextEventCallback`

### onContextEvent

```java
int onContextEvent(Object cbArg, LBMContextEvent contextEvent)
```

Context event callback.
@param cbArg Callback object token
@param contextEvent LBMContextEvent object encapsulating event
@return an int, which should always be 0.
information.

## LBMContextSourceEventCallback

*interface* `com.latencybusters.lbm.LBMContextSourceEventCallback`

### onContextSourceEvent

```java
int onContextSourceEvent(Object cbArg, LBMContextSourceEvent sourceEvent)
```

Source event callback.
@param cbArg Callback object token
@param sourceEvent LBMContextSourceEvent object encapsulating source event
@return an int, which should always be 0.
information.

## LBMContextStatistics

*class* `com.latencybusters.lbm.LBMContextStatistics`

### LBMContextStatistics

```java
public LBMContextStatistics()
```

Instantiate an empty object containing no statistics.

### LBMContextStatistics

```java
public LBMContextStatistics(UMMonAttributes attributes, Context ctxStats) throws LBMException
```

Instantiate an object containing the context statistics from a Protobuf message.
     @param attributes An UMMonAttributesProtos.UMMonAttributes
     @param ctxStats An UMSMonProtos.Stats.Context
@throws LBMException if any error occurred retrieving context statistics.

### LBMContextStatistics

```java
public LBMContextStatistics(LBMMonitorReceiver lbmmonrcv, ByteBuffer attributeBuffer, ByteBuffer ctxStats) throws LBMException
```

Instantiate an object containing the context statistics from a passthrough CSV message.
@param lbmmonrcv  LBMMonitorReceiver that received this packet.
@param attributeBuffer A ByteBuffer of packet attributes passed to the passthrough callback
@param ctxStats   A ByteBuffer of CSV statistics passed to the passthrough callback
@throws LBMException if any error occurred retrieving context statistics.

### LBMContextStatistics

```java
public LBMContextStatistics(LBMContext ctx) throws LBMException
```

Instantiate an object containing the current set of
context statistics for a given UM Context.
@param ctx LBMContext object
@throws LBMException if any error occurred retrieving context statistics.
@see #refresh

### refresh

```java
public void refresh(LBMContext ctx) throws LBMException
```

Refresh lbm context statistics for a given LBMContext
@param ctx LBMContext object
@throws LBMException if any error occurred retrieving context statistics.

### dispose

```java
public void dispose()
```

Free memory associated with this set of statistics

### topicResolutionDatagramsSent

```java
public long topicResolutionDatagramsSent() throws LBMException
```

Number of topic resolution datagrams sent from this context. Each datagram can
contain one or more advertisements, queries, query responses, etc. from source or
receiver objects. A faster accumulation of counts typically indicates more source,
receiver, and/or context objects are being created.
@return Number of topic resolution datagrams sent
@throws LBMException if any error occurred retrieving topic resolution datagrams sent
@see #LBMContextStatistics(LBMContext)
@see LBM

### topicResolutionDatagramsReceived

```java
public long topicResolutionDatagramsReceived() throws LBMException
```

Number of topic resolution datagrams received by this context. Each datagram can
contain one or more advertisements, queries, query responses, etc. from source or
receiver objects. A faster accumulation of counts typically indicates more source,
receiver, and/or context objects are being created.
@return Number of topic resolution datagrams received by this context
@throws LBMException if any error occurred retrieving topic resolution datagrams received
@see #LBMContextStatistics(LBMContext)
@see LBM

### topicResolutionBytesSent

```java
public long topicResolutionBytesSent() throws LBMException
```

Number of topic resolution datagram bytes
sent. This count is triggered under the same circumstances as datagrams sent (above),
but measures the total number of byte for all datagrams sent, including their
headers.
@return Number of topic resolution datagram bytes sent
@throws LBMException if any error occurred retrieving bytes sent of topic resolution.
@see #LBMContextStatistics(LBMContext)
@see LBM

### topicResolutionBytesReceived

```java
public long topicResolutionBytesReceived() throws LBMException
```

Number of topic resolution datagram bytes received. This count is triggered under the
same circumstances as datagrams received (above), but measures the total number of
bytes for all datagrams received, including their headers.
@return Number of topic resolution datagram bytes received
@throws LBMException if any error occurred retrieving bytes received of topic resolution.
@see #LBMContextStatistics(LBMContext)
@see LBM

### topicResolutionDatagramsDroppedVersion

```java
public long topicResolutionDatagramsDroppedVersion() throws LBMException
```

Number of topic resolution datagrams discarded due to incorrect version. The
datagram's version field must match the expectations of the receiving context.
@return Number of topic resolution datagrams discarded due to incorrect version
@throws LBMException if any error occurred retrieving topic resolution datagrams
discarded due to incorrect version.
@see #LBMContextStatistics(LBMContext)
@see LBM

### topicResolutionDatagramsDroppedType

```java
public long topicResolutionDatagramsDroppedType() throws LBMException
```

Number of topic resolution datagrams discarded due to incorrect type. The datagram's
type field must match the expectations of the receiving context. A mismatch in
encryption (TLS) or compression will also be treated as a mismatch of type.
@return Number of topic resolution datagrams discarded due to incorrect type
@throws LBMException if any error occurred retrieving topic resolution datagrams
discarded due to incorrect type
@see #LBMContextStatistics(LBMContext)
@see LBM

### topicResolutionDatagramsDroppedMalformed

```java
public long topicResolutionDatagramsDroppedMalformed() throws LBMException
```

Number of topic resolution datagrams discarded due to being malformed or corrupted.
@return Number of topic resolution datagrams discarded due to being malformed
@throws LBMException if any error occurred retrieving topic resolution datagrams
discarded due to a malformed header
@see #LBMContextStatistics(LBMContext)
@see LBM

### topicResolutionDatagramsSendFailed

```java
public long topicResolutionDatagramsSendFailed() throws LBMException
```

Number of topic resolution datagram sends that failed. This count should be at or at
least near 0.
@return Number of topic resolution datagram sends that failed
@throws LBMException if any error occurred retrieving topic resolution datagram
send failures.
@see #LBMContextStatistics(LBMContext)
@see LBM

### topicResolutionSourceTopics

```java
public long topicResolutionSourceTopics() throws LBMException
```

Number of topics in the source topic resolver cache (also known as the topic map).
Inordinately large or growing values here may impact performance.
@return Number of topics in the source topic map
@throws LBMException if any error occurred retrieving the number of topics
in the source topic map.
@see #LBMContextStatistics(LBMContext)
@see LBM

### topicResolutionReceiverTopics

```java
public long topicResolutionReceiverTopics() throws LBMException
```

Number of topics in the receiver topic resolver cache (also referred to as the topic
map). Inordinately large or growing values here may impact performance.
@return Number of topics in the receiver topic map
@throws LBMException if any error occurred retrieving the number of topics
in the receiver topic map.
@see #LBMContextStatistics(LBMContext)
@see LBM

### topicResolutionUnresolvedReceiverTopics

```java
public long topicResolutionUnresolvedReceiverTopics() throws LBMException
```

Number of unresolved topics in the receiver topic resolver cache (also referred to as
the topic map). Inordinately large or growing values here may impact performance.
@return Number of unresolved topics is the receiver topic map
@throws LBMException if any error occurred retrieving the number of
unresolved topics in the receiver topic map.
@see #LBMContextStatistics(LBMContext)
@see LBM

### lbtrmUnknownMessagesReceived

```java
public long lbtrmUnknownMessagesReceived() throws LBMException
```

Number of LBT-RM datagrams received not belonging to any transport session. Such
occurrences should be investigated. These datagrams can be from a source in a
different topic resolution domain targeting the same group (or IP) and port as a
source of interest on this receiver's topic resolution domain. Among less likely
possibilities would be an attempt to spoof UM messages.
@return Number of LBT-RM datagrams received not belonging to any transport session
@throws LBMException if any error occurred retrieving the number of LBT-RM
datagrams received not belonging to any transport session
@see #LBMContextStatistics(LBMContext)
@see LBM

### lbtruUnknownMessagesReceived

```java
public long lbtruUnknownMessagesReceived() throws LBMException
```

Number of LBT-RU datagrams received not belonging to any transport session. Such
occurrences should be investigated. These datagrams can be from a source in a
different topic resolution domain targeting the same group (or IP) and port as a
source of interest on this receiver's topic resolution domain. Among less likely
possibilities would be an attempt to spoof UM messages.
@return Number of LBT-RU datagrams received not belonging to any transport session
@throws LBMException if any error occurred retrieving the number of LBT-RU
datagrams received not belonging to any transport session
@see #LBMContextStatistics(LBMContext)
@see LBM

### sendBlocked

```java
public long sendBlocked() throws LBMException
```

Number of incidents where a UM send call was blocked. Unusually high counts could
indicate performance degradation or I/O problems.
@return Number of incidents where a UM send call was blocked
@throws LBMException if any error occurred retrieving the number of UM send
calls which blocked.
@see #LBMContextStatistics(LBMContext)
@see LBM

### sendWouldBlock

```java
public long sendWouldBlock() throws LBMException
```

Number of incidents where a UM send call returned EWOULDBLOCK. This is when a send
call set to be nonblocking encounters an error condition where it would otherwise be
blocked. Under normal operating conditions, this count should be at or near 0.
@return Number of incidents where a UM send call returned EWOULDBLOCK
@throws LBMException if any error occurred retrieving the number of UM send
calls which returned EWOULDBLOCK
@see #LBMContextStatistics(LBMContext)
@see LBM

### responseBlocked

```java
public long responseBlocked() throws LBMException
```

Number of incidents where a UM send response call was blocked. Unusually high counts
could indicate performance degradation or I/O problems.
@return Number of incidents where a UM send response call was blocked
@throws LBMException if any error occurred retrieving the number of UM send
response calls which blocked
@see #LBMContextStatistics(LBMContext)
@see LBM

### responseWouldBlock

```java
public long responseWouldBlock() throws LBMException
```

Number of incidents where a UM send response call returned EWOULDBLOCK. This is when
a send response call set to be nonblocking encounters an error condition where it
would otherwise be blocked. Under normal operating conditions, this count should be
at or near 0.
@return Number of incidents where a UM send response call returned EWOULDBLOCK
@throws LBMException if any error occurred retrieving the number of UM send
response calls which returned EWOULDBLOCK
@see #LBMContextStatistics(LBMContext)
@see LBM

### unicastImmediateMessageDuplicatesReceived

```java
public long unicastImmediateMessageDuplicatesReceived() throws LBMException
```

Number of duplicate unicast immediate messages (UIMs) received and dropped.
@return Number of duplicate unicast immediate messages (UIMs) received and dropped.
@throws LBMException
@see #LBMContextStatistics(LBMContext)
@see LBM

### unicastImmediateMessageNoStreamReceived

```java
public long unicastImmediateMessageNoStreamReceived() throws LBMException
```

Number of unicast immediate messages (UIMs) received without stream information.
@return Number of unicast immediate messages (UIMs) received without stream information.
@throws LBMException
@see #LBMContextStatistics(LBMContext)
@see LBM

### fragmentsLost

```java
public long fragmentsLost() throws LBMException
```

Number of fragments that have possibly been lost. This stat is
incremented when a gap is detected by a receiver delivery controller. A
delivery controller is created for every topic that has an interested
receiver. This stat is not updated for gaps detected in responses, MIM
transports, or UIMs. This stat will not be updated for hot-failover
receivers with arrival-order delivery (i.e. option ordered_delivery
set to 0). SMX receivers are excluded from this stat.
@return Number of fragments that have possibly been lost.
@throws LBMException
@see #LBMContextStatistics(LBMContext)
@see LBM

### fragmentsUnrecoverablyLost

```java
public long fragmentsUnrecoverablyLost() throws LBMException
```

Number of fragments that have been declared as unrecoverably
lost. This stat is incremented when LBM_MSG_UNRECOVERABLE_LOSS or
LBM_MSG_UNRECOVERABLE_LOSS_BURST is delivered to an UM receiver
callback. In the case of burst loss, the stat is incremented
by the number of fragments lost in the burst event. This
stat will not be updated for hot-failover receivers with
arrival-order delivery (i.e. option ordered_delivery set to 0). For
hot-failover receivers, this stat may be updated while no actual
LBM_MSG_UNRECOVERABLE_LOSS/LOSS_BURST messages are delivered to
the application. In that case, one of the receivers underlying the
hot-failover receivers had experienced unrecoverable loss, but the
other underlying receiver was able to compensate. SMX receivers are
excluded from this stat.
@return Number of fragments that have been declared as unrecoverably lost.
@throws LBMException
@see #LBMContextStatistics(LBMContext)
@see LBM

### receiveCallbackServiceTimeMin

```java
public long receiveCallbackServiceTimeMin() throws LBMException
```

Minimum time (in milliseconds) spent in message delivery callbacks
associated with LBM receivers, wildcard receivers, hot-failover
receivers. For the Java and .NET APIs, the overhead time spent in
crossing the managed/jni boundaries is included. This stat is only
collected if the context option receiver_callback_service_time_enabled
is set to 1. SMX receivers are excluded from these stats.

This field is initialized to all 1s (-1 if printed signed).
@return Minimum time (in milliseconds) spent in message delivery callbacks.
@throws LBMException
@see #LBMContextStatistics(LBMContext)
@see LBM

### receiveCallbackServiceTimeMax

```java
public long receiveCallbackServiceTimeMax() throws LBMException
```

Maximum time (in milliseconds) spent in message delivery callbacks
associated with LBM receivers, wildcard receivers, hot-failover
receivers. For the Java and .NET APIs, the overhead time spent in
crossing the managed/jni boundaries is included. This stat is only
collected if the context option receiver_callback_service_time_enabled
is set to 1. SMX receivers are excluded from these stats.
@return Maximum time (in milliseconds) spent in message delivery callbacks.
@throws LBMException
@see #LBMContextStatistics(LBMContext)
@see LBM

### receiveCallbackServiceTimeMean

```java
public long receiveCallbackServiceTimeMean() throws LBMException
```

Mean time (in milliseconds) spent in message delivery callbacks
associated with LBM receivers, wildcard receivers, hot-failover
receivers. This is an exponentially weighted moving average (weighted
to more recent). For the Java and .NET APIs, the overhead time spent
in crossing the managed/jni boundaries is included. This stat is only
collected if the context option receiver_callback_service_time_enabled
is set to 1. SMX receivers are excluded from these stats.
@return Mean time (in milliseconds) spent in message delivery callbacks.
@throws LBMException
@see #LBMContextStatistics(LBMContext)
@see LBM

## LBMContextThread

*class* `com.latencybusters.lbm.LBMContextThread`

### LBMContextThread

```java
public LBMContextThread(LBMContext ctx)
```

Instantiate an LBM Context Thread object.
@param ctx LBMContext to run on this thread.
The thread will run for 1000ms at a time.

### LBMContextThread

```java
public LBMContextThread(LBMContext ctx, long msec)
```

Instantiate an LBM Context Thread object.
@param ctx LBMContext to run on this thread.
@param msec Milliseconds at a time to run the thread.

### terminate

```java
public void terminate()
```

Stop the context thread.

## LBMEventQueue

*class* `com.latencybusters.lbm.LBMEventQueue`

### LBMEventQueue

```java
public LBMEventQueue() throws LBMException
```

Instantiate an LBM Event Queue object using default attributes.
See \ref eventqueueobject for a full description of Event Queues.
@throws LBMException if there was an error creating the event queue.

### LBMEventQueue

```java
public LBMEventQueue(LBMEventQueueAttributes lbmevqattr) throws LBMException
```

Instantiate an LBM Event Queue object using the given attributes.
See \ref eventqueueobject for a full description of Event Queues.
@param lbmevqattr LBMEventQueueAttributes used to initialize the event queue.
@throws LBMException if any error occurs creating the event queue.

### LBMEventQueue

```java
public LBMEventQueue(LBMEventQueueCallback cb, Object cbArg) throws LBMException
```

Instantiate an LBM Event Queue object using default attributes.
See \ref eventqueueobject for a full description of Event Queues.
@param cb An object implementing the LBMEventQueueCallback interface
@param cbArg Callback object passed as token to callback interface
@throws LBMException if any error occurs creating the event queue.

### LBMEventQueue

```java
public LBMEventQueue(LBMEventQueueAttributes lbmevqattr, LBMEventQueueCallback cb, Object cbArg) throws LBMException
```

Instantiate an LBM Event Queue object using the given attributes.
See \ref eventqueueobject for a full description of Event Queues.
@param lbmevqattr LBMEventQueueAttributes used to initialize the event queue.
@param cb An object implementing the LBMEventQueueCallback interface
@param cbArg Callback object passed as token to callback interface
@throws LBMException if any error occurs creating the event queue.

### close

```java
public void close()
```

Close this event queue.
Since this method deletes the underlying LBM event queue object, it
should not be called prior to closing or canceling of its dependent
objects (e.g., LBMSource, LBMReceiver, LBMRequest, LBMTimer).

### queueSize

```java
public int queueSize() throws LBMException
```

Determine the number of queued events in the event queue.
This method is only supported when the queue_size_warning config
variable is set.  If not set, then this function will throw
an exception with an error number == LBM.EINVAL.
@return Number of queued events on the event queue
@throws LBMException if any error occurs.

### propertySize

```java
public int propertySize()
```

A wrapper for the size() method in java.util.Properties due to an
unfortunate name choice.
@return Number of keys in the property list.
@deprecated In LBM4.0. This API existed because there was an
    LBMEventQueue.size() API which conflicted with java.util.Properties.
    This has been removed so propertySize() is no longer required.
    Use size()

### shutdown

```java
public int shutdown() throws LBMException
```

Shutdown the event queue by purging any pending events and not allowing
additional events to be added to the queue.
@return Always returns 0 although an exception may be thrown in the event
of an error.
@throws LBMException if any error occurs shutting down the event queue.

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions.
@return Array of LBMConfigOption

### getAttributeValue

```java
public String getAttributeValue(String attributeName) throws LBMException
```

Returns the value of an event queue-related attribute for this event queue.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setAttributeValue

```java
public void setAttributeValue(String attributeName, String attributeValue) throws LBMException
```

Set the value of an event queue-related attribute for this event queue.
Note that this method bypasses the property list.
As such no attributes configured using this method will appear in
the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.
@see #setProperty

### setProperty

```java
public Object setProperty(String attributeName, String attributeValue)
```

Set the value of an event queue-related attribute for this event queue.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMRuntimeException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### load

```java
public void load(InputStream inStream) throws IOException
```

Reads a property (attribute) list (key and element pairs) from the
input stream.
@param inStream Input stream of bytes
@throws IOException if any I/O error occurs.
@throws LBMRuntimeException if any invalid attribute is detected in <code>inStream</code>.

### run

```java
public void run(long milliseconds)
```

Dispatch waiting events to the appropriate callback methods.
@param milliseconds Number of milliseconds to block before returning.

### stop

```java
public void stop()
```

Signal any threads dispatching the event queue to return from run(long) as soon as
possible (unblocks the queue).
@see #run(long)

### getStatistics

```java
public LBMEventQueueStatistics getStatistics() throws LBMException
```

Return the current set of statistics for this event queue.
@return LBMEventQueueStatistics object containing the statistics
corresponding to this event queue.
@throws LBMException if any error occurred retrieving statistics.

### resetStatistics

```java
public void resetStatistics() throws LBMException
```

Reset the event queue statistics.
@throws LBMException if any error occurs resetting the statistics.

### addMonitor

```java
public void addMonitor(LBMEventQueueCallback cb)
```

Register a monitor callback
@param cb Object implementing the LBMEventQueueCallback interface
@see LBMEventQueueCallback
@see #removeMonitor

### addMonitor

```java
public void addMonitor(LBMEventQueueCallback cb, Object cbArg)
```

Register a monitor callback (and callback token)
@param cb Object implementing the LBMEventQueueCallback interface
@param cbArg Callback token object
@see LBMEventQueueCallback
@see #removeMonitor

### removeMonitor

```java
public void removeMonitor(LBMEventQueueCallback cb)
```

Deregister a monitor callback
@param cb Previously registered object implementing the
LBMEventQueueCallback interface
@see LBMEventQueueCallback
@see #addMonitor

### removeMonitor

```java
public void removeMonitor(LBMEventQueueCallback cb, Object cbArg)
```

Deregister a monitor callback (and callback token)
@param cb Previously registered object implementing the
LBMEventQueueCallback interface
@param cbArg Callback token for previously registered object
@see LBMEventQueueCallback
@see #addMonitor

## LBMEventQueueAttributes

*class* `com.latencybusters.lbm.LBMEventQueueAttributes`

### LBMEventQueueAttributes

```java
public LBMEventQueueAttributes(String eventQueueName) throws LBMException
```

Create and fill an LBMEventQueueAttributes object with the current default values for the given event queue name.
@param eventQueueName Event queue name string. Is written into the attributes object.
@throws LBMException if the eventQueueName is not permitted by the configuration or other operational failure.

### setFromXml

```java
public void setFromXml(String eventQueueName) throws LBMException
```

Fill an LBMEventQueueAttributes object with the default values for the given event queue name specified by the XML configuration.
@param eventQueueName Event queue name string. Is written into the attributes object.
@throws LBMException if the eventQueueName is not permitted by the configuration or other operational failure.

### LBMEventQueueAttributes

```java
public LBMEventQueueAttributes() throws LBMException
```

Create an LBMEventQueueAttributes object with the current default values
@throws LBMException for operational failure.

### dispose

```java
public void dispose()
```

Free memory associated with this set of attributes.

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions.
@return Array of LBMConfigOption

### getValue

```java
public String getValue(String attributeName) throws LBMException
```

Returns the current value of an attribute from this set of
event queue attributes.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setValue

```java
public void setValue(String attributeName, String attributeValue) throws LBMException
```

FOR INTERNAL INFORMATICA USE ONLY - NOT FOR DIRECT APPLICATION USEAGE.
Applications should use setProperty() instead.
Set the current value of an attribute in this set of
event queue attributes.  Note that this method bypasses the property
list.  As such no attributes configured using this method will appear
in the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.
@see #setProperty

### setProperty

```java
public Object setProperty(String attributeName, String attributeValue)
```

Set the current value of an attribute in this set of event queue
attributes.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMRuntimeException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### load

```java
public void load(InputStream inStream) throws IOException
```

Reads a property (attribute) list (key and element pairs) from the
input stream.
@param inStream Input stream of bytes
@throws IOException if any I/O error occurs.
@throws LBMRuntimeException if any invalid attribute is detected in <code>inStream</code>.

### setObjectRecycler

```java
public void setObjectRecycler(LBMObjectRecyclerBase objRec, Object objRecCbArg)
```

Set the LBM object recycler that can be used by the event queue to reuse statistics objects.
@param objRec an LBM object recycler that will be called when objects need to be retrieved
@param objRecCbArg a callback object token that will be passed in the retrieve method

## LBMEventQueueCallback

*interface* `com.latencybusters.lbm.LBMEventQueueCallback`

### monitor

```java
void monitor(Object cbArg, int eventType, int eventQueueSize, long eventQueueDelay)
```

Event Queue callback method.
@param cbArg Client data pointer supplied in LBMEventQueue()
@param eventType One of LBM.EVENT_QUEUE_*_WARNING or
    LBM.EVENT_QUEUE_ENQUEUE_NOTIFICATION, depending on enabled options.
@param eventQueueSize Number of events currently in the queue.
@param eventQueueDelay Number of microseconds the oldest event has been in
    the event queue. (Note, this will be the next event dispatched.)

## LBMEventQueueStatistics

*class* `com.latencybusters.lbm.LBMEventQueueStatistics`

### LBMEventQueueStatistics

```java
public LBMEventQueueStatistics()
```

Instantiate an empty object containing no statistics.

### LBMEventQueueStatistics

```java
public LBMEventQueueStatistics(UMMonAttributes attributes, EventQueue eqStats) throws LBMException
```

Instantiate an object containing the event queue statistics from a Protobuf message.
     @param attributes An UMMonAttributesProtos.UMMonAttributes
     @param eqStats An UMSMonProtos.Stats.EventQueue
@throws LBMException if any error occurred retrieving event queue statistics.

### LBMEventQueueStatistics

```java
public LBMEventQueueStatistics(LBMMonitorReceiver lbmmonrcv, ByteBuffer attributeBuffer, ByteBuffer eqStats) throws LBMException
```

Instantiate an object containing the event queue statistics from a passthrough CSV message.
@param lbmmonrcv  LBMMonitorReceiver that received this packet.
@param attributeBuffer A ByteBuffer of packet attributes passed to the passthrough callback
@param eqStats   A ByteBuffer of CSV statistics passed to the passthrough callback
@throws LBMException if any error occurred retrieving context statistics.

### LBMEventQueueStatistics

```java
public LBMEventQueueStatistics(LBMEventQueue evq) throws LBMException
```

Instantiate an object containing the current set of
event queue statistics for a given UM Event Queue.
@param evq LBMEventQueue object
@throws LBMException if any error occurred retrieving event queue statistics.
@see #refresh

### refresh

```java
public void refresh(LBMEventQueue evq) throws LBMException
```

Refresh event queue statistics for a given LBMEventQueue
@param evq LBMEventQueue object
@throws LBMException if any error occurred retrieving event queue statistics.

### dispose

```java
public void dispose()
```

Free memory associated with this set of statistics.

### dataMessages

```java
public long dataMessages() throws LBMException
```

Number of data messages currently in the event queue, i.e., a snapshot.
Configuration option queue_count_enabled must be activated.
@return Data messages currently in the event queue
@throws LBMException if any error occurred retrieving data messages.
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### dataMessagesTotal

```java
public long dataMessagesTotal() throws LBMException
```

Total accumulated number of data messages that have been added to the event queue
(even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
@return Total data messages enqueued since last reset
@throws LBMException if any error occurred retrieving total data messages.
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### dataMessagesMinimumServiceTime

```java
public long dataMessagesMinimumServiceTime() throws LBMException
```

Minimum service time for data messages (in microseconds). This is the low-water mark
(i.e., the shortest so far) for data message service durations, measured from the
point of de-queuement until the application has finished servicing the message.
Configuration option queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
@return Minimum service time for data messages (in microseconds)
@throws LBMException if any error occurred retrieving minimum service time.
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### dataMessagesMeanServiceTime

```java
public long dataMessagesMeanServiceTime() throws LBMException
```

Mean service time for data messages (in microseconds). This is an exponentially
weighted moving average (weighted to more recent) for accumulated data message
service durations, measured from the point of de-queuement until the application has
finished servicing the message. Configuration option queue_service_time_enabled must
be activated.
@return Mean service time for data messages (in microseconds)
@throws LBMException if any error occurred retrieving mean service time.
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### dataMessagesMaximumServiceTime

```java
public long dataMessagesMaximumServiceTime() throws LBMException
```

Maximum service time for data messages (in microseconds). This is the high-water mark
(i.e., the longest so far) for data message service durations measured from the point
of de-queuement until the application has finished servicing the message.
Configuration option queue_service_time_enabled must be activated.
@return Maximum service time for data messages (in microseconds)
@throws LBMException if any error occurred retrieving maximum service time.
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### responseMessages

```java
public long responseMessages() throws LBMException
```

Number of response messages (from receiver objects) currently in the event queue,
i.e., a snapshot. Configuration option queue_count_enabled must be activated.
@return Response messages currently in the event queue
@throws LBMException if any error occurred retrieving response messages.
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### responseMessagesTotal

```java
public long responseMessagesTotal() throws LBMException
```

Total accumulated number of response messages that have been added to the event queue
(even if subsequently de-queued) since last reset.
@return Total response messages enqueued since last reset
@throws LBMException if any error occurred retrieving total response messages.
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### responseMessagesMinimumServiceTime

```java
public long responseMessagesMinimumServiceTime() throws LBMException
```

Minimum service time for response messages (in microseconds). This is the low-water
mark (i.e., the shortest so far) for response message service durations, measured
from the point of de-queuement until the application has finished servicing the
message. Configuration option queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
@return Minimum service time for response messages (in microseconds)
@throws LBMException if any error occurred retrieving minimum service time.
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### responseMessagesMeanServiceTime

```java
public long responseMessagesMeanServiceTime() throws LBMException
```

Mean service time for response messages (in microseconds). This is an exponentially
weighted moving average (weighted to more recent) for accumulated response message
service durations, measured from the point of de-queuement until the application has
finished servicing the message. Configuration option queue_service_time_enabled must
be activated.
@return Mean service time for response messages (in microseconds)
@throws LBMException if any error occurred retrieving mean service time.
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### responseMessagesMaximumServiceTime

```java
public long responseMessagesMaximumServiceTime() throws LBMException
```

Maximum service time for response messages (in microseconds). This is the high-water
mark (i.e., the longest so far) for response message service durations measured from
the point of de-queuement until the application has finished servicing the message.
Configuration option queue_service_time_enabled must be activated.
@return Maximum service time for response messages (in microseconds)
@throws LBMException if any error occurred retrieving maximum service time.
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### topiclessImmediateMessages

```java
public long topiclessImmediateMessages() throws LBMException
```

Number of topic-less Multicast Immediate Messaging (MIM) messages currently in the
event queue, i.e., a snapshot. Configuration option queue_count_enabled must be
activated.
@return Topic-less MIM messages currently in the event queue
@throws LBMException if any error occurred retrieving topicless immediate messages
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### topiclessImmediateMessagesTotal

```java
public long topiclessImmediateMessagesTotal() throws LBMException
```

Total accumulated number of topic-less Multicast Immediate Messaging (MIM) messages
that have been added to the event queue (even if subsequently de-queued) since last
reset. Configuration option queue_count_enabled must be activated.
@return Total topic-less MIM messages enqueued since last reset
@throws LBMException if any error occurred retrieving total topicless immediate messages
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### topiclessImmediateMessagesMinimumServiceTime

```java
public long topiclessImmediateMessagesMinimumServiceTime() throws LBMException
```

Minimum service time for topic-less Multicast Immediate Messaging (MIM) messages (in
microseconds). This is the low-water mark (i.e., the shortest so far) for topic-less
MIM message service durations, measured from the point of de-queuement until the
application has finished servicing the message. Configuration option
queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
@return Minimum service time for topic-less MIM messages (in microseconds)
@throws LBMException if any error occurred retrieving minimum service time.
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### topiclessImmediateMessagesMeanServiceTime

```java
public long topiclessImmediateMessagesMeanServiceTime() throws LBMException
```

Mean service time for topic-less Multicast Immediate Messaging (MIM) messages (in
microseconds). This is an exponentially weighted moving average (weighted to more
recent) for accumulated topic-less MIM message service durations, measured from the
point of de-queuement until the application has finished servicing the message.
Configuration option queue_service_time_enabled must be activated.
@return Mean service time for topic-less MIM messages (in microseconds)
@throws LBMException if any error occurred retrieving mean service time
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### topiclessImmediateMessagesMaximumServiceTime

```java
public long topiclessImmediateMessagesMaximumServiceTime() throws LBMException
```

Maximum service time for topic-less Multicast Immediate Messaging (MIM) messages (in
microseconds). This is the high-water mark (i.e., the longest so far) for topic-less
MIM message service durations measured from the point of de-queuement until the
application has finished servicing the message. Configuration option
queue_service_time_enabled must be activated.
@return Maximum service time for topic-less MIM messages (in microseconds)
@throws LBMException if any error occurred retrieving maximum service time
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### wildcardReceiverMessages

```java
public long wildcardReceiverMessages() throws LBMException
```

Number of wildcard receiver messages currently in the event queue, i.e., a snapshot.
Configuration option queue_count_enabled must be activated.
@return Number of wildcard messages currently in the event queue
@throws LBMException if any error occurred retrieving the number of wildcard messages enqueued.
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### wildcardReceiverMessagesTotal

```java
public long wildcardReceiverMessagesTotal() throws LBMException
```

Total accumulated number of wildcard receiver messages that have been added to the
event queue (even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
@return Total number of wildcard messages enqueued since last reset
@throws LBMException if any error occurred retrieving the total number of wildcard messages
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### wildcardReceiverMessagesMinimumServiceTime

```java
public long wildcardReceiverMessagesMinimumServiceTime() throws LBMException
```

Minimum service time for wildcard receiver messages (in microseconds). This is the
low-water mark (i.e., the shortest so far) for wildcard receiver message service
durations measured from the point of de-queuement until the application has finished
servicing the message. Configuration option queue_service_time_enabled must be
activated.

This field is initialized to all 1s (-1 if printed signed).
@return Minimum service time of wildcard messages (in microseconds)
@throws LBMException if any error occurred retrieving the minimum service time of wildcard messages
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### wildcardReceiverMessagesMeanServiceTime

```java
public long wildcardReceiverMessagesMeanServiceTime() throws LBMException
```

Mean service time for wildcard receiver messages (in microseconds). This is an
exponentially weighted moving average (weighted to more recent) for accumulated
wildcard receiver message service durations, measured from the point of de-queuement
until the application has finished servicing the message. Configuration option
queue_service_time_enabled must be activated.
@return Mean service time of wildcard messages (in microseconds)
@throws LBMException if any error occurred retrieving the mean service time of wildcard messages
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### wildcardReceiverMessagesMaximumServiceTime

```java
public long wildcardReceiverMessagesMaximumServiceTime() throws LBMException
```

Maximum service time for wildcard receiver messages (in microseconds). This is the
high-water mark (i.e., the longest so far) for wildcard receiver message service
durations measured from the point of de-queuement until the application has finished
servicing the message. Configuration option queue_service_time_enabled must be
activated.
@return Maximum service time of wildcard messages (in microseconds)
@throws LBMException if any error occurred retrieving the maximum service time of wildcard messages
@see #LBMEventQueueStatistics(LBMEventQueue)
@see LBM

### ioEvents

```java
public long ioEvents() throws LBMException
```

Number of I/O events currently in the event queue, i.e., a snapshot. Configuration
option queue_count_enabled must be activated.
@return Number of I/O events currently in the event queue
@throws LBMException if any error occurred retrieving the statistics.

### ioEventsTotal

```java
public long ioEventsTotal() throws LBMException
```

Total accumulated number of I/O events that have been added to the event queue (even
if subsequently de-queued) since last reset. Configuration option queue_count_enabled
must be activated.
@return Total number of I/O events enqueued since last reset
@throws LBMException if any error occurred retrieving the statistics.

### ioEventsMinimumServiceTime

```java
public long ioEventsMinimumServiceTime() throws LBMException
```

Minimum Service Time for I/O Events (in microseconds). This is the low-water mark
(i.e., the shortest so far) for I/O event service durations measured from the point
of de-queuement until the application has finished servicing the event. Configuration
option queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
@return Minimum service time for I/O events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### ioEventsMeanServiceTime

```java
public long ioEventsMeanServiceTime() throws LBMException
```

Mean service time for I/O events (in microseconds). This is an exponentially weighted
moving average (weighted to more recent) for accumulated I/O event service durations,
measured from the point of de-queuement until the application has finished servicing
the event. Configuration option queue_service_time_enabled must be activated.
@return Mean service time for I/O events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### ioEventsMaximumServiceTime

```java
public long ioEventsMaximumServiceTime() throws LBMException
```

Maximum service time for I/O events (in microseconds). This is the high-water mark
(i.e., the longest so far) for I/O event service durations measured from the point of
de-queuement until the application has finished servicing the event. Configuration
option queue_service_time_enabled must be activated.
@return Maximum service time for I/O events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### timerEvents

```java
public long timerEvents() throws LBMException
```

Number of timer events currently in the event queue, i.e., a snapshot. Configuration
option queue_count_enabled must be activated.
@return Number of timer events currently in the event queue
@throws LBMException if any error occurred retrieving the statistics.

### timerEventsTotal

```java
public long timerEventsTotal() throws LBMException
```

Total accumulated number of timer events that have been added to the event queue
(even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
@return Total number of timer events enqueued since last reset
@throws LBMException if any error occurred retrieving the statistics.

### timerEventsMinimumServiceTime

```java
public long timerEventsMinimumServiceTime() throws LBMException
```

Minimum service time for timer events (in microseconds). This is the low-water mark
(i.e., the shortest so far) for timer event service durations measured from the point
of de-queuement until the application has finished servicing the event. Configuration
option queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
@return Minimum service time for timer events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### timerEventsMeanServiceTime

```java
public long timerEventsMeanServiceTime() throws LBMException
```

Mean service time for timer events (in microseconds). This is an exponentially
weighted moving average (weighted to more recent) for accumulated timer event service
durations, measured from the point of de-queuement until the application has finished
servicing the message. Configuration option queue_service_time_enabled must be
activated.
@return Mean service time for timer events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### timerEventsMaximumServiceTime

```java
public long timerEventsMaximumServiceTime() throws LBMException
```

Maximum service time for timer events (in microseconds). This is the high-water mark
(i.e., the longest so far) for timer event service durations measured from the point
of de-queuement until the application has finished servicing the event. Configuration
option queue_service_time_enabled must be activated.
@return Maximum service time for timer events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### sourceEvents

```java
public long sourceEvents() throws LBMException
```

Number of source events currently in the event queue, i.e., a snapshot. Configuration
option queue_count_enabled must be activated.
@return Number of source events currently in the event queue
@throws LBMException if any error occurred retrieving the statistics.

### sourceEventsTotal

```java
public long sourceEventsTotal() throws LBMException
```

Total accumulated number of source events that have been added to the event queue
(even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
@return Total number of source events enqueued since last reset
@throws LBMException if any error occurred retrieving the statistics.

### sourceEventsMinimumServiceTime

```java
public long sourceEventsMinimumServiceTime() throws LBMException
```

Minimum service time for source events (in microseconds). This is the low-water mark
(i.e., the shortest so far) for source event service durations measured from the
point of de-queuement until the application has finished servicing the event.
Configuration option queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
@return Minimum service time for source events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### sourceEventsMeanServiceTime

```java
public long sourceEventsMeanServiceTime() throws LBMException
```

Mean service time for source events (in microseconds). This is an exponentially
weighted moving average (weighted to more recent) for accumulated source event
service durations, measured from the point of de-queuement until the application has
finished servicing the message. Configuration option queue_service_time_enabled must
be activated.
@return Mean service time for source events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### sourceEventsMaximumServiceTime

```java
public long sourceEventsMaximumServiceTime() throws LBMException
```

Maximum service time for source events (in microseconds). This is the high-water mark
(i.e., the longest so far) for source event service durations measured from the point
of de-queuement until the application has finished servicing the event. Configuration
option queue_service_time_enabled must be activated.
@return Maximum service time for source events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### unblockEvents

```java
public long unblockEvents() throws LBMException
```

Number of unblock events currently in the event queue, i.e., a snapshot.
Configuration option queue_count_enabled must be activated.
@return Number of unblock events currently in the event queue
@throws LBMException if any error occurred retrieving the statistics.

### unblockEventsTotal

```java
public long unblockEventsTotal() throws LBMException
```

Total accumulated number of unblock events that have been added to the event queue
(even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
@return Total number of unblock events enqueued since last reset
@throws LBMException if any error occurred retrieving the statistics.

### cancelEvents

```java
public long cancelEvents() throws LBMException
```

Number of cancel events currently in the event queue, i.e., a snapshot. Configuration
option queue_count_enabled must be activated.
@return Number of cancel events currently in the event queue
@throws LBMException if any error occurred retrieving the statistics.

### cancelEventsTotal

```java
public long cancelEventsTotal() throws LBMException
```

Total accumulated number of cancel events that have been added to the event queue
(even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
@return Total number of cancel events enqueued since last reset
@throws LBMException if any error occurred retrieving the statistics.

### cancelEventsMinimumServiceTime

```java
public long cancelEventsMinimumServiceTime() throws LBMException
```

Minimum service time for cancel events. Cancel events as seen by the event queue do
not actually consume service time, so we do not recommend the general use of this
counter.

This field is initialized to all 1s (-1 if printed signed).
@return Minimum service time for cancel events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### cancelEventsMeanServiceTime

```java
public long cancelEventsMeanServiceTime() throws LBMException
```

Mean service time for cancel events. Cancel events as seen by the event queue do not
actually consume service time, so we do not recommend the general use of this
counter.
@return Mean service time for cancel events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### cancelEventsMaximumServiceTime

```java
public long cancelEventsMaximumServiceTime() throws LBMException
```

Maximum service time for cancel events. Cancel events as seen by the event queue do
not actually consume service time, so we do not recommend the general use of this
counter.
@return Maximum service time for cancel events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### callbackEvents

```java
public long callbackEvents() throws LBMException
```

Number of callback events currently in the event queue, i.e., a snapshot.
Configuration option queue_count_enabled must be activated.
@return Number of callback events currently in the event queue
@throws LBMException if any error occurred retrieving the statistics.

### callbackEventsTotal

```java
public long callbackEventsTotal() throws LBMException
```

Total accumulated number of callback events that have been added to the event queue
even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
@return Total number of callback events enqueued since last reset
@throws LBMException if any error occurred retrieving the statistics.

### callbackEventsMinimumServiceTime

```java
public long callbackEventsMinimumServiceTime() throws LBMException
```

Minimum service time for callback events (in microseconds). This is the low-water
mark (i.e., the shortest so far) for callback event service durations measured from
the point of de-queuement until the application has finished servicing the event.
Configuration option queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
@return Minimum service time for callback events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### callbackEventsMeanServiceTime

```java
public long callbackEventsMeanServiceTime() throws LBMException
```

Mean service time for callback events (in microseconds). This is an exponentially
weighted moving average (weighted to more recent) for accumulated callback event
service durations, measured from the point of de-queuement until the application has
finished servicing the message. Configuration option queue_service_time_enabled must
be activated.
@return Mean service time for callback events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### callbackEventsMaximumServiceTime

```java
public long callbackEventsMaximumServiceTime() throws LBMException
```

Maximum service time for callback events (in microseconds). This is the high-water
mark (i.e., the longest so far) for callback event service durations measured from
the point of de-queuement until the application has finished servicing the event.
Configuration option queue_service_time_enabled must be activated.
@return Maximum service time for callback events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### contextSourceEvents

```java
public long contextSourceEvents() throws LBMException
```

Number of context source events currently in the event queue, i.e., a snapshot.
Configuration option queue_count_enabled must be activated.
@return Number of context source events currently in the event queue
@throws LBMException if any error occurred retrieving the statistics.

### contextSourceEventsTotal

```java
public long contextSourceEventsTotal() throws LBMException
```

Total accumulated number of context source events that have been added to the event
queue (even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
@return Total number of context source events enqueued since last reset
@throws LBMException if any error occurred retrieving the statistics.

### contextSourceEventsMinimumServiceTime

```java
public long contextSourceEventsMinimumServiceTime() throws LBMException
```

Minimum service time for context source events (in microseconds). This is the
low-water mark (i.e., the shortest so far) for context source event service durations
measured from the point of de-queuement until the application has finished servicing
the event. Configuration option queue_service_time_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
@return Minimum service time for context source events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### contextSourceEventsMeanServiceTime

```java
public long contextSourceEventsMeanServiceTime() throws LBMException
```

Mean service time for context source events (in microseconds). This is an
exponentially weighted moving average (weighted to more recent) for accumulated
context source event service durations, measured from the point of de-queuement until
the application has finished servicing the event. Configuration option
queue_service_time_enabled must be activated.
@return Mean service time for context source events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### contextSourceEventsMaximumServiceTime

```java
public long contextSourceEventsMaximumServiceTime() throws LBMException
```

Maximum service time for context source events (in microseconds). This is the
high-water mark (i.e., the longest so far) for context source event service durations
measured from the point of de-queuement until the application has finished servicing
the event. Configuration option queue_service_time_enabled must be activated.
@return Maximum service time for context source events (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### events

```java
public long events() throws LBMException
```

Total number of events (including messages) currently in the event queue, i.e., a
snapshot. Configuration option queue_count_enabled must be activated.
@return Number of events currently in the event queue
@throws LBMException if any error occurred retrieving the statistics.

### eventsTotal

```java
public long eventsTotal() throws LBMException
```

Total accumulated number of events (including messages) that have been added to the
event queue (even if subsequently de-queued) since last reset. Configuration option
queue_count_enabled must be activated.
@return Total number of events that have been enqueued since last reset
@throws LBMException if any error occurred retrieving the statistics.

### minimumAge

```java
public long minimumAge() throws LBMException
```

Minimum age of event queue entry when dequeued (in microseconds). This is the
low-water mark for the measured age of any event or message (i.e., the shortest one
so far) from the point of enqueuement until de-queuement. Configuration option
queue_age_enabled must be activated.

This field is initialized to all 1s (-1 if printed signed).
@return Minimum age of event queue entry when dequeued (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### meanAge

```java
public long meanAge() throws LBMException
```

Mean age of event queue entries when dequeued (in microseconds). This is an
exponentially weighted moving average (weighted to more recent) for accumulated event
or message ages (measured from the point enqueuement until de-queuement).
Configuration option queue_age_enabled must be activated.
@return Mean age of event queue entry when dequeued (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

### maximumAge

```java
public long maximumAge() throws LBMException
```

Maximum age of event queue entry when dequeued (in microseconds). This is the
high-water mark for the measured age of any event or message (i.e., the oldest one so
far) from the point of enqueuement until de-queuement. Configuration option
queue_age_enabled must be activated.
@return Maximum age of event queue entry when dequeued (in microseconds)
@throws LBMException if any error occurred retrieving the statistics.

## LBMException

*class* `com.latencybusters.lbm.LBMException`

### LBMException

```java
public LBMException(String errorMessage)
```

Internally used constructor which sets the error number to LBM.EOP

### errorNumber

```java
public int errorNumber()
```

Get LBM error number.
@return LBM error number

## LBMFlightSizeInflightInfo

*class* `com.latencybusters.lbm.LBMFlightSizeInflightInfo`

### getMessages

```java
public int getMessages()
```

Get current inflight messages.
@return The current number of inflight messages.

### setMessages

```java
public void setMessages(int msgs)
```

Set the messages value of this flight size info. When called from a
set inflight callback, the new value will also be set in the native code.
@see LBMSetInflightCallbackEx#setInflight
@param msgs

### getBytes

```java
public long getBytes()
```

Get the current number of inflight bytes if flight size is configured
to keep track of them.
@return The current number of inflight bytes.

### setBytes

```java
public void setBytes(long bytes)
```

Set the bytes value of this flight size info. When called from a
set inflight callback, the new value will also be set in the native code.
@see LBMSetInflightCallbackEx#setInflight
@param bytes

## LBMHFX

*class* `com.latencybusters.lbm.LBMHFX`

### LBMHFX

```java
public LBMHFX(LBMHFXAttributes attr, String topic, LBMReceiverCallback cb, LBMEventQueue evq)
```

Instantiate a new LBMHFX object on the specified topic.
This constructor will create a new LBMHFX object.
@param attr Optional attributes that modify the behavior of
            the LBMHFX object.
@param topic The topic to be used for all receivers created
             using this LBMHFX object.
@param cb   The callback to be invoked when a new message is
            delivered.
@param evq  Optional event queue to be used to deliver messages.

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions
@return Array of LBMConfigOption

### close

```java
public void close()
```

Close this HFX object.  All receivers created using the HFX.createReceiver method should be closed before attempting to close the HFX object.
  <b>Warning</b>: It is not safe to call this method from a context thread callback.

### close

```java
public void close(LBMOperationCompleteCallback cb, Object cbArg)
```

Close this HFX object.  All receivers created using the HFX.createReceiver method should be closed before attempting to close the HFX object.
  <b>Warning</b>: It is not safe to call this method from a context thread callback.
  @param cb Callback to be called when the object is completely closed.
  @param cbArg Token to be delivered with the callback.

### createReceiver

```java
public LBMHFXReceiver createReceiver(LBMContext ctx, LBMReceiverAttributes rattr, Object cbArg)
```

Create a receiver on the specified context, with the specified attributes and callback token. A hot failover receiver is created on the specified context with the attributes passed in.  Some attributes related to message delivery may be overridden (e.g. duplicate delivery will be enabled if it is enabled on the HFX object.
@param ctx Context on which to create the receiver.
@param rattr Attributes to be used for the receiver.
@param cbArg Callback token to be associated with messages delivered through the newly created receiver.

### getAttributeValue

```java
public String getAttributeValue(String attributeName) throws LBMException
```

Returns the value of a HFX-related attribute for this HFX.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setAttributeValue

```java
public void setAttributeValue(String attributeName, String attributeValue) throws LBMException
```

Set the value of a HFX-related attribute for this HFX.

Note that this method bypasses the property list.
As such no attributes configured using this method will appear in
the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

## LBMHFXAttributes

*class* `com.latencybusters.lbm.LBMHFXAttributes`

### LBMHFXAttributes

```java
public LBMHFXAttributes() throws LBMException
```

Create an LBMHFXAttributes object with the current default values
@throws LBMException

### LBMHFXAttributes

```java
public LBMHFXAttributes(String topicName) throws LBMException
```

Create and fill an LBMHFXAttributes object with the current default values for the given HFX topic name.
@param topicName The topic name to be used to create the LBMHFX object.
@throws LBMException if the HFX topic name is not permitted by the XML configuration.

### setFromXml

```java
public void setFromXml(String topicName) throws LBMException
```

Fill an LBMHFXAttributes object with the default values for the given HFX topic name specified by XML configuration.
@param topicName The topic name to be used to create the LBMHFX object.
@throws LBMException if the HFX topic name is not permitted by the XML configuration.

### dispose

```java
public synchronized void dispose()
```

Free memory associated with this set of attributes.

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions
@return Array of LBMConfigOption

### getValue

```java
public String getValue(String attributeName) throws LBMException
```

Returns the current value of an attribute from this set of
HFX attributes.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setValue

```java
public void setValue(String attributeName, String attributeValue) throws LBMException
```

FOR INTERNAL INFORMATICA USE ONLY - NOT FOR DIRECT APPLICATION USEAGE.
Applications should use setProperty() instead.
Set the current value of an attribute in this set of
HFX attributes.  Note that this method bypasses the
property list.  As such no attributes configured using this method
will appear in the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.
@see #setProperty

### setProperty

```java
public Object setProperty(String attributeName, String attributeValue)
```

Set the current value of an attribute in this set of HFX attributes.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMRuntimeException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### load

```java
public void load(InputStream inStream) throws IOException
```

Reads a property (attribute) list (key and element pairs) from the
input stream.
@param inStream Input stream of bytes
@throws IOException if any I/O error occurs.
@throws LBMRuntimeException if any invalid attribute is detected in <code>inStream</code>.

### setObjectRecycler

```java
public void setObjectRecycler(LBMObjectRecyclerBase objRec, Object objRecCbArg)
```

Set the LBM object recycler that can be used by the context to reuse LBMMessage objects as
well as LBM Context/Receiver/Source Statistics objects.
@param objRec an LBM object recycler that will be called when objects need to be retrieved
@param objRecCbArg a callback object token that will be passed in the retrieve method

## LBMHFXReceiver

*class* `com.latencybusters.lbm.LBMHFXReceiver`

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions
@return Array of LBMConfigOption

### setAttributeValue

```java
public int setAttributeValue(String attributeName, String attributeValue)
```

Set the value of a receiver-related attribute for this receiver.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### getAttributeValue

```java
public String getAttributeValue(String attributeName)
```

Returns the value of a receiver-related attribute for this receiver.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### getStatistics

```java
public LBMReceiverStatistics getStatistics(String source) throws LBMException
```

Return the current set of receiver transport statistics for a particular
source.
@param source Source string (as returned by LBMMesage source())
that specifies the set of statistics to return.
@return LBMReceiverStatistics object containing the statistics
corresponding to the specified source.
@throws LBMException if any error occurred retrieving receiver statistics.

### getStatistics

```java
public LBMReceiverStatistics getStatistics(int maxStats) throws LBMException
```

Return the current set of receiver transport statistics for all sources.
@param maxStats Maximum number of sources
@return LBMReceiverStatistics object containing the statistics
corresponding to the specified number of sources
@throws LBMException if any error occurred retrieving receiver statistics.

### close

```java
public void close()
```

Close this receiver.
    <b>Warning</b>: It is not safe to call this method from a context thread callback.

### close

```java
public void close(LBMOperationCompleteCallback cb, Object cbArg)
```

Close this receiver.
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param cb Callback to be invoked when the close operation is complete.
@param cbArg Token to be delivered with the callback.

## LBMHotFailoverReceiver

*class* `com.latencybusters.lbm.LBMHotFailoverReceiver`

### LBMHotFailoverReceiver

```java
public LBMHotFailoverReceiver(LBMContext lbmctx, LBMTopic lbmtopic, LBMReceiverCallback cb, Object cbArg) throws LBMException
```

Instantiate an LBM Hot-Failover Receiver object associated with a
given context and topic.
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the receiver.
@param lbmtopic LBMTopic used to initialize the receiver.
@param cb An object implementing the LBMReceiverCallback interface
@param cbArg Callback object passed as token to callback interface
@throws LBMException if any error occurs creating the hot failover receiver.

### LBMHotFailoverReceiver

```java
public LBMHotFailoverReceiver(LBMContext lbmctx, LBMTopic lbmtopic, LBMReceiverCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Instantiate an LBM Hot-Failover Receiver object associated with a
given context, topic, and event queue.
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the receiver.
@param lbmtopic LBMTopic used to initialize the receiver.
@param cb An object implementing the LBMReceiverCallback interface
@param cbArg Callback object passed as token to callback interface
@param lbmevq Event queue with which to associate the receiver
(all receiver events will be posted to this event queue).
@throws LBMException if any error occurs creating the hot failover receiver.

### subscribeChannel

```java
public void subscribeChannel(long channelNumber, LBMReceiverCallback cb, Object cbArg) throws LBMException
```

Subscribe to a given channel

### unsubscribeChannel

```java
public void unsubscribeChannel(long channelNumber) throws LBMException
```

Cancel an existing subscription

### getAttributeValue

```java
public String getAttributeValue(String attributeName) throws LBMException
```

Returns the value of a receiver-related attribute for this receiver.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setAttributeValue

```java
public void setAttributeValue(String attributeName, String attributeValue) throws LBMException
```

Set the value of a receiver-related attribute for this receiver.
Note that this method bypasses the property list.
As such no attributes configured using this method will appear in
the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.
@see #setProperty

## LBMHotFailoverSource

*class* `com.latencybusters.lbm.LBMHotFailoverSource`

### LBMHotFailoverSource

```java
public LBMHotFailoverSource(LBMContext lbmctx, LBMTopic lbmtopic) throws LBMException
```

Instantiate an LBM Hot-Failover Source object associated with a
given context and topic.
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the source.
@param lbmtopic LBMTopic used to initialize the source.
@throws LBMException if any error occurs creating the hot failover source.

### LBMHotFailoverSource

```java
public LBMHotFailoverSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMSourceEventCallback cb, Object cbArg) throws LBMException
```

Instantiate an LBM Hot-Failover Source object associated with a
given context and topic and initialize source event callback.
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the source.
@param lbmtopic LBMTopic used to initialize the source.
@param cb An object implementing the LBMSourceEventCallback interface
@param cbArg Callback token object
@throws LBMException if any error occurs creating the hot failover source.

### LBMHotFailoverSource

```java
public LBMHotFailoverSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMEventQueue lbmevq) throws LBMException
```

Instantiate an LBM Hot-Failover Source object associated with a
given context, topic, and event queue.
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the source.
@param lbmtopic LBMTopic used to initialize the source.
@param lbmevq Event queue with which to associate the source (all source events will be posted to this event queue).
@throws LBMException if any error occurs creating the hot failover source.

### LBMHotFailoverSource

```java
public LBMHotFailoverSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMSourceEventCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Instantiate an LBM Hot-Failover Source object associated with a
given context, topic, and event queue and initialize source event
callback.
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the source.
@param lbmtopic LBMTopic used to initialize the source.
@param cb An object implementing the LBMSourceEventCallback interface
@param cbArg Callback token object
@param lbmevq Event queue with which to associate the source
(all source events will be posted to this event queue).
@throws LBMException if any error occurs creating the hot failover source.

### send

```java
public void send(byte [] message, int messageLength, long sqn, int flags) throws LBMException
```

  Send a message to the topic associated with the LBM source.
      <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param message Data to send in this message
  @param messageLength Number of bytes of data to send in this message
  @param sqn The application sequence number to associate with this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the message.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK

### send

```java
public void send(byte [] message, int messageLength, long sqn, int flags, Object cbArg) throws LBMException
```

  Send a message to the topic associated with the LBM source.
  <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param message Data to send in this message
  @param messageLength Number of bytes of data to send in this message
  @param sqn The application sequence number to associate with this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @param cbArg Client object to be passed back in stability or confirmation
  events related to this message (UME only)
  @throws LBMException if any error occurs sending the message.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#SRC_EVENT_UME_MESSAGE_STABLE
  @see LBM#SRC_EVENT_UME_DELIVERY_CONFIRMATION

### send

```java
public void send(byte [] message, int messageLength, long sqn, int flags, LBMSourceSendExInfo exinfo) throws LBMException
```

  Send a message to the topic associated with the LBM source.
  <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param message Data to send in this message
  @param messageLength Number of bytes of data to send in this message
  @param sqn The application sequence number to associate with this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @param exinfo LBMSourceSendExInfo object, which includes flags to change
  callback behavior and a client-supplied object to be passed back. (UME only)
  @throws LBMException if any error occurs sending the message.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#SRC_EVENT_UME_MESSAGE_STABLE
  @see LBM#SRC_EVENT_UME_MESSAGE_STABLE_EX
  @see LBM#SRC_EVENT_UME_DELIVERY_CONFIRMATION
  @see LBM#SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX
  @see LBMSourceSendExInfo
  @since UME 2.0

### send

```java
public void send(ByteBuffer message, int startPosition, int messageLength, long sqn, int flags) throws LBMException
```

  Send a message to the topic associated with the LBM source.
      <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param message Data to send in this message
  @param startPosition Starting position within the buffer to send from
  @param messageLength Number of bytes of data to send in this message
  @param sqn The application sequence number to associate with this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurs sending the message.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK

### send

```java
public void send(ByteBuffer message, int startPosition, int messageLength, long sqn, int flags, Object cbArg) throws LBMException
```

  Send a message to the topic associated with the LBM source.
  <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param message Data to send in this message
  @param startPosition Starting position within the buffer to send from
  @param messageLength Number of bytes of data to send in this message
  @param sqn The application sequence number to associate with this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @param cbArg Client object to be passed back in stability or confirmation
  events related to this message (UME only)
  @throws LBMException if any error occurs sending the message.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#SRC_EVENT_UME_MESSAGE_STABLE
  @see LBM#SRC_EVENT_UME_DELIVERY_CONFIRMATION

### send

```java
public void send(ByteBuffer message, int startPosition, int messageLength, long sqn, int flags, LBMSourceSendExInfo exinfo) throws LBMException
```

  Send a message to the topic associated with the LBM source.
  <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param message Data to send in this message
  @param startPosition Starting position within the buffer to send from
  @param messageLength Number of bytes of data to send in this message
  @param sqn The application sequence number to associate with this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @param exinfo LBMSourceSendExInfo object, which includes flags to change
  callback behavior and a client-supplied object to be passed back. (UME only)
  @throws LBMException if any error occurs sending the message.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#SRC_EVENT_UME_MESSAGE_STABLE
  @see LBM#SRC_EVENT_UME_MESSAGE_STABLE_EX
  @see LBM#SRC_EVENT_UME_DELIVERY_CONFIRMATION
  @see LBM#SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX
  @see LBMSourceSendExInfo
  @since UME 2.0

### sendReceiverReset

```java
public void sendReceiverReset(int flags, LBMSourceSendExInfo exinfo) throws LBMException
```

  Send a message that instructs hot-failover receivers to reset their state. In, and only in, the case that hf receivers
  cannot be manually restarted, this function can be used to allow delivering of previously sent sequence numbers. The
  hot-failover receiver will deliver a message of type LBM.MSG_HF_RESET and will include the new expected sequence number.
  The sequence number contained with the reset will be used as the next expected sequence number to be sent.

  NOTE: The best way to reset a hot-failover receiver's state is to restart the receiver itself. This function should be used
  only when that is impossible.
  <p>
      <b>Caution</b>: It is not recommended to call this method from a context thread callback.
  <p>
  <b>Warning</b>: This method should only be used when it is impossible to restart hot failover receivers.

\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

   @param flags Flags indicating various send conditions.
   @param exinfo LBMSourceSendExInfo object which must include the hot failover sequence number to send

## LBMImmediateMessageCallback

*interface* `com.latencybusters.lbm.LBMImmediateMessageCallback`

### onReceiveImmediate

```java
int onReceiveImmediate(Object cbArg, LBMMessage lbmmsg)
```

Received immediate message callback.
@param cbArg Callback object token
@param lbmmsg LBMMessage object encapsulating the received data
@return an int, which should always be 0.

## LBMImmediateMessageReceiverStatistics

*class* `com.latencybusters.lbm.LBMImmediateMessageReceiverStatistics`

### LBMImmediateMessageReceiverStatistics

```java
public LBMImmediateMessageReceiverStatistics()
```

Instantiate an empty object containing no statistics.
@see #refresh

### LBMImmediateMessageReceiverStatistics

```java
public LBMImmediateMessageReceiverStatistics(UMMonAttributes attributes, ReceiverTransport rcvStats) throws LBMException
```

Instantiate object containing the set of receiver transport statistics
for a given receiver transport.
@param attributes An UMMonAttributesProtos.UMMonAttributes
@param rcvStats An UMSMonProtos.RcvTransportStats
@throws LBMException if any error occurred retrieving receiver statistics.

### LBMImmediateMessageReceiverStatistics

```java
public LBMImmediateMessageReceiverStatistics(LBMMonitorReceiver lbmmonrcv, ByteBuffer attributeBuffer, ByteBuffer rcvStats) throws LBMException
```

Instantiate object containing the set of receiver transport statistics
for a given receiver transport.
@param lbmmonrcv LBMMonitorReceiver that received this packet.
@param attributeBuffer A ByteBuffer of packet attributes passed to the passthrough callback
@param rcvStats A ByteBuffer of CSV statistics passed to the passthrough callback
@throws LBMException if any error occurred parsing receiver statistics.

### LBMImmediateMessageReceiverStatistics

```java
public LBMImmediateMessageReceiverStatistics(LBMContext lbmctx, int maxStats) throws LBMException
```

Instantiate object containing the aggregate set of statistics
for a particular context.
This constructor will throw LBMMonitorEInvalException if maxStats
is less than the available number of transport statistical sets.
@param lbmctx LBMContext object
@param maxStats Maximum number of sources
@throws LBMException if any error occurred retrieving statistics.
@see #refresh

### refresh

```java
public void refresh(LBMContext lbmctx, int maxStats) throws LBMException
```

Refresh the aggregate set of statistics for a particular context.
This method will throw LBMMonitorEInvalException if maxStats
is less than the available number of transport statistical sets.
@param lbmctx LBMContext object associated with statistics to be retrieved.
@param maxStats Maximum number of sources.
@throws LBMException if any error occurred retrieving statistics.

### dispose

```java
public void dispose()
```

Free memory associated with this set of statistics.

### size

```java
public int size()
```

Number of transport statistical sets encapsulated within this object
@return Statistical set size

### type

```java
public int type() throws LBMException
```

Transport type (TCP, LBT-RM, etc.).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@return Transport type
@throws LBMException if any error occurred retrieving statistics.
@see LBM

### type

```java
public int type(int n) throws LBMException
```

Transport type (TCP, LBT-RM, etc.).
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Transport type
@throws LBMException if any error occurred retrieving receiver statistics.
@see LBM

### typeName

```java
public String typeName() throws LBMException
```

Transport type name (TCP, LBT-RM, etc.).
This method returns a value from the first
set of statistics encapsulated within this object
@return Transport type name
@throws LBMException if any error occurred retrieving receiver statistics.

### typeName

```java
public String typeName(int n) throws LBMException
```

Transport type name (TCP, LBT-RM, etc.).
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Transport type name
@throws LBMException if any error occurred retrieving receiver statistics.

### source

```java
public String source() throws LBMException
```

Source of transport as a string.
This method returns a value from the first
set of statistics encapsulated within this object.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
@see LBMTransportSourceInfo
@return Source of transport as a string
@throws LBMException if any error occurred retrieving statistics.

### source

```java
public String source(int n) throws LBMException
```

Source of transport as a string.
This method returns a value from the nth set of statistics
encapsulated within this object.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
@see LBMTransportSourceInfo
@param n Statistics set index
@return Source of transport as a string
@throws LBMException if any error occurred retrieving receiver statistics.

### bytesReceived

```java
public long bytesReceived() throws LBMException
```

Number of datagram bytes received (TCP, LBT-RM).
The total of lengths of all transport packets, including UM header information.
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagram bytes received
@throws LBMException if any error occurred retrieving receiver statistics.

### bytesReceived

```java
public long bytesReceived(int n) throws LBMException
```

Number of datagram bytes received (TCP, LBT-RM).
The total of lengths of all transport packets, including UM header information.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagram bytes received
@throws LBMException if any error occurred retrieving receiver statistics.

### messagesReceived

```java
public long messagesReceived() throws LBMException
```

Number of datagrams received (LBT-RM only).
Depending on batching settings, a single LBT-RM datagram may contain one or more
messages, or a fragment of a larger message. With LBT-RM, larger messages are split into
fragment sizes limited by configuration option transport_lbtrm_datagram_max_size
(default 8KB).
    <p>This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams received
@throws LBMException if any error occurred retrieving receiver statistics.

### messagesReceived

```java
public long messagesReceived(int n) throws LBMException
```

Number of datagrams received (LBT-RM only).
Depending on batching settings, a single LBT-RM datagram may contain one or more
messages, or a fragment of a larger message. With LBT-RM, larger messages are split into
fragment sizes limited by configuration option transport_lbtrm_datagram_max_size
(default 8KB).
    <p>This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagrams received
@throws LBMException if any error occurred retrieving receiver statistics.

### nakPacketsSent

```java
public long nakPacketsSent() throws LBMException
```

Number of NAK packets sent by the receiver transport (LBT-RM only).
UM batches NAKs into NAK packets to save network bandwidth. This should always be less
than or equal to the number of individual NAKs sent (naksSent, below).
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of NAK packets sent by the receiver transport
@throws LBMException if any error occurred retrieving receiver statistics.

### nakPacketsSent

```java
public long nakPacketsSent(int n) throws LBMException
```

Number of NAK packets sent by the receiver transport (LBT-RM only).
UM batches NAKs into NAK packets to save network bandwidth. This should always be less
than or equal to the number of individual NAKs sent (naksSent, below).
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of NAK packets sent by the receiver transport
@throws LBMException if any error occurred retrieving receiver statistics.

### naksSent

```java
public long naksSent() throws LBMException
```

Number of individual NAKs sent by the receiver transport (LBT-RM only).
This may differ from the tally of lost datagrams (below) due to reasons such as
<ul>
<li>
Other receiver transports may have already sent a NAK for the same lost datagram,
resulting in a retransmitted lost datagram (or an NCF) to arrive at this receiver
transport before it has a chance to issue a NAK, or
<li>
During periods of heavy loss, receiver transports may be forced to issue multiple NAKs
per lost datagram (controlled by configuration options
transport_lbtrm_nak_generation_interval and transport_lbtrm_nak_backoff_interval) until
either the retransmission is received or the datagram is declared unrecovered (which may
ultimately lead to UM delivering an LBM_MSG_UNRECOVERABLE_LOSS notification to the
receiver application).
</ul>
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of individual NAKs sent by the receiver transport.
@throws LBMException if any error occurred retrieving receiver statistics.

### naksSent

```java
public long naksSent(int n) throws LBMException
```

Number of individual NAKs sent by the receiver transport (LBT-RM only).
This may differ from the tally of lost datagrams (below) due to reasons such as
<ul>
<li>
Other receiver transports may have already sent a NAK for the same lost datagram,
resulting in a retransmitted lost datagram (or an NCF) to arrive at this receiver
transport before it has a chance to issue a NAK, or
<li>
During periods of heavy loss, receiver transports may be forced to issue multiple NAKs
per lost datagram (controlled by configuration options
transport_lbtrm_nak_generation_interval and transport_lbtrm_nak_backoff_interval) until
either the retransmission is received or the datagram is declared unrecovered (which may
ultimately lead to UM delivering an LBM_MSG_UNRECOVERABLE_LOSS notification to the
receiver application).
</ul>
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of individual NAKs sent by the receiver transport.
@throws LBMException if any error occurred retrieving receiver statistics.

### lost

```java
public long lost() throws LBMException
```

Number of datagrams that have been detected as lost. (LBT-RM only).
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams that have been detected as lost
@throws LBMException if any error occurred retrieving receiver statistics.

### lost

```java
public long lost(int n) throws LBMException
```

Number of datagrams that have been detected as lost. (LBT-RM only).
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagrams that have been detected as lost
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsIgnored

```java
public long ncfsIgnored() throws LBMException
```

Number of NCFs received from a source transport with reason code "ignored" (LBT-RM
only).
If a source transport receives a NAK for a datagram that it has recently retransmitted,
it sends an "NCF ignored" and does not retransmit. How "recently" is determined by the
configuration option source transport_lbtrm_ignore_interval (default 500ms). If this
count is high, a receiver transport may be having trouble receiving retransmissions, or
the ignore interval may be set too long.
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of NCFs received from a source transport with the reason
    code set to "ignored".
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsIgnored

```java
public long ncfsIgnored(int n) throws LBMException
```

Number of NCFs received from a source transport with reason code "ignored" (LBT-RM
only).
If a source transport receives a NAK for a datagram that it has recently retransmitted,
it sends an "NCF ignored" and does not retransmit. How "recently" is determined by the
configuration option source transport_lbtrm_ignore_interval (default 500ms). If this
count is high, a receiver transport may be having trouble receiving retransmissions, or
the ignore interval may be set too long.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of NCFs received from a source transport with the reason
    code set to "ignored".
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsShed

```java
public long ncfsShed() throws LBMException
```

Number of NCFs received with reason code "shed" (LBT-RM only).
When a source transport's retransmit queue and rate limiter are both at maximum, it
responds to a NAK by sending an "NCF shed", and does not retransmit. The receiver
transport should wait, then send another NAK. If this count is high, one or more crybaby
receiver transports may be clogging the source transport's retransmit queue.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@return Number of NCFs that have been received with the reason code set to "shed"
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsShed

```java
public long ncfsShed(int n) throws LBMException
```

Number of NCFs received with reason code "shed" (LBT-RM only).
When a source transport's retransmit queue and rate limiter are both at maximum, it
responds to a NAK by sending an "NCF shed", and does not retransmit. The receiver
transport should wait, then send another NAK. If this count is high, one or more crybaby
receiver transports may be clogging the source transport's retransmit queue.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of NCFs that have been received with the reason code set to "shed"
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsRetransmissionDelay

```java
public long ncfsRetransmissionDelay() throws LBMException
```

Number of NCFs received with reason code "rx_delay" (LBT-RM only).
When a source transport's retransmit rate limiter prevents it from immediately
retransmitting any more lost datagrams, it responds to a NAK by sending an "NCF
rx_delay", then queues the retransmission for a later send. The receiver transport
should wait for the retransmission and not immediately send another NAK. If this count
is high, one or more crybaby receiver transports may be clogging the source transport's
retransmit queue.
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of NCFs that have been received with the reason
    code set to "rx_delay".
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsRetransmissionDelay

```java
public long ncfsRetransmissionDelay(int n) throws LBMException
```

Number of NCFs received with reason code "rx_delay" (LBT-RM only).
When a source transport's retransmit rate limiter prevents it from immediately
retransmitting any more lost datagrams, it responds to a NAK by sending an "NCF
rx_delay", then queues the retransmission for a later send. The receiver transport
should wait for the retransmission and not immediately send another NAK. If this count
is high, one or more crybaby receiver transports may be clogging the source transport's
retransmit queue.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of NCFs received with reason code "rx_delay"
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsUnknown

```java
public long ncfsUnknown() throws LBMException
```

Number of NCFs received with reason code "unknown" (LBT-RM only).
These are NCFs with a reason code this receiver transport does not recognize. After a
delay (set by configuration option transport_lbtrm_nak_suppress_interval (default
1000ms), it resends the NAK. This counter should never be greater than 0 unless
applications linked with different versions of Ultra Messaging software coexist on the
same network.
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of NCFs that have been received with the reason
    code set to "unknown".
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsUnknown

```java
public long ncfsUnknown(int n) throws LBMException
```

Number of NCFs received with reason code "unknown" (LBT-RM only).
These are NCFs with a reason code this receiver transport does not recognize. After a
delay (set by configuration option transport_lbtrm_nak_suppress_interval (default
1000ms), it resends the NAK. This counter should never be greater than 0 unless
applications linked with different versions of Ultra Messaging software coexist on the
same network.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of NCFs that have been received with the reason
    code set to "unknown".
@throws LBMException if any error occurred retrieving receiver statistics.

### minimumRecoveryTime

```java
public long minimumRecoveryTime() throws LBMException
```

Minimum time (in milliseconds), i.e., the shortest time recorded so far, for  a lost
message to be recovered (LBT-RM only).
If this time is greater than configuration option transport_lbtrm_nak_backoff_interval,
it may be taking multiple NAKs to initiate retransmissions, indicating a lossy network.
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Minimum time (in milliseconds) in which loss recovery was accomplished
@throws LBMException if any error occurred retrieving receiver statistics.

### minimumRecoveryTime

```java
public long minimumRecoveryTime(int n) throws LBMException
```

Minimum time (in milliseconds), i.e., the shortest time recorded so far, for  a lost
message to be recovered (LBT-RM only).
If this time is greater than configuration option transport_lbtrm_nak_backoff_interval,
it may be taking multiple NAKs to initiate retransmissions, indicating a lossy network.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Minimum time (in milliseconds) in which loss recovery was accomplished
@throws LBMException if any error occurred retrieving receiver statistics.

### meanRecoveryTime

```java
public long meanRecoveryTime() throws LBMException
```

Mean time (in milliseconds) in which loss recovery was accomplished (LBT-RM only).
This is an exponentially weighted moving average (weighted to more recent) for
accumulated measured recovery times. Ideally this field should be as close to your
minimum recovery time (nak_stm_min, above) as possible. High mean recovery times
indicate a lossy network.
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Mean time (in milliseconds) in which loss recovery was accomplished
@throws LBMException if any error occurred retrieving receiver statistics.

### meanRecoveryTime

```java
public long meanRecoveryTime(int n) throws LBMException
```

Mean time (in milliseconds) in which loss recovery was accomplished (LBT-RM only).
This is an exponentially weighted moving average (weighted to more recent) for
accumulated measured recovery times. Ideally this field should be as close to your
minimum recovery time (nak_stm_min, above) as possible. High mean recovery times
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Mean time (in milliseconds) in which loss recovery was accomplished
@throws LBMException if any error occurred retrieving receiver statistics.

### maximumRecoveryTime

```java
public long maximumRecoveryTime() throws LBMException
```

Maximum time (in milliseconds), i.e., the longest time recorded so far, for a lost
message to be recovered (LBT-RM only).
If this time is near or equal to the configuration option
transport_lbtrm_nak_generation_interval setting, you have likely experienced some level
of unrecoverable loss.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Maximum time (in milliseconds) in which loss recovery was accomplished
@throws LBMException if any error occurred retrieving receiver statistics.

### maximumRecoveryTime

```java
public long maximumRecoveryTime(int n) throws LBMException
```

Maximum time (in milliseconds), i.e., the longest time recorded so far, for a lost
message to be recovered (LBT-RM only).
If this time is near or equal to the configuration option
transport_lbtrm_nak_generation_interval setting, you have likely experienced some level
of unrecoverable loss.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Maximum time (in milliseconds) in which loss recovery was accomplished
@throws LBMException if any error occurred retrieving receiver statistics.

### minimumNakTransmissions

```java
public long minimumNakTransmissions() throws LBMException
```

Minimum number of times per lost message that a receiver transport transmitted a NAK,
i.e., the lowest value collected so far (LBT-RM only).
A value greater than 1 indicates a chronically lossy network.
    This method returns a value from the first
set of statistics encapsulated within this object.
@return  Minimum number of times per lost message that a receiver transport transmitted
a NAK.
@throws LBMException if any error occurred retrieving receiver statistics.

### minimumNakTransmissions

```java
public long minimumNakTransmissions(int n) throws LBMException
```

Minimum number of times per lost message that a receiver transport transmitted a NAK,
i.e., the lowest value collected so far (LBT-RM only).
A value greater than 1 indicates a chronically lossy network.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return  Minimum number of times per lost message that a receiver transport transmitted
a NAK.
@throws LBMException if any error occurred retrieving receiver statistics.

### meanNakTransmissions

```java
public long meanNakTransmissions() throws LBMException
```

Mean number of times per lost message that a receiver transport transmitted a NAK
(LBT-RM only).
Ideally this should be at or near 1. A higher value indicates a lossy network. This is
an exponentially weighted moving average (weighted to more recent) for accumulated NAKs
per lost message.
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Mean number of times per lost message that a receiver transport transmitted a
NAK
@throws LBMException if any error occurred retrieving receiver statistics.

### meanNakTransmissions

```java
public long meanNakTransmissions(int n) throws LBMException
```

Mean number of times per lost message that a receiver transport transmitted a NAK
(LBT-RM only).
Ideally this should be at or near 1. A higher value indicates a lossy network. This is
an exponentially weighted moving average (weighted to more recent) for accumulated NAKs
per lost message.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Mean number of times per lost message that a receiver transport transmitted a
NAK
@throws LBMException if any error occurred retrieving receiver statistics.

### maximumNakTransmissions

```java
public long maximumNakTransmissions() throws LBMException
```

Maximum number of times per lost message that a receiver transport transmitted a NAK,
i.e., the highest value collected so far (LBT-RM only).
A value higher than 1 suggests that there may have been some unrecoverable loss on the
network during the sample period. A significantly high value compared to the mean
number) implies an isolated incident.
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Maximum number of times per lost message that a receiver transport transmitted a
NAK
    transmitted.
@throws LBMException if any error occurred retrieving receiver statistics.

### maximumNakTransmissions

```java
public long maximumNakTransmissions(int n) throws LBMException
```

Maximum number of times per lost message that a receiver transport transmitted a NAK,
i.e., the highest value collected so far (LBT-RM only).
A value higher than 1 suggests that there may have been some unrecoverable loss on the
network during the sample period. A significantly high value compared to the mean
number) implies an isolated incident.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Maximum number of times per lost message that a receiver transport transmitted a
NAK
@throws LBMException if any error occurred retrieving receiver statistics.

### duplicateMessages

```java
public long duplicateMessages() throws LBMException
```

Number of duplicate datagrams received (LBT-RM only).
A large number can indicate a lossy network, primarily due to other receiver transports
requesting retransmissions that this receiver transport has already successfully
received. Such duplicates require extra effort for filtering, and this should be
investigated.
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of duplicate datagrams received
@throws LBMException if any error occurred retrieving receiver statistics.

### duplicateMessages

```java
public long duplicateMessages(int n) throws LBMException
```

Number of duplicate datagrams received (LBT-RM only).
A large number can indicate a lossy network, primarily due to other receiver transports
requesting retransmissions that this receiver transport has already successfully
received. Such duplicates require extra effort for filtering, and this should be
investigated.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of duplicate datagrams received
@throws LBMException if any error occurred retrieving receiver statistics.

### unrecoveredMessagesWindowAdvance

```java
public long unrecoveredMessagesWindowAdvance() throws LBMException
```

Number of datagrams unrecovered (LBM_MSG_UNRECOVERABLE_LOSS delivered to receiver
application) due to transmission window advance (LBT-RM only).
This means that the message was no longer in the source-side transmission window and
therefore not retransmitted. The window size is set by transport configuration option
lbtrm_transmission_window_size (default 24MB).
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams unrecovered due to transmission window advance
@throws LBMException if any error occurred retrieving receiver statistics.

### unrecoveredMessagesWindowAdvance

```java
public long unrecoveredMessagesWindowAdvance(int n) throws LBMException
```

Number of datagrams unrecovered (LBM_MSG_UNRECOVERABLE_LOSS delivered to receiver
application) due to transmission window advance (LBT-RM only).
This means that the message was no longer in the source-side transmission window and
therefore not retransmitted. The window size is set by transport configuration option
lbtrm_transmission_window_size (default 24MB).
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagrams unrecovered due to transmission window advance
@throws LBMException if any error occurred retrieving receiver statistics.

### unrecoveredMessagesNakGenerationTimeout

```java
public long unrecoveredMessagesNakGenerationTimeout() throws LBMException
```

Number of LBT-RM datagrams unrecovered due to a retransmission not received within the
NAK generation interval (LBT-RM only).
This is set by configuration option transport_lbtrm_nak_generation_interval; default
10,000ms. Note: Receivers for these messages' topics will also report related messages
as unrecoverable, with LBM_MSG_UNRECOVERABLE_LOSS for an individual message and
LBM_MSG_UNRECOVERABLE_LOSS_BURST for a burst loss event. However, it is possible for
these application-level message declarations to occur even without increments to this
counter, as the transport is unaware of the topic content of messages and may still be
trying to deliver related lost packets.
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of LBT-RM datagrams unrecovered due to a retransmission not received
within the NAK generation interval
@throws LBMException if any error occurred retrieving receiver statistics.

### unrecoveredMessagesNakGenerationTimeout

```java
public long unrecoveredMessagesNakGenerationTimeout(int n) throws LBMException
```

Number of LBT-RM datagrams unrecovered due to a retransmission not received within the
NAK generation interval (LBT-RM only).
This is set by configuration option transport_lbtrm_nak_generation_interval; default
10,000ms. Note: Receivers for these messages' topics will also report related messages
as unrecoverable, with LBM_MSG_UNRECOVERABLE_LOSS for an individual message and
LBM_MSG_UNRECOVERABLE_LOSS_BURST for a burst loss event. However, it is possible for
these application-level message declarations to occur even without increments to this
counter, as the transport is unaware of the topic content of messages and may still be
trying to deliver related lost packets.
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of LBT-RM datagrams unrecovered due to a retransmission not received
within the NAK generation interval
@throws LBMException if any error occurred retrieving receiver statistics.

### lbmMessagesReceived

```java
public long lbmMessagesReceived() throws LBMException
```

Number of messages or message fragments received over a transport (TCP, LBT-RM).
A single datagram may contain one or more messages or a fragment of a larger message.
For fragmented messages larger than the transport's maximum size configuration option,
this count reflects the number of datagrams used to constitute those messages. Thus,
this number is equal to or greater than the datagram counter (messagesReceived, above).
This number also includes messages received for which there was no interested receiver,
tallied in the noTopicMessagesReceived counter (below).
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of messages or message fragments received over a transport
@throws LBMException if any error occurred retrieving receiver statistics.

### lbmMessagesReceived

```java
public long lbmMessagesReceived(int n) throws LBMException
```

Number of messages or message fragments received over a transport (TCP, LBT-RM).
A single datagram may contain one or more messages or a fragment of a larger message.
For fragmented messages larger than the transport's maximum size configuration option,
this count reflects the number of datagrams used to constitute those messages. Thus,
this number is equal to or greater than the datagram counter (messagesReceived, above).
This number also includes messages received for which there was no interested receiver,
tallied in the noTopicMessagesReceived counter (below).
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of messages or message fragments received over a transport
@throws LBMException if any error occurred retrieving receiver statistics.

### lbmRequestsReceived

```java
public long lbmRequestsReceived() throws LBMException
```

Number of UM request messages received (message type LBM_MSG_REQUEST) (TCP, LBT-RM).
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of UM request messages received (message type LBM_MSG_REQUEST)
@throws LBMException if any error occurred retrieving receiver statistics.

### lbmRequestsReceived

```java
public long lbmRequestsReceived(int n) throws LBMException
```

Number of UM request messages received (message type LBM_MSG_REQUEST) (TCP, LBT-RM).
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of UM request messages received (message type LBM_MSG_REQUEST)
@throws LBMException if any error occurred retrieving receiver statistics.

### noTopicMessagesReceived

```java
public long noTopicMessagesReceived() throws LBMException
```

Number of messages received that were not for a topic of interest to the receiver
(TCP, LBT-RM).
A high value (relative to, or approaching lbmMessagesReceived above) indicates more CPU
time required to filter out uninteresting topics, in which case, consider reconfiguring
sources to filter more aggressively at the transport layer.
    This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of messages received that were not for a topic of interest to the
receiver
@throws LBMException if any error occurred retrieving receiver statistics.

### noTopicMessagesReceived

```java
public long noTopicMessagesReceived(int n) throws LBMException
```

Number of messages received that were not for a topic of interest to the receiver
(TCP, LBT-RM).
A high value (relative to, or approaching lbmMessagesReceived above) indicates more CPU
time required to filter out uninteresting topics, in which case, consider reconfiguring
sources to filter more aggressively at the transport layer.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of messages received that were not for a topic of interest to the receiver
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedIncorrectSize

```java
public long datagramsDroppedIncorrectSize() throws LBMException
```

Number of datagrams discarded due to being smaller than the size designated in the
datagram's size field.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams discarded due to size
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedIncorrectSize

```java
public long datagramsDroppedIncorrectSize(int n) throws LBMException
```

Number of datagrams discarded due to being smaller than the size designated in the
datagram's size field.
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagrams discarded due to size
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedType

```java
public long datagramsDroppedType() throws LBMException
```

Number of datagrams discarded due to bad packet type.
The datagram's type field must match the expectations of the receiver transport.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams discarded due to bad packet type
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedType

```java
public long datagramsDroppedType(int n) throws LBMException
```

Number of datagrams discarded due to bad packet type.
The datagram's type field must match the expectations of the receiver transport.
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagrams discarded due to bad packet type
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedVersion

```java
public long datagramsDroppedVersion() throws LBMException
```

Number of datagrams discarded due to version mismatch.
The datagram's version field must match the expectations of the receiver transport.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams discarded due to version mismatch
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedVersion

```java
public long datagramsDroppedVersion(int n) throws LBMException
```

Number of datagrams discarded due to version mismatch.
The datagram's version field must match the expectations of the receiver transport.
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagrams discarded due to version mismatch
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedHeader

```java
public long datagramsDroppedHeader() throws LBMException
```

Number of datagrams discarded due to bad header type.
These datagrams appeared to be intact, but with an unrecognizable header format.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams discarded due to bad header type
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedHeader

```java
public long datagramsDroppedHeader(int n) throws LBMException
```

Number of datagrams discarded due to bad header type.
These datagrams appeared to be intact, but with an unrecognizable header format.
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagrams discarded due to bad header type
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedOther

```java
public long datagramsDroppedOther() throws LBMException
```

Number of unrecognizable datagrams discarded due to reasons other than those
determined by the above counts.
They could be garbled, or possibly be from foreign or
incompatible software at the other end.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams discarded for other reasons
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedOther

```java
public long datagramsDroppedOther(int n) throws LBMException
```

Number of unrecognizable datagrams discarded due to reasons other than those
determined by the above counts.
They could be garbled, or possibly be from foreign or
incompatible software at the other end.
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagrams discarded for other reasons
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedSID

```java
public long datagramsDroppedSID() throws LBMException
```

Number of datagrams discarded due to session ID mismatch.
These datagrams appeared to be correctly formed, but with an unmatched/unrecognized
session ID field.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams discarded due to session ID mismatch
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedSID

```java
public long datagramsDroppedSID(int n) throws LBMException
```

Number of datagrams discarded due to session ID mismatch.
These datagrams appeared to be correctly formed, but with an unmatched/unrecognized
session ID field.
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagrams discarded due to session ID mismatch
@throws LBMException if any error occurred retrieving receiver statistics.

### outOfOrder

```java
public long outOfOrder() throws LBMException
```

Number of out-of-order datagrams received.
A datagram is counted as out of order if it fills a previously detected sequence gap,
but is not a retransmission. Note that if the duplicates counter duplicate_data,
above) increases along with this statistic, this implies the arrivals of
retransmitted datagrams before their originals.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of out-of-order datagrams received
@throws LBMException if any error occurred retrieving receiver statistics.

### outOfOrder

```java
public long outOfOrder(int n) throws LBMException
```

Number of out-of-order datagrams received.
A datagram is counted as out of order if it fills a previously detected sequence gap,
but is not a retransmission. Note that if the duplicates counter duplicate_data,
above) increases along with this statistic, this implies the arrivals of
retransmitted datagrams before their originals.
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of out-of-order datagrams received
@throws LBMException if any error occurred retrieving receiver statistics.

## LBMImmediateMessageSourceStatistics

*class* `com.latencybusters.lbm.LBMImmediateMessageSourceStatistics`

### LBMImmediateMessageSourceStatistics

```java
public LBMImmediateMessageSourceStatistics()
```

Instantiate an empty object containing no statistics.

### LBMImmediateMessageSourceStatistics

```java
public LBMImmediateMessageSourceStatistics(UMMonAttributes attributes, SourceTransport srcStats) throws LBMException
```

Instantiate object containing the set of IM source transport statistics
for a given IM source.
@param attributes An UMMonAttributesProtos.UMMonAttributes
@param srcStats An UMSMonProtos.SrcTransportStats
@throws LBMException if any error occurred retrieving source statistics.

### LBMImmediateMessageSourceStatistics

```java
public LBMImmediateMessageSourceStatistics(LBMMonitorReceiver lbmmonrcv, ByteBuffer attributeBuffer, ByteBuffer srcStats) throws LBMException
```

Instantiate object containing the set of source transport statistics
for a given source transport.

@param lbmmonrcv  LBMMonitorReceiver that received this packet.
@param attributeBuffer A ByteBuffer of packet attributes passed to the passthrough callback
@param srcStats   A ByteBuffer of CSV statistics passed to the passthrough callback
@throws LBMException if any error occurred retrieving source statistics.

### LBMImmediateMessageSourceStatistics

```java
public LBMImmediateMessageSourceStatistics(LBMContext lbmctx, int maxStats) throws LBMException
```

Instantiate object containing the aggregate set of statistics
for a particular context.
This constructor will throw LBMMonitorEInvalException if maxStats
is less than the available number of transport statistical sets.
@param lbmctx LBMContext object
@param maxStats Maximum number of sources
@throws LBMException if any error occurred retrieving immediate message source statistics.
@see #refresh

### refresh

```java
public void refresh(LBMContext lbmctx, int maxStats) throws LBMException
```

Refresh the aggregate set of statistics for a particular context.
This method will throw LBMMonitorEInvalException if maxStats
is less than the available number of transport statistical sets.
@param lbmctx LBMContext object associated with statistics to be retrieved.
@param maxStats Maximum number of statistical sets to retrieve.
@throws LBMException if any error occurred retrieving statistics.

### dispose

```java
public void dispose()
```

Free memory associated with this set of statistics.

### size

```java
public int size()
```

Number of transport statistical sets encapsulated within this object
@return Statistical set size

### type

```java
public int type() throws LBMException
```

Transport type (TCP, LBT-RM, etc.).
This method returns a value from the first
set of statistics encapsulated within this object.
@return Transport type
@throws LBMException if any error occurred retrieving source statistics.
@see LBM

### type

```java
public int type(int n) throws LBMException
```

Transport type (TCP, LBT-RM, etc.).
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Transport type
@throws LBMException if any error occurred retrieving source statistics.
@see LBM

### typeName

```java
public String typeName() throws LBMException
```

Transport type name (TCP, LBT-RM, etc.).
This method returns a value from the first
set of statistics encapsulated within this object.
@return Transport type name
@throws LBMException if any error occurred retrieving statistics.

### typeName

```java
public String typeName(int n) throws LBMException
```

Transport type name (TCP, LBT-RM, etc.).
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Transport type name
@throws LBMException if any error occurred retrieving source statistics.

### source

```java
public String source() throws LBMException
```

Source of transport as a string.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
This method returns a value from the first
set of statistics encapsulated within this object
@see LBMTransportSourceInfo
@return Source of transport as a string
@throws LBMException if any error occurred retrieving statistics.

### source

```java
public String source(int n) throws LBMException
```

Source of transport as a string.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
This method returns a value from the nth set of statistics
encapsulated within this object.
@see LBMTransportSourceInfo
@param n Statistics set index
@return Source of transport as a string
@throws LBMException if any error occurred retrieving source statistics.

### numberOfClients

```java
public long numberOfClients() throws LBMException
```

Number of receiver clients currently connected over this transport (TCP only).
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of receiver clients currently connected over this transport
@throws LBMException if any error occurred retrieving source statistics.

### numberOfClients

```java
public long numberOfClients(int n) throws LBMException
```

Number of receiver clients currently connected over this transport (TCP only).
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of receiver clients currently connected over this transport
@throws LBMException if any error occurred retrieving source statistics.

### bytesBuffered

```java
public long bytesBuffered() throws LBMException
```

Number of bytes currently in UM's TCP buffer, i.e., a snapshot (TCP only).
This count is affected by the number of receivers,and configuration options
transport_tcp_multiple_receiver_behavior and transport_session_maximum_buffer.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of bytes currently in UM's TCP buffer
@throws LBMException if any error occurred retrieving source statistics.

### bytesBuffered

```java
public long bytesBuffered(int n) throws LBMException
```

Number of bytes currently in UM's TCP buffer, i.e., a snapshot (TCP only).
This count is affected by the number of receivers,and configuration options
transport_tcp_multiple_receiver_behavior and transport_session_maximum_buffer.
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of bytes currently in UM's TCP buffer
@throws LBMException if any error occurred retrieving source statistics.

### messagesSent

```java
public long messagesSent() throws LBMException
```

Number of datagrams sent (LBT-RM only).
Depending on batching settings, a single datagram may contain one or more messages, or a
fragment of a larger message. With LBT-RM, larger messages are split into fragment sizes
limited by configuration option transport_lbtrm_datagram_max_size (default 8KB).
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams sent
@throws LBMException if any error occurred retrieving source statistics.

### messagesSent

```java
public long messagesSent(int n) throws LBMException
```

Number of datagrams sent (LBT-RM only).
Depending on batching settings, a single datagram may contain one or more messages, or a
fragment of a larger message. With LBT-RM, larger messages are split into fragment sizes
limited by configuration option transport_lbtrm_datagram_max_size (default 8KB).
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of datagrams sent
@throws LBMException if any error occurred retrieving source statistics.

### bytesSent

```java
public long bytesSent() throws LBMException
```

Number of datagram bytes sent (LBT-RM only).
This is the total of lengths of all LBT-RM packets, including UM header information.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagram bytes sent
@throws LBMException if any error occurred retrieving source statistics.

### bytesSent

```java
public long bytesSent(int n) throws LBMException
```

Number of datagram bytes sent (LBT-RM only).
This is the total of lengths of all LBT-RM packets, including UM header information.
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of datagram bytes sent
@throws LBMException if any error occurred retrieving source statistics.

### transmissionWindowMessages

```java
public long transmissionWindowMessages() throws LBMException
```

Number of datagrams in the transmission window (LBT-RM only).
Each source transport session maintains a transmission window buffer (the size of which
is set by transport_lbtrm_transmission_window_size, default 24MB). When the source
transport receives a NAK, the corresponding message for retransmission must be found in
this transmission window.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams in the transmission window
@throws LBMException if any error occurred retrieving source statistics.

### transmissionWindowMessages

```java
public long transmissionWindowMessages(int n) throws LBMException
```

Number of datagrams in the transmission window (LBT-RM only).
Each source transport session maintains a transmission window buffer (the size of which
is set by transport_lbtrm_transmission_window_size, default 24MB). When the source
transport receives a NAK, the corresponding message for retransmission must be found in
this transmission window.
This method returns a value from the first
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of datagrams in the transmission window
@throws LBMException if any error occurred retrieving source statistics.

### transmissionWindowBytes

```java
public long transmissionWindowBytes() throws LBMException
```

Number of bytes currently in the transmission window (LBT-RM only).
Typically, this count approaches its window size or exceeds it by a small amount.
See #transmissionWindowMessages for a description of the transmission window.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of bytes currently in the transmission window
@throws LBMException if any error occurred retrieving source statistics.

### transmissionWindowBytes

```java
public long transmissionWindowBytes(int n) throws LBMException
```

Number of bytes currently in the transmission window (LBT-RM only).
Typically, this count approaches its window size or exceeds it by a small amount.
See #transmissionWindowMessages for a description of the transmission window.
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of bytes currently in the transmission window
@throws LBMException if any error occurred retrieving source statistics.

### nakPacketsReceived

```java
public long nakPacketsReceived() throws LBMException
```

Number of NAK packets received by this source transport (LBT-RM only).
UM batches NAKs into NAK packets to save network bandwidth. This should always be less
than or equal to naksReceived (below).
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of NAK packets received by this source transport
@throws LBMException if any error occurred retrieving source statistics.

### nakPacketsReceived

```java
public long nakPacketsReceived(int n) throws LBMException
```

Number of NAK packets received by this source transport (LBT-RM only).
UM batches NAKs into NAK packets to save network bandwidth. This should always be less
than or equal to naksReceived (below).
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of NAK packets received by this source transport
@throws LBMException if any error occurred retrieving source statistics.

### naksReceived

```java
public long naksReceived() throws LBMException
```

Number of individual NAKs received by the source transport (LBT-RM only).
When a source transport receives a NAK from a receiver transport, it may respond by
re-transmitting the requested LBT-RM datagram, or it may send an NCF. The NAKing
receiver transport responds to the NCF by waiting (timeout set by
transport_lbtrm_nak_suppress_interval, default 1000 ms), then re-sending the NAK.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of individual NAKs received by the source transport
@throws LBMException if any error occurred retrieving source statistics.

### naksReceived

```java
public long naksReceived(int n) throws LBMException
```

Number of individual NAKs received by the source transport (LBT-RM only).
When a source transport receives a NAK from a receiver transport, it may respond by
re-transmitting the requested LBT-RM datagram, or it may send an NCF. The NAKing
receiver transport responds to the NCF by waiting (timeout set by
transport_lbtrm_nak_suppress_interval, default 1000 ms), then re-sending the NAK.
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of individual NAKs received by the source transport
@throws LBMException if any error occurred retrieving source statistics.

### naksIgnored

```java
public long naksIgnored() throws LBMException
```

Number of NAKs the source ignored and sent an NCF with reason code "ignored"
(LBT-RM only).
A source transport ignores a NAK for a datagram it has already recently retransmitted.
How "recently" is determined by the configuration option source
transport_lbtrm_ignore_interval (default 500ms). If this count is high, a receiver
transport may be having trouble receiving retransmissions, or the ignore interval may be
set too long.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of NAKs the source ignored and sent an NCF with reason code "ignored"
@throws LBMException if any error occurred retrieving source statistics.

### naksIgnored

```java
public long naksIgnored(int n) throws LBMException
```

Number of NAKs the source ignored and sent an NCF with reason code
"ignored" (LBT-RM only).
A source transport ignores a NAK for a datagram it has already recently retransmitted.
How "recently" is determined by the configuration option source
transport_lbtrm_ignore_interval (default 500ms). If this count is high, a receiver
transport may be having trouble receiving retransmissions, or the ignore interval may be
set too long.
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of NAKs the source ignored and sent an NCF with reason code "ignored"
@throws LBMException if any error occurred retrieving source statistics.

### naksShed

```java
public long naksShed() throws LBMException
```

Number of NAKs this source shed and sent an NCF with reason code "shed"
(LBT-RM only).
When a source transport's retransmit rate limiter and retransmit queue are both at
maximum, it responds to a NAK by sending an "NCF shed", and does not retransmit. The
receiver transport should wait, then send another NAK. If this count is high, one or
more crybaby receiver transports may be clogging the source transport's retransmit
queue.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of NAKs this source shed and sent an NCF with reason code "shed"
@throws LBMException if any error occurred retrieving source statistics.

### naksShed

```java
public long naksShed(int n) throws LBMException
```

Number of NAKs this source shed and sent an NCF with reason code "shed"
(LBT-RM only).
When a source transport's retransmit rate limiter and retransmit queue are both at
maximum, it responds to a NAK by sending an "NCF shed", and does not retransmit. The
receiver transport should wait, then send another NAK. If this count is high, one or
more crybaby receiver transports may be clogging the source transport's retransmit
queue.
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of NAKs this source shed and sent an NCF with reason code "shed"
@throws LBMException if any error occurred retrieving source statistics.

### naksIgnoredRetransmitDelay

```java
public long naksIgnoredRetransmitDelay() throws LBMException
```

Number of NAKs this source did not process because doing so would exceed its retransmit
rate limit (LBT-RM only).
This rate limit is set by configuration option transport_lbtrm_retransmit_rate_limit
(default 5Mbps). For each of these NAKs, the source transport immediately sends an NFC
rx_delay, then queues the retransmission for a later send within the rate limit. If this
count is high, one or more crybaby receiver transports may be clogging the source
transport's retransmit queue.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of NAKs this source transport has not processed because it met its
retransmission rate limit
@throws LBMException if any error occurred retrieving source statistics.

### naksIgnoredRetransmitDelay

```java
public long naksIgnoredRetransmitDelay(int n) throws LBMException
```

Number of NAKs this source did not process because doing so would exceed its retransmit
rate limit (LBT-RM only).
This rate limit is set by configuration option transport_lbtrm_retransmit_rate_limit
(default 5Mbps). For each of these NAKs, the source transport immediately sends an NFC
rx_delay, then queues the retransmission for a later send within the rate limit. If this
count is high, one or more crybaby receiver transports may be clogging the source
transport's retransmit queue.
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of NAKs this source transport has not processed because it met its
retransmission rate limit
@throws LBMException if any error occurred retrieving source statistics.

### retransmissionsSent

```java
public long retransmissionsSent() throws LBMException
```

Number of datagrams retransmitted by this source transport (LBT-RM only).
This count is incremented under the same circumstances as retransmissionBytesSent,
below. In a normal, light-loss scenario, most NAKs received induce a retransmission.
When losses become heavy and/or many receiver transports begin losing the same
datagrams, NCF-related no-retransmit counts (naksIgnored, naksShed and
naksIgnoredRetransmitDelay) may begin to inflate, and retransmissions
retransmissionsSent) may become significantly lower than NAKS received (naksReceived).
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams retransmitted by this source
@throws LBMException if any error occurred retrieving source statistics.

### retransmissionsSent

```java
public long retransmissionsSent(int n) throws LBMException
```

Number of datagrams retransmitted by this source transport (LBT-RM only).
This count is incremented under the same circumstances as retransmissionBytesSent,
below. In a normal, light-loss scenario, most NAKs received induce a retransmission.
When losses become heavy and/or many receiver transports begin losing the same
datagrams, NCF-related no-retransmit counts (naksIgnored, naksShed and
naksIgnoredRetransmitDelay) may begin to inflate, and retransmissions
retransmissionsSent) may become significantly lower than NAKS received (naksReceived).
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of datagrams retransmitted by this source
@throws LBMException if any error occurred retrieving source statistics.

### messagesQueued

```java
public long messagesQueued() throws LBMException
```

Number of datagrams currently queued by the data rate limiter (LBT-RM only).
When a source transport attempts to send messages (any type) faster than its data rate
limiter allows (set by configuration option transport_lbtrm_data_rate_limit, default
10Mbps), the data rate limiter queues the messages until they can be sent within the
data rate limit.
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams currently queued by the data rate limiter
@throws LBMException if any error occurred retrieving source statistics.

### messagesQueued

```java
public long messagesQueued(int n) throws LBMException
```

Number of datagrams currently queued by the data rate limiter (LBT-RM only).
When a source transport attempts to send messages (any type) faster than its data rate
limiter allows (set by configuration option transport_lbtrm_data_rate_limit, default
10Mbps), the data rate limiter queues the messages until they can be sent within the
data rate limit.
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of datagrams currently queued by the data rate limiter
@throws LBMException if any error occurred retrieving source statistics.

### retransmissionsQueued

```java
public long retransmissionsQueued() throws LBMException
```

Number of retransmission datagrams currently queued by the retransmit
rate limiter (LBT-RM only).
When a source transport attempts to send retransmissions faster that its
retransmit rate limiter allows (set by configuration option
transport_lbtrm_retransmit_rate_limit, default 5Mbps), the retransmit rate limiter
queues retransmissions until they can be sent within the rate limit.
naks_rx_delay_ignored (above) will generally also rise if this count is high
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of datagrams currently queued by the retransmit rate limiter
@throws LBMException if any error occurred retrieving source statistics.

### retransmissionsQueued

```java
public long retransmissionsQueued(int n) throws LBMException
```

Number of retransmission datagrams currently queued by the retransmit
rate limiter (LBT-RM only).
When a source transport attempts to send retransmissions faster that its
retransmit rate limiter allows (set by configuration option
transport_lbtrm_retransmit_rate_limit, default 5Mbps), the retransmit rate limiter
queues retransmissions until they can be sent within the rate limit.
naks_rx_delay_ignored (above) will generally also rise if this count is high
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of datagrams currently queued by the retransmit rate limiter
@throws LBMException if any error occurred retrieving source statistics.

### retransmissionBytesSent

```java
public long retransmissionBytesSent() throws LBMException
```

Total number of bytes retransmitted by this source transport (LBT-RM only).
This count is triggered under the same circumstances as retransmissionsSent, above. In a
normal, light-loss scenario, most NAKs received induce a retransmission. When losses
become heavy and/or many receiver transports begin losing the same datagrams,
NCF-related no-retransmit counts (naksIgnored, naksShed and naksIgnoredRetransmitDelay)
may begin to inflate, and retransmissions retransmissionsSent) may become significantly
lower than NAKs received (naksReceived).
This method returns a value from the first
set of statistics encapsulated within this object.
@return Number of transport bytes retransmitted by this source
@throws LBMException if any error occurred retrieving source statistics.

### retransmissionBytesSent

```java
public long retransmissionBytesSent(int n) throws LBMException
```

Total number of bytes retransmitted by this source transport (LBT-RM only).
This count is triggered under the same circumstances as retransmissionsSent, above. In a
normal, light-loss scenario, most NAKs received induce a retransmission. When losses
become heavy and/or many receiver transports begin losing the same datagrams,
NCF-related no-retransmit counts (naksIgnored, naksShed and naksIgnoredRetransmitDelay)
may begin to inflate, and retransmissions retransmissionsSent) may become significantly
lower than NAKs received (naksReceived).
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Number of transport bytes retransmitted by this source
@throws LBMException if any error occurred retrieving source statistics.

## LBMLogging

*interface* `com.latencybusters.lbm.LBMLogging`

### LBMLog

```java
void LBMLog(int level, String message)
```

Log a message
@param level LBM Logging level, where values can be (in order of decreasing importance):
        <ul>
        <li>LBM.LOG_EMERG
        <li>LBM.LOG_ALERT
        <li>LBM.LOG_CRIT
        <li>LBM.LOG_ERR
        <li>LBM.LOG_WARNING
        <li>LBM.LOG_NOTICE
        <li>LBM.LOG_INFO
        <li>LBM.LOG_DEBUG
        </ul>
@param message Message to be logged

## LBMMessage

*class* `com.latencybusters.lbm.LBMMessage`

### promote

```java
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
See \ref javamessagereception.

Note that this creates a new object, so delivery is no longer
"zero object".

\note the message must be promoted <i>before</i> being made available to
the other parts of the application.
For example, it would not be legal for a separate thread to start
processing the message before the receiver callback called promote.

\warning promote() is NOT thread safe;
do not call it on the same message from multiple threads at the same time.

@return The promoted message. This will be a new message object, not
the message object passed into the receiver callback.

### getMessagesBuffer

```java
public ByteBuffer getMessagesBuffer()
```

Return a DirectByteBuffer view of the entire transport if this message has not been promoted.
The buffer has its position and limit values set to where the message data begins and ends. Only
this portion of the buffer is valid for this message. The purpose is to provide zero copy
access to the message data.
This is different than {@link #dataBuffer()} which has message data always starting at position 0.
If {@link #dataBuffer()} is called on an smx transport message, the message data is copied from
the transport into another buffer to preserve these semantics.
<p>
If the application has called {@link #promote()} on this message, the view of the transport is no longer
valid and the data has been copied. In this case, this method will return the same thing as {@link #dataBuffer()}.
<p>
Only LBT-SMX transports currently support this method. The return value will be null If this message did not
come from an LBT-SMX transport or has no message data.
@return View of messages buffer with position and limit set to where message data is stored or null

### dispose

```java
public void dispose()
```

Dispose of memory associated with this message.
Every received message must be disposed after processing is complete.
See \ref javamessagereception.

If this message is delivered from a persistent receiver,
deleting the message might signal consumption of the message,
depending on the use case.
See \ref persistencemessageconsumption for a full explanation of
consumption acknowledgements.
    <p>
@see LBMContext#close
@see LBMReceiver#close
@see LBMWildcardReceiver#close

### applicationHeaderChain

```java
public LBMApplicationHeaderChain applicationHeaderChain() throws LBMException
```

Get the application header chain, if any, associated with this message.
@return Application header chain.
@throws LBMEInvalException if the message contains no application header data, LBMException if another error occurs.

### hasApplicationHeaderChain

```java
public boolean hasApplicationHeaderChain()
```

Check to see if this message contains any application header chain data.
@see LBMMessage#applicationHeaderChain()
@return True if the message has an application header chain, false otherwise.

### type

```java
public int type()
```

LBM message type.
@return LBM message type
@see LBM

### flags

```java
public int flags()
```

LBM message flags.
@return LBM message flags.
@see LBM

### sequenceNumber

```java
public long sequenceNumber()
```

LBM message (or message fragment) sequence number. When the message is 32 bit hot-failover, this will
be the hot-failover sequence number. When 64 bit hot failover, this will always be 0.
@see osqn
@see hfSequenceNumber
@return LBM message (or message fragment) sequence number

### data

```java
public byte[] data()
```

Message data.
@return byte array containing message data

### dataLength

```java
public long dataLength()
```

Message data length. For ZOD, use this in conjunction with dataBuffer().
@return Message data length, in bytes.

### dataBuffer

```java
public ByteBuffer dataBuffer()
```

Message data as a direct ByteBuffer. For ZOD, use in conjunction with {@link #dataLength()} to determine how many bytes
in the buffer are actually valid, since buffers are generally larger than actual message data. Message data
starts at position 0.
<p>
If this message has been promoted, the returned byte buffer will have a backing array (non-direct).
<p>
If this message was delivered via SMX, this method will copy the message data from the transport into a ByteBuffer
allocated with a backing array (non-direct). For more information on getting SMX message data, see {@link #getMessagesBuffer()}.
@return ByteBuffer containing message data

### dataString

```java
public String dataString()
```

Message string data.
@return Message data converted to String

### source

```java
public String source()
```

Message source
@return Message source string

### sourceAsCharArray

```java
public char [] sourceAsCharArray()
```

Message sourceAsCharArray
@return Message source as character array

### proxySource

```java
public String proxySource()
```

Message proxySource
@return Message proxy source string. Only valid for hotlinked receiver BOS/EOS events. See \ref hotlinksourcestrings.

### proxySourceAsCharArray

```java
public char [] proxySourceAsCharArray()
```

Message proxySourceAsCharArray
@return Message proxy source as character array

### topicName

```java
public String topicName()
```

Topic on which the current message has been delivered.
@return Topic name string

### topicNameAsCharArray

```java
public char [] topicNameAsCharArray()
```

Message topicNameAsCharArray
@return Topic name as character array

### channelInfo

```java
public LBMMessageChannelInfo channelInfo()
```

Object containing channel information included with the message.
@return Channel info object, or null if no channel information is present.

### firstFragmentSequenceNumber

```java
public long firstFragmentSequenceNumber()
```

LBM sequence number of the first fragment of the current message
@return Sequence number of the first message fragment

### fragmentOffset

```java
public long fragmentOffset()
```

Byte offset of the current fragment within the associated message.
@return Byte offset of the current fragment

### totalMessageLength

```java
public long totalMessageLength()
```

Total message size.  This value may be larger than the length of the
data byte array, if the current object represents a message fragment.
@return Total size (in bytes) of the current message.

### isFragment

```java
public boolean isFragment()
```

Determine if the current message is a single fragment of
a larger, multi-fragment message.

Note that this method will not return true unless:
<ul>
<li>\ref ordereddeliveryreceiver is set to "0" (zero), and
<li>the application message required UM fragmentation.
</ul>

@return true if the current object is a message fragment; otherwise,
false.

### respond

```java
public void respond(byte [] data, int dataLength, int flags) throws LBMException
```

Send a response for this request message.
<p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param data Data to send in this response
@param dataLength Number of bytes of data to send in this response
@param flags Flags indicating various conditions.
See next section for possible OR'd set of values.
@throws LBMException if any error occurs sending the response.
@see LBM#SRC_NONBLOCK
@see LBM#SRC_BLOCK

### sourceRegistrationId

```java
public long sourceRegistrationId()
```

The registration ID for the source (UME only).
@return The registration ID for the source.

### receiverRegistrationId

```java
public long receiverRegistrationId()
```

The registration ID for the receiver (UME only).
@return The registration ID for the receiver.

### queueMessageId

```java
public UMQMessageId queueMessageId()
```

The message ID assigned by the queue (UMQ only).
@return The message ID assigned by the queue.

### timestampSeconds

```java
public long timestampSeconds()
```

Seconds portion of the timestamp indicating when the message was received.
@return Number of whole seconds since Midnight, January 1st 1970 UTC.

### timestampMicroseconds

```java
public long timestampMicroseconds()
```

Microseconds portion of the timestamp indicating when the message was received.
@return Number of fractional seconds since Midnight, January 1st 1970 UTC, represented as
an integer number of microseconds.

### hrTimestampSeconds

```java
public long hrTimestampSeconds()
```

Seconds portion of the high resolution timestamp indicating when the message was received.
@return Number of whole seconds since Midnight, January 1st 1970 UTC.

### hrTimestampNanoseconds

```java
public long hrTimestampNanoseconds()
```

Nanoseconds portion of the high resolution timestamp indicating when the message was received.
@return Number of fractional seconds since Midnight, January 1st 1970 UTC, represented as
an integer number of nanoseconds.

### isFromGateway

```java
public boolean isFromGateway()
```

Whether or not the message arrived via a gateway.
@return boolean indicating if it arrived via a gateway.
@deprecated No replacement

### originalSequenceNumber

```java
public long originalSequenceNumber()
```

Original sequence number (if the message arrived via a gateway).
@return Original sequence number.
@deprecated No replacement

### originalSource

```java
public String originalSource()
```

Original message source (if the message arrived via a gateway).
@return Original message source.
@deprecated No replacement

### originalSourceAsCharArray

```java
public char [] originalSourceAsCharArray()
```

Original message source (if the message arrived via a gateway) as char array.
@return Original message source as character array.
@deprecated No replacement

### hfSequenceNumber

```java
public long hfSequenceNumber()
```

Get the hot failover sequence number as a long. Since Java does not have unsigned integers
this will return the signed long value of either the 32 or 64 bit hot-failover sequence
number as specified by LBMMessage.flags(). 64 bit sequence numbers can appear negative
and should be handled accordingly.
@see LBMSourceSendExInfo::getHfSequenceNumberBigInt
@return Hot-failover sequence number

### hfSequenceNumberBigInt

```java
public BigInteger hfSequenceNumberBigInt()
```

Get the hot failover sequence number as a BigInteger. Since Java does not have unsigned
integers, this is provided to ensure all possible hot failover sequence numbers are given
with a positive value. This method is a convenience when using 64 bit sequence
numbers, and simply interprets the long value as if it were unsigned.
@see LBMSourceSendExInfo::getHfSequenceNumber
@return Hot-failover sequence number

### registrationSuccessInfo

```java
public UMERegistrationSuccessInfo registrationSuccessInfo()
```

Get an extended registration success info object from
the message (only for {@link LBM#MSG_UME_REGISTRATION_SUCCESS_EX}
messages).
@return UMERegistrationSuccessInfo object holding extended registration success info.
@since UME 2.0

### registrationCompleteInfo

```java
public UMERegistrationCompleteInfo registrationCompleteInfo()
```

Get an extended registration complete info object from the message
(only for {@link LBM#MSG_UME_REGISTRATION_COMPLETE_EX} messages).
@return UMERegistrationCompleteInfo object holding extended registration complete info.
@since UME 2.0

### deregistrationSuccessInfo

```java
public UMEDeregistrationSuccessInfo deregistrationSuccessInfo()
```

Get an extended deregistration success info object from
the message (only for {@link LBM#MSG_UME_DEREGISTRATION_SUCCESS_EX}
messages).
@return UMEDeregistrationSuccessInfo object holding extended deregistration success info.
@since UME 5.3

### deregistrationCompleteInfo

```java
public UMEDeregistrationCompleteInfo deregistrationCompleteInfo()
```

Get an extended registration complete info object from the message
(only for {@link LBM#MSG_UME_DEREGISTRATION_COMPLETE_EX} messages).
@return UMEDeregistrationCompleteInfo object holding extended deregistration complete info.
@since UME 5.3

### queueRegistrationCompleteInfo

```java
public UMQRegistrationCompleteInfo queueRegistrationCompleteInfo()
```

Get an extended queue registration complete info object from the message
(only for {@link LBM#MSG_UMQ_REGISTRATION_COMPLETE_EX} messages).
@return UMQRegistrationCompleteInfo object holding extended registration complete info.
@since UME 3.0

### queueDeregistrationCompleteInfo

```java
public UMQDeregistrationCompleteInfo queueDeregistrationCompleteInfo()
```

Get an extended queue deregistration complete info object from the message
(only for {@link LBM#MSG_UMQ_DEREGISTRATION_COMPLETE_EX} messages).
@return UMQDrregistrationCompleteInfo object holding extended deregistration complete info.
@since UME 3.0

### queueIndexAssignedInfo

```java
public UMQIndexAssignedInfo queueIndexAssignedInfo()
```

Get a queue index assigned info object from the message
(only for {@link LBM#MSG_UMQ_INDEX_ASSIGNED_EX} messages).
@return {@link UMQIndexAssignedInfo} object holding extended index assignment info.
@since UMQ 1.2

### queueIndexReleasedInfo

```java
public UMQIndexReleasedInfo queueIndexReleasedInfo()
```

Get a queue index released info object from the message
(only for {@link LBM#MSG_UMQ_INDEX_RELEASED_EX} messages).
@return {@link UMQIndexReleasedInfo} object holding extended index release info.
@since UMQ 1.2

### queueIndexAssignmentEligibilityStartCompleteInfo

```java
public UMQIndexAssignmentEligibilityStartCompleteInfo queueIndexAssignmentEligibilityStartCompleteInfo()
```

Get a queue index assignment eligibility start complete info object from the message
(only for {@link LBM#MSG_UMQ_INDEX_ASSIGNMENT_ELIGIBILITY_START_COMPLETE_EX} messages).
@return {@link UMQIndexAssignmentEligibilityStartCompleteInfo} object holding extended index assignment eligibility start complete info.
@since UMQ 1.2

### queueIndexAssignmentEligibilityStopCompleteInfo

```java
public UMQIndexAssignmentEligibilityStopCompleteInfo queueIndexAssignmentEligibilityStopCompleteInfo()
```

Get a queue index assignment eligibility stop complete info object from the message
(only for {@link LBM#MSG_UMQ_INDEX_ASSIGNMENT_ELIGIBILITY_STOP_COMPLETE_EX} messages).
@return {@link UMQIndexAssignmentEligibilityStopCompleteInfo} object holding extended index assignment eligibility stop complete info.
@since UMQ 1.2

### queueIndexInfo

```java
public UMQIndexInfo queueIndexInfo() throws LBMException
```

Retrieve UMQ index information for this message.
@return {@link UMQIndexInfo} object holding index information, or null if no index information is present.
@throws LBMException if an internal error occurs
@since UMQ 1.2

### sendExplicitAck

```java
public void sendExplicitAck() throws LBMException
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

@throws LBMException if any error occurs or the message object is not valid, or if dispose() has already been called on this LBMMessage.
@since UME 2.0

### reassign

```java
public void reassign(int flags) throws LBMException
```

Do not acknowledge the given message and instead request that the message be reassigned.
@throws LBMException if any error occurs or the message object is not valid, or if dispose() has already been called on this LBMMessage.
@since UMQ 2.2
@param flags Flags indicating various conditions. ORed set of values: {@link LBM#MSG_UMQ_REASSIGN_FLAG_DISCARD}

### osqn

```java
public long osqn()
```

Retrieve the message original sequence number set by the UM library.
@return Message original sequence number

### sourceClientObject

```java
public Object sourceClientObject()
```

Get the source client object, set by an LBMSourceCreationCallback callback.
@return Source client object.
@since LBM 3.3, UME 2.0

### extractUMEAck

```java
public UMEMessageAck extractUMEAck() throws LBMException
```

Retrieves the ack structure from a UME message.
@throws LBMException if the message has already been disposed, ACK'd, or was not a UME message
@return UMEMessageAck object

### getSerializedResponse

```java
public void getSerializedResponse(LBMSerializedResponse serializedResponse) throws LBMException
```

Gets the serialized response information from a message so it can be sent to and used by another application to respond.
@throws LBMException if there were problems getting the serialized response information or there was no response information in the message.
@see LBMContext#respond

## LBMMessageChannelInfo

*class* `com.latencybusters.lbm.LBMMessageChannelInfo`

### channelFlags

```java
public int channelFlags()
```

LBM channel flags.
@return LBM channel flags.

### channelNumber

```java
public long channelNumber()
```

Channel on which the current message has been delivered.

## LBMMessageProperties

*class* `com.latencybusters.lbm.LBMMessageProperties`

### LBMMessageProperties

```java
public LBMMessageProperties()
```

Create an LBMMessageProperties object, used to associate properties with
an outgoing message

@since UMS 5.1

### iterator

```java
public Iterator<LBMMessageProperty> iterator()
```

Returns an iterator over all LBMMessageProperty objects contained in this collection.
@return An iterator over the collection.

### elements

```java
public Enumeration elements()
```

Returns an enumeration of all LBMMessageProperty objects contained in this collection.
@return An enumeration of the collection.

### clear

```java
public void clear()
```

Clear all properties from this object.

### clear

```java
public void clear(String key)
```

Clear the property with the specified key from this object.

### set

```java
public void set(String key, byte value)
```

 Set a property to the provided byte value.
@param key The name of the property to be set
@param value The value to be set

### set

```java
public void set(String key, short value)
```

 Set a property to the provided short value.
@param key The name of the property to be set
@param value The value to be set

### set

```java
public void set(String key, int value)
```

 Set a property to the provided int value.
@param key The name of the property to be set
@param value The value to be set

### set

```java
public void set(String key, long value)
```

 Set a property to the provided long value.
@param key The name of the property to be set
@param value The value to be set

### set

```java
public void set(String key, float value)
```

 Set a property to the provided float value.
@param key The name of the property to be set
@param value The value to be set

### set

```java
public void set(String key, double value)
```

 Set a property to the provided double value.
@param key The name of the property to be set
@param value The value to be set

### set

```java
public void set(String key, boolean value)
```

 Set a property to the provided boolean value.
@param key The name of the property to be set
@param value The value to be set

### set

```java
public void set(String key, String value)
```

 Set a property to the provided string value.
@param key The name of the property to be set
@param value The value to be set

### set

```java
public void set(String key, Object value) throws LBMEInvalException
```

 Set a property to the provided object value.
@param key The name of the property to be set
@param value The object whose value to be set.
  Must be an instance of Integer, Short, Byte, Long,
  Float, Double, Boolean, or String.

### containsKey

```java
public boolean containsKey(String key)
```

 Test if the specified key is contained in the properties object.
@param key The name of the property
@return True if the property has been set, False if the property isn't set.

### getBoolean

```java
public boolean getBoolean(String key) throws LBMEInvalException, IllegalArgumentException
```

Get the property with the specified key as a boolean.
@param key The name of the property
@return The value of the property, converted to a boolean if necessary.
@throws IllegalArgumentException if the key is not set.
@throws LBMEInvalException if the value is a String, and cannot be converted to a boolean,
or if the value cannot be converted to a boolean.

### getByte

```java
public byte getByte(String key) throws LBMEInvalException, IllegalArgumentException
```

Get the property with the specified key as a byte.
@param key The name of the property
@return The value of the property, converted to a byte if necessary.
@throws IllegalArgumentException if the key is not set.
@throws LBMEInvalException if the value is a String, and cannot be converted to a byte,
or if the value cannot be converted to a byte.

### getShort

```java
public short getShort(String key) throws LBMEInvalException, IllegalArgumentException
```

Get the property with the specified key as a short.
@param key The name of the property
@return The value of the property, converted to a short if necessary.
@throws IllegalArgumentException if the key is not set.
@throws LBMEInvalException if the value is a String, and cannot be converted to a short,
or if the value cannot be converted to a short.

### getInteger

```java
public int getInteger(String key) throws LBMEInvalException, IllegalArgumentException
```

Get the property with the specified key as a integer.
@param key The name of the property
@return The value of the property, converted to a integer if necessary.
@throws IllegalArgumentException if the key is not set.
@throws LBMEInvalException if the value is a String, and cannot be converted to a integer,
or if the value cannot be converted to a integer.

### getLong

```java
public long getLong(String key) throws LBMEInvalException, IllegalArgumentException
```

Get the property with the specified key as a long.
@param key The name of the property
@return The value of the property, converted to a long if necessary.
@throws IllegalArgumentException if the key is not set.
@throws LBMEInvalException if the value is a String, and cannot be converted to a long,
or if the value cannot be converted to a long.

### getFloat

```java
public float getFloat(String key) throws LBMEInvalException, IllegalArgumentException
```

Get the property with the specified key as a float.
@param key The name of the property
@return The value of the property, converted to a float if necessary.
@throws IllegalArgumentException if the key is not set.
@throws LBMEInvalException if the value is a String, and cannot be converted to a float,
or if the value cannot be converted to a float.

### getDouble

```java
public double getDouble(String key) throws LBMEInvalException, IllegalArgumentException
```

Get the property with the specified key as a double.
@param key The name of the property
@return The value of the property, converted to a double if necessary.
@throws IllegalArgumentException if the key is not set.
@throws LBMEInvalException if the value is a String, and cannot be converted to a double,
or if the value cannot be converted to a double.

### getString

```java
public String getString(String key) throws LBMEInvalException, IllegalArgumentException
```

Get the property with the specified key as a string.
@param key The name of the property
@return The value of the property, converted to a string if necessary.
@throws IllegalArgumentException if the key is not set.
@throws LBMEInvalException if the property cannot be converted to a string.

### getObject

```java
public Object getObject(String key) throws IllegalArgumentException
```

Get the property with the specified key as an object.
@param key The name of the property
@return The value of the property as an object.
@throws IllegalArgumentException if the key is not set.
@throws LBMEInvalException if the property cannot be converted to a string.

## LBMMessageProperty

*class* `com.latencybusters.lbm.LBMMessageProperty`

### key

```java
public String key()
```

Retrieve the name of the property represented by this object.

### type

```java
public int type()
```

Retrieve the type of the property represented by this object.

### getBoolean

```java
public boolean getBoolean() throws LBMEInvalException
```

Retrieve the value stored in this object as a boolean. Only properties of
type LBM.MSG_PROPERTY_BOOLEAN and LBM.MSG_PROPERTY_STRING can be retrieved as
a boolean.

### getByte

```java
public byte getByte() throws LBMEInvalException
```

 Retrieve the value stored in this object as a byte. Only properties of
type LBM.MSG_PROPERTY_BYTE and LBM.MSG_PROPERTY_STRING can be retrieved as
a byte.
 @return The stored value, converted to a java.lang.Byte.
 @throws LBMEInvalException if the stored value is of a type that cannot be converted to a java.lang.Byte,
 or if the stored value is a string and does not contain the string representation of a java.lang.Byte.

### getShort

```java
public short getShort() throws LBMEInvalException
```

 Retrieve the value stored in this object as a short. Only properties of
type LBM.MSG_PROPERTY_BYTE, LBM.MSG_PROPERTY_SHORT, and LBM.MSG_PROPERTY_STRING can be retrieved as
a short.
 @return The stored value, converted to a java.lang.Short.
 @throws LBMEInvalException if the stored value is of a type that cannot be converted to a java.lang.Short,
 or if the stored value is a string and does not contain the string representation of a java.lang.Short.

### getInteger

```java
public int getInteger() throws LBMEInvalException
```

 Retrieve the value stored in this object as a integer. Only properties of
type LBM.MSG_PROPERTY_BYTE, LBM.MSG_PROPERTY_SHORT, LBM.MSG_PROPERTY_INT, and
 LBM.MSG_PROPERTY_STRING can be retrieved as a integer.
 @return The stored value, converted to a java.lang.Integer.
 @throws LBMEInvalException if the stored value is of a type that cannot be converted to a java.lang.Integer.
 or if the stored value is a string and does not contain the string representation of a java.lang.Integer.

### getLong

```java
public long getLong() throws LBMEInvalException
```

 Retrieve the value stored in this object as a long. Only properties of
type LBM.MSG_PROPERTY_BYTE, LBM.MSG_PROPERTY_SHORT, LBM.MSG_PROPERTY_INT, LBM.MSG_PROPERTY_LONG and
 LBM.MSG_PROPERTY_STRING can be retrieved as a long.
 @return The stored value, converted to a java.lang.Long.
 @throws LBMEInvalException if the stored value is of a type that cannot be converted to a java.lang.Long,
 or if the stored value is a string and does not contain the string representation of a java.lang.Long.

### getFloat

```java
public float getFloat() throws LBMEInvalException
```

 Retrieve the value stored in this object as a float. Only properties of
type LBM.MSG_PROPERTY_FLOAT and LBM.MSG_PROPERTY_STRING can be retrieved as
a float.
 @return The stored value, converted to a java.lang.Float.
 @throws LBMEInvalException if the stored value is of a type that cannot be converted to a java.lang.Float,
 or if the stored value is a string and does not contain the string representation of a java.lang.Float.

### getDouble

```java
public double getDouble() throws LBMEInvalException, NumberFormatException
```

 Retrieve the value stored in this object as a double. Only properties of
type LBM.MSG_PROPERTY_FLOAT, LBM.MSG_PROPERTY_DOUBLE and LBM.MSG_PROPERTY_STRING can be retrieved as
a double.
 @return The stored value, converted to a java.lang.Double.
 @throws LBMEInvalException if the stored value is of a type that cannot be converted to a java.lang.Double,
 or if the stored value is a string and does not contain the string representation of a java.lang.Double.

### getString

```java
public String getString() throws LBMEInvalException
```

Retrieve the value stored in this object as a string. Any type may be retrieved as a string.
@return The stored value, converted to a java.lang.String.
@throws LBMEInvalException if the stored value is of a type that cannot be converted to a java.lang.String.

### getObject

```java
public Object getObject()
```

Retrieve the value stored in this object as an Object. Any type may be retrieved as a Object.
@return The stored value, converted to a java.lang.Object.

## LBMMessageReclamationCallback

*interface* `com.latencybusters.lbm.LBMMessageReclamationCallback`

### onMessageReclaim

```java
void onMessageReclaim(Object cbArg, String topic, long seqnum)
```

Forced message reclamation callback.
@param cbArg Callback object token
@param topic Name of the topic for the reclaimed message.
@param seqnum Sequence number of the message that is reclaimed.

## LBMMonitorReceiver

*class* `com.latencybusters.lbm.LBMMonitorReceiver`

### LBMMonitorReceiver

```java
public LBMMonitorReceiver(int formatter, String formatOpts, int transport, String transportOpts) throws LBMException
```

Create an LBM Monitoring Receiver Controller.
This creates an instance of an LBM Monitoring Receive Controller.
On some JVMs this object may be garbage collected prematurely if
it is not referenced after creation; therefore, it may be prudent to
explicitly call its close method at a point in the program logic
where it would no longer be required.
@see #close
@param formatter Format module type
@param formatOpts A block of data which is passed to the format
module's initialization function. This may be used to pass
configuration options to the format module. `
@param transport Transport module type
@param transportOpts A block of data which is passed to the transport
module's initialization function. This may be used to pass
configuration options to the transport module.
@throws LBMException if any error occurs creating the monitor receiver.

### LBMMonitorReceiver

```java
public LBMMonitorReceiver(int formatter, String formatOpts, int transport, String transportOpts, LBMObjectRecyclerBase recycler, Object objRecCbArg) throws LBMException
```

Create an LBM Monitoring Receiver Controller.
This creates an instance of an LBM Monitoring Receive Controller.
On some JVMs this object may be garbage collected prematurely if
it is not referenced after creation; therefore, it may be prudent to
explicitly call its close method at a point in the program logic
where it would no longer be required.
@see #close
@param formatter Format module type
@param formatOpts A block of data which is passed to the format
module's initialization function. This may be used to pass
configuration options to the format module. `
@param transport Transport module type
@param transportOpts A block of data which is passed to the transport
module's initialization function. This may be used to pass
configuration options to the transport module.
@param recycler an object recycler to handle recycling stats objects. Only the last callback
should call the doneWith* method to return the stat object back to the recycler.
@param objRecCbArg a callback object token that will be passed to the recycler (normally null is used)
@throws LBMException if any error occurs creating the monitor receiver.

### getSourceType

```java
public long getSourceType(ByteBuffer attributes) throws LBMException
```

Get the type of source associated with this statistics packet.
@param attributes A block of data which contains the attributes for the statistics packet.
@return Value indicating whether the source is normal or IM
@throws LBMException if any error occurs.

### close

```java
public void close() throws LBMException
```

Destroy a statistics receive controller.
Destroys a monitoring controller.
@throws LBMException if any error occurs destroying the monitor receiver.

### addStatisticsCallback

```java
public void addStatisticsCallback(LBMMonitorStatisticsCallback cb)
```

Register statistics callbacks.
@param cb Object implementing the LBMMonitorStatisticsCallback
interface
@deprecated This method is provided for backwards compatibility with LBM 3.3.9/ UME 2.0.7; please use the {@link #addStatisticsCallback(LBMMonitorStatisticsCallbackObject)} method instead.

### removeStatisticsCallback

```java
public void removeStatisticsCallback(LBMMonitorStatisticsCallback cb)
```

Deregister previously registered statistics callback.
@param cb Previously registered object implementing the
LBMMonitorStatisticsCallback interface
@deprecated This method is provided for backwards compatibility with LBM 3.3.9/ UME 2.0.7; please use the {@link #removeStatisticsCallback(LBMMonitorStatisticsCallbackObject)} method instead.

### addStatisticsCallback

```java
public void addStatisticsCallback(LBMMonitorStatisticsCallbackObject cb)
```

Register statistics callbacks.
@param cb Object extending the LBMMonitorStatisticsCallbackObject class.

### removeStatisticsCallback

```java
public void removeStatisticsCallback(LBMMonitorStatisticsCallbackObject cb)
```

Deregister previously registered statistics callback.
@param cb Previously registered object extending the
LBMMonitorStatisticsCallbackObject class.

## LBMMonitorSource

*class* `com.latencybusters.lbm.LBMMonitorSource`

### LBMMonitorSource

```java
public LBMMonitorSource(int formatter, String formatOpts, int transport, String transportOpts) throws LBMException
```

Create an LBM Monitoring Source Controller.
This creates an instance of an LBM Monitoring Source Controller.
On some JVMs this object may be garbage collected prematurely if
it is not referenced after creation; therefore, it may be prudent to
explicitly call its close method at a point in the program logic
where it would no longer be required.
@see #close
@param formatter Format module type
@param formatOpts A block of data which is passed to the format
module's initialization function. This may be used to pass
configuration options to the format module.
@param transport Transport module type
@param transportOpts A block of data which is passed to the transport
module's initialization function. This may be used to pass
configuration options to the transport module.
@throws LBMException if any error occurs creating the monitor source.

### close

```java
public void close() throws LBMException
```

Destroy a source monitoring controller.
Destroys a monitoring controller. Any contexts, sources, or receivers
currently registered to the controller will be automatically
unregistered.
@throws LBMException if any error occurs destroying the monitor source.

### start

```java
public void start(LBMContext lbmctx, String appSourceId, int secs) throws LBMException
```

Register a context for monitoring.
Monitoring may be done at regular intervals, specified by the secs
parameter. As an alternative, passing zero for secs will not
automatically monitor the context, but instead require an explicit
call to the sample() method.
<p>
If monitoring is to be used as a form of heartbeat, the preferred
method is to call the sample() method from a context thread or
event queue timer callback. This ensures that the object actually
processing the messages is the one generating the monitoring
statistics, guaranteeing that it is truly acting as a heartbeat
mechanism.
@param lbmctx LBMContext to be monitored
@param appSourceId String containing an application-specified source
identifier. If null or an empty string is passed, the application
name will be used.
@param secs Interval (in seconds) at which monitoring information will
be gathered and sent. If zero, the context will not be automatically
monitored, but instead will be monitored upon a call to the sample()
method.
@throws LBMException if any error occurs enabling monitoring for the context.

### start

```java
public void start(LBMReceiver lbmrcv, String appSourceId, int secs) throws LBMException
```

Register a receiver for monitoring.
Monitoring may be done at regular intervals, specified by the secs
parameter. As an alternative, passing zero for secs will not
automatically monitor the context, but instead require an explicit
call to the sample() method.
<p>
If monitoring is to be used as a form of heartbeat, the preferred
method is to call the sample() method from a context thread or
event queue timer callback. This ensures that the object actually
processing the messages is the one generating the monitoring
statistics, guaranteeing that it is truly acting as a heartbeat
mechanism.
@param lbmrcv LBMReceiver to be monitored
@param appSourceId String containing an application-specified source
identifier. If null or an empty string is passed, the application
name will be used.
@param secs Interval (in seconds) at which monitoring information will
be gathered and sent. If zero, the receiver will not be automatically
monitored, but instead will be monitored upon a call to the sample()
method.
@throws LBMException if any error occurs enabling monitoring for the receiver.

### start

```java
public void start(LBMSource lbmsrc, String appSourceId, int secs) throws LBMException
```

Register a source for monitoring.
Monitoring may be done at regular intervals, specified by the secs
parameter. As an alternative, passing zero for secs will not
automatically monitor the source, but instead require an explicit
call to the sample() method.
<p>
If monitoring is to be used as a form of heartbeat, the preferred
method is to call the sample() method from a context thread or
event queue timer callback. This ensures that the object actually
processing the messages is the one generating the monitoring
statistics, guaranteeing that it is truly acting as a heartbeat
mechanism.
@param lbmsrc LBMSource to be monitored
@param appSourceId String containing an application-specified source
identifier. If null or an empty string is passed, the application
name will be used.
@param secs Interval (in seconds) at which monitoring information will
be gathered and sent. If zero, the source will not be automatically
monitored, but instead will be monitored upon a call to the sample()
method.
@throws LBMException if any error occurs enabling monitoring for the source.

### start

```java
public void start(LBMSSource lbmssrc, String appSourceId, int secs) throws LBMException
```

Register a smart source for monitoring.
Monitoring may be done at regular intervals, specified by the secs
parameter. As an alternative, passing zero for secs will not
automatically monitor the source, but instead require an explicit
call to the sample() method.
<p>
If monitoring is to be used as a form of heartbeat, the preferred
method is to call the sample() method from a context thread or
event queue timer callback. This ensures that the object actually
processing the messages is the one generating the monitoring
statistics, guaranteeing that it is truly acting as a heartbeat
mechanism.
@param lbmssrc LBMSSource to be monitored
@param appSourceId String containing an application-specified smart source
identifier. If null or an empty string is passed, the application
name will be used.
@param secs Interval (in seconds) at which monitoring information will
be gathered and sent. If zero, the smart source will not be automatically
monitored, but instead will be monitored upon a call to the sample()
method.
@throws LBMException if any error occurs enabling monitoring for the source.

### start

```java
public void start(LBMEventQueue lbmevq, String appSourceId, int secs) throws LBMException
```

Register an event queue for monitoring.
Monitoring may be done at regular intervals, specified by the secs
parameter. As an alternative, passing zero for secs will not
automatically monitor the source, but instead require an explicit
call to the sample() method.
<p>
If monitoring is to be used as a form of heartbeat, the preferred
method is to call the sample() method from a context thread or
event queue timer callback. This ensures that the object actually
processing the messages is the one generating the monitoring
statistics, guaranteeing that it is truly acting as a heartbeat
mechanism.
@param lbmevq LBMEventQueue to be monitored
@param appSourceId String containing an application-specified source
identifier. If null or an empty string is passed, the application
name will be used.
@param secs Interval (in seconds) at which monitoring information will
be gathered and sent. If zero, the source will not be automatically
monitored, but instead will be monitored upon a call to the sample()
method.
@throws LBMException if any error occurs enabling monitoring for the event queue.

### stop

```java
public void stop(LBMContext lbmctx) throws LBMException
```

Terminate monitoring for a context.
Unregister a context to prevent further monitoring of that context.
@param lbmctx Previously registered LBMContext
@throws LBMException if any error occurs disabling monitoring for the context.

### stop

```java
public void stop(LBMReceiver lbmrcv) throws LBMException
```

Terminate monitoring for a receiver.
Unregister a receiver to prevent further monitoring of that receiver.
@param lbmrcv Previously registered LBMReceiver
@throws LBMException if any error occurs disabling monitoring for the receiver.

### stop

```java
public void stop(LBMSource lbmsrc) throws LBMException
```

Terminate monitoring for a source.
Unregister a source to prevent further monitoring of that source.
@param lbmsrc Previously registered LBMSource
@throws LBMException if any error occurs disabling monitoring for the source.

### stop

```java
public void stop(LBMSSource lbmssrc) throws LBMException
```

Terminate monitoring for a smart source.
Unregister a smart source to prevent further monitoring of that source.
@param lbmssrc Previously registered LBMSSource
@throws LBMException if any error occurs disabling monitoring for the smart source.

### stop

```java
public void stop(LBMEventQueue lbmevq) throws LBMException
```

Terminate monitoring for an event queue.
Unregister an event queue to prevent further monitoring of that event queue.
@param lbmevq Previously registered LBMEventQueue
@throws LBMException if any error occurs disabling monitoring for the event queue.

### sample

```java
public void sample() throws LBMException
```

Gather statistics for on-demand objects.
@throws LBMException if any error occurs gathering statistics.

## LBMMonitorStatisticsCallback

*interface* `com.latencybusters.lbm.LBMMonitorStatisticsCallback`

### onReceive

```java
void onReceive(LBMReceiverStatistics lbmrcvstats)
```

Receiver statistics callback.
@param lbmrcvstats LBMReceiverStatistics object encapsulating
the received (LBM receiver) statistics

### onReceive

```java
void onReceive(LBMSourceStatistics lbmsrcstats)
```

Source statistics callback.
@param lbmsrcstats LBMSourceStatistics object encapsulating
the received (LBM source) statistics

## LBMMonitorStatisticsCallbackObject

*class* `com.latencybusters.lbm.LBMMonitorStatisticsCallbackObject`

### onReceive

```java
public void onReceive(LBMReceiverStatistics lbmrcvstats)
```

Receiver statistics callback.
@param lbmrcvstats LBMReceiverStatistics object encapsulating
the received (UM receiver) statistics

### onReceive

```java
public void onReceive(LBMSourceStatistics lbmsrcstats)
```

Source statistics callback.
@param lbmsrcstats LBMSourceStatistics object encapsulating
the received (UM source) statistics

### onReceive

```java
public void onReceive(LBMContextStatistics lbmctxstats)
```

Context statistics callback.
@param lbmctxstats LBMContextStatistics object encapsulating
the received (UM context) statistics

### onReceive

```java
public void onReceive(LBMEventQueueStatistics lbmevqstats)
```

Event queue statistics callback.
@param lbmevqstats LBMEventQueueStatistics object encapsulating
the received (UM event queue) statistics

### onReceive

```java
public void onReceive(LBMImmediateMessageSourceStatistics lbmsrcimstats)
```

Immediate message source statistics callback.
@param lbmsrcimstats LBMImmediateMessageSourceStatistics object encapsulating
the received (UM immediate message source) statistics

### onReceive

```java
public void onReceive(LBMImmediateMessageReceiverStatistics lbmrcvimstats)
```

Immediate message receiver statistics callback.
@param lbmrcvimstats LBMImmediateMessageReceiverStatistics object encapsulating
the received (UM immediate message receiver) statistics

### onReceive

```java
public void onReceive(short type, short format, ByteBuffer attributes, ByteBuffer stats)
```

Passthrough statistics callback.
@param type The type of message in stats.  See LBMMonitor.LBMMON_PACKET_TYPE_*
@param format The format of attributes.  See LBMMonitor.FORMAT_*
@param attributes ByteBuffer. For CSV, contains Attribute table. For PB, set to null
    (the attributes are part of the PB binary message pointed to by stats).
@param stats ByteBuffer contains either a CSV message or a PB binary message
created from UMSMonProtos

## LBMNewTransportInfo

*class* `com.latencybusters.lbm.LBMNewTransportInfo`

### getFlags

```java
public int getFlags()
```

Flags (currently unused).
@return flags

### getTransportSourceInfo

```java
public LBMTransportSourceInfo getTransportSourceInfo()
```

Transport source information. Contains a description of the transport.
@return transportSourceInfo

### getSourceString

```java
public String getSourceString()
```

Transport source string.
@return sourceString

## LBMObjectRecycler

*class* `com.latencybusters.lbm.LBMObjectRecycler`

### setLocalMsgPoolSize

```java
public void setLocalMsgPoolSize(int size)
```

Sets the size of the thread local pool of LBMMessages for all LBMObjectRecyclers
(defaults to 1000)
@param size the size of the local pool

### setSharedMsgPoolSize

```java
public void setSharedMsgPoolSize(int size)
```

Sets the size of the shared pool of LBMMessages for all LBMObjectRecyclers
(defaults to 2000)
@param size the size of the shared pool

### doneWithMessage

```java
public void doneWithMessage(LBMMessage obj)
```

Call when finished with a LBMMessage object.  Call dispose on the message object
before passing to this method. If the local and shared object size is reached,
it will simply ignore the passed object which will result in it being garbage collected.
@param obj The message object

### retrieveMessage

```java
public LBMMessage retrieveMessage(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return A valid stats object will be returned

### getLocalPoolMessageCount

```java
public int getLocalPoolMessageCount()
```

Gets the current number of objects in the local pool.
@return The number of objects

### returnAllMessagesToSharedPool

```java
public int returnAllMessagesToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).
@return The number of objects actually returned

### setLocalRcvStatsPoolSize

```java
public void setLocalRcvStatsPoolSize(int size)
```

Sets the size of the thread local pool of LBMReceiverStatistics for all LBMObjectRecyclers
(defaults to 10)
@param size the size of the local pool

### setSharedRcvStatsPoolSize

```java
public void setSharedRcvStatsPoolSize(int size)
```

Sets the size of the shared pool of LBMReceiverStatistics for all LBMObjectRecyclers
(defaults to 20)
@param size the size of the shared pool

### doneWithReceiverStatistics

```java
public void doneWithReceiverStatistics(LBMReceiverStatistics obj)
```

Call when finished with a LBMReceiverStatistics object.  Do not call dispose on the stats object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.
@param obj The stats object

### retrieveReceiverStatistics

```java
public LBMReceiverStatistics retrieveReceiverStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return A valid stats object will be returned

### getLocalPoolReceiverStatisticsCount

```java
public int getLocalPoolReceiverStatisticsCount()
```

Gets the current number of objects in the local pool.
@return The number of objects

### returnAllReceiverStatisticsToSharedPool

```java
public int returnAllReceiverStatisticsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).
@return The number of objects actually returned

### setLocalSrcStatsPoolSize

```java
public void setLocalSrcStatsPoolSize(int size)
```

Sets the size of the thread local pool of LBMSourceStatistics for all LBMObjectRecyclers
(defaults to 10)
@param size the size of the local pool

### setSharedSrcStatsPoolSize

```java
public void setSharedSrcStatsPoolSize(int size)
```

Sets the size of the shared pool of LBMSourceStatistics for all LBMObjectRecyclers
(defaults to 20)
@param size the size of the shared pool

### doneWithSourceStatistics

```java
public void doneWithSourceStatistics(LBMSourceStatistics obj)
```

Call when finished with a LBMSourceStatistics object.  Do not call dispose on the stats object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.
@param obj The stats object

### retrieveSourceStatistics

```java
public LBMSourceStatistics retrieveSourceStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return A valid stats object will be returned

### getLocalPoolSourceStatisticsCount

```java
public int getLocalPoolSourceStatisticsCount()
```

Gets the current number of objects in the local pool.
@return The number of objects

### returnAllSourceStatisticsToSharedPool

```java
public int returnAllSourceStatisticsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).
@return The number of objects actually returned

### setLocalCtxStatsPoolSize

```java
public void setLocalCtxStatsPoolSize(int size)
```

Sets the size of the thread local pool of LBMContextStatistics for all LBMObjectRecyclers
(defaults to 10)
@param size the size of the local pool

### setSharedCtxStatsPoolSize

```java
public void setSharedCtxStatsPoolSize(int size)
```

Sets the size of the shared pool of LBMContextStatistics for all LBMObjectRecyclers
(defaults to 20)
@param size the size of the shared pool

### doneWithContextStatistics

```java
public void doneWithContextStatistics(LBMContextStatistics obj)
```

Call when finished with a LBMContextStatistics object.  Do not call dispose on the stats object
before passing to this method. If the local and shared object size is reached,
it will simply ignore the passed object which will result in it being garbage collected.
@param obj The stats object

### retrieveContextStatistics

```java
public LBMContextStatistics retrieveContextStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return A valid stats object will be returned

### getLocalPoolContextStatisticsCount

```java
public int getLocalPoolContextStatisticsCount()
```

Gets the current number of objects in the local pool.
@return The number of objects

### returnAllContextStatisticsToSharedPool

```java
public int returnAllContextStatisticsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).
@return The number of objects actually returned

### setLocalIMRcvStatsPoolSize

```java
public void setLocalIMRcvStatsPoolSize(int size)
```

Sets the size of the thread local pool of LBMImmediateMessageReceiverStatistics for all LBMObjectRecyclers
(defaults to 10)
@param size the size of the local pool

### setSharedIMRcvStatsPoolSize

```java
public void setSharedIMRcvStatsPoolSize(int size)
```

Sets the size of the shared pool of LBMImmediateMessageReceiverStatistics for all LBMObjectRecyclers
(defaults to 20)
@param size the size of the shared pool

### doneWithImmediateMessageReceiverStatistics

```java
public void doneWithImmediateMessageReceiverStatistics(LBMImmediateMessageReceiverStatistics obj)
```

Call when finished with a LBMImmediateMessageReceiverStatistics object.  Do not call dispose on the stats object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.
@param obj The stats object

### retrieveImmediateMessageReceiverStatistics

```java
public LBMImmediateMessageReceiverStatistics retrieveImmediateMessageReceiverStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return A valid stats object will be returned

### getLocalPoolImmediateMessageReceiverStatisticsCount

```java
public int getLocalPoolImmediateMessageReceiverStatisticsCount()
```

Gets the current number of objects in the local pool.
@return The number of objects

### returnAllImmediateMessageReceiverStatisticsToSharedPool

```java
public int returnAllImmediateMessageReceiverStatisticsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).
@return The number of objects actually returned

### setLocalIMSrcStatsPoolSize

```java
public void setLocalIMSrcStatsPoolSize(int size)
```

Sets the size of the thread local pool of LBMImmediateMessageSourceStatistics for all LBMObjectRecyclers
(defaults to 10)
@param size the size of the local pool

### setSharedIMSrcStatsPoolSize

```java
public void setSharedIMSrcStatsPoolSize(int size)
```

Sets the size of the shared pool of LBMImmediateMessageSourceStatistics for all LBMObjectRecyclers
(defaults to 20)
@param size the size of the shared pool

### doneWithImmediateMessageSourceStatistics

```java
public void doneWithImmediateMessageSourceStatistics(LBMImmediateMessageSourceStatistics obj)
```

Call when finished with a LBMImmediateMessageSourceStatistics object.  Do not call dispose on the stats object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.
@param obj The stats object

### retrieveImmediateMessageSourceStatistics

```java
public LBMImmediateMessageSourceStatistics retrieveImmediateMessageSourceStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return A valid stats object will be returned

### getLocalPoolImmediateMessageSourceStatisticsCount

```java
public int getLocalPoolImmediateMessageSourceStatisticsCount()
```

Gets the current number of objects in the local pool.
@return The number of objects

### returnAllImmediateMessageSourceStatisticsToSharedPool

```java
public int returnAllImmediateMessageSourceStatisticsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).
@return The number of objects actually returned

### setLocalEvqStatsPoolSize

```java
public void setLocalEvqStatsPoolSize(int size)
```

Sets the size of the thread local pool of LBMEventQueueStatistics for all LBMObjectRecyclers
(defaults to 10)
@param size the size of the local pool

### setSharedEvqStatsPoolSize

```java
public void setSharedEvqStatsPoolSize(int size)
```

Sets the size of the shared pool of LBMEventQueueStatistics for all LBMObjectRecyclers
(defaults to 20)
@param size the size of the shared pool

### doneWithEventQueueStatistics

```java
public void doneWithEventQueueStatistics(LBMEventQueueStatistics obj)
```

Call when finished with a LBMEventQueueStatistics object.  Do not call dispose on the stats object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.
@param obj The stats object

### retrieveEventQueueStatistics

```java
public LBMEventQueueStatistics retrieveEventQueueStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return A valid stats object will be returned

### getLocalPoolEventQueueStatisticsCount

```java
public int getLocalPoolEventQueueStatisticsCount()
```

Gets the current number of objects in the local pool.
@return The number of objects

### returnAllEventQueueStatisticsToSharedPool

```java
public int returnAllEventQueueStatisticsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).
@return The number of objects actually returned

### setLocalSrcEvPoolSize

```java
public void setLocalSrcEvPoolSize(int size)
```

Sets the size of the thread local pool of LBMSourceEvents for all LBMObjectRecyclers
(defaults to 10)
@param size the size of the local pool

### setSharedSrcEvPoolSize

```java
public void setSharedSrcEvPoolSize(int size)
```

Sets the size of the shared pool of LBMSourceEvents for all LBMObjectRecyclers
(defaults to 20)
@param size the size of the shared pool

### doneWithSourceEvent

```java
public void doneWithSourceEvent(LBMSourceEvent obj)
```

Call when finished with a LBMSourceEvent object.  Call dispose on the source event object
before passing to this method. If the local and shared object size is reached,
it will simply ignore the passed object which will result in it being garbage collected.
@param obj The message object

### retrieveSourceEvent

```java
public LBMSourceEvent retrieveSourceEvent(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return A valid object will be returned

### getLocalPoolSourceEventCount

```java
public int getLocalPoolSourceEventCount()
```

Gets the current number of objects in the local pool.
@return The number of objects

### returnAllSourceEventsToSharedPool

```java
public int returnAllSourceEventsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).
@return The number of objects actually returned

### setLocalCtxSrcEvPoolSize

```java
public void setLocalCtxSrcEvPoolSize(int size)
```

Sets the size of the thread local pool of LBMContextSourceEvents for all LBMObjectRecyclers
(defaults to 10)
@param size the size of the local pool

### setSharedCtxSrcEvPoolSize

```java
public void setSharedCtxSrcEvPoolSize(int size)
```

Sets the size of the shared pool of LBMContextSourceEvents for all LBMObjectRecyclers
(defaults to 20)
@param size the size of the shared pool

### doneWithContextSourceEvent

```java
public void doneWithContextSourceEvent(LBMContextSourceEvent obj)
```

Call when finished with a LBMContextSourceEvent object.  Call dispose on the source event object
before passing to this method. If the local and shared object size is reached,
it will simply ignore the passed object which will result in it being garbage collected.
@param obj The message object

### retrieveContextSourceEvent

```java
public LBMContextSourceEvent retrieveContextSourceEvent(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return A valid object will be returned

### getLocalPoolContextSourceEventCount

```java
public int getLocalPoolContextSourceEventCount()
```

Gets the current number of objects in the local pool.
@return The number of objects

### returnAllContextSourceEventsToSharedPool

```java
public int returnAllContextSourceEventsToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).
@return The number of objects actually returned

### setLocalAsyncOpInfosPoolSize

```java
public void setLocalAsyncOpInfosPoolSize(int size)
```

Sets the size of the thread local pool of LBMAsyncOperationInfo for all LBMObjectRecyclers
(defaults to 10)
@param size the size of the local pool

### setSharedAsyncOpInfosPoolSize

```java
public void setSharedAsyncOpInfosPoolSize(int size)
```

Sets the size of the shared pool of LBMAsyncOperationInfo for all LBMObjectRecyclers
(defaults to 20)
@param size the size of the shared pool

### doneWithAsyncOperationInfo

```java
public void doneWithAsyncOperationInfo(LBMAsyncOperationInfo obj)
```

Call when finished with a LBMAsyncOperationInfo object.  Do not call dispose on the async info object
before passing to this method. If the local and shared object limit is reached,
it will simply ignore the passed object which will result in it being garbage collected.
@param obj The async info object

### retrieveAsyncOperationInfo

```java
public LBMAsyncOperationInfo retrieveAsyncOperationInfo(Object cbObj)
```

LBM will call this method to attempt to retrieve an object that it can reuse.  It will transfer
a batch of objects from the shared pool when the local pool gets low or will create the objects
if the shared pool is empty.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return A valid async info object will be returned

### getLocalPoolAsyncOperationInfoCount

```java
public int getLocalPoolAsyncOperationInfoCount()
```

Gets the current number of objects in the local pool.
@return The number of objects

### returnAllAsyncOperationInfosToSharedPool

```java
public int returnAllAsyncOperationInfosToSharedPool()
```

Returns all of the objects in the local pool back to the shared pool.  If the shared
pool is full, the objects are still removed from the local pool but they are discarded
and will be garbage collected (and are not counted in the return value as objects that
were actually returned).
@return The number of objects actually returned

### disposeThreadLocals

```java
public void disposeThreadLocals()
```

A convenience method to clean up thread local variables if needed.

### close

```java
public void close()
```

A method to clean up all objects referenced by the recycler when the application is closing
(which will dispose all of the stats objects in the recycler).

## LBMObjectRecyclerBase

*class* `com.latencybusters.lbm.LBMObjectRecyclerBase`

### doneWithMessage

```java
public void doneWithMessage(LBMMessage obj)
```

If dispose is not called on an LBMMessage in the callback, it is retained for use in the application.
Once the application is finished with the LBMMessage, it should call dispose and then
pass it to this method to make it available for reuse, instead of letting it be garbage collected.
@param obj The LBMMessage object that the application is done with and is ready for reuse

### retrieveMessage

```java
public LBMMessage retrieveMessage(Object cbObj)
```

LBM will call this method to attempt to retrieve a LBMMessage object instance that it can use
instead of creating a new instance to reduce garbage collection.  It will reset the state of
the LBMMessage once it is retrieved and then use it as if it were a new instance.  Returning null
causes LBM to create a new instance as if there were no recycler.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return Either null or a valid LBMMessage object will be returned

### doneWithReceiverStatistics

```java
public void doneWithReceiverStatistics(LBMReceiverStatistics obj)
```

Once the application is finished with the stats object, it should NOT call dispose but rather
should pass it to this method to make the object instance available for reuse, instead of letting
it be garbage collected.
@param obj The LBMReceiverStatistics object that the application is done with and is ready for reuse

### retrieveReceiverStatistics

```java
public LBMReceiverStatistics retrieveReceiverStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve a stats object instance that it can use instead of
creating a new instance to reduce garbage collection.  It will refresh the stats object and then use it
as if it were a new instance.  Returning null causes LBM to create a new instance as if there were
no recycler.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return Either null or a valid LBMReceiverStatistics object will be returned

### doneWithSourceStatistics

```java
public void doneWithSourceStatistics(LBMSourceStatistics obj)
```

Once the application is finished with the stats object, it should NOT call dispose but rather
should pass it to this method to make the object instance available for reuse, instead of letting
it be garbage collected.
@param obj The LBMSourceStatistics object that the application is done with and is ready for reuse

### retrieveSourceStatistics

```java
public LBMSourceStatistics retrieveSourceStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve a stats object instance that it can use instead of
creating a new instance to reduce garbage collection.  It will refresh the stats object and then use it
as if it were a new instance.  Returning null causes LBM to create a new instance as if there were
no recycler.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return Either null or a valid LBMSourceStatistics object will be returned

### doneWithContextStatistics

```java
public void doneWithContextStatistics(LBMContextStatistics obj)
```

Once the application is finished with the stats object, it should NOT call dispose but rather
should pass it to this method to make the object instance available for reuse, instead of letting
it be garbage collected.
@param obj The LBMContextStatistics object that the application is done with and is ready for reuse

### retrieveContextStatistics

```java
public LBMContextStatistics retrieveContextStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve a stats object instance that it can use instead of
creating a new instance to reduce garbage collection.  It will refresh the stats object and then use it
as if it were a new instance.  Returning null causes LBM to create a new instance as if there were
no recycler.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return Either null or a valid LBMContextStatistics object will be returned

### doneWithImmediateMessageReceiverStatistics

```java
public void doneWithImmediateMessageReceiverStatistics(LBMImmediateMessageReceiverStatistics obj)
```

Once the application is finished with the stats object, it should NOT call dispose but rather
should pass it to this method to make the object instance available for reuse, instead of letting
it be garbage collected.
@param obj The LBMImmediateMessageReceiverStatistics object that the application is done with
and is ready for reuse

### retrieveImmediateMessageReceiverStatistics

```java
public LBMImmediateMessageReceiverStatistics retrieveImmediateMessageReceiverStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve a stats object instance that it can use instead of
creating a new instance to reduce garbage collection.  It will refresh the stats object and then use it
as if it were a new instance.  Returning null causes LBM to create a new instance as if there were
no recycler.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return Either null or a valid LBMImmediateMessageReceiverStatistics object will be returned

### doneWithImmediateMessageSourceStatistics

```java
public void doneWithImmediateMessageSourceStatistics(LBMImmediateMessageSourceStatistics obj)
```

Once the application is finished with the stats object, it should NOT call dispose but rather
should pass it to this method to make the object instance available for reuse, instead of letting
it be garbage collected.
@param obj The LBMImmediateMessageSourceStatistics object that the application is done with
and is ready for reuse

### retrieveImmediateMessageSourceStatistics

```java
public LBMImmediateMessageSourceStatistics retrieveImmediateMessageSourceStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve a stats object instance that it can use instead of
creating a new instance to reduce garbage collection.  It will refresh the stats object and then use it
as if it were a new instance.  Returning null causes LBM to create a new instance as if there were
no recycler.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return Either null or a valid LBMImmediateMessageSourceStatistics object will be returned

### doneWithEventQueueStatistics

```java
public void doneWithEventQueueStatistics(LBMEventQueueStatistics obj)
```

Once the application is finished with the stats object, it should NOT call dispose but rather
should pass it to this method to make the object instance available for reuse, instead of letting
it be garbage collected.
@param obj The LBMEventQueueStatistics object that the application is done with
and is ready for reuse

### retrieveEventQueueStatistics

```java
public LBMEventQueueStatistics retrieveEventQueueStatistics(Object cbObj)
```

LBM will call this method to attempt to retrieve a stats object instance that it can use instead of
creating a new instance to reduce garbage collection.  It will refresh the stats object and then use it
as if it were a new instance.  Returning null causes LBM to create a new instance as if there were
no recycler.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return Either null or a valid LBMEventQueueStatistics object will be returned

### doneWithSourceEvent

```java
public void doneWithSourceEvent(LBMSourceEvent obj)
```

If dispose is not called on an LBMSourceEvent in the callback, it is retained for use in the application.
Once the application is finished with the LBMSourceEvent, it should call dispose and then
pass it to this method to make it available for reuse, instead of letting it be garbage collected.
@param obj The LBMSourceEvent object that the application is done with and is ready for reuse

### retrieveSourceEvent

```java
public LBMSourceEvent retrieveSourceEvent(Object cbObj)
```

LBM will call this method to attempt to retrieve an LBMSourceEvent object instance that it can use
instead of creating a new instance to reduce garbage collection.  It will reset the state of
the LBMSourceEvent once it is retrieved and then use it as if it were a new instance.  Returning null
causes LBM to create a new instance as if there were no recycler.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return Either null or a valid LBMSourceEvent object will be returned

### retrieveAsyncOperationInfo

```java
public LBMAsyncOperationInfo retrieveAsyncOperationInfo(Object cbObj)
```

LBM will call this method to attempt to retrieve an LBMAsyncOperationInfo object instance that it can use
instead of creating a new instance to reduce garbage collection.  It will reset the state of
the LBMAsyncOperationInfo once it is retrieved and then use it as if it were a new instance.  Returning null
causes LBM to create a new instance as if there were no recycler.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return Either null or a valid LBMAsyncOperationInfo object will be returned

### doneWithAsyncOperationInfo

```java
public void doneWithAsyncOperationInfo(LBMAsyncOperationInfo obj)
```

If dispose is not called on an LBMAsyncOperationInfo in the callback, it is retained for use in the application.
Once the application is finished with the LBMAsyncOperationInfo, it should call dispose and then
pass it to this method to make it available for reuse, instead of letting it be garbage collected.
@param obj The LBMAsyncOperationInfo object that the application is done with and is ready for reuse

### doneWithContextSourceEvent

```java
public void doneWithContextSourceEvent(LBMSourceEvent obj)
```

If dispose is not called on an LBMContextSourceEvent in the callback, it is retained for use in the application.
Once the application is finished with the LBMContextSourceEvent, it should call dispose and then
pass it to this method to make it available for reuse, instead of letting it be garbage collected.
@param obj The LBMContextSourceEvent object that the application is done with and is ready for reuse

### retrieveContextSourceEvent

```java
public LBMContextSourceEvent retrieveContextSourceEvent(Object cbObj)
```

LBM will call this method to attempt to retrieve an LBMContextSourceEvent object instance that it can use
instead of creating a new instance to reduce garbage collection.  It will reset the state of
the LBMContextSourceEvent once it is retrieved and then use it as if it were a new instance.  Returning null
causes LBM to create a new instance as if there were no recycler.
@param cbObj The callback object token that was stored when setting LBMObjectRecycler in the attributes
@return Either null or a valid LBMContextSourceEvent object will be returned

### close

```java
public void close()
```

A method that should be overridden by derived classes, if needed, to provide a way to clean up objects
referenced by the recycler (like stats objects).

## LBMOperationCompleteCallback

*class* `com.latencybusters.lbm.LBMOperationCompleteCallback`

### LBMOperationCompleteCallback

```java
public LBMOperationCompleteCallback()
```

Instantiate a new callback object.
Applications wishing to have a callback delivered should
extend this class and override the onOperationComplete
method.

## LBMReceiver

*class* `com.latencybusters.lbm.LBMReceiver`

### LBMReceiver

```java
public LBMReceiver(LBMContext lbmctx, LBMTopic lbmtopic, LBMReceiverCallback cb, Object cbArg) throws LBMException
```

Instantiate an LBM Receiver object associated with a given context
and topic.
    <p>
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the receiver.
@param lbmtopic LBMTopic used to initialize the receiver.
@param cb An object implementing the LBMReceiverCallback interface
@param cbArg Callback object passed as token to callback interface
@throws LBMException if an error occurs creating the receiver.

### LBMReceiver

```java
public LBMReceiver(LBMContext lbmctx, LBMTopic lbmtopic, LBMReceiverCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Instantiate an LBM Receiver object associated with a given context,
topic, and event queue.
    <p>
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the receiver.
@param lbmtopic LBMTopic used to initialize the receiver.
@param cb An object implementing the LBMReceiverCallback interface
@param cbArg Callback object passed as token to callback interface
@param lbmevq Event queue with which to associate the receiver
(all receiver events will be posted to this event queue).
@throws LBMException if an error occurs creating the receiver.

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions
@return Array of LBMConfigOption

### getAttributeValue

```java
public String getAttributeValue(String attributeName) throws LBMException
```

Returns the value of a receiver-related attribute for this receiver.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setAttributeValue

```java
public void setAttributeValue(String attributeName, String attributeValue) throws LBMException
```

Set the value of a receiver-related attribute for this receiver.
Note that this method bypasses the property list.
As such no attributes configured using this method will appear in
the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.
@see #setProperty

### setProperty

```java
public Object setProperty(String attributeName, String attributeValue)
```

Set the value of a receiver-related attribute for this receiver.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMRuntimeException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### load

```java
public void load(InputStream inStream) throws IOException
```

Reads a property (attribute) list (key and element pairs) from the
input stream.
@param inStream Input stream of bytes
@throws IOException if any I/O error occurs.
@throws LBMRuntimeException if any invalid attribute is detected in <code>inStream</code>.

### getStatistics

```java
public LBMReceiverStatistics getStatistics(String source) throws LBMException
```

Return the current set of receiver transport statistics for a particular
source.
@param source Source string (as returned by LBMMesage source())
that specifies the set of statistics to return.
@return LBMReceiverStatistics object containing the statistics
corresponding to the specified source.
@throws LBMException if any error occurred retrieving receiver statistics.

### resetStatistics

```java
public void resetStatistics(String source) throws LBMException
```

Reset the receiver transport statistics for a particular source.
@param source The string version of the source to reset statistics for.
@throws LBMException if any error occurred resetting statistics.

### getStatistics

```java
public LBMReceiverStatistics getStatistics(int maxStats) throws LBMException
```

Return the current set of receiver transport statistics for all sources.
@param maxStats Maximum number of sources
@return LBMReceiverStatistics object containing the statistics
corresponding to the specified number of sources
@throws LBMException if any error occurred retrieving receiver statistics.

### resetStatistics

```java
public void resetStatistics() throws LBMException
```

Reset the receiver transport statistics for all sources.
@throws LBMException if any error occurred resetting statistics.

### subscribeChannel

```java
public void subscribeChannel(long channelNumber, LBMReceiverCallback cb, Object cbArg) throws LBMException
```

Subscribe to a given channel

### unsubscribeChannel

```java
public void unsubscribeChannel(long channelNumber) throws LBMException
```

Cancel an existing subscription

## LBMReceiverAttributes

*class* `com.latencybusters.lbm.LBMReceiverAttributes`

### LBMReceiverAttributes

```java
public LBMReceiverAttributes() throws LBMException
```

Create and fill an LBMReceiverAttributes object with the current default values.
@throws LBMException

### LBMReceiverAttributes

```java
public LBMReceiverAttributes(String contextName, String topic) throws LBMException
```

Create and fill an LBMReceiverAttributes object with the current default values for the given context name and receiver topic name.
@param contextName Context name string.
@param topic Receiver topic name string.
@throws LBMException if the context name and / or receiver topic name is not permitted by the configuration or other operational failure.

### setFromXml

```java
public void setFromXml(String contextName, String topic) throws LBMException
```

Fill an LBMReceiverAttributes object with the default values specified by the XML configuration for the given context name and receiver topic name.
@param contextName Context name string.
@param topic Receiver topic name string.
@throws LBMException if the context name and / or receiver topic name is not permitted by the configuration or other operational failure.

### dispose

```java
public synchronized void dispose()
```

Free memory associated with this set of attributes.

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions
@return Array of LBMConfigOption

### getValue

```java
public String getValue(String attributeName) throws LBMException
```

Returns the current value of an attribute from this set of
receiver-related attributes.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setValue

```java
public void setValue(String attributeName, String attributeValue) throws LBMException
```

FOR INTERNAL INFORMATICA USE ONLY - NOT FOR DIRECT APPLICATION USEAGE.
Applications should use setProperty() instead.
Set the current value of an attribute in this set of
receiver-related attributes.  Note that this method bypasses the
property list.  As such no attributes configured using this method
will appear in the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.
@see #setProperty

### setProperty

```java
public Object setProperty(String attributeName, String attributeValue)
```

Set the current value of an attribute in this set of receiver-related
attributes.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMRuntimeException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### load

```java
public void load(InputStream inStream) throws IOException
```

Reads a property (attribute) list (key and element pairs) from the
input stream.
@param inStream Input stream of bytes
@throws IOException if any I/O error occurs.
@throws LBMRuntimeException if any invalid attribute is detected in <code>inStream</code>.

### setObjectRecycler

```java
public void setObjectRecycler(LBMObjectRecyclerBase objRec, Object objRecCbArg)
```

Set the LBM object recycler that can be used by the context to reuse LBMMessage objects as
well as LBM Context/Receiver/Source Statistics objects.
@param objRec an LBM object recycler that will be called when objects need to be retrieved
@param objRecCbArg a callback object token that will be passed in the retrieve method

### setRegistrationIdCallback

```java
public void setRegistrationIdCallback(LBMRegistrationIdCallback cb, Object cbArg)
```

Register a callback interface (and a callback handle argument) to be
called to enable a receiver to set the registration ID it uses for a
given source (UME only).
This callback is called directly in line and does not use the event queue;
therefore, the callback function used should not block or it will block the
context thread processing.
This API may not be called from a wildcard receiver create callback. Doing so
will not result in the callbacks being called.
@param cb An object implementing the LBMRegistrationIdCallback interface
@param cbArg Callback object passed as a token to the callback interface
@see LBMRegistrationIdCallback
@see LBMWildcardReceiverCreateCallback

### setRegistrationIdCallback

```java
public void setRegistrationIdCallback(UMERegistrationIdExCallback cb, Object cbArg)
```

Register an extended callback interface (and a callback handle argument) to be
called to enable a receiver to set the registration ID it uses for a
given source (UME only).
This callback is called directly in line and does not use the event queue;
therefore, the callback function used should not block or it will block the
context thread processing.
This API may not be called from a wildcard receiver create callback. Doing so
will not result in the callbacks being called.
@param cb An object implementing the LBMRegistrationIdCallback interface
@param cbArg Callback object passed as a token to the callback interface
@see LBMRegistrationIdCallback
@see LBMWildcardReceiverCreateCallback

### setRecoverySequenceNumberCallback

```java
public void setRecoverySequenceNumberCallback(UMERecoverySequenceNumberCallback cb, Object cbArg)
```

Register an extended callback interface (and a callback handle argument) to be
called to enable a receiver to set the low sequence number it uses for
recovery events (including late joins and durable subscriptions).
This callback is called directly in line and does not use the event queue;
therefore, the callback function used should not block or it will block the
context thread processing.
This API may not be called from a wildcard receiver create callback. Doing so
will not result in the callbacks being called.
@param cb An object implementing the UMERecoverySequenceNumberCallback interface
@param cbArg Callback object passed as a token to the callback interface
@see UMERecoverySequenceNumberCallback
@see LBMWildcardReceiverCreateCallback
@since UME 2.0

### setSourceNotificationCallbacks

```java
public void setSourceNotificationCallbacks(LBMSourceCreationCallback creationCb, LBMSourceDeletionCallback deletionCb, Object cbArg) throws LBMException
```

Register callbacks for new source notifications and source deletion notifications
for sources on the topic a receiver is listening to.  Both callbacks must be set.
This API may not be called from a wildcard receiver create callback. Doing so
will not result in the callbacks being called.
@param creationCb Callback for new source notifications.
@param deletionCb Callback for source deletions.
@param cbArg Client-supplied callback object that will be passed into both the new source and source deletion callbacks.
@throws LBMException if both source creation and source deletion callbacks are not specified at once.
@since LBM 3.3, UME 2.0
@see LBMWildcardReceiverCreateCallback

### setSourceNotificationExCallbacks

```java
public void setSourceNotificationExCallbacks(LBMSourceCreationExCallback creationCb, LBMSourceDeletionExCallback deletionCb, Object cbArg) throws LBMException
```

Register extended callbacks for new source notifications and source deletion notifications
for sources on the topic a receiver is listening to.  Both callbacks must be set.
This API may not be called from a wildcard receiver create callback. Doing so
will not result in the callbacks being called.
@param creationCb Extended Callback for new source notifications.
@param deletionCb Extended Callback for source deletions.
@param cbArg Client-supplied callback object that will be passed into both the new sourceex and source deletion ex callbacks.
@throws LBMException if both source creation and source deletion extended callbacks are not specified at once.
@since LBM 6.17.1

### enableSingleReceiverCallback

```java
public void enableSingleReceiverCallback(boolean enable)
```

Used to enable or disable single receiver callbacks. This means that when the application creates a receiver,
wildcard receiver, or hotfailover receiver with these attributes, an LBMReceiverCallback must also be supplied.
This receiver callback then becomes the one and only callback for that receiver. The addReceiver and removeReceiver
methods of the various receiver classes become no-ops. The benefit is removal of synchronization code and iteration
over a list of callbacks, which can help speed up message delivery.
<p>
Enabling this is recommended for SMX and any application that does not use addReceiver() or removeReceiver().
@param enable allow Enable or disable addReceiver and removeReceiver

## LBMReceiverCallback

*interface* `com.latencybusters.lbm.LBMReceiverCallback`

### onReceive

```java
int onReceive(Object cbArg, LBMMessage lbmmsg)
```

Received data callback.
@param lbmmsg LBMMessage object encapsulating the received data
@param cbArg Callback object token
@return all return values are ignored

## LBMReceiverStatistics

*class* `com.latencybusters.lbm.LBMReceiverStatistics`

### LBMReceiverStatistics

```java
public LBMReceiverStatistics()
```

Instantiate an empty object containing no statistics.
@see #refresh

### LBMReceiverStatistics

```java
public LBMReceiverStatistics(UMMonAttributes attributes, ReceiverTransport rcvStats) throws LBMException
```

Instantiate object containing the set of receiver transport statistics
for a given receiver transport.
@param attributes An UMMonAttributesProtos.UMMonAttributes
@param rcvStats An UMSMonProtos.Stats.ReceiverTransport
@throws LBMException if any error occurred retrieving receiver statistics.

### LBMReceiverStatistics

```java
public LBMReceiverStatistics(LBMMonitorReceiver lbmmonrcv, ByteBuffer attributeBuffer, ByteBuffer rcvStats) throws LBMException
```

Instantiate object containing the set of receiver transport statistics
for a given receiver transport.
@param lbmmonrcv LBMMonitorReceiver that received this packet.
@param attributeBuffer A ByteBuffer of packet attributes passed to the passthrough callback
@param rcvStats A ByteBuffer of CSV statistics passed to the passthrough callback
@throws LBMException if any error occurred parsing receiver statistics.

### LBMReceiverStatistics

```java
public LBMReceiverStatistics(LBMReceiver lbmrcv, int maxStats) throws LBMException
```

Instantiate object containing the aggregate set of statistics
for a particular receiver.
This constructor will throw LBMMonitorEInvalException if maxStats
is less than the available number of transport statistical sets.
@param lbmrcv LBMReceiver object
@param maxStats Maximum number of sources
@throws LBMException if any error occurred retrieving receiver statistics.
@see #refresh

### LBMReceiverStatistics

```java
public LBMReceiverStatistics(LBMContext lbmctx, int maxStats) throws LBMException
```

Instantiate object containing the aggregate set of statistics
for a particular context.
This constructor will throw LBMMonitorEInvalException if maxStats
is less than the available number of transport statistical sets.
@param lbmctx LBMContext object
@param maxStats Maximum number of sources
@throws LBMException if any error occurred retrieving receiver statistics.
@see #refresh

### LBMReceiverStatistics

```java
public LBMReceiverStatistics(LBMReceiver lbmrcv, String source) throws LBMException
```

Instantiate object containing the current set of statistics
for a particular receiver and source
@param lbmrcv LBMReceiver object
@param source Source string (as returned by LBMMesage source())
that specifies the set of statistics to retrieve.
@throws LBMException if any error occurred retrieving receiver statistics.
@see #refresh

### refresh

```java
public void refresh(LBMReceiver lbmrcv, int maxStats) throws LBMException
```

Refresh the aggregate set of statistics for a particular receiver.
This method will throw LBMMonitorEInvalException if maxStats
is less than the available number of transport statistical sets.
@param lbmrcv LBMReceiver object
@param maxStats Maximum number of sources
@throws LBMException if any error occurred retrieving receiver statistics.

### refresh

```java
public void refresh(LBMContext lbmctx, int maxStats) throws LBMException
```

Refresh the aggregate set of statistics for a particular context.
This method will throw LBMMonitorEInvalException if maxStats
is less than the available number of transport statistical sets.
@param lbmctx LBMContext object
@param maxStats Maximum number of sources
@throws LBMException if any error occurred retrieving receiver statistics.

### refresh

```java
public void refresh(LBMReceiver lbmrcv, String source) throws LBMException
```

Refresh the set of statistics for a particular receiver and source
@param lbmrcv LBMReceiver object
@param source Source string (as returned by LBMMesage source())
that specifies the set of statistics to retrieve.
@throws LBMException if any error occurred retrieving receiver statistics.

### dispose

```java
public void dispose()
```

Free memory associated with this set of statistics.

### size

```java
public int size()
```

Number of transport statistical sets encapsulated within this object
@return Statistical set size

### type

```java
public int type() throws LBMException
```

Transport type (TCP, LBT-RM, LBT-RU, etc.).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@return Transport type
@throws LBMException if any error occurred retrieving receiver statistics.
@see LBM
@see #LBMReceiverStatistics(LBMReceiver, String)

### type

```java
public int type(int n) throws LBMException
```

Transport type (TCP, LBT-RM, LBT-RU, etc.).
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Transport type
@throws LBMException if any error occurred retrieving receiver statistics.
@see LBM

### typeName

```java
public String typeName() throws LBMException
```

Transport type name (TCP, LBT-RM, LBT-RU, etc.).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@return Transport type name
@throws LBMException if any error occurred retrieving receiver statistics.
@see #LBMReceiverStatistics(LBMReceiver, String)

### typeName

```java
public String typeName(int n) throws LBMException
```

Transport type name (TCP, LBT-RM, LBT-RU, etc.).
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Transport type name
@throws LBMException if any error occurred retrieving receiver statistics.

### source

```java
public String source() throws LBMException
```

Source of transport as a string.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see LBMTransportSourceInfo
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Source of transport as a string
@throws LBMException if any error occurred retrieving receiver statistics.

### source

```java
public String source(int n) throws LBMException
```

Source of transport as a string.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
This method returns a value from the nth set of statistics
encapsulated within this object.
@see LBMTransportSourceInfo
@param n Statistics set index
@return Source of transport as a string
@throws LBMException if any error occurred retrieving receiver statistics.

### bytesReceived

```java
public long bytesReceived() throws LBMException
```

Number of datagram bytes received (TCP, LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA)
or complete message bytes received (BROKER).
The total of lengths of all transport packets, including UM header information (except BROKER).
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@return Number of bytes received
@throws LBMException if any error occurred retrieving receiver statistics.
@see #LBMReceiverStatistics(LBMReceiver, String)

### bytesReceived

```java
public long bytesReceived(int n) throws LBMException
```

Number of datagram bytes received (TCP, LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA)
or complete message bytes received (BROKER).
The total of lengths of all transport packets, including UM header information (except BROKER).
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of bytes received
@throws LBMException if any error occurred retrieving receiver statistics.

### messagesReceived

```java
public long messagesReceived() throws LBMException
```

Number of datagrams received (LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA)
or complete messages received (BROKER).
Depending on batching settings, a single datagram may contain one or more messages, or a
fragment of a larger message. Larger messages are split into fragment sizes limited by
the transport's configuration option transport_xxxx_datagram_max_size.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of datagrams received.
@throws LBMException if any error occurred retrieving receiver statistics.

### messagesReceived

```java
public long messagesReceived(int n) throws LBMException
```

Number of datagrams received (LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA)
or complete messages received (BROKER).
Depending on batching settings, a single datagram may contain one or more messages, or a
fragment of a larger message. Larger messages are split into fragment sizes limited by
the transport's configuration option transport_xxxx_datagram_max_size.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagrams received.
@throws LBMException if any error occurred retrieving receiver statistics.

### nakPacketsSent

```java
public long nakPacketsSent() throws LBMException
```

Number of NAK packets sent by the receiver transport (LBT-RM, LBT-RU).
UM batches NAKs into NAK packets to save network bandwidth. This should always be less
than or equal to the number of individual NAKs sent (naksSent, below).
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of NAK packets sent by the receiver transport
@throws LBMException if any error occurred retrieving receiver statistics.

### nakPacketsSent

```java
public long nakPacketsSent(int n) throws LBMException
```

Number of NAK packets sent by the receiver transport (LBT-RM, LBT-RU).
UM batches NAKs into NAK packets to save network bandwidth. This should always be less
than or equal to the number of individual NAKs sent (naksSent, below).
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of NAK packets sent by the receiver transport
@throws LBMException if any error occurred retrieving receiver statistics.

### naksSent

```java
public long naksSent() throws LBMException
```

Number of individual NAKs sent by the receiver transport (LBT-RM, LBT-RU).
This may differ from the tally of lost datagrams (below) due to reasons such as
<ul>
<li>
Other receiver transports may have already sent a NAK for the same lost datagram,
resulting in a retransmitted lost datagram (or an NCF) to arrive at this receiver
transport before it has a chance to issue a NAK, or
<li>
During periods of heavy loss, receiver transports may be forced to issue multiple NAKs
per lost datagram (controlled by configuration options
transport_lbtrm_nak_generation_interval and transport_lbtrm_nak_backoff_interval) until
either the retransmission is received or the datagram is declared unrecovered (which may
ultimately lead to UM delivering an LBM_MSG_UNRECOVERABLE_LOSS notification to the
receiver application).
</ul>
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of individual NAKs sent by the receiver transport
@throws LBMException if any error occurred retrieving receiver statistics.

### naksSent

```java
public long naksSent(int n) throws LBMException
```

Number of individual NAKs sent by the receiver transport (LBT-RM, LBT-RU).
This may differ from the tally of lost datagrams (below) due to reasons such as
<ul>
<li>
Other receiver transports may have already sent a NAK for the same lost datagram,
resulting in a retransmitted lost datagram (or an NCF) to arrive at this receiver
transport before it has a chance to issue a NAK, or
<li>
During periods of heavy loss, receiver transports may be forced to issue multiple NAKs
per lost datagram (controlled by configuration options
transport_lbtrm_nak_generation_interval and transport_lbtrm_nak_backoff_interval) until
either the retransmission is received or the datagram is declared unrecovered (which may
ultimately lead to UM delivering an LBM_MSG_UNRECOVERABLE_LOSS notification to the
receiver application).
</ul>
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of individual NAKs sent by the receiver transport
@throws LBMException if any error occurred retrieving receiver statistics.

### lost

```java
public long lost() throws LBMException
```

Number of datagrams that have been detected as lost. (LBT-RM, LBT-RU).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of datagrams that have been detected as lost
@throws LBMException if any error occurred retrieving receiver statistics.

### lost

```java
public long lost(int n) throws LBMException
```

Number of datagrams that have been detected as lost. (LBT-RM, LBT-RU).
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagrams that have been detected as lost
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsIgnored

```java
public long ncfsIgnored() throws LBMException
```

Number of NCFs received from a source transport with reason code "ignored" (LBT-RM, LBT-RU).
If a source transport receives a NAK for a datagram that it has recently retransmitted,
it sends an "NCF ignored" and does not retransmit. How "recently" is determined by the
configuration option source transport_lbtrm_ignore_interval (default 500ms). If this
count is high, a receiver transport may be having trouble receiving retransmissions, or
the ignore interval may be set too long.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of NCFs received from a source transport with the reason
    code set to "ignored"
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsIgnored

```java
public long ncfsIgnored(int n) throws LBMException
```

Number of NCFs received from a source transport with reason code "ignored" (LBT-RM, LBT-RU).
If a source transport receives a NAK for a datagram that it has recently retransmitted,
it sends an "NCF ignored" and does not retransmit. How "recently" is determined by the
configuration option source transport_lbtrm_ignore_interval (default 500ms). If this
count is high, a receiver transport may be having trouble receiving retransmissions, or
the ignore interval may be set too long.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of NCFs received from a source transport with the reason
    code set to "ignored"
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsShed

```java
public long ncfsShed() throws LBMException
```

Number of NCFs received from a source transport with reason code "shed" (LBT-RM only).
When a source transport's retransmit queue and rate limiter are both at maximum, it
responds to a NAK by sending an "NCF shed", and does not retransmit. The receiver
transport should wait, then send another NAK. If this count is high, one or more crybaby
receiver transports may be clogging the source transport's retransmit queue.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of NCFs that have been received with the reason
    code set to "shed"
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsShed

```java
public long ncfsShed(int n) throws LBMException
```

Number of NCFs received from a source transport with reason code "shed" (LBT-RM only).
When a source transport's retransmit queue and rate limiter are both at maximum, it
responds to a NAK by sending an "NCF shed", and does not retransmit. The receiver
transport should wait, then send another NAK. If this count is high, one or more crybaby
receiver transports may be clogging the source transport's retransmit queue.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of NCFs that have been received with the reason
    code set to "shed"
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsRetransmissionDelay

```java
public long ncfsRetransmissionDelay() throws LBMException
```

Number of NCFs received with reason code "rx_delay" (LBT-RM, LBT-RU).
When a source transport's retransmit rate limiter prevents it from immediately
retransmitting any more lost datagrams, it responds to a NAK by sending an "NCF
rx_delay", then queues the retransmission for a later send. The receiver transport
should wait for the retransmission and not immediately send another NAK. If this count
is high, one or more crybaby receiver transports may be clogging the source transport's
retransmit queue.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of NCFs received with the reason code "rx_delay".
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsRetransmissionDelay

```java
public long ncfsRetransmissionDelay(int n) throws LBMException
```

Number of NCFs received with reason code "rx_delay" (LBT-RM, LBT-RU).
When a source transport's retransmit rate limiter prevents it from immediately
retransmitting any more lost datagrams, it responds to a NAK by sending an "NCF
rx_delay", then queues the retransmission for a later send. The receiver transport
should wait for the retransmission and not immediately send another NAK. If this count
is high, one or more crybaby receiver transports may be clogging the source transport's
retransmit queue.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of NCFs received with the reason code "rx_delay"
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsUnknown

```java
public long ncfsUnknown() throws LBMException
```

Number of NCFs received with reason code "unknown" (LBT-RM, LBT-RU).
These are NCFs with a reason code this receiver transport does not recognize. After a
delay (set by configuration option for NAK suppress interval), it resends the NAK. This
counter should never be greater than 0 unless applications linked with different
versions of Ultra Messaging software coexist on the same network.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of NCFs received with reason code "unknown"
@throws LBMException if any error occurred retrieving receiver statistics.

### ncfsUnknown

```java
public long ncfsUnknown(int n) throws LBMException
```

Number of NCFs received with reason code "unknown" (LBT-RM, LBT-RU).
These are NCFs with a reason code this receiver transport does not recognize. After a
delay (set by configuration option for NAK suppress interval), it resends the NAK. This
counter should never be greater than 0 unless applications linked with different
versions of Ultra Messaging software coexist on the same network.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of NCFs received with reason code "unknown"
@throws LBMException if any error occurred retrieving receiver statistics.

### minimumRecoveryTime

```java
public long minimumRecoveryTime() throws LBMException
```

Minimum time (in milliseconds), i.e., the shortest time recorded so far, for  a lost
message to be recovered (LBT-RM, LBT-RU ).
If this time is greater than configuration option transport_lbtrm_nak_backoff_interval,
it may be taking multiple NAKs to initiate retransmissions, indicating a lossy network.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Minimum time (in milliseconds) in which loss recovery was accomplished
@throws LBMException if any error occurred retrieving receiver statistics.

### minimumRecoveryTime

```java
public long minimumRecoveryTime(int n) throws LBMException
```

Minimum time (in milliseconds), i.e., the shortest time recorded so far, for  a lost
message to be recovered (LBT-RM, LBT-RU ).
If this time is greater than configuration option transport_lbtrm_nak_backoff_interval,
it may be taking multiple NAKs to initiate retransmissions, indicating a lossy network.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Minimum time (in milliseconds) in which loss recovery was accomplished
@throws LBMException if any error occurred retrieving receiver statistics.

### meanRecoveryTime

```java
public long meanRecoveryTime() throws LBMException
```

Mean time (in milliseconds) in which loss recovery was accomplished (LBT-RM, LBT-RU).
This is an exponentially weighted moving average (weighted to more recent) for
accumulated measured recovery times. Ideally this field should be as close to your
minimum recovery time (nak_stm_min, above) as possible. High mean recovery times
indicate a lossy network.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Mean time (in milliseconds) in which loss recovery was accomplished
@throws LBMException if any error occurred retrieving receiver statistics.

### meanRecoveryTime

```java
public long meanRecoveryTime(int n) throws LBMException
```

Mean time (in milliseconds) in which loss recovery was accomplished (LBT-RM, LBT-RU).
This is an exponentially weighted moving average (weighted to more recent) for
accumulated measured recovery times. Ideally this field should be as close to your
minimum recovery time (nak_stm_min, above) as possible. High mean recovery times
indicate a lossy network.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Mean time (in milliseconds) in which loss recovery was accomplished
@throws LBMException if any error occurred retrieving receiver statistics.

### maximumRecoveryTime

```java
public long maximumRecoveryTime() throws LBMException
```

Maximum time (in milliseconds), i.e., the longest time recorded so far, for a lost
message to be recovered (LBT-RM, LBT-RU).
If this time is near or equal to the configuration option
transport_lbtrm_nak_generation_interval setting, you have likely experienced some level
of unrecoverable loss.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Maximum time (in milliseconds) in which loss recovery was accomplished
@throws LBMException if any error occurred retrieving receiver statistics.

### maximumRecoveryTime

```java
public long maximumRecoveryTime(int n) throws LBMException
```

Maximum time (in milliseconds), i.e., the longest time recorded so far, for a lost
message to be recovered (LBT-RM, LBT-RU).
If this time is near or equal to the configuration option
transport_lbtrm_nak_generation_interval setting, you have likely experienced some level
of unrecoverable loss.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Maximum time (in milliseconds) in which loss recovery was accomplished
@throws LBMException if any error occurred retrieving receiver statistics.

### minimumNakTransmissions

```java
public long minimumNakTransmissions() throws LBMException
```

Minimum number of times per lost message that a receiver transport transmitted a NAK,
i.e., the lowest value collected so far (LBT-RM, LBT-RU).
A value greater than 1 indicates a chronically lossy network.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return  Minimum number of times per lost message that a receiver transport transmitted
a NAK
@throws LBMException if any error occurred retrieving receiver statistics.

### minimumNakTransmissions

```java
public long minimumNakTransmissions(int n) throws LBMException
```

Minimum number of times per lost message that a receiver transport transmitted a NAK,
i.e., the lowest value collected so far (LBT-RM, LBT-RU).
A value greater than 1 indicates a chronically lossy network.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return  Minimum number of times per lost message that a receiver transport transmitted
a NAK
@throws LBMException if any error occurred retrieving receiver statistics.

### meanNakTransmissions

```java
public long meanNakTransmissions() throws LBMException
```

Mean number of times per lost message that a receiver transport transmitted a NAK
(LBT-RM, LBT-RU).
If this time is near or equal to the configuration option
transport_lbtrm_nak_generation_interval setting, you have likely experienced some level
of unrecoverable loss.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Mean number of times per lost message that a receiver transport transmitted a
NAK
@throws LBMException if any error occurred retrieving receiver statistics.

### meanNakTransmissions

```java
public long meanNakTransmissions(int n) throws LBMException
```

Mean number of times per lost message that a receiver transport transmitted a NAK
(LBT-RM, LBT-RU).
If this time is near or equal to the configuration option
transport_lbtrm_nak_generation_interval setting, you have likely experienced some level
of unrecoverable loss.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Mean number of times per lost message that a receiver transport transmitted a
NAK
@throws LBMException if any error occurred retrieving receiver statistics.

### maximumNakTransmissions

```java
public long maximumNakTransmissions() throws LBMException
```

Maximum number of times per lost message that a receiver transport transmitted a NAK,
i.e., the highest value collected so far (LBT-RM, LBT-RU).
A value higher than 1 suggests that there may have been some unrecoverable loss on the
network during the sample period. A significantly high value compared to the mean
number) implies an isolated incident.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Maximum number of times per lost message that a receiver transport transmitted a
NAK
@throws LBMException if any error occurred retrieving receiver statistics.

### maximumNakTransmissions

```java
public long maximumNakTransmissions(int n) throws LBMException
```

Maximum number of times per lost message that a receiver transport transmitted a NAK,
i.e., the highest value collected so far (LBT-RM, LBT-RU).
A value higher than 1 suggests that there may have been some unrecoverable loss on the
network during the sample period. A significantly high value compared to the mean
number) implies an isolated incident.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Maximum number of times per lost message that a receiver transport transmitted a
NAK
@throws LBMException if any error occurred retrieving receiver statistics.

### duplicateMessages

```java
public long duplicateMessages() throws LBMException
```

Number of duplicate datagrams received (LBT-RM, LBT-RU).
A large number can indicate a lossy network, primarily due to other receiver transports
requesting retransmissions that this receiver transport has already successfully
received. Such duplicates require extra effort for filtering, and this should be
investigated.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of duplicate datagrams received
@throws LBMException if any error occurred retrieving receiver statistics.

### duplicateMessages

```java
public long duplicateMessages(int n) throws LBMException
```

Number of duplicate datagrams received (LBT-RM, LBT-RU).
A large number can indicate a lossy network, primarily due to other receiver transports
requesting retransmissions that this receiver transport has already successfully
received. Such duplicates require extra effort for filtering, and this should be
investigated.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of duplicate datagrams received
@throws LBMException if any error occurred retrieving receiver statistics.

### unrecoveredMessagesWindowAdvance

```java
public long unrecoveredMessagesWindowAdvance() throws LBMException
```

Number of datagrams unrecovered (LBM_MSG_UNRECOVERABLE_LOSS delivered to receiver
application) due to transmission window advance (LBT-RM, LBT-RU).
This means that the message was no longer in the source-side transmission window and
therefore not retransmitted. The window size is set by the transport configuration option
for transmission window size.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of datagrams that were unrecovered
    (LBM_MSG_UNRECOVERABLE_LOSS message was delivered) due to
    transmission window advance.
@throws LBMException if any error occurred retrieving receiver statistics.

### unrecoveredMessagesWindowAdvance

```java
public long unrecoveredMessagesWindowAdvance(int n) throws LBMException
```

Number of datagrams unrecovered (LBM_MSG_UNRECOVERABLE_LOSS delivered to receiver
application) due to transmission window advance (LBT-RM, LBT-RU).
This means that the message was no longer in the source-side transmission window and
therefore not retransmitted. The window size is set by the transport configuration option
for transmission window size.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of datagrams that were unrecovered
    (LBM_MSG_UNRECOVERABLE_LOSS message was delivered) due to
    transmission window advance.
@throws LBMException if any error occurred retrieving receiver statistics.

### unrecoveredMessagesNakGenerationTimeout

```java
public long unrecoveredMessagesNakGenerationTimeout() throws LBMException
```

Number of LBT-RM datagrams unrecovered due to a retransmission not received within the
NAK generation interval (LBT-RM, LBT-RU).
This is set by configuration option transport_lbtrm_nak_generation_interval; default
10,000ms. Note: Receivers for these messages' topics will also report related messages
as unrecoverable, with LBM_MSG_UNRECOVERABLE_LOSS for an individual message and
LBM_MSG_UNRECOVERABLE_LOSS_BURST for a burst loss event. However, it is possible for
these application-level message declarations to occur even without increments to this
counter, as the transport is unaware of the topic content of messages and may still be
trying to deliver related lost packets.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of LBT-RM datagrams unrecovered due to a retransmission not received
within the NAK generation interval.
@throws LBMException if any error occurred retrieving receiver statistics.

### unrecoveredMessagesNakGenerationTimeout

```java
public long unrecoveredMessagesNakGenerationTimeout(int n) throws LBMException
```

Number of LBT-RM datagrams unrecovered due to a retransmission not received within the
NAK generation interval (LBT-RM, LBT-RU).
This is set by configuration option transport_lbtrm_nak_generation_interval; default
10,000ms. Note: Receivers for these messages' topics will also report related messages
as unrecoverable, with LBM_MSG_UNRECOVERABLE_LOSS for an individual message and
LBM_MSG_UNRECOVERABLE_LOSS_BURST for a burst loss event. However, it is possible for
these application-level message declarations to occur even without increments to this
counter, as the transport is unaware of the topic content of messages and may still be
trying to deliver related lost packets.
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of LBT-RM datagrams unrecovered due to a retransmission not received
within the NAK generation interval.
@throws LBMException if any error occurred retrieving receiver statistics.

### lbmMessagesReceived

```java
public long lbmMessagesReceived() throws LBMException
```

Number of messages or message fragments received over a transport (TCP, LBM-RM, LBT-RU,
LBT-IPC, LBT-RDMA).
A single datagram may contain one or more messages or a fragment of a larger message.
For fragmented messages larger than the transport's maximum size configuration option,
this count reflects the number of datagrams used to constitute those messages. Thus,
this number is equal to or greater than the datagram counter (messagesReceived, above).
This number also includes messages received for which there was no interested receiver,
tallied in the noTopicMessagesReceived counter (below).
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of messages or message fragments received over a transport
@throws LBMException if any error occurred retrieving receiver statistics.

### lbmMessagesReceived

```java
public long lbmMessagesReceived(int n) throws LBMException
```

Number of messages or message fragments received over a transport (TCP, LBM-RM, LBT-RU,
LBT-IPC, LBT-RDMA).
A single datagram may contain one or more messages or a fragment of a larger message.
For fragmented messages larger than the transport's maximum size configuration option,
this count reflects the number of datagrams used to constitute those messages. Thus,
this number is equal to or greater than the datagram counter (messagesReceived, above).
This number also includes messages received for which there was no interested receiver,
tallied in the noTopicMessagesReceived counter (below).
encapsulated within this object.
@param n Statistics set index
@return Number of messages or message fragments received over a transport
@throws LBMException if any error occurred retrieving receiver statistics.

### lbmRequestsReceived

```java
public long lbmRequestsReceived() throws LBMException
```

Number of UM request messages received (message type LBM_MSG_REQUEST) (TCP, LBM-RM,
LBT-RU, LBT-IPC, LBT-RDMA).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of UM request messages received (message type LBM_MSG_REQUEST)
@throws LBMException if any error occurred retrieving receiver statistics.

### lbmRequestsReceived

```java
public long lbmRequestsReceived(int n) throws LBMException
```

Number of UM request messages received (message type LBM_MSG_REQUEST) (TCP, LBM-RM,
LBT-RU, LBT-IPC, LBT-RDMA).
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of UM request messages received (message type LBM_MSG_REQUEST)
@throws LBMException if any error occurred retrieving receiver statistics.

### noTopicMessagesReceived

```java
public long noTopicMessagesReceived() throws LBMException
```

Number of messages received that were not for a topic of interest to the receiver
    (TCP, LBM-RM, LBT-RU, LBT-IPC, LBT-RDMA).
A high value (relative to, or approaching lbmMessagesReceived above) indicates more CPU
time required to filter out uninteresting topics, in which case, consider reconfiguring
sources to filter more aggressively at the transport layer.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@see #LBMReceiverStatistics(LBMReceiver, String)
@return Number of messages received that were not for a topic of interest to the
receiver
@throws LBMException if any error occurred retrieving receiver statistics.

### noTopicMessagesReceived

```java
public long noTopicMessagesReceived(int n) throws LBMException
```

Number of messages received that were not for a topic of interest to the receiver
    (TCP, LBM-RM, LBT-RU, LBT-IPC, LBT-RDMA).
A high value (relative to, or approaching lbmMessagesReceived above) indicates more CPU
time required to filter out uninteresting topics, in which case, consider reconfiguring
sources to filter more aggressively at the transport layer.
    This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Number of messages received that were not for a topic of interest to the
receiver
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedIncorrectSize

```java
public long datagramsDroppedIncorrectSize() throws LBMException
```

Number of datagrams discarded due to being smaller than the size designated in the
datagram's size field.
@return Number of datagrams discarded due to size
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedIncorrectSize

```java
public long datagramsDroppedIncorrectSize(int n) throws LBMException
```

Number of datagrams discarded due to being smaller than the size designated in the
datagram's size field.
@param n Statistics set index
@return Number of datagrams discarded due to size
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedType

```java
public long datagramsDroppedType() throws LBMException
```

Number of datagrams discarded due to bad packet type.
The datagram's type field must match the expectations of the receiver transport.
@return Number of datagrams discarded due to bad packet type
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedType

```java
public long datagramsDroppedType(int n) throws LBMException
```

Number of datagrams discarded due to bad packet type.
The datagram's type field must match the expectations of the receiver transport.
@param n Statistics set index
@return Number of datagrams discarded due to bad packet type
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedVersion

```java
public long datagramsDroppedVersion() throws LBMException
```

Number of datagrams discarded due to version mismatch.
The datagram's version field must match the expectations of the receiver transport.
@return Number of datagrams discarded due to version mismatch
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedVersion

```java
public long datagramsDroppedVersion(int n) throws LBMException
```

Number of datagrams discarded due to version mismatch.
The datagram's version field must match the expectations of the receiver transport.
@param n Statistics set index
@return Number of datagrams discarded due to version mismatch
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedHeader

```java
public long datagramsDroppedHeader() throws LBMException
```

Number of datagrams discarded due to bad header type.
These datagrams appeared to be intact, but with an unrecognizable header format.
@return Number of datagrams discarded due to bad header type
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedHeader

```java
public long datagramsDroppedHeader(int n) throws LBMException
```

Number of datagrams discarded due to bad header type.
These datagrams appeared to be intact, but with an unrecognizable header format.
@param n Statistics set index
@return Number of datagrams discarded due to bad header type
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedOther

```java
public long datagramsDroppedOther() throws LBMException
```

Number of unrecognizable datagrams discarded due to reasons other than those
determined by the above counts.
They could be garbled, or possibly be from foreign or
incompatible software at the other end.
@return Number of datagrams discarded for other reasons
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedOther

```java
public long datagramsDroppedOther(int n) throws LBMException
```

Number of unrecognizable datagrams discarded due to reasons other than those
determined by the above counts.
They could be garbled, or possibly be from foreign or
incompatible software at the other end.
@param n Statistics set index
@return Number of datagrams discarded for other reasons
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedSID

```java
public long datagramsDroppedSID() throws LBMException
```

Number of datagrams discarded due to session ID mismatch.
These datagrams appeared to be correctly formed, but with an unmatched/unrecognized
session ID field.
@return Number of datagrams discarded due to session ID mismatch
@throws LBMException if any error occurred retrieving receiver statistics.

### datagramsDroppedSID

```java
public long datagramsDroppedSID(int n) throws LBMException
```

Number of datagrams discarded due to session ID mismatch.
These datagrams appeared to be correctly formed, but with an unmatched/unrecognized
session ID field.
@param n Statistics set index
@return Number of datagrams discarded due to session ID mismatch
@throws LBMException if any error occurred retrieving receiver statistics.

### outOfOrder

```java
public long outOfOrder() throws LBMException
```

Number of out-of-order datagrams received.
A datagram is counted as out of order if it fills a previously detected sequence gap,
but is not a retransmission. Note that if the duplicates counter duplicate_data,
above) increases along with this statistic, this implies the arrivals of
retransmitted datagrams before their originals.
@return Number of out-of-order datagrams received
@throws LBMException if any error occurred retrieving receiver statistics.

### outOfOrder

```java
public long outOfOrder(int n) throws LBMException
```

Number of out-of-order datagrams received.
A datagram is counted as out of order if it fills a previously detected sequence gap,
but is not a retransmission. Note that if the duplicates counter duplicate_data,
above) increases along with this statistic, this implies the arrivals of
retransmitted datagrams before their originals.
@param n Statistics set index
@return Number of out-of-order datagrams received
@throws LBMException if any error occurred retrieving receiver statistics.

## LBMRegistrationIdCallback

*interface* `com.latencybusters.lbm.LBMRegistrationIdCallback`

### setRegistrationId

```java
long setRegistrationId(Object cbArg, String source, long sourceRegId)
```

Callback to set a receiver registration ID (UME only)
@param cbArg Callback object token
@param source Name of the source for the ID.
@param sourceRegId Registration ID for the source.
@return Registration ID to be used by the receiver

## LBMRequest

*class* `com.latencybusters.lbm.LBMRequest`

### LBMRequest

```java
public LBMRequest()
```

Instantiate an LBM Request object

### LBMRequest

```java
public LBMRequest(byte [] data, int dataLength)
```

Instantiate an LBM Request object with a specified message data byte array and length.
@param data A byte array containing message data.
@param dataLength An int representing the number of bytes in the message data.

### close

```java
public void close() throws LBMException
```

Close this request.
    <p>
    <b>Warning</b>:  It is not safe to call this method from a context thread callback.
@throws LBMException if any error occurs deleting the request.

### data

```java
public byte [] data()
```

Get request data.
@return Byte array associated with this request

### dataLength

```java
public int dataLength()
```

Get request data length
@return Length of data array associated with this request

### data

```java
public void data(byte [] data, int dataLength)
```

Set request data.
@param data Data byte array
@param dataLength Length of data byte array

### addResponseCallback

```java
public void addResponseCallback(LBMResponseCallback cb)
```

Register a callback to be invoked when a response is received
for this request.
@param cb Object implementing the LBMResponseCallback interface
@see LBMResponseCallback
@see #removeResponseCallback

### addResponseCallback

```java
public void addResponseCallback(LBMResponseCallback cb, Object cbArg)
```

Register a callback to be invoked when a response is received
for this request.
@param cb Object implementing the LBMResponseCallback interface
@param cbArg Callback token object
@see LBMResponseCallback
@see #removeResponseCallback

### removeResponseCallback

```java
public void removeResponseCallback(LBMResponseCallback cb)
```

Deregister a request response callback
@param cb Previously registered callback object implementing the
LBMResponseCallback interface
@see LBMResponseCallback
@see #addResponseCallback

### removeResponseCallback

```java
public void removeResponseCallback(LBMResponseCallback cb, Object cbArg)
```

Deregister a request response callback
@param cb Previously registered callback object implementing the
LBMResponseCallback interface
@param cbArg Token for previously registered callback
@see LBMResponseCallback
@see #addResponseCallback

## LBMResolverEvent

*class* `com.latencybusters.lbm.LBMResolverEvent`

### LBMResolverEvent

```java
public LBMResolverEvent()
```

Constructor

### getAdvertisementEvent

```java
public LBMResolverEventAdvertisement getAdvertisementEvent()
```

Send returns LBMResolverEventAdvertisement
@return an LBMResolverEventAdvertisement object.

### setAdvertisementEvent

```java
public void setAdvertisementEvent(LBMResolverEventAdvertisement ev)
```

Assigns value to the _advertisementEvent

### getType

```java
public int getType()
```

Returns the type of the Event
@return _type corresponding to the specified attribute name

### setType

```java
public void setType(int type)
```

Populates the Event Type field

## LBMResolverEventAdvertisement

*class* `com.latencybusters.lbm.LBMResolverEventAdvertisement`

### setEventParameters

```java
public void setEventParameters(String tstring, String transport, long tidx, long doidx, byte[] otidx, int stype, long iflags,long did, int cap_flags, long ver, byte src_id_type, byte [] src_id)
```

Set the private members of the LBMResolverEventAdvertisement objects
@param tstring Topic name to send message to or null for non-topic
@param transport Transport string
@param tidx Topic index
@param doidx Source domain ID
@param otidx Source OTID
@param stype Type of source (ULB, UMQ, UME, ...)
@param iflags Infomation about available options
@param did Sender's domain ID
@param cap_flags Capabilities of the source (UME,UMQ)
@param ver UM Version of the source
@param src_id_type Type of the source ID
@param src_id Source ID
See next section for possible OR'd set of values.
@return void

### getTopicIndex

```java
public long getTopicIndex()
```

Returns Topic Index
@return topic_index

### getDomainID

```java
public long getDomainID()
```

Returns source_domain_id
@return source_domain_id

### getOTID

```java
public byte[] getOTID()
```

Returns otid
@return otid

### getSourceType

```java
public int getSourceType()
```

Returns source_type
@return source_type

### getTopicString

```java
public String getTopicString()
```

Returns topic_string
@return topic_string

### getTransportString

```java
public String getTransportString()
```

Returns transport_string
@return transport_string

### getInfoFlags

```java
public long getInfoFlags()
```

Returns info_flags
@return info_flags

### getSenderDomainId

```java
public long getSenderDomainId()
```

Returns domain_id of sender
@return domain_id

### getCapabilityFlags

```java
public int getCapabilityFlags()
```

Returns capability_flags
@return capability_flags

### getVersion

```java
public long getVersion()
```

Returns version
@return version

### getSourceIdType

```java
public byte getSourceIdType()
```

Returns source_id_type
@return source_id_type

### getSourceId

```java
public byte [] getSourceId()
```

Returns source_id
@return source_id

## LBMResolverEventCallback

*interface* `com.latencybusters.lbm.LBMResolverEventCallback`

### onResolverEvent

```java
long onResolverEvent(Object cbArg, LBMResolverEvent evt)
```

Callback for resolver events
@param cbArg Callback object token
@param evt LBMResolverEvent object
@return Always returns 0

## LBMResponseCallback

*interface* `com.latencybusters.lbm.LBMResponseCallback`

### onResponse

```java
int onResponse(Object cbArg, LBMRequest lbmreq, LBMMessage lbmmsg)
```

Response data callback.
@param cbArg Callback object token
@param lbmreq LBMRequest object corresponding to the original request
@param lbmmsg LBMMessage object encapsulating the response data
@return an int, which should always be 0.

## LBMRuntimeException

*class* `com.latencybusters.lbm.LBMRuntimeException`

### LBMRuntimeException

```java
public LBMRuntimeException(String errorMessage)
```

Internally used constructor which sets the error number to LBM.EOP

### errorNumber

```java
public int errorNumber()
```

Get LBM error number.
@return LBM error number

## LBMSSource

*class* `com.latencybusters.lbm.LBMSSource`

### LBMSSource

```java
public LBMSSource(LBMContext lbmctx, LBMTopic lbmtopic) throws LBMException
```

Instantiate an LBM SmartSource object associated with a given context
and topic.

In addition to creating the Smart Source object, this function also creates message
buffers associated with the source and transport session.

See \ref smartsources for more information.  See also \ref grpsmartsource for
configuration information.

    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the source.
@param lbmtopic LBMTopic used to initialize the source.
@throws LBMException if any error occurred during source creation.

### LBMSSource

```java
public LBMSSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMSourceEventCallback cb, Object cbArg) throws LBMException
```

Instantiate an LBM SmartSource object associated with a given context
and topic and initialize source event callback.

In addition to creating the Smart Source object, this function also creates message
buffers associated with the source and transport session.

See \ref smartsources for more information.  See also \ref grpsmartsource for
configuration information.

    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the source.
@param lbmtopic LBMTopic used to initialize the source.
@param cb An object implementing the LBMSourceEventCallback interface
@param cbArg Callback token object
@throws LBMException if any error occurred during source creation.

### LBMSSource

```java
public LBMSSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMEventQueue lbmevq) throws LBMException
```

Instantiate an LBM SmartSource object associated with a given context,
topic, and event queue.

In addition to creating the Smart Source object, this function also creates message
buffers associated with the source and transport session.

See \ref smartsources for more information.  See also \ref grpsmartsource for
configuration information.

    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the source.
@param lbmtopic LBMTopic used to initialize the source.
@param lbmevq Event queue with which to associate the source
(all source events will be posted to this event queue).
@throws LBMException if any error occurred during source creation.

### LBMSSource

```java
public LBMSSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMSourceEventCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Instantiate an LBM SmartSource object associated with a given context,
topic, and event queue and initialize source event callback.

In addition to creating the Smart Source object, this function also creates message
buffers associated with the source and transport session.

See \ref smartsources for more information.  See also \ref grpsmartsource for
configuration information.

    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the source.
@param lbmtopic LBMTopic used to initialize the source.
@param cb An object implementing the LBMSourceEventCallback interface
@param cbArg Callback token object
@param lbmevq Event Queues not supported at this time
@throws LBMException if any error occurred during source creation.

### umederegister

```java
public void umederegister() throws LBMException
```

Deregister this smart source
    <p>
    <b>Warning</b>: It is not safe to call this method from a context thread callback.
@throws LBMException if any error occurred during source deletion.

### close

```java
public void close() throws LBMException
```

Close this source.

Note that this function can return while the
source callback may still be executing if source events are being delivered
via an event queue.

See \ref smartsources for more information on Smart Sources.  See also \ref grpsmartsource for
configuration information.

    <b>Warning</b>: It is not safe to call this method from a context thread callback.
@throws LBMException if any error occurred during source deletion.

### isClosed

```java
public boolean isClosed()
```

Returns boolean describing whether this instance has a reference
          to a valid C source
@return boolean describing whether this instance has a reference
          to a valid C source

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions
@return Array of LBMConfigOption

### addSSourceCallback

```java
public void addSSourceCallback(LBMSourceEventCallback cb)
```

Register a source event callback
@param cb Object implementing the LBMSourceEventCallback interface
@see LBMSourceEventCallback
@see #removeSSourceCallback

### addSSourceCallback

```java
public void addSSourceCallback(LBMSourceEventCallback cb, Object cbArg)
```

Register a source event callback (and callback token)
@param cb Object implementing the LBMSourceEventCallback interface
@param cbArg Callback token object
@see LBMSourceEventCallback
@see #removeSSourceCallback

### removeSSourceCallback

```java
public void removeSSourceCallback(LBMSourceEventCallback cb)
```

Deregister a source event callback
@param cb Previously registered object implementing the
LBMSourceEventCallback interface
@see LBMSourceEventCallback
@see #addSSourceCallback

### removeSSourceCallback

```java
public void removeSSourceCallback(LBMSourceEventCallback cb, Object cbArg)
```

Deregister a source event callback (and callback token)
@param cb Previously registered object implementing the
LBMSourceEventCallback interface
@param cbArg Callback token object
@see LBMSourceEventCallback
@see #addSSourceCallback

### getAttributeValue

```java
public String getAttributeValue(String attributeName) throws LBMException
```

Returns the value of a source-related attribute for this source.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setAttributeValue

```java
public void setAttributeValue(String attributeName, String attributeValue) throws LBMException
```

Set the value of a source-related attribute for this source.
Note that this method bypasses the property list.
As such no attributes configured using this method will appear in
the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### getStatistics

```java
public LBMSourceStatistics getStatistics() throws LBMException
```

Return the current set of source transport statistics for this
source.
@return LBMSourceStatistics object containing the statistics
corresponding to this source.
@throws LBMException if any error occurred retrieving source statistics.

### resetStatistics

```java
public void resetStatistics() throws LBMException
```

Reset the transport statistics for this source.
@throws LBMException if any error occurred resetting source statistics.

### send

```java
public void send(ByteBuffer message, int messageLength, int flags) throws LBMException
```

Send a message using a pre-allocated buffer to the topic associated with the LBM Smart Source.

See \ref smartsources for more information.  See also \ref grpsmartsource for
configuration information.

@param message Data to send in this message.  This must be a buffer retrieved via the buffGet() method from this SmartSource.
@param messageLength Number of bytes of data to send in this message
@param flags Flags indicating various conditions.
\b NOT \b USED \b AT \b THIS \b TIME.  Pass in zero (0).
@throws LBMException if any error occurred during sending.

### send

```java
public void send(ByteBuffer message, int startPosition, int messageLength, int flags) throws LBMException
```

Send a message using a pre-allocated buffer to the topic associated with the LBM Smart Source.

See \ref smartsources for more information.  See also \ref grpsmartsource for
configuration information.

@param message Data to send in this message.  This must be a buffer retrieved via the buffGet() method from this SmartSource.
@param startPosition Must be set to 0
@param messageLength Number of bytes of data to send in this message
@param flags Flags indicating various conditions.
\b NOT \b USED \b AT \b THIS \b TIME.  Pass in zero (0).
@throws LBMException if any error occurred during sending.

### send

```java
public void send(ByteBuffer message, int messageLength, int flags, LBMSSourceSendExInfo exinfo) throws LBMException
```

Send a message using a pre-allocated buffer to the topic associated with the LBM Smart Source.

See \ref smartsources for more information.  See also \ref grpsmartsource for
configuration information.

@param message Data to send in this message.  This must be a buffer retrieved via the buffGet() method from this SmartSource.
@param messageLength Number of bytes of data to send in this message
@param flags Flags indicating various conditions.
\b NOT \b USED \b AT \b THIS \b TIME.  Pass in zero (0).
@param exinfo LBMSSourceSendExInfo object
@throws LBMException if any error occurred during sending.
@see LBMSSourceSendExInfo

### send

```java
public void send(ByteBuffer message, int startPosition, int messageLength, int flags, LBMSSourceSendExInfo exinfo) throws LBMException
```

Send a message using a pre-allocated buffer to the topic associated with the LBM Smart Source.

See \ref smartsources for more information.  See also \ref grpsmartsource for
configuration information.

@param message Data to send in this message.  This must be a buffer retrieved via the buffGet() method from this SmartSource.
@param startPosition Must be set to 0
@param messageLength Number of bytes of data to send in this message
@param flags Flags indicating various conditions.
\b NOT \b USED \b AT \b THIS \b TIME.  Pass in zero (0).
@param exinfo LBMSSourceSendExInfo object; used to set callback behavior
flags and to pass back a user-supplied object. (UME only)
@throws LBMException if any error occurred during sending.
@see LBMSSourceSendExInfo

### buffGet

```java
public ByteBuffer buffGet() throws LBMException
```

Return a ByteBuffer that has a SmartSource pre-allocated buffer associated with it.

See \ref smartsources for more information on Smart Sources.  See also \ref grpsmartsource for
configuration information.

@return ByteBuffer object that can be filled in with the message to be sent.
@throws LBMException if any error occurred retrieving a buffer.

### getSSrcInflight

```java
public int getSSrcInflight(int type) throws LBMException
```

Get the current inflight value for this smart source
@param type The type of flight size
@see LBM#FLIGHT_SIZE_TYPE_UME
@return the inflight value
@throws LBMException if an error occurs while retrieving the inflight value

### getSSrcInflightEx

```java
public LBMFlightSizeInflightInfo getSSrcInflightEx(int type) throws LBMException
```

Get the current inflight values of messages and bytes for this smart source
@param type The type of flight size
@see LBM#FLIGHT_SIZE_TYPE_UME
@return the inflight value
@throws LBMException if an error occurs while retrieving the inflight value

### setSSrcInflight

```java
public int setSSrcInflight(int type, LBMSetInflightCallback setInflightCb, Object clientd) throws LBMException
```

Set the current inflight value for this smart source.
@param type The type of flight size
@see LBM#FLIGHT_SIZE_TYPE_UME
@param setInflightCb Object that implements the LBMSetInflightCallback interface
@param clientd Clientd object passed into the setInflight callback
@return the new inflight value
@throws LBMException if an error occurs while setting the inflight value

### setSSrcInflightEx

```java
public LBMFlightSizeInflightInfo setSSrcInflightEx(int type, LBMSetInflightCallback setInflightCb, Object clientd) throws LBMException
```

Set the current inflight messages and bytes value for this smart source. The values
are set from within the provided set inflight callback with appropriate locking held.
@param type The type of flight size
@see LBM#FLIGHT_SIZE_TYPE_UME
@param setInflightCb Object that implements the LBMSetInflightCallback interface
@param clientd Clientd object passed into the setInflight callback
@return the new inflight values
@throws LBMException if an error occurs while setting the inflight value

### buffPut

```java
public void buffPut(ByteBuffer userBuff) throws LBMException
```

Return a ByteBuffer to the pool of SmartSource pre-allocated buffers for use later.

See \ref smartsources for more information on Smart Sources.  See also \ref grpsmartsource for
configuration information.

@param userBuff A ByteBuffer previously retrieved with a call to buffGet().
@throws LBMException if any error occurred returning the buffer.

### getAvailableDataSpace

```java
public int getAvailableDataSpace()
```

Return the maximum allowable message size (data space) that the configured SmartSource will allow.

See \ref smartsources for more information on Smart Sources.  See also \ref grpsmartsource for
configuration information.

@return The maximum allowable message size for this SmartSource.

## LBMSSourceSendExInfo

*class* `com.latencybusters.lbm.LBMSSourceSendExInfo`

### LBMSSourceSendExInfo

```java
public LBMSSourceSendExInfo()
```

Create an empty LBMSSourceSendExInfo object.

### LBMSSourceSendExInfo

```java
public LBMSSourceSendExInfo(int flags, Object cbArg)
```

Create an LBMSSourceSendExInfo object with flags and callback object set.
@param flags Flags to control callback behavior.
@param cbArg User-supplied client data pointer passed back with any callback.
@see LBM#SSRC_SEND_EX_FLAG_UME_CLIENTD
@see LBM#SSRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@since UM 6.11
@see LBM#SSRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@since UM 6.12

### LBMSSourceSendExInfo

```java
public LBMSSourceSendExInfo(int flags, Object cbArg, long channel)
```

Create an LBMSSourceSendExInfo object with flags, callback object and channel set
@param flags Flags that indicate which settings are active as defined by "LBM_SSRC_SEND_EX_*".
@param cbArg User-supplied client data pointer passed back with any callback.
@param channel Spectrum channel number.
@see LBM#SSRC_SEND_EX_FLAG_UME_CLIENTD
@see LBM#SSRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SSRC_SEND_EX_FLAG_CHANNEL
@see LBM#SSRC_SEND_EX_FLAG_REBUILD_BUFFER
@see LBM#SSRC_SEND_EX_FLAG_UPDATE_CHANNEL
@since UM 6.11
@see LBM#SSRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@since UM 6.12

### LBMSSourceSendExInfo

```java
public LBMSSourceSendExInfo(int flags, Object cbArg, int mprop_int_cnt, String[] mprop_int_keys, long[] mprop_int_vals)
```

Create an LBMSSourceSendExInfo object with flags, callback object  and message properties set
@param flags Flags that indicate which settings are active as defined by "LBM_SSRC_SEND_EX_*".
@param cbArg User-supplied client data pointer passed back with any callback.
@param mprop_int_cnt Message property count.
@param mprop_int_keys A list of message property key strings.
@param mprop_int_vals A list of message property unsigned 32-bit integers.
@see LBM#SSRC_SEND_EX_FLAG_UME_CLIENTD
@see LBM#SSRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SSRC_SEND_EX_FLAG_PROPERTIES
@see LBM#SSRC_SEND_EX_FLAG_REBUILD_BUFFER
@see LBM#SSRC_SEND_EX_FLAG_UPDATE_PROPERTY_VALUES
@since UM 6.11
@see LBM#SSRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@since UM 6.12

### LBMSSourceSendExInfo

```java
public LBMSSourceSendExInfo(int flags, Object cbArg, long channel, int mprop_int_cnt, String[] mprop_int_keys, long[] mprop_int_vals)
```

Create an LBMSSourceSendExInfo object with flags, callback object, channel and message properties set
@param flags Flags that indicate which settings are active as defined by "LBM_SSRC_SEND_EX_*".
@param cbArg User-supplied client data pointer passed back with any callback.
@param channel Spectrum channel number.
@param mprop_int_cnt Message property count.
@param mprop_int_keys A list of message property key strings.
@param mprop_int_vals A list of message property unsigned 32-bit integers.
@see LBM#SSRC_SEND_EX_FLAG_UME_CLIENTD
@see LBM#SSRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SSRC_SEND_EX_FLAG_CHANNEL
@see LBM#SSRC_SEND_EX_FLAG_PROPERTIES
@see LBM#SSRC_SEND_EX_FLAG_REBUILD_BUFFER
@see LBM#SSRC_SEND_EX_FLAG_UPDATE_CHANNEL
@see LBM#SSRC_SEND_EX_FLAG_UPDATE_PROPERTY_VALUES
@since UM 6.11
@see LBM#SSRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@since UM 6.12

### setClientObject

```java
public void setClientObject(Object cbArg)
```

Set the user-supplied callback object.
@param cbArg User-supplied client data pointer passed back with any callback.
@since UM 6.11

### setFlags

```java
public void setFlags(int flags)
```

Sets flags that control callback behavior.
@param flags An integer representing an OR'd value of flags to set.
@see LBM#SSRC_SEND_EX_FLAG_UME_CLIENTD
@see LBM#SSRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SSRC_SEND_EX_FLAG_CHANNEL
@see LBM#SSRC_SEND_EX_FLAG_PROPERTIES
@see LBM#SSRC_SEND_EX_FLAG_REBUILD_BUFFER
@see LBM#SSRC_SEND_EX_FLAG_UPDATE_CHANNEL
@see LBM#SSRC_SEND_EX_FLAG_UPDATE_PROPERTY_VALUES
@since UM 6.11
@see LBM#SSRC_SEND_EX_FLAG_USER_SUPPLIED_BUFFER
@since UM 6.11.1.2
@see LBM#SSRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@since UM 6.12

### setChannel

```java
public void setChannel(long channel)
```

Sets spectrum channel to be included with messages and sets the LBM.SSRC_SEND_EX_FLAG_CHANNEL flag.
@param channel Spectrum channel number.
@since UM 6.11

### setMessageProperties

```java
public void setMessageProperties(int mprop_int_cnt, String[] mprop_int_keys, long[] mprop_int_vals)
```

Sets message properties to be included with messages and sets the LBM.SSRC_SEND_EX_FLAG_PROPERTIES flag.
@param mprop_int_cnt Message property count.
@param mprop_int_keys A list of message property key strings.
@param mprop_int_vals A list of message property unsigned 32-bit integers.
@since UM 6.11

### setUserSuppliedBuffer

```java
public void setUserSuppliedBuffer(ByteBuffer userBuffer) throws LBMEInvalException
```

Sets the value of a supplied user buffer which will be used as a message buffer.
@param userBuffer The direct ByteBuffer object. Use null to unset this option
@since UM 6.11.1.2

### flags

```java
public int flags()
```

Returns currently set flags.
@return An int representing an OR'd set of currently set flags.
@see LBM#SSRC_SEND_EX_FLAG_UME_CLIENTD
@see LBM#SSRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SSRC_SEND_EX_FLAG_CHANNEL
@see LBM#SSRC_SEND_EX_FLAG_PROPERTIES
@see LBM#SSRC_SEND_EX_FLAG_REBUILD_BUFFER
@see LBM#SSRC_SEND_EX_FLAG_UPDATE_CHANNEL
@see LBM#SSRC_SEND_EX_FLAG_UPDATE_PROPERTY_VALUES
@since UM 6.11
@see LBM#SSRC_SEND_EX_FLAG_USER_SUPPLIED_BUFFER
@since UM 6.11.1.2
@see LBM#SSRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@since UM 6.12

### clientObject

```java
public Object clientObject()
```

Returns the client-supplied callback object.
@return The current client-supplied callback object.
@since UM 6.11

### getChannel

```java
public long getChannel()
```

Returns the currently set channel.
@return The current spectrum channel.
@since UM 6.11

### getMessagePropertyCnt

```java
public int getMessagePropertyCnt()
```

Returns the number of message properties to be included with messages.
@return Message property count.
@since UM 6.11

### getMessagePropertyKey

```java
public String getMessagePropertyKey(int index) throws LBMEInvalException
```

Returns the message property key at the specified index to be included with messages.
@return The message property key string at the given index.
@since UM 6.11

### getMessagePropertyValue

```java
public long getMessagePropertyValue(int index) throws LBMEInvalException
```

Returns the message property value at the specified index to be included with messages.
@return The message property value at the given index.
@since UM 6.11

### getUserSuppliedBuffer

```java
public ByteBuffer getUserSuppliedBuffer()
```

Returns the value of a previously supplied user buffer which will be used as a message buffer.
@return The direct ByteBuffer object.
@since UM 6.11.1.2

## LBMSerializedResponse

*class* `com.latencybusters.lbm.LBMSerializedResponse`

### getBytes

```java
public byte[] getBytes()
```

Gets the bytes representing the serialized response information which can be sent to
and used by another application.
@return byte[] the serialized response information as binary data

### copyBytes

```java
public void copyBytes(byte[] src, int srcPos)
```

Copies a byte[] containing serialized response information into this object so that it
can be used by the LBMContext respond method.  It will copy a length of LBMSerializedResponse.SERIAL_RESPONSE_LENGTH
from the src parameter starting at the srcPos.
@see LBMContext#respond
@param src The source byte[] containing the serialized response information as binary data to load into this object
@param srcPos The starting offset in the source byte[] which is normally 0

## LBMSetInflightCallback

*interface* `com.latencybusters.lbm.LBMSetInflightCallback`

### setInflight

```java
int setInflight(int inflight, Object cbArg)
```

Callback for setting the inflight
@param inflight Current inflight value
@param cbArg Callback object specified with setXXXInflight
@return New inflight value

## LBMSetInflightCallbackEx

*interface* `com.latencybusters.lbm.LBMSetInflightCallbackEx`

### setInflight

```java
public void setInflight(LBMFlightSizeInflightInfo inflight, Object cbArg)
```

Callback for setting the inflight messages and bytes. This method is called
with appropriate locking held such that the inflight values cannot change
during the callback. Use the getters and setters of the inflight object
to view and change the internal inflight values.
@see LBMSource#setInflightEx
@param inflight Class containing current inflight values with ability to set new values
@param cbArg Callback object specified with setInflight

## LBMSource

*class* `com.latencybusters.lbm.LBMSource`

### LBMSource

```java
public LBMSource(LBMContext lbmctx, LBMTopic lbmtopic) throws LBMException
```

Instantiate an LBM Source object associated with a given context
and topic.
    <p>
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the source.
@param lbmtopic LBMTopic used to initialize the source.
@throws LBMException if any error occurred during source creation.

### LBMSource

```java
public LBMSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMSourceEventCallback cb, Object cbArg) throws LBMException
```

Instantiate an LBM Source object associated with a given context
and topic and initialize source event callback.
    <p>
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the source.
@param lbmtopic LBMTopic used to initialize the source.
@param cb An object implementing the LBMSourceEventCallback interface
@param cbArg Callback token object
@throws LBMException if any error occurred during source creation.

### LBMSource

```java
public LBMSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMEventQueue lbmevq) throws LBMException
```

Instantiate an LBM Source object associated with a given context,
topic, and event queue.
    <p>
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the source.
@param lbmtopic LBMTopic used to initialize the source.
@param lbmevq Event queue with which to associate the source
(all source events will be posted to this event queue).
@throws LBMException if any error occurred during source creation.

### LBMSource

```java
public LBMSource(LBMContext lbmctx, LBMTopic lbmtopic, LBMSourceEventCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Instantiate an LBM Source object associated with a given context,
topic, and event queue and initialize source event callback.
    <p>
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the source.
@param lbmtopic LBMTopic used to initialize the source.
@param cb An object implementing the LBMSourceEventCallback interface
@param cbArg Callback token object
@param lbmevq Event queue with which to associate the source
(all source events will be posted to this event queue).
@throws LBMException if any error occurred during source creation.

### umederegister

```java
public void umederegister() throws LBMException
```

Deregister this source
    <p>
    <b>Warning</b>: It is not safe to call this method from a context thread callback.
@throws LBMException if any error occurred during source deletion.

### unblock

```java
public void unblock() throws LBMException
```

This method is for internal use only, and is not supported for
customer applications.

### close

```java
public void close() throws LBMException
```

Close this source
    <p>
    <b>Warning</b>: It is not safe to call this method from a context thread callback.
@throws LBMException if any error occurred during source deletion.

### isClosed

```java
public boolean isClosed()
```

Returns boolean describing whether this instance has a reference
          to a valid C source
@return boolean describing whether this instance has a reference
          to a valid C source

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions
@return Array of LBMConfigOption

### createChannel

```java
public LBMSourceChannelInfo createChannel(long channelNumber) throws LBMException
```

Create a channel object to send messages with the given channel number.
The application is responsible for calling close() or LBMSource.deleteChannel()  on any
LBMSourceChannelInfo object allocated via the LBMSourceChannelInfo constructor or the
LBMSource.createChannel method once it is no longer being used.  Failure to do so will
result in unmanaged resources not being reclaimed.
@param channelNumber Channel number in the range 0-4294967295
@return A new LBMSourceChannelInfo object
@see LBMSourceChannelInfo
@see #deleteChannel

### deleteChannel

```java
public void deleteChannel(LBMSourceChannelInfo channelInfo) throws LBMException
```

Delete a channel object
@param channelInfo A channelInfo object
@see LBMSourceChannelInfo
@see #createChannel

### addSourceCallback

```java
public void addSourceCallback(LBMSourceEventCallback cb)
```

Register a source event callback
@param cb Object implementing the LBMSourceEventCallback interface
@see LBMSourceEventCallback
@see #removeSourceCallback

### addSourceCallback

```java
public void addSourceCallback(LBMSourceEventCallback cb, Object cbArg)
```

Register a source event callback (and callback token)
@param cb Object implementing the LBMSourceEventCallback interface
@param cbArg Callback token object
@see LBMSourceEventCallback
@see #removeSourceCallback

### removeSourceCallback

```java
public void removeSourceCallback(LBMSourceEventCallback cb)
```

Deregister a source event callback
@param cb Previously registered object implementing the
LBMSourceEventCallback interface
@see LBMSourceEventCallback
@see #addSourceCallback

### removeSourceCallback

```java
public void removeSourceCallback(LBMSourceEventCallback cb, Object cbArg)
```

Deregister a source event callback (and callback token)
@param cb Previously registered object implementing the
LBMSourceEventCallback interface
@param cbArg Callback token object
@see LBMSourceEventCallback
@see #addSourceCallback

### getAttributeValue

```java
public String getAttributeValue(String attributeName) throws LBMException
```

Returns the value of a source-related attribute for this source.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setAttributeValue

```java
public void setAttributeValue(String attributeName, String attributeValue) throws LBMException
```

Set the value of a source-related attribute for this source.
Note that this method bypasses the property list.
As such no attributes configured using this method will appear in
the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.
@see #setProperty

### setProperty

```java
public Object setProperty(String attributeName, String attributeValue)
```

Set the value of a source-related attribute for this source.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMRuntimeException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### load

```java
public void load(InputStream inStream) throws IOException
```

Reads a property (attribute) list (key and element pairs) from the
input stream.
@param inStream Input stream of bytes
@throws IOException if any I/O error occurs.
@throws LBMRuntimeException if any invalid attribute is detected in <code>inStream</code>.

### getStatistics

```java
public LBMSourceStatistics getStatistics() throws LBMException
```

Return the current set of source transport statistics for this
source.
@return LBMSourceStatistics object containing the statistics
corresponding to this source.
@throws LBMException if any error occurred retrieving source statistics.

### resetStatistics

```java
public void resetStatistics() throws LBMException
```

Reset the transport statistics for this source.
@throws LBMException if any error occurred resetting source statistics.

### sendStatistics

```java
public void sendStatistics(ByteBuffer message, int messageLength, int statsType) throws LBMException
```

Send a serialized PB message to the topic associated with the LBM source.
<p>

@param message ByteBuffer that contains serialized PB stats to send.
@param messageLength Number of bytes in the ByteBuffer.
@param statsType Indicates the type of statistics being sent.
See next section for set of possible values.
@throws LBMException if any error occurred during sending.
@see LBMMonitor#LBMMON_PACKET_TYPE_SOURCE
@see LBMMonitor#LBMMON_PACKET_TYPE_RECEIVER
@see LBMMonitor#LBMMON_PACKET_TYPE_EVENT_QUEUE
@see LBMMonitor#LBMMON_PACKET_TYPE_CONTEXT
@see LBMMonitor#LBMMON_PACKET_TYPE_RECEIVER_TOPIC
@see LBMMonitor#LBMMON_PACKET_TYPE_WILDCARD_RECEIVER
@see LBMMonitor#LBMMON_PACKET_TYPE_UMESTORE
@see LBMMonitor#LBMMON_PACKET_TYPE_GATEWAY
@see LBMMonitor#LBMMON_PACKET_TYPE_UMDS
@see LBMMonitor#LBMMON_PACKET_TYPE_SRS

### send

```java
public void send(byte [] message, int messageLength, int flags) throws LBMException
```

  Send a message to the topic associated with the LBM source.
  <p>
\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param message Data to send in this message
  @param messageLength Number of bytes of data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurred during sending.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#SRC_EVENT_UME_MESSAGE_STABLE
  @see LBM#SRC_EVENT_UME_DELIVERY_CONFIRMATION

### send

```java
public void send(byte [] message, int messageLength, int flags, Object cbArg) throws LBMException
```

  Send a message to the topic associated with the LBM source.
  <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param message Data to send in this message
  @param messageLength Number of bytes of data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @param cbArg Client object to be passed back in stability or confirmation
  events related to this message (UME only)
  @throws LBMException if any error occurred during sending.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#SRC_EVENT_UME_MESSAGE_STABLE
  @see LBM#SRC_EVENT_UME_DELIVERY_CONFIRMATION
  @deprecated This method exists for backwards compatibility but should not be used. The send method that accepts an LBMSourceSendExInfo object should be used instead.

### send

```java
public void send(byte [] message, int messageLength, int flags, LBMSourceSendExInfo exinfo) throws LBMException
```

  Send a message to the topic associated with the LBM source.
  <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param message Data to send in this message
  @param messageLength Number of bytes of data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @param exinfo LBMSourceSendExInfo object; used to set callback behavior
  flags and to pass back a user-supplied object.
  @throws LBMException if any error occurred during sending.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#SRC_EVENT_UME_MESSAGE_STABLE
  @see LBM#SRC_EVENT_UME_DELIVERY_CONFIRMATION
  @see LBMSourceSendExInfo
  @since UME 2.0

### send

```java
public void send(ByteBuffer message, int startPosition, int messageLength, int flags) throws LBMException
```

  Send a message to the topic associated with the LBM source.
  <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param message Data to send in this message
  @param startPosition Starting position within the buffer to send from
  @param messageLength Number of bytes of data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurred during sending.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#SRC_EVENT_UME_MESSAGE_STABLE
  @see LBM#SRC_EVENT_UME_DELIVERY_CONFIRMATION

### send

```java
public void send(ByteBuffer message, int startPosition, int messageLength, int flags, Object cbArg) throws LBMException
```

  Send a message to the topic associated with the LBM source.
  <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param message Data to send in this message
  @param startPosition Starting position within the buffer to send from
  @param messageLength Number of bytes of data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @param cbArg Client object to be passed back in stability or confirmation
  events related to this message (UME only)
  @throws LBMException if any error occurred during sending.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#SRC_EVENT_UME_MESSAGE_STABLE
  @see LBM#SRC_EVENT_UME_DELIVERY_CONFIRMATION
  @deprecated This method exists for backwards compatibility but should not be used. The send method that accepts an LBMSourceSendExInfo object should be used instead.

### send

```java
public void send(ByteBuffer message, int startPosition, int messageLength, int flags, LBMSourceSendExInfo exinfo) throws LBMException
```

  Send a message to the topic associated with the LBM source.
  <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param message Data to send in this message
  @param startPosition Starting position within the buffer to send from
  @param messageLength Number of bytes of data to send in this message
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @param exinfo LBMSourceSendExInfo object; used to set callback behavior
  flags and to pass back a user-supplied object. (UME only)
  @throws LBMException if any error occurred during sending.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK
  @see LBM#SRC_EVENT_UME_MESSAGE_STABLE
  @see LBM#SRC_EVENT_UME_DELIVERY_CONFIRMATION
  @see LBMSourceSendExInfo
  @since UME 2.0

### send

```java
public void send(LBMRequest lbmreq, int flags) throws LBMException
```

  Send a request message to the topic associated with the LBM source.
      <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param lbmreq LBMRequest object
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurred during sending.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK

### send

```java
public void send(LBMRequest lbmreq, LBMEventQueue lbmevq, int flags) throws LBMException
```

  Send a request message to the topic associated with the LBM source
  using an designated event queue for responses.
      <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param lbmreq LBMRequest object
  @param lbmevq LBMEventQueue used to handle response messages
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @throws LBMException if any error occurred during sending.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK

### send

```java
public void send(LBMRequest lbmreq, LBMEventQueue lbmevq, int flags, LBMSourceSendExInfo exinfo) throws LBMException
```

  Send a request message to the topic associated with the LBM source
  using an designated event queue for responses.
      <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param lbmreq LBMRequest object
  @param lbmevq LBMEventQueue used to handle response messages
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @param exinfo LBMSourceSendExInfo object; used to set callback behavior
  flags and to pass back a user-supplied object. (UME only)
  @throws LBMException if any error occurred during sending.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK

### send

```java
public void send(LBMRequest lbmreq, int flags, LBMSourceSendExInfo exinfo) throws LBMException
```

  Send a request message to the topic associated with the LBM source
  using an designated event queue for responses.
      <p>

\note  If called from a context thread callback, use the LBM_SRC_NONBLOCK flag and
handle any LBM_EWOULDBLOCK errors internally.
\warning Do not call this function from a context thread callback for persistence stability
         or persistence confirmation events.  It can result in deadlock.

  @param lbmreq LBMRequest object
  @param flags Flags indicating various conditions.
  See next section for possible OR'd set of values.
  @param exinfo LBMSourceSendExInfo object; used to set callback behavior
  flags and to pass back a user-supplied object. (UME only)
  @throws LBMException if any error occurred during sending.
  @see LBM#MSG_START_BATCH
  @see LBM#MSG_END_BATCH
  @see LBM#MSG_COMPLETE_BATCH
  @see LBM#MSG_FLUSH
  @see LBM#SRC_NONBLOCK
  @see LBM#SRC_BLOCK

### flush

```java
public void flush() throws LBMException
```

  Send messages from both the explicit and implicit batches ASAP.
  <p>
\note calling lbm_src_flush() for a given source effectively flushes the
implicit batcher for \a all sources on the same transport session.

\warning Do not call this function from a context thread callback.
         It can result in deadlock.

  @throws LBMException if any error occurred during sending.

### getInflight

```java
public int getInflight(int type) throws LBMException
```

Get the current inflight value for this source
@param type The type of flight size
@see LBM#FLIGHT_SIZE_TYPE_UME
@see LBM#FLIGHT_SIZE_TYPE_ULB
@see LBM#FLIGHT_SIZE_TYPE_UMQ
@return the inflight value
@throws LBMException if an error occurs while retrieving the inflight value

### getInflightEx

```java
public LBMFlightSizeInflightInfo getInflightEx(int type) throws LBMException
```

Get the current inflight values of messages and bytes for this source
@param type The type of flight size
@see LBM#FLIGHT_SIZE_TYPE_UME
@see LBM#FLIGHT_SIZE_TYPE_ULB
@see LBM#FLIGHT_SIZE_TYPE_UMQ
@return the inflight value
@throws LBMException if an error occurs while retrieving the inflight value

### setInflight

```java
public int setInflight(int type, LBMSetInflightCallback setInflightCb, Object clientd) throws LBMException
```

Set the current inflight value for this source.
@param type The type of flight size
@see LBM#FLIGHT_SIZE_TYPE_UME
@see LBM#FLIGHT_SIZE_TYPE_ULB
@see LBM#FLIGHT_SIZE_TYPE_UMQ
@param setInflightCb Object that implements the LBMSetInflightCallback interface
@param clientd Clientd object passed into the setInflight callback
@return the new inflight value
@throws LBMException if an error occurs while setting the inflight value

### setInflightEx

```java
public LBMFlightSizeInflightInfo setInflightEx(int type, LBMSetInflightCallback setInflightCb, Object clientd) throws LBMException
```

Set the current inflight messages and bytes value for this source. The values
are set from within the provided set inflight callback with appropriate locking held.
@param type The type of flight size
@see LBM#FLIGHT_SIZE_TYPE_UME
@see LBM#FLIGHT_SIZE_TYPE_ULB
@see LBM#FLIGHT_SIZE_TYPE_UMQ
@param setInflightCb Object that implements the LBMSetInflightCallback interface
@param clientd Clientd object passed into the setInflight callback
@return the new inflight values
@throws LBMException if an error occurs while setting the inflight value

### setUMEMessageStable

```java
public void setUMEMessageStable(long sqn) throws LBMException
```

Mark a specific sqn as stable, triggering an event if configured to do so, and adjusting the inflight if necessary.
@param sqn Sqn of the fragment to mark stable
@throws LBMException if an error occurs while marking the fragment stable

### getMessagesBuffer

```java
public ByteBuffer getMessagesBuffer() throws LBMException
```

Get the buffer for writing messages for an LBT-SMX source. This buffer will not change for the duration
of this source. Messages are written into this buffer by using the return value of  {@link #acquireMessageBufferPosition(final int, final int)}.
<p>
Only LBT-SMX transports currently support this method.
@return A DirectByteBuffer view of the transport window

### acquireMessageBufferPosition

```java
public int acquireMessageBufferPosition(final int messageLength, final int flags) throws LBMException
```

Reserve space in this source's messages buffer. When this method returns,
we have guaranteed that there is sufficient space in the message buffer to safely
write up to messageLength bytes starting at the returned position. The application
must ensure that this contract is not broken. When message data has been written,
call {@link #messageBuffersComplete()} to make them available to receivers.
<p>
If non-blocking send, and the source would have to wait for recievers to catch up,
a value of -1 is returned. This is in contrast to send methods that throw a new
LBMEWouldBlockException and is done for performance reasons.
<p>
Only LBT-SMX transports currently support this method.
<p>
<b>Warning</b> Not thread safe among sources sharing the same transport.
@param messageLength Length in bytes to reserve in the messages buffer
@param flags Source send flags
@return Position into the source messages buffer {@link #getMessagesBuffer()} or -1 if Non-blocking and send would block.
@throws LBMException If an error occurs
@see LBM#SRC_NONBLOCK
@see LBM#SRC_BLOCK

### messageBuffersComplete

```java
public void messageBuffersComplete() throws LBMException
```

Commits all previously acquired message buffers for this source's transport to be read by receivers.
Call this when message data placed in the transport buffer is ready to be consumed by receivers.
Calling this method with no new data has no effect.
<p>
Only LBT-SMX transports currently support this method.
<p>
<b>Warning</b> Not thread safe among sources sharing the same transport.
@throws LBMException
@see #acquireMessageBufferPosition(final int, final int)
@see #messageBuffersCompleteAndAcquirePosition(final int, final int)

### messageBuffersCompleteAndAcquirePosition

```java
public int messageBuffersCompleteAndAcquirePosition(final int messageLength, final int flags) throws LBMException
```

Convenience method that calls {@link #messageBuffersComplete()} followed by {@link #acquireMessageBufferPosition(final int, final int)}.
This is intended to reduce the number of calls per message.
<p>
Only LBT-SMX transports currently support this method.
<p>
<b>Warning</b> Not thread safe among sources sharing the same transport.
@param messageLength - length in bytes to reserve in the messages buffer
@param flags - Source send flags
@return Position into the source messages buffer {@link #getMessagesBuffer()} or -1 if Non-blocking and send would block.
@throws LBMException
@see LBM#SRC_NONBLOCK
@see LBM#SRC_BLOCK

### messageBuffersCancel

```java
public void messageBuffersCancel() throws LBMException
```

For this source, declare all previously acquired, but not completed, buffers to be invalid.
The messages will not be delivered to receiving applications and the reserved buffer space will be ignored.
<p>
Only LBT-SMX transports currently support this method.
<p>
<b>Warning</b> Not thread safe among sources sharing the same transport.
@see #acquireMessageBufferPosition(final int, final int)
@see #messageBuffersCompleteAndAcquirePosition(final int, final int)
@throws LBMException

## LBMSourceAttributes

*class* `com.latencybusters.lbm.LBMSourceAttributes`

### LBMSourceAttributes

```java
public LBMSourceAttributes() throws LBMException
```

Create and fill an LBMSourceAttributes object with the current default values
@throws LBMException

### LBMSourceAttributes

```java
public LBMSourceAttributes(String contextName, String topic) throws LBMException
```

Create and fill an LBMSourceAttributes object with the current default values for the given context name and source topic name.
@param contextName Context name string.
@param topic Source topic name string.
@throws LBMException if the context name and / or source topic name is not permitted by the configuration or other operational failure.

### setFromXml

```java
public void setFromXml(String contextName, String topic) throws LBMException
```

Fill an LBMSourceAttributes object with the default values specified by the XML configuration for the given context name and source topic name.
@param contextName Context name string.
@param topic Source topic name string.
@throws LBMException if the context name and / or source topic name is not permitted by the configuration or other operational failure.

### dispose

```java
public void dispose()
```

Free memory associated with this set of attributes.

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions
@return Array of LBMConfigOption

### getValue

```java
public String getValue(String attributeName) throws LBMException
```

Returns the current value of an attribute from this set of
source-related attributes.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setValue

```java
public void setValue(String attributeName, String attributeValue) throws LBMException
```

FOR INTERNAL INFORMATICA USE ONLY - NOT FOR DIRECT APPLICATION USEAGE.
Applications should use setProperty() instead.
Set the current value of an attribute in this set of
source-related attributes.  Note that this method bypasses the
property list.  As such no attributes configured using this method
will appear in the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.
@see #setProperty

### setProperty

```java
public Object setProperty(String attributeName, String attributeValue)
```

Set the current value of an attribute in this set of source-related
attributes.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMRuntimeException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### load

```java
public void load(InputStream inStream) throws IOException
```

Reads a property (attribute) list (key and element pairs) from the
input stream.
@param inStream Input stream of bytes
@throws IOException if any I/O error occurs.
@throws LBMRuntimeException if any invalid attribute is detected in <code>inStream</code>.

### setObjectRecycler

```java
public void setObjectRecycler(LBMObjectRecyclerBase objRec, Object objRecCbArg)
```

Set the LBM object recycler that can be used by the context to reuse LBMMessage objects as
well as LBM Context/Receiver/Source Statistics objects.
@param objRec an LBM object recycler that will be called when objects need to be retrieved
@param objRecCbArg a callback object token that will be passed in the retrieve method

### setMessageReclamationCallback

```java
public void setMessageReclamationCallback(LBMMessageReclamationCallback cb, Object cbArg)
```

Register a callback interface (and a callback handle argument) to be
called when a message is forcibly reclaimed from the collection of
retained messages on a UME source (UME only).
This callback is called directly in line and does not use the event queue;
therefore, the callback function used should not block or it will block the
context thread processing.
@param cb An object implementing the LBMMessageReclamationCallback interface
@param cbArg Callback object passed as a token to the callback interface
@see LBMRegistrationIdCallback

### getStores

```java
public UMEStoreEntry[] getStores()
```

Gets an array of the UME stores this source has configuration
entries for.
@return An array of UMEStoreEntry objects. Each member of the array
contains information about a different UME store.
@since UME 2.0

### getStoreGroups

```java
public UMEStoreGroupEntry[] getStoreGroups()
```

Gets an array of the UME store groups this source has configured.
@return An array of UMEStoreGroupEntry objects. Each member of the array
contains information about a different UME store group.
@since UME 2.0

## LBMSourceChannelInfo

*class* `com.latencybusters.lbm.LBMSourceChannelInfo`

### LBMSourceChannelInfo

```java
public LBMSourceChannelInfo(LBMSource source, long channel_number) throws LBMException
```

Instantiate an LBM Source Channel Info object associated with a given source.
The application is responsible for calling close() or LBMSource.deleteChannel on any
LBMSourceChannelInfo object allocated via the LBMSourceChannelInfo constructor or the
LBMSource.createChannel method once it is no longer being used.  Failure to do so will
result in unmanaged resources not being reclaimed.
@param source The LBM Source that will be used to send messages on the channel to be created.
@param channel_number A channel number in the range 0-4294967295.

### close

```java
public void close() throws LBMException
```

Reclaim resources associated with the underlying LBM data structures
once the channel info object will no longer be used.

## LBMSourceCostCallback

*interface* `com.latencybusters.lbm.LBMSourceCostCallback`

### onSourceCost

```java
long onSourceCost(Object cbArg, String topic, LBMTransportSourceInfo transport, long hop_count, long cost)
```

Callback to determine source cost
@param cbArg Callback object token
@param topic Topic for which the new source was discovered
@param transport LBMTransportSourceInfo object describing the transport session
@param hop_count Current hop count for the transport session
@param cost Current cumulative cost for the transport session
@return Application-determined cost for this source as an unsigned 32-bit number.
To permanently reject this source, return LBM.LBM_SRC_COST_FUNCTION_REJECT

## LBMSourceCreateExInfo

*class* `com.latencybusters.lbm.LBMSourceCreateExInfo`

### LBMSourceCreateExInfo

```java
public LBMSourceCreateExInfo()
```

Creates a LBMSourceCreateExInfo object and initializes all fields to
0/null.

### LBMSourceCreateExInfo

```java
public LBMSourceCreateExInfo(int flags, String proxySourceString, long origDomainId, long hlIndex)
```

Creates a LBMSourceCreateExInfo object and initializes fields to
supplied values.
@param flags Flags set by the underlying controller.
@param proxySourceString Source string of the proxy source.
@param origDomainId The domain ID of the originating source.
@param hlIndex Hotlink index of the local connection

### proxySourceString

```java
public String proxySourceString()
```

For the delivery controller being created, get the source string of the proxy source, if any.
@return proxy source string.

### originalDomainId

```java
public long originalDomainId()
```

For the delivery controller being created, get originating source's domain ID.
The value is only defined if the config option \ref usehotlinkreceiver is set to 1.
See \ref flags() and \ref isHotlink().

@return original domain ID.

### hotlinkIndex

```java
public long hotlinkIndex()
```

For the delivery controller being created, get the hotlink index.
The value is only defined if the config option \ref usehotlinkreceiver is set to 1.
See \ref flags() and \ref isHotlink().
@return Hotlink index.

### isHotlink

```java
public boolean isHotlink()
```

Convenience function to test \ref flags() for the
\ref LBM.LBM_SOURCE_NOTIFICATION_EX_INFO_FLAG_HOT_LINK bit,
meaning the config option \ref usehotlinkreceiver is set to 1.
(It does not imply that publisher's source had lot links enabled.)

@return true if the receiver has hotlinks enabled, false otherwise.

### flags

```java
public int flags()
```

For the delivery controller being created, get bit map of flags.
See \ref flags() and \ref isHotlink().
Defined bits:
* \ref LBM.LBM_SOURCE_NOTIFICATION_EX_INFO_FLAG_HOT_LINK - the config option \ref usehotlinkreceiver is set to 1.
  (It does not imply that publisher's source had hot links enabled.)

@return original domain ID.

## LBMSourceCreationCallback

*interface* `com.latencybusters.lbm.LBMSourceCreationCallback`

### onNewSource

```java
Object onNewSource(String sourceName, Object cbArg)
```

New source creation callback method for receivers.
@param sourceName Source as a string. Format depends on transport type. For TCP, string is "TCP:IP:Port" (e.g. "TCP:192.168.0.4:45789"). For LBT-RM, string is "LBTRM:src:sport:sessionid:grp:dport".
@param cbArg Client callback object specified with {@link LBMReceiverAttributes#setSourceNotificationCallbacks}
@return Client callback object to pass into an LBMSourceDeletionCallback callback.

## LBMSourceCreationExCallback

*interface* `com.latencybusters.lbm.LBMSourceCreationExCallback`

### onNewSource

```java
Object onNewSource(String sourceName, Object cbArg, LBMSourceCreateExInfo srcCreateExInfo)
```

Extended source creation callback method for receivers.
See \ref LBMReceiverAttributes::setSourceNotificationExCallbacks().
@param sourceName Source as a string. Format depends on transport type. For TCP, string is "TCP:IP:Port" (e.g. "TCP:192.168.0.4:45789"). For LBT-RM, string is "LBTRM:src:sport:sessionid:grp:dport".
@param cbArg Client callback object specified with {@link LBMReceiverAttributes#setSourceNotificationCallbacks}
@param srcCreateExInfo source creation extdended info {@link LBMSourceCreateExInfo}
@return Client callback object to pass into an LBMSourceDeletionCallback callback.

## LBMSourceDeleteExInfo

*class* `com.latencybusters.lbm.LBMSourceDeleteExInfo`

### LBMSourceDeleteExInfo

```java
public LBMSourceDeleteExInfo()
```

Creates a LBMSourceCreateExInfo object and initializes all fields to
0/null.

### LBMSourceDeleteExInfo

```java
public LBMSourceDeleteExInfo(int flags, String proxySourceString, long origDomainId)
```

Creates a LBMSourceDeleteExInfo object and initializes fields to
supplied values.
@param flags Flags set by the underlying controller.
@param proxySourceString Source string of the proxy source.
@param origDomainId The domain ID of the originating source.

### proxySourceString

```java
public String proxySourceString()
```

For the delivery controller being deleted, get the source string of the proxy source, if any.
The value is only defined if the config option \ref usehotlinkreceiver is set to 1.
See \ref flags() and \ref isHotlink().
@return proxy source string.

### originalDomainId

```java
public long originalDomainId()
```

For the delivery controller being deleted, get originating source's domain ID.
The value is only defined if the config option \ref usehotlinkreceiver is set to 1.
See \ref flags() and \ref isHotlink().

@return original domain ID.

### flags

```java
public int flags()
```

For the delivery controller being deleted, get bit map of flags.
See \ref flags() and \ref isHotlink().
Defined bits:
* \ref LBM.LBM_SOURCE_NOTIFICATION_EX_INFO_FLAG_HOT_LINK - the config option \ref usehotlinkreceiver is set to 1.
  (It does not imply that publisher's source had hot links enabled.)

@return original domain ID.

### isHotlink

```java
public boolean isHotlink()
```

Convenience function to test \ref flags() for the
\ref LBM.LBM_SOURCE_NOTIFICATION_EX_INFO_FLAG_HOT_LINK bit,
meaning the config option \ref usehotlinkreceiver is set to 1.
(It does not imply that publisher's source had lot links enabled.)

@return true if the receiver has hotlinks enabled, false otherwise.

## LBMSourceDeletionCallback

*interface* `com.latencybusters.lbm.LBMSourceDeletionCallback`

### onSourceDelete

```java
int onSourceDelete(String sourceName, Object cbArg, Object sourceCbArg)
```

Source deletion callback method for receivers.
@param sourceName Source as a string. Format depends on transport type. For TCP, string is "TCP:IP:Port" (e.g. "TCP:192.168.0.4:45789"). For LBT-RM, string is "LBTRM:src:sport:sessionid:grp:dport".
@param cbArg Client callback object specified with {@link LBMReceiverAttributes#setSourceNotificationCallbacks}
@param sourceCbArg Client callback object specified by the return value of an {@link LBMSourceCreationCallback}.
@return This method should always return 0.

## LBMSourceDeletionExCallback

*interface* `com.latencybusters.lbm.LBMSourceDeletionExCallback`

### onSourceDelete

```java
int onSourceDelete(String sourceName, Object cbArg, Object sourceCbArg, LBMSourceDeleteExInfo srcDeleteExInfo)
```

Extended source deletion callback method for receivers.
See \ref LBMReceiverAttributes::setSourceNotificationExCallbacks().
@param sourceName Source as a string. Format depends on transport type. For TCP, string is "TCP:IP:Port" (e.g. "TCP:192.168.0.4:45789"). For LBT-RM, string is "LBTRM:src:sport:sessionid:grp:dport".
@param cbArg Client callback object specified with {@link LBMReceiverAttributes#setSourceNotificationCallbacks}
@param sourceCbArg Client callback object specified by the return value of an {@link LBMSourceCreationCallback}.
@param srcDeleteExInfo Extended information for the transport session being deleted {@link LBMSourceDeleteExInfo}.
@return This method should always return 0.

## LBMSourceEvent

*class* `com.latencybusters.lbm.LBMSourceEvent`

### type

```java
public int type()
```

LBM Source Event type.
@return LBM Source Event type
@see LBM

### registrationId

```java
public long registrationId()
```

Registration ID associated with this event.
This value may not be valid for all event types.
@return Registration ID.
@see LBM

### sequenceNumber

```java
public long sequenceNumber()
```

Sequence number associated with this event.
This value may not be valid for all event types.
@return Sequence number.
@see LBM

### dataString

```java
public String dataString()
```

String data associated with this event.
This value may not be valid for all event types.
@return Event string data

### clientObject

```java
public Object clientObject()
```

Client callback object.
This object is specified by the application using another API method.
@return Client callback object
@see LBMSource#send(byte [],int,int,Object)

### registrationSuccessInfo

```java
public UMESourceEventRegistrationSuccessInfo registrationSuccessInfo()
```

Registration success info object.  Contains extended registration
information.
@return Extended registration success info object.
@see UMESourceEventRegistrationSuccessInfo
@since UME 2.0

### registrationCompleteInfo

```java
public UMESourceEventRegistrationCompleteInfo registrationCompleteInfo()
```

Registration complete info.  Contains extended registration complete
information.
@return Registration complete info.
@see UMESourceEventRegistrationCompleteInfo
@since UME 2.0

### setDeregistrationSuccessInfo

```java
public void setDeregistrationSuccessInfo(UMESourceEventDeregistrationSuccessInfo dereg)
```

Registration success info object.  Contains extended Deregistration
information.
@return void
@see UMESourceEventDeregistrationSuccessInfo
@since UME 5.3

### setDeregistrationCompleteInfo

```java
public void setDeregistrationCompleteInfo(UMESourceEventDeregistrationCompleteInfo dregc)
```

Registration complete info.  Contains extended registration complete
information.
@return void
@see UMESourceEventderegistrationCompleteInfo
@since UME 5.3

### deregistrationSuccessInfo

```java
public UMESourceEventDeregistrationSuccessInfo deregistrationSuccessInfo()
```

Registration success info object.  Contains extended Deregistration
information.
@return Extended deregistration success info object.
@see UMESourceEventDeregistrationSuccessInfo
@since UME 5.3

### deregistrationCompleteInfo

```java
public UMESourceEventDeregistrationCompleteInfo deregistrationCompleteInfo()
```

Registration complete info.  Contains extended registration complete
information.
@return Registration complete info.
@see UMESourceEventderegistrationCompleteInfo
@since UME 5.3

### sequenceNumberInfo

```java
public LBMSourceEventSequenceNumberInfo sequenceNumberInfo()
```

Gets extended sequence number info.
@return Sequence number info.
@see LBMSourceEventSequenceNumberInfo
@since UME 2.0

### ackInfo

```java
public UMESourceEventAckInfo ackInfo()
```

Gets extended ACK info.
@return Ack info.
@see UMESourceEventAckInfo
@since UME 2.0

### sourceWakeupInfo

```java
public LBMSourceEventWakeupInfo sourceWakeupInfo()
```

Gets extended information about a source wakeup event.
@return Source wakeup info.
@see LBMSourceEventWakeupInfo
@since LBM 3.4

### messageIdInfo

```java
public UMQSourceEventMessageIdInfo messageIdInfo()
```

Gets an object describing the message ID assigned to a message.
@return A UMQSourceEventMessageIdInfo object containing message ID information.
@see UMQSourceEventMessageIdInfo
@since UME 3.0

### queueAckInfo

```java
public UMQSourceEventAckInfo queueAckInfo()
```

Gets an object containing extended information about a message that has been acknowledged as stable.
@return A UMQSourceEventAckInfo object with acknowledgement information.
@see UMQSourceEventAckInfo
@since UME 3.0

### queueRegistrationCompleteInfo

```java
public UMQSourceEventRegistrationCompleteInfo queueRegistrationCompleteInfo()
```

Queue registration complete info.  Contains extended queue registration complete
information.
@return Registration complete info.
@see UMQSourceEventRegistrationCompleteInfo
@since UME 3.0

### ulbReceiverInfo

```java
public UMQSourceEventULBReceiverInfo ulbReceiverInfo()
```

ULB Receiver info. Contains extended ULB receiver information.
@return ULB Receiver info.
@see UMQSourceEventULBReceiverInfo
@since UMQ 1.1

### ulbMessageInfo

```java
public UMQSourceEventULBMessageInfo ulbMessageInfo()
```

ULB Message info. Contains extended ULB message information.
@return ULB Message info.
@see UMQSourceEventULBMessageInfo
@since UMQ 1.1

### flightSizeNotification

```java
public LBMSourceEventFlightSizeNotification flightSizeNotification()
```

Flight Size Notificaiton.
@return Flight Size Notification
@see LBMSourceEventFlightSizeNotification
@since UME 3.1

### timestampInfo

```java
public LBMSourceEventTimestampInfo timestampInfo()
```

Gets high-resolution timestamp Info.
@return Timestamp Info
@see LBMSourceEventTimestampInfo
@since UMS 6.9

### promote

```java
public LBMSourceEvent promote()
```

This method should be called if the application wishes to continue
processing the source event on another thread, or after the source event callback returns.
@return the promoted LBMSourceEvent

### dispose

```java
public void dispose()
```

This method should be called before the source event callback returns
to indicate that the application is finished with the source event allowing it
to be reused when processing a future source event

## LBMSourceEventCallback

*interface* `com.latencybusters.lbm.LBMSourceEventCallback`

### onSourceEvent

```java
int onSourceEvent(Object cbArg, LBMSourceEvent sourceEvent)
```

Source event callback.
@param cbArg Callback object token
@param sourceEvent LBMSourceEvent object encapsulating source event
@return an int, which should always be 0.
information.

## LBMSourceEventFlightSizeNotification

*class* `com.latencybusters.lbm.LBMSourceEventFlightSizeNotification`

### LBMSourceEventFlightSizeNotification

```java
public LBMSourceEventFlightSizeNotification(int type, int state)
```

Creates an LBMSourceEventFlightSizeNotification with fields initialized to the
given values.
@param type type of flight size in question.
@param state current state (over or under).
@since UME 3.1

### type

```java
public int type()
```

Get type.
@return type of flight size.
@since UME 3.1

### state

```java
public int state()
```

Get state.
@return state of flight size.
@since UME 3.1

## LBMSourceEventSequenceNumberInfo

*class* `com.latencybusters.lbm.LBMSourceEventSequenceNumberInfo`

### LBMSourceEventSequenceNumberInfo

```java
public LBMSourceEventSequenceNumberInfo()
```

Creates an LBMSourceEventSequenceNumberInfo object with all fields
initialized to 0/null.
@since UME 2.0

### LBMSourceEventSequenceNumberInfo

```java
public LBMSourceEventSequenceNumberInfo(int flags, long firstSeqNum, long lastSeqNum, Object clientd) throws LBMEInvalException
```

Creates an LBMSourceEventSequenceNumberInfo with fields initialized to the
given values.
@param flags Flags concerning when sequence number messages are sent.
@param firstSeqNum First sequence number (must be >= 0).
@param lastSeqNum Last sequence number (must be >= 0).
@param clientd Client-supplied callback object.
@throws LBMEInvalException if firstSeqNum or lastSeqNum are < 0.
@since UME 2.0

### flags

```java
public int flags()
```

Get sequence number message flags.
@return Flags indicating when sequence number messages are sent.
@since UME 2.0

### firstSequenceNumber

```java
public long firstSequenceNumber()
```

Get the first sequence number.
@return The first sequence number.
@since UME 2.0

### lastSequenceNumber

```java
public long lastSequenceNumber()
```

Get the last sequence number.
@return The last sequence number.
@since UME 2.0

### clientObject

```java
public Object clientObject()
```

Get the client-supplied callback object.
@return Client-supplied object.

## LBMSourceEventTimestampInfo

*class* `com.latencybusters.lbm.LBMSourceEventTimestampInfo`

### LBMSourceEventTimestampInfo

```java
public LBMSourceEventTimestampInfo()
```

Creates an LBMSourceEventTimestampInfo object with all fields
initialized to 0.
@since UMS 6.9

### LBMSourceEventTimestampInfo

```java
public LBMSourceEventTimestampInfo(long tv_sec, long tv_nsec, long sequenceNumber)
```

Creates an LBMSourceEventTimestampInfo with fields initialized to the
given values.
@param tv_sec High-resolution timestamp, seconds.
@param tv_nsec High-resolution timestamp, nanoseconds.
@param sequenceNumber Sequence number.
@since UMS 6.9

### hrTimestamp

```java
public LBMTimespec hrTimestamp()
```

Get the high-resolution timestamp of the sent message.
@return The high-resolution timestamp of the sent message.
@since UMS 6.9

### sequenceNumber

```java
public long sequenceNumber()
```

Get the sequence number associated with the sent high-resolution timestamp.
@return The sequence number of the sent message.
@since UMS 6.9

## LBMSourceEventWakeupInfo

*class* `com.latencybusters.lbm.LBMSourceEventWakeupInfo`

### flags

```java
public int flags()
```

Retrieve flags indicating what type of source(s) (normal, MIM, etc.) has woken up.
@return Flags indicating the type of source(s) woken up.
@see LBM.SRC_EVENT_WAKEUP_FLAG_NORMAL
@see LBM.SRC_EVENT_WAKEUP_FLAG_MIM
@see LBM.SRC_EVENT_WAKEUP_FLAG_UIM
@see LBM.SRC_EVENT_WAKEUP_FLAG_REQUEST
@see LBM.SRC_EVENT_WAKEUP_FLAG_RESPONSE

## LBMSourceNotification

*interface* `com.latencybusters.lbm.LBMSourceNotification`

### sourceNotification

```java
int sourceNotification(String topic, String source, Object cbArg)
```

Callback function called when a new source topic is detected.
This callback is called directly in line and does not use an event
queue; therefore, it should not block which would impact processing
on the context processing thread.
@param topic New topic string
@param source String identifying the source for the new topic
@param cbArg Callback object token
@return an int, which should always be 0.
@see LBMContextAttributes#setSourceNotifyCallback(LBMSourceNotification, Object)

## LBMSourceSendExInfo

*class* `com.latencybusters.lbm.LBMSourceSendExInfo`

### LBMSourceSendExInfo

```java
public LBMSourceSendExInfo()
```

Create an empty LBMSourceSendExInfo object.
@since UME 2.0

### LBMSourceSendExInfo

```java
public LBMSourceSendExInfo(int flags, Object cbArg)
```

Create an LBMSourceSendExInfo object with flags and callback object set.
@param flags Flags to control callback behavior.
@param cbArg User-supplied object passed back with any callbacks.
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@since UME 2.0

### LBMSourceSendExInfo

```java
public LBMSourceSendExInfo(int flags, Object cbArg, LBMSourceChannelInfo channelInfo)
```

Create an LBMSourceSendExInfo object with flags and callback object set
as well as channel information included.
@param flags Flags to control callback behavior.
@param cbArg User-supplied object passed back with any callbacks.
@param channelInfo Channel information to be included with messages.
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@see LBM#SRC_SEND_EX_FLAG_CHANNEL
@since LBM 3.6

### LBMSourceSendExInfo

```java
public LBMSourceSendExInfo(int flags, Object cbArg, LBMSourceChannelInfo channelInfo, LBMApplicationHeaderChain appHeaderChain)
```

Create an LBMSourceSendExInfo object with flags and callback object set
as well as channel information included.
@param flags Flags to control callback behavior.
@param cbArg User-supplied object passed back with any callbacks.
@param channelInfo Channel information to be included with messages.
@param appHeaderChain Application header chain to be sent with messages.
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@see LBM#SRC_SEND_EX_FLAG_CHANNEL
@see LBM#SRC_SEND_EX_FLAG_APPHDR_CHAIN
@since LBM 3.6

### LBMSourceSendExInfo

```java
public LBMSourceSendExInfo(int flags, Object cbArg, LBMSourceChannelInfo channelInfo, LBMApplicationHeaderChain appHeaderChain, UMQIndexInfo indexInfo)
```

Create an LBMSourceSendExInfo object with flags and callback object set
as well as channel information included.
@param flags Flags to control callback behavior.
@param cbArg User-supplied object passed back with any callbacks.
@param channelInfo Channel information to be included with messages.
@param appHeaderChain Application header chain to be sent with messages.
@param indexInfo UMQ index info to send with messages.
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@see LBM#SRC_SEND_EX_FLAG_CHANNEL
@see LBM#SRC_SEND_EX_FLAG_APPHDR_CHAIN
@see LBM#SRC_SEND_EX_FLAG_UMQ_INDEX
@since UMQ 1.2

### LBMSourceSendExInfo

```java
public LBMSourceSendExInfo(int flags, Object cbArg, LBMSourceChannelInfo channelInfo, LBMApplicationHeaderChain appHeaderChain, UMQIndexInfo indexInfo, UMQMessageTotalLifetimeInfo lifetimeInfo)
```

Create an LBMSourceSendExInfo object with flags and callback object set
@param flags Flags to control callback behavior.
@param cbArg User-supplied object passed back with any callbacks.
@param channelInfo Channel information to be included with messages.
@param appHeaderChain Application header chain to be sent with messages.
@param indexInfo UMQ index info to send with messages.
@param lifetimeInfo UMQ total lifetime info to send with messages.
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@see LBM#SRC_SEND_EX_FLAG_CHANNEL
@see LBM#SRC_SEND_EX_FLAG_APPHDR_CHAIN
@see LBM#SRC_SEND_EX_FLAG_UMQ_TOTAL_LIFETIME
@see LBM#SRC_SEND_EX_FLAG_UMQ_INDEX
@since UMQ 1.2

### LBMSourceSendExInfo

```java
public LBMSourceSendExInfo(int flags, Object cbArg, LBMSourceChannelInfo channelInfo, LBMApplicationHeaderChain appHeaderChain, UMQIndexInfo indexInfo, UMQMessageTotalLifetimeInfo lifetimeInfo, LBMMessageProperties properties)
```

Create an LBMSourceSendExInfo object with flags and callback object set
@param flags Flags to control callback behavior.
@param cbArg User-supplied object passed back with any callbacks.
@param channelInfo Channel information to be included with messages.
@param appHeaderChain Application header chain to be sent with messages.
@param indexInfo UMQ index info to send with messages.
@param lifetimeInfo UMQ total lifetime info to send with messages.
@param properties LBMMessageProperties to be sent with messages.
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@see LBM#SRC_SEND_EX_FLAG_CHANNEL
@see LBM#SRC_SEND_EX_FLAG_APPHDR_CHAIN
@see LBM#SRC_SEND_EX_FLAG_UMQ_INDEX
@see LBM#SRC_SEND_EX_FLAG_UMQ_TOTAL_LIFETIME
@see LBM#SRC_SEND_EX_FLAG_PROPERTIES
@since UMQ 1.2

### setClientObject

```java
public void setClientObject(Object cbArg)
```

Set the user-supplied callback object.
@param cbArg User-supplied object passed back with any callbacks.
@since UME 2.0

### setFlags

```java
public void setFlags(int flags)
```

Sets flags that control callback behavior.
@param flags An integer representing an OR'd value of flags to set.
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@see LBM#SRC_SEND_EX_FLAG_CHANNEL
@see LBM#SRC_SEND_EX_FLAG_APPHDR_CHAIN
@see LBM#SRC_SEND_EX_FLAG_UMQ_INDEX
@see LBM#SRC_SEND_EX_FLAG_UMQ_TOTAL_LIFETIME
@see LBM#SRC_SEND_EX_FLAG_PROPERTIES
@see LBM#SRC_SEND_EX_FLAG_HF_32
@see LBM#SRC_SEND_EX_FLAG_HF_64
@since UME 2.0

### setChannelInfo

```java
public void setChannelInfo(LBMSourceChannelInfo channelInfo)
```

Sets channel info to be included with messages. Removes channel info from this
object if null is passed. Also sets or clears the LBM#SRC_SEND_EX_FLAG_CHANNEL from the
flags field as appropriate.
@param channelInfo A channel info object
@see LBMSource#createChannel(int)
@since LBM 3.6

### setIndexInfo

```java
public void setIndexInfo(UMQIndexInfo indexInfo)
```

Sets index info to be included with messages. Removes index info from this
object if null is passed. Also sets or clears the LBM#SRC_SEND_EX_FLAG_UMQ_INDEX from the
flags field as appropriate.
@param indexInfo An index info object
@since UMQ 1.2

### setTotalLifetimeInfo

```java
public void setTotalLifetimeInfo(UMQMessageTotalLifetimeInfo lifetimeInfo)
```

Sets total lifetime info to be included with messages. Removes total lifetime info from this
object if null is passed. Also sets or clears the LBM#SRC_SEND_EX_FLAG_UMQ_TOTAL_LIFETIME from the
flags field as appropriate.
@param lifetimeInfo A total lifetime info object
@since UMQ 2.2

### setMessageProperties

```java
public void setMessageProperties(LBMMessageProperties properties)
```

Sets message properties to be included with messages. Removes message properties from this
object if null is passed. Also sets or clears the LBM#SRC_SEND_EX_FLAG_PROPERTIES from the
flags field as appropriate.
@param properties A properties object
@since UMS 5.1

### flags

```java
public int flags()
```

Returns currently set flags.
@return An int representing an OR'd set of currently set flags.
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO
@see LBM#SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO_FRAGONLY
@see LBM#SRC_SEND_EX_FLAG_CHANNEL
@see LBM#SRC_SEND_EX_FLAG_APPHDR_CHAIN
@see LBM#SRC_SEND_EX_FLAG_PROPERTIES
@see LBM#SRC_SEND_EX_FLAG_HF_32
@see LBM#SRC_SEND_EX_FLAG_HF_64
@since UME 2.0

### getApplicationHeaderChain

```java
public LBMApplicationHeaderChain getApplicationHeaderChain()
```

Get the {@link LBMApplicationHeaderChain} currently attached to this LBMSourceSendExInfo object, if any.
@return The LBMApplicationHeaderChain object attached to this LBMSourceSendExInfo object, or null if it has no LBMApplicationHeaderChain attached.
@since UMQ 1.1

### setApplicationHeaderChain

```java
public void setApplicationHeaderChain(LBMApplicationHeaderChain appHeaderChain)
```

Attaches a {@link LBMApplicationHeaderChain} object to this LBMSourceSendExInfo object, or removes an existing LBMApplicationHeaderChain object if null is passed.
Also sets or clears the LBM#SRC_SEND_EX_FLAG_APPHDR_CHAIN from the flags field as appropriate.
@param appHeaderChain LBMApplicationHeaderChain to attach, or null to remove an existing LBMApplicationHeaderChain.
@since UMQ 1.1

### clientObject

```java
public Object clientObject()
```

Returns the client-supplied callback object.
@return The current client-supplied callback object.
@since UME 2.0

### channelInfo

```java
public LBMSourceChannelInfo channelInfo()
```

Returns the currently set channel info.
@return The current channel info.
@since LBM 3.6

### indexInfo

```java
public UMQIndexInfo indexInfo()
```

Returns the currently set index info.
@return The current index info.
@since UMQ 1.2

### totalLifetimeInfo

```java
public UMQMessageTotalLifetimeInfo totalLifetimeInfo()
```

Returns the currently set total lifetime info.
@return The current total lifetime info.
@since UMQ 2.2

### properties

```java
public LBMMessageProperties properties()
```

Gets the current message properties to be included with messages. Returns null if no
message properties are set.
@since UMS 6.8

### setHfSequenceNumber

```java
public void setHfSequenceNumber(long hfsqn)
```

Set the hot failover sequence number to send. Though java does not support unsigned integers, UMS
hot failover values are considered unsigned. This method is used to set either the 32 or 64 bit
sequence number to send. The ExInfo flags determine which bit value will be used, and must be set
accordingly.
@param hfsqn Hot failover sequence number to send.
@see LBM#SRC_SEND_EX_FLAG_HF_32
@see LBM#SRC_SEND_EX_FLAG_HF_64
@see setHfSequenceNumberBigInt(BigInteger)
@since UMS 5.1.1

### setHfSequenceNumberBigInt

```java
public void setHfSequenceNumberBigInt(BigInteger hfsqn)
```

Set the hot failover sequence number to send. This method is provided for convenience when using
64 bit numbers. UMS will only use 64 bits of the BigInteger and is stored internally as a long.
@param hfsqn Hot failover sequence number to send
@see LBM#SRC_SEND_EX_FLAG_HF_32
@see LBM#SRC_SEND_EX_FLAG_HF_64
@see setHfSequenceNumber(long)
@since UMS 5.1.1

### getHfSequenceNumber

```java
public long getHfSequenceNumber()
```

Get the currently set hot failover sequence number as a long value.
@see getHfSequenceNumberBigInt(BigInteger)
@return Hot failover sequence number

### getHfSequenceNumberBigInt

```java
public BigInteger getHfSequenceNumberBigInt()
```

Get the currently set hot failover sequence number as a BigInteger. This is provided as a
convenience method to ensure 64 bit numbers are returned as unsigned values.
@see #getHfSequenceNumber
@return Hot failover sequence number

## LBMSourceStatistics

*class* `com.latencybusters.lbm.LBMSourceStatistics`

### LBMSourceStatistics

```java
public LBMSourceStatistics()
```

Instantiate an empty object containing no statistics.

### LBMSourceStatistics

```java
public LBMSourceStatistics(UMMonAttributes attributes, SourceTransport srcStats) throws LBMException
```

Instantiate object containing the set of source transport statistics
for a given source transport.
@param attributes An UMMonAttributesProtos.UMMonAttributes
@param srcStats An UMSMonProtos.Stats.SourceTransport
@throws LBMException if any error occurred retrieving source statistics.

### LBMSourceStatistics

```java
public LBMSourceStatistics(LBMMonitorReceiver lbmmonrcv, ByteBuffer attributeBuffer, ByteBuffer srcStats) throws LBMException
```

Instantiate object containing the set of source transport statistics
for a given source transport.

@param lbmmonrcv  LBMMonitorReceiver that received this packet.
@param attributeBuffer A ByteBuffer of packet attributes passed to the passthrough callback
@param srcStats   A ByteBuffer of CSV statistics passed to the passthrough callback
@throws LBMException if any error occurred retrieving source statistics.

### LBMSourceStatistics

```java
public LBMSourceStatistics(LBMContext lbmctx, int maxStats) throws LBMException
```

Instantiate object containing the current set of
source transport statistics for a given LBM context
This constructor will throw LBMMonitorEInvalException if maxStats
is less than the available number of transport statistical sets.
@param lbmctx LBMContext object associated with statistics to be retrieved
@param maxStats Maximum number of statistical sets to retrieve
@throws LBMException if any error occurred retrieving source statistics.
@see #refresh

### LBMSourceStatistics

```java
public LBMSourceStatistics(LBMSource lbmsrc) throws LBMException
```

Instantiate object containing the current set of
    source transport statistics for a given LBM source.
@param lbmsrc LBMSource object
@throws LBMException if any error occurred retrieving source statistics.
@see #refresh

### refresh

```java
public void refresh(LBMContext lbmctx, int maxStats) throws LBMException
```

Refresh source transport statistics for a given LBM context.
This method will throw LBMMonitorEInvalException if maxStats
is less than the available number of transport statistical sets.
@param lbmctx LBMContext object associated with statistics to be retrieved
@param maxStats Maximum number of statistical sets to retrieve
@throws LBMException if any error occurred retrieving source statistics.

### refresh

```java
public void refresh(LBMSource lbmsrc) throws LBMException
```

Refresh source transport statistics for a given LBM source
@param lbmsrc LBMSource object
@throws LBMException if any error occurred retrieving source statistics.

### dispose

```java
public void dispose()
```

Free memory associated with this set of statistics.

### size

```java
public int size()
```

Number of statistical sets encapsulated within this object
@return Statistical set size

### type

```java
public int type() throws LBMException
```

Transport type (TCP, LBT-RM, LBT-RU, etc.).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Transport type
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)
@see LBM

### type

```java
public int type(int n) throws LBMException
```

Transport type (TCP, LBT-RM, LBT-RU, etc.).
This method returns a value from the nth
set of statistics encapsulated within this object.
@param n Statistics set index
@return Transport type
@throws LBMException if any error occurred retrieving source statistics.
@see LBM

### typeName

```java
public String typeName() throws LBMException
```

Transport type name (TCP, LBT-RM, LBT-RU, etc.).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been created
using a specific source to instantiate the class.
@return Transport type name
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### typeName

```java
public String typeName(int n) throws LBMException
```

Transport type name (TCP, LBT-RM, LBT-RU, etc.).
This method returns a value from the nth set of statistics
encapsulated within this object.
@param n Statistics set index
@return Transport type name
@throws LBMException if any error occurred retrieving source statistics.

### source

```java
public String source() throws LBMException
```

Source of a transport as a string.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@see LBMTransportSourceInfo
@return Source of transport as a string
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### source

```java
public String source(int n) throws LBMException
```

Source of a transport as a string.
The string format depends on transport type and is described under
LBMTransportSourceInfo.
This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@see LBMTransportSourceInfo
@return Source of transport as a string
@throws LBMException if any error occurred retrieving source statistics.

### numberOfClients

```java
public long numberOfClients() throws LBMException
```

Number of receiver clients currently connected over this transport
(TCP, LBT-RU, LBT-IPC, LBT-RDMA).
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of receiver clients currently connected over this transport
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### numberOfClients

```java
public long numberOfClients(int n) throws LBMException
```

Number of receiver clients currently connected over this transport
(TCP, LBT-RU, LBT-IPC, LBT-RDMA).
This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of receiver clients currently connected over this transport
@throws LBMException if any error occurred retrieving source statistics.

### bytesBuffered

```java
public long bytesBuffered() throws LBMException
```

Number of bytes currently in UM's TCP buffer, i.e., a snapshot (TCP only).
This count is affected by the number of receivers,and configuration options
transport_tcp_multiple_receiver_behavior and transport_session_maximum_buffer.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of bytes currently in UM's TCP buffer
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### bytesBuffered

```java
public long bytesBuffered(int n) throws LBMException
```

Number of bytes currently in UM's TCP buffer, i.e., a snapshot (TCP only).
This count is affected by the number of receivers,and configuration options
transport_tcp_multiple_receiver_behavior and transport_session_maximum_buffer.
This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of bytes currently in UM's TCP buffer
@throws LBMException if any error occurred retrieving source statistics.

### messagesSent

```java
public long messagesSent() throws LBMException
```

Number of datagrams sent (LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA)
or complete messages sent (BROKER).
Depending on batching settings, a single datagram may contain one or more messages, or a
fragment of a larger message. With LBT-RM, larger messages are split into fragment sizes
limited by configuration option transport_lbtrm_datagram_max_size (default 8KB).
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of datagrams sent
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### messagesSent

```java
public long messagesSent(int n) throws LBMException
```

Number of datagrams sent (LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA)
or complete messages sent (BROKER).
Depending on batching settings, a single datagram may contain one or more messages, or a
fragment of a larger message. With LBT-RM, larger messages are split into fragment sizes
limited by configuration option transport_lbtrm_datagram_max_size (default 8KB).
    This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of datagrams sent
@throws LBMException if any error occurred retrieving source statistics.

### bytesSent

```java
public long bytesSent() throws LBMException
```

Number of datagram bytes sent (LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA)
or complete message bytes sent (BROKER).
This is the total of lengths of all transport packets, including UM header information (except BROKER).
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of datagram bytes sent
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### bytesSent

```java
public long bytesSent(int n) throws LBMException
```

Number of datagram bytes sent (LBT-RM, LBT-RU, LBT-IPC, LBT-RDMA)
or complete message bytes sent (BROKER).
This is the total of lengths of all transport packets, including UM header information (except BROKER).
    This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of datagram bytes sent
@throws LBMException if any error occurred retrieving source statistics.

### transmissionWindowMessages

```java
public long transmissionWindowMessages() throws LBMException
```

    Number of datagrams in the transmission window (LBT-RM only).
Each source transport session maintains a transmission window buffer (the size of which
is set by transport_lbtrm_transmission_window_size, default 24MB). When the source
transport receives a NAK, the corresponding message for retransmission must be found in
this transmission window.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of datagrams in the transmission window
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### transmissionWindowMessages

```java
public long transmissionWindowMessages(int n) throws LBMException
```

    Number of datagrams in the transmission window (LBT-RM only).
Each source transport session maintains a transmission window buffer (the size of which
is set by transport_lbtrm_transmission_window_size, default 24MB). When the source
transport receives a NAK, the corresponding message for retransmission must be found in
this transmission window.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of datagrams in the transmission window
@throws LBMException if any error occurred retrieving source statistics.

### transmissionWindowBytes

```java
public long transmissionWindowBytes() throws LBMException
```

Number of bytes currently in the transmission window (LBT-RM only).
Typically, this count approaches its window size or exceeds it by a small amount.
See #transmissionWindowMessages for a description of the transmission window.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of bytes currently in the transmission window
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### transmissionWindowBytes

```java
public long transmissionWindowBytes(int n) throws LBMException
```

Number of bytes currently in the transmission window (LBT-RM only).
Typically, this count approaches its window size or exceeds it by a small amount.
See #transmissionWindowMessages for a description of the transmission window.
    This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of bytes currently in the transmission window
@throws LBMException if any error occurred retrieving source statistics.

### nakPacketsReceived

```java
public long nakPacketsReceived() throws LBMException
```

Number of NAK packets received by this source transport (LBT-RM, LBT-RU).
UM batches NAKs into NAK packets to save network bandwidth. This should always be less
than or equal to naksReceived (below).
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of NAK packets received by this source transport
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### nakPacketsReceived

```java
public long nakPacketsReceived(int n) throws LBMException
```

Number of NAK packets received by this source transport (LBT-RM, LBT-RU).
UM batches NAKs into NAK packets to save network bandwidth. This should always be less
than or equal to naksReceived (below).
This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of NAK packets received by this source transport
@throws LBMException if any error occurred retrieving source statistics.

### naksReceived

```java
public long naksReceived() throws LBMException
```

Number of individual NAKs received by the source transport (LBT-RM, LBT-RU).
When a source transport receives a NAK from a receiver transport, it may respond by
re-transmitting the requested LBT-RM datagram, or it may send an NCF. The NAKing
receiver transport responds to the NCF by waiting (timeout set by
transport_lbtrm_nak_suppress_interval, default 1000 ms), then re-sending the NAK.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of individual NAKs received by this source transport
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### naksReceived

```java
public long naksReceived(int n) throws LBMException
```

Number of individual NAKs received by the source transport (LBT-RM, LBT-RU).
When a source transport receives a NAK from a receiver transport, it may respond by
re-transmitting the requested LBT-RM datagram, or it may send an NCF. The NAKing
receiver transport responds to the NCF by waiting (timeout set by
transport_lbtrm_nak_suppress_interval, default 1000 ms), then re-sending the NAK.
This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of individual NAKs received by this source transport
@throws LBMException if any error occurred retrieving source statistics.

### naksIgnored

```java
public long naksIgnored() throws LBMException
```

Number of NAKs the source ignored and sent an NCF with reason code "ignored"
    (LBT-RM, LBT-RU).
A source transport ignores a NAK for a datagram it has already recently retransmitted.
How "recently" is determined by the configuration option source
transport_lbtrm_ignore_interval (default 500ms). If this count is high, a receiver
transport may be having trouble receiving retransmissions, or the ignore interval may be
set too long.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of NAKs the source ignored and sent an NCF with reason code "ignored"
    code set to "ignored".
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### naksIgnored

```java
public long naksIgnored(int n) throws LBMException
```

Number of NAKs the source ignored and sent an NCF with reason code "ignored"
    (LBT-RM, LBT-RU).
A source transport ignores a NAK for a datagram it has already recently retransmitted.
How "recently" is determined by the configuration option source
transport_lbtrm_ignore_interval (default 500ms). If this count is high, a receiver
transport may be having trouble receiving retransmissions, or the ignore interval may be
set too long.
This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of NAKs the source ignored and sent an NCF with reason code "ignored"
@throws LBMException if any error occurred retrieving source statistics.

### naksShed

```java
public long naksShed() throws LBMException
```

Number of NAKs this source shed and sent an NCF with reason code "shed"
    (LBT-RM, LBT-RU).
When a source transport's retransmit rate limiter and retransmit queue are both at
maximum, it responds to a NAK by sending an "NCF shed", and does not retransmit. The
receiver transport should wait, then send another NAK. If this count is high, one or
more crybaby receiver transports may be clogging the source transport's retransmit
queue.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of NAKs this source shed by sending an NCF with the reason code set to "shed"
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### naksShed

```java
public long naksShed(int n) throws LBMException
```

Number of NAKs this source shed and sent an NCF with reason code "shed"
    (LBT-RM, LBT-RU).
When a source transport's retransmit rate limiter and retransmit queue are both at
maximum, it responds to a NAK by sending an "NCF shed", and does not retransmit. The
receiver transport should wait, then send another NAK. If this count is high, one or
more crybaby receiver transports may be clogging the source transport's retransmit
queue.
This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of NAKs this source shed by sending an NCF with the reason code set to "shed"
@throws LBMException if any error occurred retrieving source statistics.

### naksIgnoredRetransmitDelay

```java
public long naksIgnoredRetransmitDelay() throws LBMException
```

Number of NAKs this source did not process because doing so would exceed its retransmit
    rate limit (LBT-RM, LBT-RU).
This rate limit is set by configuration option transport_lbtrm_retransmit_rate_limit
(default 5Mbps). For each of these NAKs, the source transport immediately sends an NFC
rx_delay, then queues the retransmission for a later send within the rate limit. If this
count is high, one or more crybaby receiver transports may be clogging the source
transport's retransmit queue.
This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of NAKs ignored due to retransmit delay
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### naksIgnoredRetransmitDelay

```java
public long naksIgnoredRetransmitDelay(int n) throws LBMException
```

Number of NAKs this source did not process because doing so would exceed its retransmit
    rate limit (LBT-RM, LBT-RU).
This rate limit is set by configuration option transport_lbtrm_retransmit_rate_limit
(default 5Mbps). For each of these NAKs, the source transport immediately sends an NFC
rx_delay, then queues the retransmission for a later send within the rate limit. If this
count is high, one or more crybaby receiver transports may be clogging the source
transport's retransmit queue.
    This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of NAKs ignored due to retransmit delay
@throws LBMException if any error occurred retrieving source statistics.

### retransmissionsSent

```java
public long retransmissionsSent() throws LBMException
```

Number of datagrams retransmitted by this source transport (LBT-RM, LBT-RU).
This count is incremented under the same circumstances as retransmissionBytesSent,
below. In a normal, light-loss scenario, most NAKs received induce a retransmission.
When losses become heavy and/or many receiver transports begin losing the same
datagrams, NCF-related no-retransmit counts (naksIgnored, naksShed and
naksIgnoredRetransmitDelay) may begin to inflate, and retransmissions
retransmissionsSent) may become significantly lower than NAKS received (naksReceived).
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of datagrams retransmitted by this source
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### retransmissionsSent

```java
public long retransmissionsSent(int n) throws LBMException
```

Number of datagrams retransmitted by this source transport (LBT-RM, LBT-RU).
This count is incremented under the same circumstances as retransmissionBytesSent,
below. In a normal, light-loss scenario, most NAKs received induce a retransmission.
When losses become heavy and/or many receiver transports begin losing the same
datagrams, NCF-related no-retransmit counts (naksIgnored, naksShed and
naksIgnoredRetransmitDelay) may begin to inflate, and retransmissions
retransmissionsSent) may become significantly lower than NAKS received (naksReceived).
This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of datagrams retransmitted by this source
@throws LBMException if any error occurred retrieving source statistics.

### retransmissionBytesSent

```java
public long retransmissionBytesSent() throws LBMException
```

Number of bytes retransmitted by this source transport (LBT-RM, LBT-RU).
This count is triggered under the same circumstances as retransmissionsSent, above. In a
normal, light-loss scenario, most NAKs received induce a retransmission. When losses
become heavy and/or many receiver transports begin losing the same datagrams,
NCF-related no-retransmit counts (naksIgnored, naksShed and naksIgnoredRetransmitDelay)
may begin to inflate, and retransmissions retransmissionsSent) may become significantly
lower than NAKs received (naksReceived).
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of transport bytes retransmitted by this source
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### retransmissionBytesSent

```java
public long retransmissionBytesSent(int n) throws LBMException
```

Number of bytes retransmitted by this source transport (LBT-RM, LBT-RU).
This count is triggered under the same circumstances as retransmissionsSent, above. In a
normal, light-loss scenario, most NAKs received induce a retransmission. When losses
become heavy and/or many receiver transports begin losing the same datagrams,
NCF-related no-retransmit counts (naksIgnored, naksShed and naksIgnoredRetransmitDelay)
may begin to inflate, and retransmissions retransmissionsSent) may become significantly
lower than NAKs received (naksReceived).
This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of transport bytes retransmitted by this source
@throws LBMException if any error occurred retrieving source statistics.

### messagesQueued

```java
public long messagesQueued() throws LBMException
```

Number of datagrams currently queued by the data rate limiter (LBT-RM only).
When a source transport attempts to send messages (any type) faster than its data rate
limiter allows (set by configuration option transport_lbtrm_data_rate_limit, default
10Mbps), the data rate limiter queues the messages until they can be sent within the
data rate limit.
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of datagrams currently queued by the data rate limiter
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### messagesQueued

```java
public long messagesQueued(int n) throws LBMException
```

Number of datagrams currently queued by the data rate limiter (LBT-RM only).
When a source transport attempts to send messages (any type) faster than its data rate
limiter allows (set by configuration option transport_lbtrm_data_rate_limit, default
10Mbps), the data rate limiter queues the messages until they can be sent within the
data rate limit.
This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of datagrams currently queued by the data rate limiter
@throws LBMException if any error occurred retrieving source statistics.

### retransmissionsQueued

```java
public long retransmissionsQueued() throws LBMException
```

Number of retransmission datagrams currently queued by the retransmit
rate limiter (LBT-RM only).
When a source transport attempts to send retransmissions faster that its
retransmit rate limiter allows (set by configuration option
transport_lbtrm_retransmit_rate_limit, default 5Mbps), the retransmit rate limiter
queues retransmissions until they can be sent within the rate limit.
naks_rx_delay_ignored (above) will generally also rise if this count is high
This method returns a value from the first
    This method returns a value from the first
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@return Number of datagrams currently queued by the retransmit rate limiter
@throws LBMException if any error occurred retrieving source statistics.
@see #LBMSourceStatistics(LBMSource)

### retransmissionsQueued

```java
public long retransmissionsQueued(int n) throws LBMException
```

Number of retransmission datagrams currently queued by the retransmit
rate limiter (LBT-RM only).
When a source transport attempts to send retransmissions faster that its
retransmit rate limiter allows (set by configuration option
transport_lbtrm_retransmit_rate_limit, default 5Mbps), the retransmit rate limiter
queues retransmissions until they can be sent within the rate limit.
naks_rx_delay_ignored (above) will generally also rise if this count is high
This method returns a value from the first
This method returns a value from the nth
set of statistics encapsulated within this object
and would normally be used when the object has been
created using a specific source to instantiate the class.
@param n Statistics set index
@return Number of datagrams currently queued by the retransmit rate limiter
@throws LBMException if any error occurred retrieving source statistics.

## LBMStatistics

*class* `com.latencybusters.lbm.LBMStatistics`

### LBMStatistics

```java
public LBMStatistics()
```

Instantiate an empty object containing no statistic attributes.

### LBMStatistics

```java
public LBMStatistics(UMMonAttributesProtos.UMMonAttributes attributes) throws LBMException
```

    Instantiate object containing the statistic attributes for a statistics packet.
@param attributes An UMMonAttributesProtos.UMMonAttributes
    @throws LBMException if any error occurred retrieving statistic attributes.

### LBMStatistics

```java
public LBMStatistics(LBMMonitorReceiver lbmmonrcv, ByteBuffer attributeBuffer) throws LBMException
```

     Instantiate object containing the statistic attributes for a statistics packet.
@param lbmmonrcv An %LBM monitor receiver object
@param attributeBuffer An UMMonAttributesProtos.UMMonAttributes
     @throws LBMException if any error occurred retrieving statistic attributes.

### getApplicationSourceId

```java
public String getApplicationSourceId()
```

Retrieve the application source identifier associated with this
set of statistics.

This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
@return Application source ID

### getSender

```java
public InetAddress getSender() throws UnknownHostException
```

Retrieve the IP sender address associated with this set of statistics.

This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
@return InetAddress object corresponding to the statistics' sender
IP address
@throws UnknownHostException if IP address is of illegal length.

### getTimestamp

```java
public Date getTimestamp()
```

Retrieve the timestamp associated with this set of statistics.

This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
@return Timestamp Date object

### getProcessId

```java
public long getProcessId()
```

Retrieve the sending process ID associated with this set of statistics.

This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
@return Process ID

### getContextId

```java
public long getContextId()
```

Retrieve the sending context ID associated with this set of statistics.

This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
@return Context ID

### getContextInstance

```java
public String getContextInstance()
```

Retrieve the sending context instance associated with this
set of statistics.

This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
@return Context Instance

### getDomainId

```java
public long getDomainId()
```

Retrieve the sending domain ID associated with this set of statistics.

This attribute is only set for remote statistics returned by the
lbmmon infrastructure.  For locally-gathered statistics, this
method returns an undefined value.
@return Domain ID

## LBMTimer

*class* `com.latencybusters.lbm.LBMTimer`

### LBMTimer

```java
public LBMTimer(LBMContext lbmctx, long milliseconds) throws LBMException
```

Creates a timer associated with a specific context that expires with
a specified delay.
    <p>
    A zero duration timer is legal and causes the
    associated callback to be called as soon as possible on the context thread.
<p>
The timer object will not be collected by GC until the timer has
expired or cancel() has been called, even if it goes out of scope.
@param lbmctx LBMContext object with which to associate this timer
(determines which LBM thread will execute the timer function).
@param milliseconds Number of milliseconds until the timer expires
@throws LBMException if any timer scheduling error occurs.

### LBMTimer

```java
public LBMTimer(LBMContext lbmctx, long milliseconds, LBMEventQueue lbmevq) throws LBMException
```

Creates a timer associated with a specific context and event queue
that expires with a specified delay.
    <p>
    A zero duration timer is legal and causes the associated callback
    to be called as soon as possible on the context thread or to be
    enqueued as an event on the associated event queue. In this case,
    the event queue dispatching thread calls the associated callback
    after all currently pending events have been dispatched.
<p>
The timer object will not be collected by GC until the timer has
expired or cancel() has been called, even if it goes out of scope.
@param lbmctx LBMContext object with which to associate this timer
@param milliseconds Number of milliseconds until the timer expires
@param lbmevq Event queue with which to associate this timer
(the timer events will be posted to this event queue)
@throws LBMException if any timer scheduling error occurs.

### LBMTimer

```java
public LBMTimer(LBMContext lbmctx, long milliseconds, LBMTimerCallback cb, Object cbArg) throws LBMException
```

Creates a timer associated with a specific context that expires with
a specified delay.
    <p>
    A zero duration timer is legal and causes the
    associated callback to be called as soon as possible on the context thread.
<p>
The timer object will not be collected by GC until the timer has
expired or cancel() has been called, even if it goes out of scope.
@param lbmctx LBMContext object with which to associate this timer
(determines which LBM thread will execute the timer function).
@param milliseconds Number of milliseconds until the timer expires
@param cb An object implementing the LBMTimerCallback interface
@param cbArg Callback object passed as token to callback interface
@throws LBMException if any timer scheduling error occurs.

### LBMTimer

```java
public LBMTimer(LBMContext lbmctx, long milliseconds, LBMTimerCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Creates a timer associated with a specific context and event queue
that expires with a specified delay.
    <p>
    A zero duration timer is legal and causes the associated callback
    to be called as soon as possible on the context thread or to be
    enqueued as an event on the associated event queue. In this case,
    the event queue dispatching thread calls the associated callback
    after all currently pending events have been dispatched.
<p>
The timer object will not be collected by GC until the timer has
expired or cancel() has been called, even if it goes out of scope.
@param lbmctx LBMContext object with which to associate this timer
@param milliseconds Number of milliseconds until the timer expires
@param lbmevq Event queue with which to associate this timer
@param cb An object implementing the LBMTimerCallback interface
@param cbArg Callback object passed as token to callback interface
(the timer events will be posted to this event queue)
@throws LBMException if any timer scheduling error occurs.

### addTimerCallback

```java
public void addTimerCallback(LBMTimerCallback cb)
```

Register a timer callback
@param cb Object implementing the LBMTimerCallback interface
@see LBMTimerCallback
@see #removeTimerCallback

### addTimerCallback

```java
public void addTimerCallback(LBMTimerCallback cb, Object cbArg)
```

Register a timer callback (and callback token)
@param cb Object implementing the LBMTimerCallback interface
@param cbArg Callback token object
@see LBMTimerCallback
@see #removeTimerCallback

### removeTimerCallback

```java
public void removeTimerCallback(LBMTimerCallback cb)
```

Deregister a timer callback
@param cb Previously registered object implementing the
LBMTimerCallback interface
@see LBMTimerCallback
@see #addTimerCallback

### removeTimerCallback

```java
public void removeTimerCallback(LBMTimerCallback cb, Object cbArg)
```

Deregister a timer callback (and callback token)
@param cb Previously registered object implementing the
LBMTimerCallback interface
@param cbArg Callback token for previously registered object
@see LBMTimerCallback
@see #addTimerCallback

### cancel

```java
public void cancel() throws LBMException
```

Cancel timer
@throws LBMException if the timer was invalid or could not be cancelled.

### cancel

```java
public void cancel(boolean rescheduling) throws LBMException
```

Cancel timer
@param rescheduling External users should always pass in false.  Unexpected behavior may result if true is passed in.
@throws LBMException if the timer was invalid or could not be cancelled.
@deprecated This method is provided for backwards compatibility with LBM 3.3.7/UME 2.0.5; please use the {@link #cancel()} method instead.

### reschedule

```java
public void reschedule(long milliseconds) throws LBMException
```

Reschedule this timer to expire in a specified number of milliseconds.
@param milliseconds Number of milliseconds until this timer should
expire.
@throws LBMException if any timer scheduling error occurs.

### context

```java
public LBMContext context()
```

Get the LBMContext object associated with this timer.
@return An LBMContext object.

## LBMTimerCallback

*interface* `com.latencybusters.lbm.LBMTimerCallback`

### onExpiration

```java
void onExpiration(Object cbArg)
```

Timer expiration callback.
@param cbArg Callback object token

## LBMTimespec

*class* `com.latencybusters.lbm.LBMTimespec`

### LBMTimespec

```java
public LBMTimespec()
```

Creates an LBMTimespec object with all fields initialized to 0.
@since UMS 6.9

### LBMTimespec

```java
public LBMTimespec(long tv_sec, long tv_nsec)
```

Creates a LBMTimespec object with all fields initialized to the
given values.
@param tv_sec Holds a 64-bit value representing the seconds of the time value.
@param tv_nsec Holds a 64-bit value representing the nanoseconds of the time value.
@since UMS 6.9

### tv_sec

```java
public long tv_sec()
```

Get the seconds associated with this time value.
@return seconds associated with this time value.
@since UMS 6.9

### tv_nsec

```java
public long tv_nsec()
```

Get the nanoseconds associated with this time value.
@return nanoseconds associated with this time value.
@since UMS 6.9

## LBMTopic

*class* `com.latencybusters.lbm.LBMTopic`

### LBMTopic

```java
public LBMTopic(LBMContext lbmctx, String symbol) throws LBMException
```

    Turn a Topic string into an LBMTopic object usable by receivers.
    (Note: This constructor cannot be used to initialize a source topic.)
It is recommended  that topic objects be instantiated from the
{@link LBMContext} factory methods <code>allocTopic</code> and
<code>lookupTopic</code> (for sources and receivers respectively).
        <p>
        <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
    @param lbmctx LBMContext object for the topic
    @param symbol Topic string (Topic strings should be limited in length to 246 characters, not including the final null).
    @throws LBMException if any topic lookup error occurs.
    @see LBMReceiver

### LBMTopic

```java
public LBMTopic(LBMContext lbmctx, String symbol, LBMReceiverAttributes lbmrattr) throws LBMException
```

    Turn a Topic string into an LBMTopic object usable by receivers.
It is recommended  that topic objects be instantiated from the
{@link LBMContext} factory methods <code>allocTopic</code> and
<code>lookupTopic</code> (for sources and receivers respectively).
        <p>
        <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
    @param lbmctx LBMContext object for the topic
    @param symbol Topic string (Topic strings should be limited in length to 246 characters, not including the final null).
    @param lbmrattr LBMReceiverAttributes object used to initialize the
    topic object.
    @throws LBMException if any topic lookup error occurs.
    @see LBMReceiver

### LBMTopic

```java
public LBMTopic(LBMContext lbmctx, String symbol, LBMSourceAttributes lbmsattr) throws LBMException
```

    Turn a Topic string into an LBMTopic object usable by sources.
It is recommended  that topic objects be instantiated from the
{@link LBMContext} factory methods <code>allocTopic</code> and
<code>lookupTopic</code> (for sources and receivers respectively).
        <p>
        <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
    @param lbmctx LBMContext object for the topic
    @param symbol Topic string (Topic strings should be limited in length to 246 characters, not including the final null).
    @param lbmsattr LBMSourceAttributes object used to initialize the
    topic object.
    @throws LBMException if any topic allocation error occurs.
    @see LBMSource

## LBMTransportMappingCallback

*interface* `com.latencybusters.lbm.LBMTransportMappingCallback`

### onTransportMapping

```java
LBMXSP onTransportMapping(LBMContext context, LBMNewTransportInfo newTransportInfo, Object cbArg)
```

Transport mapping callback method.
@param context The context that is joining the new transport.
@param newTransportInfo The LBMNewTransportInfo that describes the new transport.
@param cbArg The client data supplied in {@link com.latencybusters.lbm.LBMContextAttributes#setTransportMappingCallback(com.latencybusters.lbm.LBMTransportMappingCallback, Object)}.

## LBMTransportSourceInfo

*class* `com.latencybusters.lbm.LBMTransportSourceInfo`

### getType

```java
public int getType()
```

Type of transport
@return The type of transport

### getSrcIp

```java
public long getSrcIp()
```

Source IP address. Applicable only to LBT-RM, LBT-RU, TCP, and LBT-RDMA. Stored in network order.
@return The source ip address

### getSrcPort

```java
public int getSrcPort()
```

Source port. Applicable only to LBT-RM, LBT-RU, TCP, and LBT-RDMA. Stored in host order.
@return The source port

### getDestPort

```java
public int getDestPort()
```

Destination port. Applicable only to LBT-RM. Stored in host order.
@return The destination port

### getMCGroup

```java
public long getMCGroup()
```

Multicast group. Applicable only to LBT-RM. Stored in network order.
@return The multicast group

### getTransportId

```java
public long getTransportId()
```

Transport ID. Applicable only to LBT-IPC. Stored in host order.
@return The transport id

### getSessionId

```java
public long getSessionId()
```

Session ID. Applicable only to LBT-RM, LBT-RU, and LBT-IPC. Stored in host order.
@return The session id

### getTopicIdx

```java
public long getTopicIdx()
```

Topic index. Applicable to all transports. Stored in host order.
@return The topic index

## LBMUMMInfo

*class* `com.latencybusters.lbm.LBMUMMInfo`

### LBMUMMInfo

```java
public LBMUMMInfo(String _applicationName, String _userName, String _password, String[] _servers) throws LBMEInvalException
```

Instantiate an LBM UMM info object.
@param _applicationName The application name.
@param _userName The UMM user name.
@param _password The UMM password.
@param _servers The list of servers to attempt connections to. Servers are specified as a string in "ip:port" format. Connections are attempted in a round-robin fashion starting with index 0.
@throws LBMEInvalException

### LBMUMMInfo

```java
public LBMUMMInfo(String _applicationName, String _userName, String _password, String[] _servers, int _flags) throws LBMEInvalException
```

Instantiate an LBM UMM info object.
@param _applicationName The application name.
@param _userName The UMM user name.
@param _password The UMM password.
@param _servers The list of servers to attempt connections to. Servers are specified as a string in "ip:port" format. Connections are attempted in a round-robin fashion starting with index 0.
@param _flags Flags to enable usage of SSL.
@throws LBMEInvalException

### LBMUMMInfo

```java
public LBMUMMInfo(String _applicationName, String _userName, String _password, String[] _servers, int _flags, String _certFile) throws LBMEInvalException
```

Instantiate an LBM UMM info object.
@param _applicationName The application name.
@param _userName The UMM user name.
@param _password The UMM password.
@param _servers The list of servers to attempt connections to. Servers are specified as a string in "ip:port" format. Connections are attempted in a round-robin fashion starting with index 0.
@param _flags Flags to enable usage of SSL.
@param _certFile Path to a pem-encoded certificate file. If specified, SSL is enabled and certificate is used to validate the UMM daemon identity.
@throws LBMEInvalException

### LBMUMMInfo

```java
public LBMUMMInfo(String _applicationName, String _userName, String _password, String[] _servers, int _flags, String _certFile, String _certFilePassword) throws LBMEInvalException
```

Instantiate an LBM UMM info object.
@param _applicationName The application name.
@param _userName The UMM user name.
@param _password The UMM password.
@param _servers The list of servers to attempt connections to. Servers are specified as a string in "ip:port" format. Connections are attempted in a round-robin fashion starting with index 0.
@param _flags Flags to enable usage of SSL.
@param _certFile Path to a pem-encoded certificate file. If specified, SSL is enabled and certificate is used to validate the UMM daemon identity.
@param _certFilePassword Certificate file password. Required only if certificate file is password-protected.
@throws LBMEInvalException

## LBMWildcardPatternCallback

*interface* `com.latencybusters.lbm.LBMWildcardPatternCallback`

### comparePattern

```java
int comparePattern(String topic, Object cbArg)
```

Callback function called when a pattern match is desired for a topic
discovered for a wildcard receiver.  The function does not use an event
queue.
@param topic Topic string to evaluate
@param cbArg Callback object token
@return 0 - indicates that the given topic should be considered part of
the wildcard, 1 or more - indicates that the topic should <b>not</b> be
considered matching the wildcard.
@see LBMWildcardReceiverAttributes#setPatternCallback

## LBMWildcardReceiver

*class* `com.latencybusters.lbm.LBMWildcardReceiver`

### LBMWildcardReceiver

```java
public LBMWildcardReceiver(LBMContext lbmctx, String pattern, LBMReceiverAttributes lbmrcvattr, LBMWildcardReceiverAttributes lbmwrcvattr) throws LBMException
```

Instantiate an LBM Wildcard Receiver object that will receive messages
sent to any topic matching the given pattern.
ATTENTION: An application _must_ have at least one receiver callback
registered per receiver object.  Use of this constructor in a class
that does not override the onReceive method creates a window
after receiver creation and before adding a callback in which
messages may be lost.  Using this constructor in a class that
overrides the onReceive method yields the best performance, and
is recommended.  If multiple callbacks support is needed, or if
overriding the onReceive method is not desirable, use a constructor
that specifies at least one initial callback.
    <p>
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the wildcard receiver.
@param pattern Pattern used to match topic strings
@param lbmrcvattr LBMReceiverAttributes to be associated with this
wildcard receiver
@param lbmwrcvattr LBMWildcardReceiverAttributes to be associated with
this wildcard receiver
@throws LBMException if the wildcard receiver creation fails.

### LBMWildcardReceiver

```java
public LBMWildcardReceiver(LBMContext lbmctx, String pattern, LBMReceiverAttributes lbmrcvattr, LBMWildcardReceiverAttributes lbmwrcvattr, LBMEventQueue lbmevq) throws LBMException
```

Instantiate an LBM Wildcard Receiver object (associated with a specified
event queue) that will receive messages sent to any topic matching the
given pattern.
ATTENTION: An application _must_ have at least one receiver callback
registered per receiver object.  Use of this constructor in a class
that does not override the onReceive method creates a window
after receiver creation and before adding a callback in which
messages may be lost.  Using this constructor in a class that
overrides the onReceive method yields the best performance, and
is recommended.  If multiple callbacks support is needed, or if
overriding the onReceive method is not desirable, use a constructor
that specifies at least one initial callback.
    <p>
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the wildcard receiver.
@param pattern Pattern used to match topic strings
@param lbmrcvattr LBMReceiverAttributes to be associated with this
wildcard receiver
@param lbmwrcvattr LBMWildcardReceiverAttributes to be associated with
this wildcard receiver
@param lbmevq Event queue with which to associate the receiver
(all receiver events will be posted to this event queue).
@throws LBMException if the wildcard receiver creation fails.

### LBMWildcardReceiver

```java
public LBMWildcardReceiver(LBMContext lbmctx, String pattern, LBMReceiverAttributes lbmrcvattr, LBMWildcardReceiverAttributes lbmwrcvattr, LBMReceiverCallback cb, Object cbArg) throws LBMException
```

Instantiate an LBM Wildcard Receiver object that will receive messages
sent to any topic matching the given pattern.
    <p>
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the wildcard receiver.
@param pattern Pattern used to match topic strings
@param lbmrcvattr LBMReceiverAttributes to be associated with this
wildcard receiver
@param lbmwrcvattr LBMWildcardReceiverAttributes to be associated with
this wildcard receiver
@param cb An object implementing the LBMReceiverCallback interface
    @param cbArg Callback object passed as token to callback interface
@throws LBMException if the wildcard receiver creation fails.

### LBMWildcardReceiver

```java
public LBMWildcardReceiver(LBMContext lbmctx, String pattern, LBMReceiverAttributes lbmrcvattr, LBMWildcardReceiverAttributes lbmwrcvattr, LBMReceiverCallback cb, Object cbArg, LBMEventQueue lbmevq) throws LBMException
```

Instantiate an LBM Wildcard Receiver object (associated with a specified
event queue) that will receive messages sent to any topic matching the
given pattern.
    <p>
    <b>Warning</b>: It is not safe to call this constructor from a context thread callback.
@param lbmctx Context with which to associate the wildcard receiver.
@param pattern Pattern used to match topic strings
@param lbmrcvattr LBMReceiverAttributes to be associated with this
wildcard receiver
@param lbmwrcvattr LBMWildcardReceiverAttributes to be associated with
this wildcard receiver
@param cb An object implementing the LBMReceiverCallback interface
    @param cbArg Callback object passed as token to callback interface
@param lbmevq Event queue with which to associate the receiver
(all receiver events will be posted to this event queue).
@throws LBMException if the wildcard receiver creation fails.

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions.
@return Array of LBMConfigOption

### getAttributeValue

```java
public String getAttributeValue(String attributeName) throws LBMException
```

Returns the value of a wildcard receiver-related attribute for this wildcard receiver.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setAttributeValue

```java
public void setAttributeValue(String attributeName, String attributeValue) throws LBMException
```

Set the value of a wildcard receiver-related attribute for this wildcard receiver.
Note that this method bypasses the property list.
As such no attributes configured using this method will appear in
the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### subscribeChannel

```java
public void subscribeChannel(long channelNumber, LBMReceiverCallback cb, Object cbArg) throws LBMException
```

Subscribe to a given channel

### unsubscribeChannel

```java
public void unsubscribeChannel(long channelNumber) throws LBMException
```

Cancel an existing subscription

### umederegister

```java
public void umederegister() throws LBMException
```

Deregister from all UME Store.
@throws LBMEOPException if an error occurs while attempting to deregister.

### deregister

```java
public void deregister() throws LBMException
```

Deregister from all UMQ queues.
@throws LBMEOPException if an error occurs while attempting to deregister.

### deregister

```java
public void deregister(String queue) throws LBMException
```

Deregister from a queue.
@param queue The name of the queue to deregister from.
@throws LBMEOPException if an error occurs while attempting to deregister.

### indexStopAssignment

```java
public void indexStopAssignment(String queue) throws LBMException
```

Stops this wildcard receiver's eligibility for new index assignments from a queue.
@param queue The name of the queue to stop new index assignment from, or null for all queues.
@throws LBMException if an error occurs while attempting to stop index assignment.
@since UMQ 1.2

### indexStartAssignment

```java
public void indexStartAssignment(String queue) throws LBMException
```

Starts this wildcard receiver's eligibility for new index assignments from a queue.
@param queue The name of the queue to start new index assignment from, or null for all queues.
@throws LBMException if an error occurs while attempting to start index assignment.
@since UMQ 1.2

### indexRelease

```java
public void indexRelease(String queue, UMQIndexInfo index) throws LBMException
```

Instruct the given UMQ queue(s) to release the given UMQ index that is assigned to this wildcard receiver.
@param queue Name of the queue at which to release the index, or null for all queues.
@param index The index to release, or null for all indices.
@throws LBMException if any error occurs.
@since UMQ 1.2

## LBMWildcardReceiverAttributes

*class* `com.latencybusters.lbm.LBMWildcardReceiverAttributes`

### LBMWildcardReceiverAttributes

```java
public LBMWildcardReceiverAttributes() throws LBMException
```

Create and fill an LBMWildcardReceiverAttributes object with the current default values.
@throws LBMException

### LBMWildcardReceiverAttributes

```java
public LBMWildcardReceiverAttributes(String contextName, String pattern, int pattern_type) throws LBMException
```

Create and fill an LBMWildcardReceiverAttributes object with the current default values for the given context name, pattern and pattern type.
@param contextName The name of the context under which the wildcard receiver is to be created.
@param pattern The wildcard receiver pattern which will be used to create the wildcard receiver. Must match the wildcard receiver pattern in the XML configuration exactly.
@param pattern_type The pattern_type of the wildcard receiver. Is written into the attributes object.
@throws LBMException if contextName, or pattern and pattern_type combination are not permitted by the XML configuration.

### setFromXml

```java
public void setFromXml(String contextName, String pattern, int pattern_type) throws LBMException
```

Fill an LBMWildcardReceiverAttributes object with the default values for the given context name, pattern and pattern type.
@param contextName The name of the context under which the wildcard receiver is to be created.
@param pattern The wildcard receiver pattern which will be used to create the wildcard receiver. Must match the wildcard receiver pattern in the XML configuration exactly.
@param pattern_type The pattern_type of the wildcard receiver. Is written into the attributes object.
@throws LBMException if contextName, or pattern and pattern_type combination are not permitted by the XML configuration.

### dispose

```java
public void dispose()
```

Free memory associated with this set of attributes.

### dumpAttributeList

```java
public LBMConfigOption[] dumpAttributeList()
```

Returns an array of LBMConfigOptions.
@return Array of LBMConfigOption

### getValue

```java
public String getValue(String attributeName) throws LBMException
```

Returns the current value of an attribute from this set of
wildcard receiver-related attributes.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setValue

```java
public void setValue(String attributeName, String attributeValue) throws LBMException
```

FOR INTERNAL INFORMATICA USE ONLY - NOT FOR DIRECT APPLICATION USEAGE.
Applications should use setProperty() instead.
Set the current value of an attribute in this set of
wildcard receiver-related attributes.  Note that this method bypasses
the property list.  As such no attributes configured using this method
will appear in the property list.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.
@see #setProperty

### setProperty

```java
public Object setProperty(String attributeName, String attributeValue)
```

Set the current value of an attribute in this set of wildcard
receiver-related attributes.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMRuntimeException if <code>attributeName</code> is not a valid attribute,
    or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### load

```java
public void load(InputStream inStream) throws IOException
```

Reads a property (attribute) list (key and element pairs) from the
input stream.
@param inStream Input stream of bytes
@throws IOException if any I/O error occurs.
@throws LBMRuntimeException if any invalid attribute is detected in <code>inStream</code>.

### setPatternCallback

```java
public void setPatternCallback(LBMWildcardPatternCallback cb, Object cbArg)
```

Set the callback interface (and a callback handle argument) to be called
when a pattern match is desired for a topic discovered for a wildcard
receiver if the pattern type is set to "appcb".
@param cb An object implementing the LBMWildcardPatternCallback interface
@param cbArg Callback object passed as a token to the callback interface

### setReceiverCreateCallback

```java
public void setReceiverCreateCallback(LBMWildcardReceiverCreateCallback cb, Object cbArg)
```

Set the receiver create callback for this wildcard receiver; this callback
will be called when a new internal receiver is created and allows the LBMReceiverAttributes
that will be used to create the receiver to be changed before the receiver is created.
@param cb An object implementing the LBMWildcardReceiverCreateCallback interface.
@param cbArg Callback object passed as a token to the callback interface.

### setReceiverDeleteCallback

```java
public void setReceiverDeleteCallback(LBMWildcardReceiverDeleteCallback cb, Object cbArg)
```

Set the receiver delete callback for this wildcard receiver; this callback
will be called when a new internal receiver is deleted.
@param cb An object implementing the LBMWildcardReceiverDeleteCallback interface.
@param cbArg Callback object passed as a token to the callback interface.

## LBMWildcardReceiverCreateCallback

*interface* `com.latencybusters.lbm.LBMWildcardReceiverCreateCallback`

### onReceiverCreate

```java
int onReceiverCreate(String topicName, LBMReceiverAttributes attr, Object cbArg)
```

New receiver create callback for internal per-topic receivers of an LBMWildcardReceiver.
@param topicName Topic name matched by the newly created internal receiver.
@param attr LBMReceiverAttributes object that will be used to create the receiver; options may be changed
before the callback method completes.
@param cbArg Client callback object.
@return 0 always.

## LBMWildcardReceiverDeleteCallback

*interface* `com.latencybusters.lbm.LBMWildcardReceiverDeleteCallback`

### onReceiverDelete

```java
int onReceiverDelete(String topicName, Object cbArg)
```

New receiver delete callback for internal per-topic receivers of an LBMWildcardReceiver.
@param topicName Topic name matched by the newly created internal receiver.
@param cbArg Client callback object.

## LBMXSP

*class* `com.latencybusters.lbm.LBMXSP`

### LBMXSP

```java
public LBMXSP(LBMContext ctx, LBMContextAttributes ctxAttr, LBMXSPAttributes xspAttr) throws LBMException
```

 Instantiate an LBMXSP object using the given context and attributes objects.

For more information on XSP, see \ref transportservicesproviderxsp.

@param ctx LBMContext that will own this XSP.
@param ctxAttr LBMContextAttributes that this XSP will use.
@param xspAttr LBMXSPAttributes that this XSP will use.
@throws LBMException if any error occurs creating the XSP.

### close

```java
public final void close() throws LBMException
```

Close this XSP.  There must be no remaining transports mapped to this XSP.

### processEvents

```java
public void processEvents(long msec) throws LBMException
```

Process internal events in the given XSP object.

When the operational mode is set to "sequential",
it is the responsibility of the application to explicitly process
events for the XSP. This method will process timers and file
descriptor/socket events for internal processing.
<p>
<b>Warning</b>: It is not safe to call this method from a context thread callback.
@param msec Continue event processing loop for at least msec milliseconds before returning.
@throws LBMException if any error occurs.

### unblockProcessEvents

```java
public void unblockProcessEvents() throws LBMException
```

Unblock processEvents call.

When the operational mode is set to "sequential",
this API forces a call to processEvents to return immediately after
completing the current set of I/O operations instead of waiting.
<p>
@throws LBMException if any error occurs.

## LBMXSPAttributes

*class* `com.latencybusters.lbm.LBMXSPAttributes`

### LBMXSPAttributes

```java
public LBMXSPAttributes() throws LBMException
```

Create and fill an LBMXSPAttributes object with the current default values
@throws LBMException

### dispose

```java
public void dispose()
```

Free memory associated with this set of attributes.

### getValue

```java
public String getValue(String attributeName) throws LBMException
```

Returns the current value of an attribute from this set of XSP attributes.
@param attributeName Name of the attribute to retrieve
@return Value corresponding to the specified attribute name
@throws LBMException if <code>attributeName</code> is not a valid attribute.

### setValue

```java
public void setValue(String attributeName, String attributeValue) throws LBMException
```

FOR INTERNAL INFORMATICA USE ONLY - NOT FOR DIRECT APPLICATION USEAGE.
Applications should use setProperty() instead.
Set the current value of an attribute in this set of XSP attributes.
@param attributeName Name of the attribute to set
@param attributeValue New attribute value
@throws LBMException if <code>attributeName</code> is not a valid attribute,
or <code>attributeValue</code> is not a valid value for <code>attributeName</code>.

### setZeroTransportsCallback

```java
public void setZeroTransportsCallback(LBMZeroTransportsCallback cb)
```

Set the XSP's zero transports callback.
@param cb An object implementing the LBMZeroTransportsCallback interface.

### setZeroTransportsCallback

```java
public void setZeroTransportsCallback(LBMZeroTransportsCallback cb, Object cbArg)
```

Set the XSP's zero transports callback.
@param cb An object implementing the LBMZeroTransportsCallback interface.
@param cbArg A user-supplied callback object to be passed back in the zero transports callback.

## LBMZeroTransportsCallback

*interface* `com.latencybusters.lbm.LBMZeroTransportsCallback`

### onZeroTransports

```java
int onZeroTransports(LBMXSP xsp, Object cbArg)
```

Zero transports callback method.
@param xsp the LBMXSP that has no more associated transports.
@param cbArg the client data supplied in {@link com.latencybusters.lbm.LBMXSPAttributes#setZeroTransportsCallback(com.latencybusters.lbm.LBMZeroTransportsCallback, Object)}.

## UMEDeregistrationCompleteInfo

*class* `com.latencybusters.lbm.UMEDeregistrationCompleteInfo`

### UMEDeregistrationCompleteInfo

```java
public UMEDeregistrationCompleteInfo()
```

Creates a UMEDeregistrationCompleteInfo object and initializes fields to 0.

### UMEDeregistrationCompleteInfo

```java
public UMEDeregistrationCompleteInfo(int flags, long sequenceNumber) throws LBMEInvalException
```

Creates a UMEDeregistrationCompleteInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param sequenceNumber Starting sequence number (must be >= 0).
@throws LBMEInvalException if sequenceNumber < 0.
@since UME 2.0

### flags

```java
public int flags()
```

Get informational flags for this deregistration complete message.
@return Flags.
@since UME 2.0

### sequenceNumber

```java
public long sequenceNumber()
```

Get starting sequence number for this deregistration complete message.
@return Sequence number.
@since UME 2.0

## UMEDeregistrationSuccessInfo

*class* `com.latencybusters.lbm.UMEDeregistrationSuccessInfo`

### UMEDeregistrationSuccessInfo

```java
public UMEDeregistrationSuccessInfo()
```

Creates a UMEDeregistrationSuccessInfo object and initializes all fields to
0/null.

### UMEDeregistrationSuccessInfo

```java
public UMEDeregistrationSuccessInfo(int flags, long sourceRegId, long receiverRegId, long sequenceNumber, int storeIndex, String store) throws LBMEInvalException
```

Creates a UMEDeregistrationSuccessInfo object and initializes fields to
supplied values.
@param flags Flags concerning the type of deregistration.
@param sourceRegId Source registration ID (must be >= 0).
@param receiverRegId Receiver registration ID (must be >= 0).
@param storeIndex Index of store registered with (must be >= 0).
@param store Name (IP address) of store registered with.
@param sequenceNumber The starting sequence number according to the store.
@throws LBMEInvalException if sourceRegId, receiverRegId, or storeIndex are < 0.
@since UME 2.0

### flags

```java
public int flags()
```

Get registration success flags.
@return Flags.
@since UME 2.0

### sourceRegistrationId

```java
public long sourceRegistrationId()
```

Get source registration ID.
@return source registration ID.
@since UME 2.0

### receiverRegistrationId

```java
public long receiverRegistrationId()
```

Get receiver registration ID.
@return receiver registration ID.
@since UME 2.0

### sequenceNumber

```java
public long sequenceNumber()
```

Get starting sequence number.
@return starting sequence number.
@since UME 2.0

### storeIndex

```java
public int storeIndex()
```

Get index of the store successfully registered with.
@return index of the store.
@since UME 2.0

### store

```java
public String store()
```

Get name (IP address) of the store successfully registered with.
@return Name (IP address) of the store.
@since UME 2.0

## UMEMessageAck

*class* `com.latencybusters.lbm.UMEMessageAck`

### sendExplicitAck

```java
public void sendExplicitAck(long sqn) throws LBMException
```

Send an explicit ACK up to the sequence number provided.
@throws LBMException if an error occurs or the ack has already been disposed.

### markNotOutstanding

```java
public void markNotOutstanding(long sqn) throws LBMException
```

Marks that up to the sequence number provided should no longer be considered outstanding for throttled recovery which will free up additional requests.
@throws LBMException if an error occurs or the ack has already been disposed.

### dispose

```java
public synchronized void dispose() throws LBMException
```

Delete the underlying ack structure
@throws LBMException if an error occurs while deleting the ack.

## UMERecoverySequenceNumberCallback

*interface* `com.latencybusters.lbm.UMERecoverySequenceNumberCallback`

### setRecoverySequenceNumberInfo

```java
int setRecoverySequenceNumberInfo(Object cbArg, UMERecoverySequenceNumberCallbackInfo cbInfo)
```

Callback method for getting information about recovery sequence numbers and
setting the desired low sequence number.  Call {@link UMERecoverySequenceNumberCallbackInfo#setLowSequenceNumber(long)}
in this callback before returning to set the desired low sequence number.
@param cbArg Client-supplied callback object.
@param cbInfo Information about recovery sequence numbers (low, high, etc.).
@return 0 on success, -1 on error.
@since UME 2.0

## UMERecoverySequenceNumberCallbackInfo

*class* `com.latencybusters.lbm.UMERecoverySequenceNumberCallbackInfo`

### UMERecoverySequenceNumberCallbackInfo

```java
public UMERecoverySequenceNumberCallbackInfo()
```

Default constructor; initializes all fields to 0.
@since UME 2.0

### UMERecoverySequenceNumberCallbackInfo

```java
public UMERecoverySequenceNumberCallbackInfo(int flags, long lowSeqNum, long lowRxReqMaxSeqNum, long highSeqNum, Object sourceCbArg, String source) throws LBMEInvalException
```

Constructor, initializes fields to the given values.
@param flags Informational flags.
@param lowSeqNum Low sequence number (can be changed by the application, must be >= 0).
@param lowRxReqMaxSeqNum Low retransmission request maximum sequence number (must be >= 0).
@param highSeqNum High sequence number (must be >= 0).
@param sourceCbArg Client callback object, set by {@link LBMSourceCreationCallback}.
@param source The unique source name string (e.g., "TCP:192.168.0.4:45789").
@throws LBMEInvalException if lowSeqNum, lowRxReqMaxSeqNum, or highSeqNum < 0.
@since UME 2.0
@deprecated As of UMP 6.7, Made internal with no replacement. Applications do not need this constructor.

### flags

```java
public int flags()
```

Get recovery sequence number info informational flags.
@return Informational flags.
@since UME 2.0

### lowSequenceNumber

```java
public long lowSequenceNumber()
```

Get low sequence number.
@return Low sequence number.
@since UME 2.0

### lowRxReqMaxSequenceNumber

```java
public long lowRxReqMaxSequenceNumber()
```

Get low retransmission request maximum sequence number.
@return low rxreq max sequence number.
@since UME 2.0

### highSequenceNumber

```java
public long highSequenceNumber()
```

Get high sequence number.
@return High sequence number.
@since UME 2.0

### sourceClientObject

```java
public Object sourceClientObject()
```

Get source callback object.
@return Source callback object.
@since UME 2.0

### source

```java
public String source()
```

Get source name string.
@return Source name.
@since UME 2.0

### setLowSequenceNumber

```java
public void setLowSequenceNumber(long lowSeqNum) throws LBMEInvalException
```

Set the desired starting low sequence number for recovery events.
Used in {@link UMERecoverySequenceNumberCallback} callbacks.
@param lowSeqNum Desired starting sequence number for recovery (must be >= 0).
@throws LBMEInvalException if lowSeqNum < 0.
@since UME 2.0

### sourceSessionId

```java
public long sourceSessionId()
```

Get the sources session id. Note that the session id is an unsigned
64 bit value being represented here as a signed long.
@return The sources session id
@since UMP 6.7

## UMERegistrationCompleteInfo

*class* `com.latencybusters.lbm.UMERegistrationCompleteInfo`

### UMERegistrationCompleteInfo

```java
public UMERegistrationCompleteInfo()
```

Creates a UMERegistrationCompleteInfo object and initializes fields to 0.

### UMERegistrationCompleteInfo

```java
public UMERegistrationCompleteInfo(int flags, long sequenceNumber) throws LBMEInvalException
```

Creates a UMERegistrationCompleteInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param sequenceNumber Starting sequence number (must be >= 0).
@throws LBMEInvalException if sequenceNumber < 0.
@since UME 2.0
@deprecated As of UMP 6.7, Made internal with no replacement. Applications do not need this constructor.

### UMERegistrationCompleteInfo

```java
public UMERegistrationCompleteInfo(int flags, long sequenceNumber, long sid) throws LBMEInvalException
```

Creates a UMERegistrationCompleteInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param sequenceNumber Starting sequence number (must be >= 0).
@param sid Source specified session ID.
@throws LBMEInvalException if sequenceNumber < 0.
@since UMP 6.7

### flags

```java
public int flags()
```

Get informational flags for this registration complete message.
@return Flags.
@since UME 2.0

### sequenceNumber

```java
public long sequenceNumber()
```

Get starting sequence number for this registration complete message.
@return Sequence number.
@since UME 2.0

### sourceSessionId

```java
public long sourceSessionId()
```

Get the sources session id. Note that the session id is an unsigned
64 bit value being represented here as a signed long.
@return The sources session id
@since UMP 6.7

## UMERegistrationIdExCallback

*interface* `com.latencybusters.lbm.UMERegistrationIdExCallback`

### setRegistrationId

```java
long setRegistrationId(Object cbArg, UMERegistrationIdExCallbackInfo cbInfo)
```

Callback to set a receiver registration ID, extended version. (UME only)
@param cbArg Callback object token
@param cbInfo Callback info.
@return Registration ID to be used by the receiver

## UMERegistrationIdExCallbackInfo

*class* `com.latencybusters.lbm.UMERegistrationIdExCallbackInfo`

### UMERegistrationIdExCallbackInfo

```java
public UMERegistrationIdExCallbackInfo()
```

Creates a UMERegistrationIdExCallbackInfo object and sets all fields
to 0/null.
@since UME 2.0

### UMERegistrationIdExCallbackInfo

```java
public UMERegistrationIdExCallbackInfo(String source, long sourceRegId, String store, int storeIndex, int flags, Object sourceCbArg) throws LBMEInvalException
```

Creates a UMERegistrationIdExCallbackInfo object and initializes fields to
the given values.
@param source Name (IP address) of the source.
@param sourceRegId Reg ID of the source.
@param store Name (IP address) of the store.
@param storeIndex Index of the store.
@param flags Informational flags.
@param sourceCbArg Client callback object, set by {@link LBMSourceCreationCallback}.
@throws LBMEInvalException
@since UME 2.0

### sourceRegistrationId

```java
public long sourceRegistrationId()
```

Get the source's registration ID.
@return Source registration ID.
@since UME 2.0

### storeIndex

```java
public int storeIndex()
```

Get the store's index.
@return Store index.
@since UME 2.0

### store

```java
public String store()
```

Get the store name (IP address).
@return Store name (IP address).
@since UME 2.0

### source

```java
public String source()
```

Get the source name (IP address).
@return Source name (IP address).
@since UME 2.0

### flags

```java
public int flags()
```

Get informational flags.
@return Flags.
@since UME 2.0

### sourceClientObject

```java
public Object sourceClientObject()
```

Get source client object.
@return Source client object.
@since UME 2.0

## UMERegistrationSuccessInfo

*class* `com.latencybusters.lbm.UMERegistrationSuccessInfo`

### UMERegistrationSuccessInfo

```java
public UMERegistrationSuccessInfo()
```

Creates a UMERegistrationSuccessInfo object and initializes all fields to
0/null.

### UMERegistrationSuccessInfo

```java
public UMERegistrationSuccessInfo(int flags, long sourceRegId, long receiverRegId, long sequenceNumber, int storeIndex, String store) throws LBMEInvalException
```

Creates a UMERegistrationSuccessInfo object and initializes fields to
supplied values.
@param flags Flags concerning the type of registration.
@param sourceRegId Source registration ID (must be >= 0).
@param receiverRegId Receiver registration ID (must be >= 0).
@param storeIndex Index of store registered with (must be >= 0).
@param store Name (IP address) of store registered with.
@param sequenceNumber The starting sequence number according to the store.
@throws LBMEInvalException if sourceRegId, receiverRegId, or storeIndex are < 0.
@since UME 2.0
@deprecated As of UMP 6.7, Made internal with no replacement. Applications do not need this constructor.

### flags

```java
public int flags()
```

Get registration success flags.
@return Flags.
@since UME 2.0

### sourceRegistrationId

```java
public long sourceRegistrationId()
```

Get source registration ID.
@return source registration ID.
@since UME 2.0

### receiverRegistrationId

```java
public long receiverRegistrationId()
```

Get receiver registration ID.
@return receiver registration ID.
@since UME 2.0

### sequenceNumber

```java
public long sequenceNumber()
```

Get starting sequence number.
@return starting sequence number.
@since UME 2.0

### storeIndex

```java
public int storeIndex()
```

Get index of the store successfully registered with.
@return index of the store.
@since UME 2.0

### store

```java
public String store()
```

Get name (IP address) of the store successfully registered with.
@return Name (IP address) of the store.
@since UME 2.0

### sourceSessionId

```java
public long sourceSessionId()
```

Get the sources session id if set. Note that the session id is an unsigned
64 bit value being represented here as signed.
@return The sources session id
@since UMP 6.7

## UMESourceEventAckInfo

*class* `com.latencybusters.lbm.UMESourceEventAckInfo`

### UMESourceEventAckInfo

```java
public UMESourceEventAckInfo(int flags, long sequenceNumber, long rcvRegId, int storeIndex, String store, Object clientd) throws LBMEInvalException
```

Create a UMESourceEventAckInfo object and initialize all fields.
@param flags Informational flags.
@param sequenceNumber Sequence number being acknowledged.
@param rcvRegId Registration ID of the receiver acknowledging the message, in the case of a confirmed delivery message.
@param storeIndex Index of the store acknowledging the message, for stability ACKs.
@param store Name of the store acknowledgment came from.
@param clientd Client-supplied callback object.
@throws LBMEInvalException if sequenceNumber, rcvRegId, or storeIndex are < 0.

### sequenceNumber

```java
public long sequenceNumber()
```

Get the sequence number of the message the event was received for.
@return Sequence number.
@since UME 2.0

### receiverRegistrationId

```java
public long receiverRegistrationId()
```

Get the receiver registration ID.
@return Receiver registration ID.
@since UME 2.0

### flags

```java
public int flags()
```

Get informational flags associated with the source event.
@return Flags.
@since UME 2.0

### clientObject

```java
public Object clientObject()
```

Get the client-supplied callback object.
@return Client-supplied object.
@since UME 2.0

### store

```java
public String store()
```

Get the name (IP address) of the store the event came from.
@return Store name (IP address).
@since UME 2.0

### storeIndex

```java
public int storeIndex()
```

Get the index of the store the source event came from.
@return Store index.
@since UME 2.0

## UMESourceEventDeregistrationCompleteInfo

*class* `com.latencybusters.lbm.UMESourceEventDeregistrationCompleteInfo`

### UMESourceEventDeregistrationCompleteInfo

```java
public UMESourceEventDeregistrationCompleteInfo()
```

Creates a UMESourceEventDeregistrationCompleteInfo object and initializes
all fields to 0.
@since UME 2.0

### UMESourceEventDeregistrationCompleteInfo

```java
public UMESourceEventDeregistrationCompleteInfo(int flags, long sequenceNumber) throws LBMEInvalException
```

Creates a UMESourcEventRegistrationCompleteInfo object and initializes
fields to the supplied values.
@param flags Informational flags.
@param sequenceNumber Starting sequence number (must be >= 0).
@throws LBMEInvalException if sequenceNumber < 0.
@since UME 2.0

### flags

```java
public int flags()
```

Get flags concerning this registration complete message.
@return Flags.
@since UME 2.0

### sequenceNumber

```java
public long sequenceNumber()
```

Get the starting sequence number.
@return Sequence number.

## UMESourceEventDeregistrationSuccessInfo

*class* `com.latencybusters.lbm.UMESourceEventDeregistrationSuccessInfo`

### UMESourceEventDeregistrationSuccessInfo

```java
public UMESourceEventDeregistrationSuccessInfo()
```

Creates a UMESourceEventDeregistrationSuccessInfo object
and initializes all fields to 0/null.
@since UME 2.0

### UMESourceEventDeregistrationSuccessInfo

```java
public UMESourceEventDeregistrationSuccessInfo(int flags, long registrationId, long sequenceNumber, int storeIndex, String store) throws LBMEInvalException
```

Creates a UMESourceEventDeregistrationSuccessInfo object and initializes
fields to the given values.
@param flags Informational flags concerning the type of store registration.
@param registrationId The source's registration ID with this store (must be >= 0).
@param storeIndex Index of the store (must be >= 0).
@param store Name of the store.
@param sequenceNumber The sequence number to start at, according to the store.
@throws LBMEInvalException if registrationId or storeIndex are < 0.
@since UME 2.0

### flags

```java
public int flags()
```

Returns store registration type flags.
@return Informational flags about the source's registration.
@since UME 2.0

### registrationId

```java
public long registrationId()
```

Returns the source's registration ID.
@return Source's registration ID with this store.
@since UME 2.0

### sequenceNumber

```java
public long sequenceNumber()
```

Returns source's starting sequence number.
@return Source's starting sequence number.
@since UME 2.0

### storeIndex

```java
public int storeIndex()
```

Returns the index of the store this source successfully registered to.
@return Index of the store.
@since UME 2.0

### store

```java
public String store()
```

Returns the name (IP address) of the store registered with.
@return Name of the store.
@since UME 2.0

## UMESourceEventRegistrationCompleteInfo

*class* `com.latencybusters.lbm.UMESourceEventRegistrationCompleteInfo`

### UMESourceEventRegistrationCompleteInfo

```java
public UMESourceEventRegistrationCompleteInfo()
```

Creates a UMESourceEventRegistrationCompleteInfo object and initializes
all fields to 0.
@since UME 2.0

### UMESourceEventRegistrationCompleteInfo

```java
public UMESourceEventRegistrationCompleteInfo(int flags, long sequenceNumber) throws LBMEInvalException
```

Creates a UMESourcEventRegistrationCompleteInfo object and initializes
fields to the supplied values.
@param flags Informational flags.
@param sequenceNumber Starting sequence number (must be >= 0).
@throws LBMEInvalException if sequenceNumber < 0.
@since UME 2.0

### flags

```java
public int flags()
```

Get flags concerning this registration complete message.
@return Flags.
@since UME 2.0

### sequenceNumber

```java
public long sequenceNumber()
```

Get the starting sequence number.
@return Sequence number.

## UMESourceEventRegistrationSuccessInfo

*class* `com.latencybusters.lbm.UMESourceEventRegistrationSuccessInfo`

### UMESourceEventRegistrationSuccessInfo

```java
public UMESourceEventRegistrationSuccessInfo()
```

Creates a UMESourceEventRegistrationSuccessInfo object
and initializes all fields to 0/null.
@since UME 2.0

### UMESourceEventRegistrationSuccessInfo

```java
public UMESourceEventRegistrationSuccessInfo(int flags, long registrationId, long sequenceNumber, int storeIndex, String store) throws LBMEInvalException
```

Creates a UMESourceEventRegistrationSuccessInfo object and initializes
fields to the given values.
@param flags Informational flags concerning the type of store registration.
@param registrationId The source's registration ID with this store (must be >= 0).
@param storeIndex Index of the store (must be >= 0).
@param store Name of the store.
@param sequenceNumber The sequence number to start at, according to the store.
@throws LBMEInvalException if registrationId or storeIndex are < 0.
@since UME 2.0

### flags

```java
public int flags()
```

Returns store registration type flags.
@return Informational flags about the source's registration.
@since UME 2.0

### registrationId

```java
public long registrationId()
```

Returns the source's registration ID.
@return Source's registration ID with this store.
@since UME 2.0

### sequenceNumber

```java
public long sequenceNumber()
```

Returns source's starting sequence number.
@return Source's starting sequence number.
@since UME 2.0

### storeIndex

```java
public int storeIndex()
```

Returns the index of the store this source successfully registered to.
@return Index of the store.
@since UME 2.0

### store

```java
public String store()
```

Returns the name (IP address) of the store registered with.
@return Name of the store.
@since UME 2.0

## UMEStoreEntry

*class* `com.latencybusters.lbm.UMEStoreEntry`

### UMEStoreEntry

```java
public UMEStoreEntry()
```

Creates a UMEStoreEntry object and initializes all values to 0.
@since UME 2.0

### UMEStoreEntry

```java
public UMEStoreEntry(InetSocketAddress address, int groupIndex, long registrationId) throws LBMEInvalException
```

Creates a UMEStoreEntry object and uses supplied values for initialization. The domain ID is set to 0.
@param address The address (IP and port) of the store.
@param groupIndex The group the store belongs to (must be >= 0).
@param registrationId The source's registration ID (must be >= 0).
@throws LBMEInvalException if groupIndex or registrationId are < 0.
@since UME 2.0

### UMEStoreEntry

```java
public UMEStoreEntry(InetSocketAddress address, int groupIndex, long registrationId, long domainId) throws LBMEInvalException
```

Creates a UMEStoreEntry object and uses supplied values for initialization.
@param address The address (IP and port) of the store.
@param groupIndex The group the store belongs to (must be >= 0).
@param registrationId The source's registration ID (must be >= 0).
@param domainId The store's domain ID (must be >= 0).
@throws LBMEInvalException if groupIndex, registrationId, or domainId are < 0.
@since UME 6.0

### UMEStoreEntry

```java
public UMEStoreEntry(InetSocketAddress address, int groupIndex, long registrationId, long domainId, String name) throws LBMEInvalException
```

Creates a UMEStoreEntry object and uses supplied values for initialization.
@param address The address (IP and port) of the store.
@param groupIndex The group the store belongs to (must be >= 0).
@param registrationId The source's registration ID (must be >= 0).
@param domainId The store's domain ID (must be >= 0).
@param name The name of the store if available.
@throws LBMEInvalException if groupIndex, registrationId, or domainId are < 0.
@since UME 6.7

### address

```java
public InetSocketAddress address()
```

Accessor function to get the store's address.
@return The store's address (IP and port).
@since UME 2.0

### groupIndex

```java
public int groupIndex()
```

Accessor function to get the store's group index.
@return The store's group index.
@since UME 2.0

### registrationId

```java
public long registrationId()
```

Accessor function to return the source's registration ID with this store.
@return The source's registration ID.
@since UME 2.0

### domainId

```java
public long domainId()
```

Accessor function to return the store's domain ID
@return The store's domain ID.
@since UME 6.0

### isNamed

```java
public boolean isNamed()
```

Function to determine if the store has a name.
@return True if this entry refers to a named store, false otherwise
@since UME 6.7

### name

```java
public String name()
```

Accessor function to return the store's name.
@return The store name if set, null otherwise.
@since UME 6.7

## UMEStoreGroupEntry

*class* `com.latencybusters.lbm.UMEStoreGroupEntry`

### UMEStoreGroupEntry

```java
public UMEStoreGroupEntry()
```

Creates a UMEStoreGroupEntry object and initializes index and group size to 0.
@since UME 2.0

### UMEStoreGroupEntry

```java
public UMEStoreGroupEntry(int index, int groupSize) throws LBMEInvalException
```

Creates a UMEStoreGroupEntry object and initializes the index and group size.
@param index Index of the store group (must be >= 0).
@param groupSize Size of the store group (must be >= 0).
@throws LBMEInvalException if index or groupSize < 0.
@since UME 2.0

### index

```java
public int index()
```

Returns this store group's index.
@return The UME store group index.
@since UME 2.0

### groupSize

```java
public int groupSize()
```

Returns this store group's size.
@return Group size.
@since UME 2.0

## UMQContextEventRegistrationCompleteInfo

*class* `com.latencybusters.lbm.UMQContextEventRegistrationCompleteInfo`

### UMQContextEventRegistrationCompleteInfo

```java
public UMQContextEventRegistrationCompleteInfo(int flags, long queueId, String queue, long regId) throws LBMEInvalException
```

 Creates a UMQContextEventRegistrationCompleteInfo object,
 and initializes fields to the supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param queue The name of the queue the receiver registered with.
@param regId Since UMQ uses 64-bit unsigned registration Ids,
      and Java does not support unsigned primitive types
      the registration Id must be supplied as a byte
      array in big-endian order.
@throws LBMEInvalException An invalid parameter was specified.
@since UME 3.0

### registrationId

```java
public BigInteger registrationId()
```

Get the registration Id associated with this registration complete info object.
@return Registration Id associated with this registration complete info object.
@since UME 3.0

## UMQContextEventRegistrationSuccessInfo

*class* `com.latencybusters.lbm.UMQContextEventRegistrationSuccessInfo`

### UMQContextEventRegistrationSuccessInfo

```java
public UMQContextEventRegistrationSuccessInfo(int flags, long queueId, String queue, long index, String queueInstance, long regId) throws LBMEInvalException
```

 Creates a UMQContextEventRegistrationSuccessInfo object,
 and initializes fields to the supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param queue The name of the queue the receiver registered with.
@param index The index of the instance of the queue.
@param queueInstance The instance of the queue.
@param regId Since UMQ uses 64-bit unsigned registration Ids,
      and Java does not support unsigned primitive types
      the registration Id must be supplied as a byte
      array in big-endian order.
@throws LBMEInvalException An invalid parameter was specified.
@since UME 3.0

### registrationId

```java
public BigInteger registrationId()
```

Get the registration Id associated with this registration success info object.
@return Registration Id associated with this registration success info object.
@since UME 3.0

## UMQContextQueueTopicListInfo

*class* `com.latencybusters.lbm.UMQContextQueueTopicListInfo`

### topicStatuses

```java
public List<UMQQueueTopicStatus> topicStatuses()
```

Returns a list of UMQQueueTopicStatus objects, indicating which topics are currently present within the queue.
@return A list of topic statuses.

## UMQDeregistrationCompleteInfo

*class* `com.latencybusters.lbm.UMQDeregistrationCompleteInfo`

### UMQDeregistrationCompleteInfo

```java
public UMQDeregistrationCompleteInfo(int flags, long queueId, String queue) throws LBMEInvalException
```

Creates a UMQDeregistrationCompleteInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param queue The name of the queue the receiver registered with.
@throws LBMEInvalException An invalid parameter was specified.
@since UME 3.0

## UMQIndexAssignedInfo

*class* `com.latencybusters.lbm.UMQIndexAssignedInfo`

### UMQIndexAssignedInfo

```java
public UMQIndexAssignedInfo(int flags, long queueId, String queue, UMQIndexInfo indexInfo) throws LBMEInvalException
```

Creates a UMQIndexAssignedInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param queue The name of the queue that has assigned the receiver this index.
@param indexInfo UMQ index information object.
@throws LBMEInvalException An invalid parameter was specified.
@since UMQ 2.1

## UMQIndexAssignmentEligibilityStartCompleteInfo

*class* `com.latencybusters.lbm.UMQIndexAssignmentEligibilityStartCompleteInfo`

### UMQIndexAssignmentEligibilityStartCompleteInfo

```java
public UMQIndexAssignmentEligibilityStartCompleteInfo(int flags, long queueId, String queue) throws LBMEInvalException
```

Creates a UMQIndexAssignmentEligibilityStartCompleteInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param queue The name of the queue the receiver is now eligible to receive new index assignments from.
@throws LBMEInvalException An invalid parameter was specified.
@since UMQ 2.1

## UMQIndexAssignmentEligibilityStopCompleteInfo

*class* `com.latencybusters.lbm.UMQIndexAssignmentEligibilityStopCompleteInfo`

### UMQIndexAssignmentEligibilityStopCompleteInfo

```java
public UMQIndexAssignmentEligibilityStopCompleteInfo(int flags, long queueId, String queue) throws LBMEInvalException
```

Creates a UMQIndexAssignmentEligibilityStopCompleteInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param queue The name of the queue the receiver is now no longer eligible to receive new index assignments from.
@throws LBMEInvalException An invalid parameter was specified.
@since UMQ 2.1

## UMQIndexInfo

*class* `com.latencybusters.lbm.UMQIndexInfo`

### UMQIndexInfo

```java
public UMQIndexInfo(byte[] index, int length) throws LBMEInvalException
```

Creates a UMQIndexInfo object and initializes fields to the
supplied values.
@param index Index (user-specified binary data).
@param length Length of index data.
@throws LBMEInvalException An invalid parameter was specified.
@since UMQ 1.2

### UMQIndexInfo

```java
public UMQIndexInfo(long index)
```

Creates a numeric UMQIndexInfo object and initializes fields to the
supplied values.
@param index Numeric index (64-bit number).
@throws LBMEInvalException An invalid parameter was specified.
@since UMQ 1.2

### flags

```java
public int flags()
```

Returns flags for the UMQIndexInfo object.
@return flags.
@since UMQ 1.2

### index

```java
public byte[] index() throws LBMEInvalException
```

Returns index for non-numeric UMQIndexInfo objects.
@return Index data.
@throws LBMEInvalException if the index is numeric.
@since UMQ 1.2

### numericIndex

```java
public long numericIndex() throws LBMEInvalException
```

Returns numeric index for numeric UMQIndexInfo objects.
@return Numeric index.
@throws LBMEInvalException if the index is not numeric.
@since UMQ 1.2

### indexLength

```java
public int indexLength() throws LBMEInvalException
```

Returns length of non-numeric index.
@return Index length.
@throws LBMEInvalException if called on a numeric UMQIndexInfo object.
@since UMQ 1.2

### setIndex

```java
public void setIndex(byte[] index, int length) throws LBMEInvalException
```

Sets non-numeric index to given data.
@param index Index data to set.
@param length Length of index data.
@throws LBMEInvalException if index data is null, or index length is <= 0 or > LBM.UMQ_MAX_INDEX_LEN.
@since UMQ 1.2

### setNumericIndex

```java
public void setNumericIndex(long index)
```

Sets the numeric index value of a numeric UMQIndexInfo object.
@param index The numeric index to set.
@since UMQ 1.2

## UMQIndexReleasedInfo

*class* `com.latencybusters.lbm.UMQIndexReleasedInfo`

### UMQIndexReleasedInfo

```java
public UMQIndexReleasedInfo(int flags, long queueId, String queue, UMQIndexInfo indexInfo) throws LBMEInvalException
```

Creates a UMQIndexReleasedInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param queue The name of the queue that has released the given index assignment for the receiver.
@param indexInfo UMQ index information object.
@throws LBMEInvalException An invalid parameter was specified.
@since UMQ 2.1

## UMQMessageId

*class* `com.latencybusters.lbm.UMQMessageId`

### UMQMessageId

```java
public UMQMessageId(long regId, long stamp) throws LBMEInvalException
```

Creates a UMQMessageId object and initializes fields to the
supplied values.
@param regId The 64-bit registration Id of the source context where the message originated.
@param stamp A 64-bit identifier that indicates the individual message from the given source context.
@throws LBMEInvalException An invalid parameter was specified.
@since UME 3.0

### registrationId

```java
public BigInteger registrationId()
```

Get the registration Id associated with this message id.
@return Registration Id associated with this message id.
@since UME 3.0

### msgStamp

```java
public BigInteger msgStamp()
```

Get the message stamp associated with this message id.
@return Message stamp associated with this message id.
@since UME 3.0

## UMQMessageTotalLifetimeInfo

*class* `com.latencybusters.lbm.UMQMessageTotalLifetimeInfo`

### UMQMessageTotalLifetimeInfo

```java
public UMQMessageTotalLifetimeInfo(long totalLifetime)
```

Creates a UMQMessageTotalLifetimeInfo with the specified total lifetime
@param totalLifetime Total lifetime of the message.
@since UMQ 2.2

### UMQMessageTotalLifetimeInfo

```java
public UMQMessageTotalLifetimeInfo()
```

Creates a UMQMessageTotalLifetimeInfo with the total lifetime set to 0
@since UMQ 2.2

### totalLifetime

```java
public long totalLifetime()
```

Returns the specified total lifetime
@since UMQ 2.2

### setTotalLifetime

```java
public void setTotalLifetime(long totalLifetime)
```

Sets the total lifetime
@param totalLifetime the new total lifetime
@since UMQ 2.2

## UMQQueueApplicationSet

*class* `com.latencybusters.lbm.UMQQueueApplicationSet`

### applicationSetName

```java
public String applicationSetName()
```

 Gets the name (as configured on the queue daemon) of this application set.
@return The application set name.

### receiverTypeIDs

```java
public List<UMQQueueReceiverTypeID> receiverTypeIDs()
```

 Gets a list of the receiver type IDs that belong to this application set (as configured on the queue daemon).
@return The list of IDs.

### applicationSetIndex

```java
public int applicationSetIndex()
```

 Gets this application set's application set index (as determined by the queue daemon).
@return The application set index.

## UMQQueueIndexInfo

*class* `com.latencybusters.lbm.UMQQueueIndexInfo`

### UMQQueueIndexInfo

```java
public UMQQueueIndexInfo(int flags, long queueId, String queue, UMQIndexInfo indexInfo) throws LBMEInvalException
```

Creates a UMQQueueIndexInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param queue The name of the queue the receiver has received this event from.
@param indexInfo UMQ index information object.
@throws LBMEInvalException An invalid parameter was specified.
@since UMQ 2.1

### indexInfo

```java
public UMQIndexInfo indexInfo()
```

Get UMQ index information for this info object.
@return UMQ index information associated with this info object.
@since UMQ 1.2

## UMQQueueInfo

*class* `com.latencybusters.lbm.UMQQueueInfo`

### UMQQueueInfo

```java
public UMQQueueInfo(int flags, long queueId, String queue) throws LBMEInvalException
```

Creates a UMQQueueInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param queue The name of the queue the receiver registered with.
@throws LBMEInvalException An invalid parameter was specified.
@since UME 3.0

### flags

```java
public int flags()
```

Get informational flags for this info object.
@return Flags.
@since UME 3.0

### queueId

```java
public long queueId()
```

Get Queue Id for the queue associated with this info object.
@return Queue Id for the queue associated with this info object.
@since UME 3.0

### queueName

```java
public String queueName()
```

Get Queue name for the queue associated with this info object.
@return Queue name for the queue associated with this info object.
@since UME 3.0

## UMQQueueInstanceInfo

*class* `com.latencybusters.lbm.UMQQueueInstanceInfo`

### UMQQueueInstanceInfo

```java
public UMQQueueInstanceInfo(int flags, long queueId, String queue, long index, String queueInstance) throws LBMEInvalException
```

Creates a UMQQueueInstanceInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param queue The name of the queue the receiver registered with.
@param index The index of the instance of the queue.
@param queueInstance The instance of the queue.
@throws LBMEInvalException An invalid parameter was specified.
@since UME 3.0

### queueInstanceIndex

```java
public long queueInstanceIndex()
```

Gets the index of the queue instance associated with this info object.
@return Index of the queue instance associated with this info object.
@since UME 3.0

### queueInstanceName

```java
public String queueInstanceName()
```

Gets the name of the queue instance associated with this info object.
@return Name of the queue instance associated with this info object.
@since UME 3.0

## UMQQueueMessageStatus

*class* `com.latencybusters.lbm.UMQQueueMessageStatus`

### queueMessageId

```java
public UMQMessageId queueMessageId()
```

 Gets the UMQ message ID of the message.
@return the UMQ message ID.

### message

```java
public LBMMessage message()
```

 Gets the actual message data in the form of a normal LBMMessage object, if available.
If not available, this will return null.
@return the LBMMessage object, if available; null otherwise.

### status

```java
public int status()
```

 Get the status of the message within the queue, or LBM#UMQ_QUEUE_MSG_STATUS_UNKNOWN if the status is unavailable.
@return the message status.
@see LBM#UMQ_QUEUE_MSG_STATUS_UNKNOWN
@see LBM#UMQ_QUEUE_MSG_STATUS_UNASSIGNED
@see LBM#UMQ_QUEUE_MSG_STATUS_ASSIGNED
@see LBM#UMQ_QUEUE_MSG_STATUS_REASSIGNING
@see LBM#UMQ_QUEUE_MSG_STATUS_CONSUMED

### flags

```java
public int flags()
```

 Get informational flags associated with the message in the queue; currently always returns 0.
@return the informational flags.

## UMQQueueReceiverTypeID

*class* `com.latencybusters.lbm.UMQQueueReceiverTypeID`

### id

```java
public long id()
```

 Gets the receiver type ID as a long value.
@return the receiver type ID.

## UMQQueueTopic

*class* `com.latencybusters.lbm.UMQQueueTopic`

### topicName

```java
public String topicName()
```

 Gets the topic name.
@return the topic name.

### applicationSets

```java
public List<UMQQueueApplicationSet> applicationSets()
```

 Gets a list of the application sets within this topic as configured at the UMQ queue daemon.
@return the list of application sets.

## UMQQueueTopicStatus

*class* `com.latencybusters.lbm.UMQQueueTopicStatus`

### topic

```java
public UMQQueueTopic topic()
```

 Gets the topic object (which contains the topic name, application sets, etc.).
@return the topic.

### status

```java
public int status()
```

 Gets the status of the topic.  Currently, no topic statuses are defined, so this will always return 0.
@return the topic's status.

### flags

```java
public int flags()
```

 Gets informational flags about the topic.  Currently, no flags are defined, so this will always return 0.
@return the flags.

## UMQReceiverQueueMessageListInfo

*class* `com.latencybusters.lbm.UMQReceiverQueueMessageListInfo`

### messages

```java
public List<UMQQueueMessageStatus> messages()
```

 Gets the list of message statuses for messages currently present in the queue within the receiver's application set.
@return the list of message statuses.

## UMQReceiverQueueMessageRetrieveInfo

*class* `com.latencybusters.lbm.UMQReceiverQueueMessageRetrieveInfo`

### messages

```java
public List<UMQQueueMessageStatus> messages()
```

 Gets the list of message statuses for the retrieved messages.
@return the list of message statuses.

## UMQRegistrationCompleteInfo

*class* `com.latencybusters.lbm.UMQRegistrationCompleteInfo`

### UMQRegistrationCompleteInfo

```java
public UMQRegistrationCompleteInfo(int flags, long queueId, long assignmentId, String queue) throws LBMEInvalException
```

Creates a UMQRegistrationCompleteInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param assignmentId The generated Assignment ID for the receiver with the queue.
@param queue The name of the queue the receiver registered with.
@throws LBMEInvalException An invalid parameter was specified.
@since UME 3.0

### assignmentId

```java
public long assignmentId()
```

Get generated Assignment ID for this registration complete message.
@return The generated Assignment ID for the receiver with the queue.
@since UME 3.0

## UMQSourceEventAckInfo

*class* `com.latencybusters.lbm.UMQSourceEventAckInfo`

### UMQSourceEventAckInfo

```java
public UMQSourceEventAckInfo(int flags, long queueId, String queue, long index, String queueInstance, UMQMessageId msgId, Object clientObject) throws LBMEInvalException
```

Creates a UMQSourceEventAckInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param queue The name of the queue the receiver registered with.
@param index The index of the instance of the queue.
@param queueInstance The instance of the queue.
@param msgId The registration Id of the source context where the message eing acknowledged originated.
@param clientObject The client object associated with the acknowledgment message.
@throws LBMEInvalException An invalid parameter was specified.
@since UME 3.0

### messageIdInfo

```java
public UMQMessageId messageIdInfo()
```

Get the message Id object identifying the message being acknowledged.
@return A UMQMessageId object identifying the message being acknowledged.
@since UME 3.0

### clientObject

```java
public Object clientObject()
```

Get the client-supplied callback object.
@return Client-supplied object.
@since UME 3.0

## UMQSourceEventMessageIdInfo

*class* `com.latencybusters.lbm.UMQSourceEventMessageIdInfo`

### UMQSourceEventMessageIdInfo

```java
public UMQSourceEventMessageIdInfo(int flags, UMQMessageId msgId, Object clientObject) throws LBMEInvalException
```

Creates a UMQSourceEventMessageIdInfo object and initializes fields to the
supplied values.
@throws LBMEInvalException An invalid parameter was specified.
@since UME 3.0

### flags

```java
public int flags()
```

Get informational flags for this info object.
@return Flags.
@since UME 3.0

### messageId

```java
public UMQMessageId messageId()
```

Get the message Id object identifying the message.
@return A UMQMessageId object identifying the message.
@since UME 3.0

### clientObject

```java
public Object clientObject()
```

Get the client object provided when the message was sent.
@return The object provided when sending the message associated with this message info.
@since UME 3.0

## UMQSourceEventRegistrationCompleteInfo

*class* `com.latencybusters.lbm.UMQSourceEventRegistrationCompleteInfo`

### UMQSourceEventRegistrationCompleteInfo

```java
public UMQSourceEventRegistrationCompleteInfo(int flags, long queueId, String queue) throws LBMEInvalException
```

Creates a UMQSourceEventRegistrationCompleteInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param queueId Queue Id of the queue.
@param queue The name of the queue the receiver registered with.
@throws LBMEInvalException An invalid parameter was specified.
@since UME 3.0

## UMQSourceEventULBMessageInfo

*class* `com.latencybusters.lbm.UMQSourceEventULBMessageInfo`

### UMQSourceEventULBMessageInfo

```java
public UMQSourceEventULBMessageInfo(int flags, UMQMessageId msgId, long regId, long assignId, long appSetIdx, String receiver, Object clientObject) throws LBMEInvalException
```

Creates a UMQSourceEventULBMessageInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param msgId The Message ID of the message.
@param regId The Registration ID of the receiver.
@param assignId The Assignment ID of the receiver.
@param appSetIdx The application set index the receiver is in.
@param receiver The immediate message target string for the receiver.
@param clientObject The client object associated with the acknowledgment message.
@throws LBMEInvalException An invalid parameter was specified.
@since UMQ 1.1

### messageIdInfo

```java
public UMQMessageId messageIdInfo()
```

Get the message Id object identifying the message.
@return A UMQMessageId object identifying the message.
@since UMQ 1.1

### clientObject

```java
public Object clientObject()
```

Get the client-supplied callback object.
@return Client-supplied object.
@since UMQ 1.1

## UMQSourceEventULBReceiverInfo

*class* `com.latencybusters.lbm.UMQSourceEventULBReceiverInfo`

### UMQSourceEventULBReceiverInfo

```java
public UMQSourceEventULBReceiverInfo(int flags, long regId, long assignId, long appSetIdx, String receiver) throws LBMEInvalException
```

Creates a UMQSourceEventULBReceiverInfo object and initializes fields to the
supplied values.
@param flags Informational flags.
@param regId Registration ID of the receiver.
@param assignId The Assignment ID of the receiver.
@param appSetIdx The application set index the receiver is in.
@param receiver The receivers immediate message target string.
@throws LBMEInvalException An invalid parameter was specified.
@since UMQ 1.1

### flags

```java
public int flags()
```

Get informational flags for this info object.
@return Flags.
@since UMQ 1.1

### registrationId

```java
public long registrationId()
```

Get Registration ID for the receiver associated with this info object.
@return Registration ID of the receiver associated with this info object.
@since UMQ 1.1

### assignmentId

```java
public long assignmentId()
```

Get Assignment ID for the receiver associated with this info object.
@return Assignment ID of the receiver associated with this info object.
@since UMQ 1.1

### applicationSetIndex

```java
public long applicationSetIndex()
```

Get Application Set index for the receiver associated with this info object.
@return Application Set index for the receiver associated with this info object.
@since UMQ 1.1

### receiver

```java
public String receiver()
```

Get immediate message target string for the receiver associated with this info object.
@return Immediate message target string for the receiver associated with this info object.
@since UMQ 1.1

## javaLogger

*class* `com.latencybusters.lbm.javaLogger`

### javaLogger

```java
public javaLogger(java.util.logging.Logger logger)
```

Wrap a java.util.logging.Logger object within an object that
implements the LBMLogging interface.
@param logger java.util.logging.Logger object to be encapsulated

## log4jLogger

*class* `com.latencybusters.lbm.log4jLogger`

### log4jLogger

```java
public log4jLogger(org.apache.log4j.Logger logger)
```

Wrap an Apache log4j object within an object that
implements the LBMLogging interface.
@param logger org.apache.log4j.Logger object to be encapsulated
