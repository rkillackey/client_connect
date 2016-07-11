// Store some selectors for elements we'll reuse
var callStatus = $("#call-status");
var answerButton = $(".answer-button");
var callSupportButton = $(".call-support-button");
var hangUpButton = $(".hangup-button");
var callCustomerButtons = $(".call-customer-button");
var notesTextArea = $(".call-notes-text");

/**
  Twilio Device API methods
*/

/* Get a Twilio Client token with an AJAX request */
$(document).ready(function() {
  setupDevice();
});

/* Callback when Twilio Client token is invalid/expired */
Twilio.Device.offline(function (device) {
  console.log("Device token is invalid or expired.");
  // need to figure out how to stop setupDevice function from executing more than once
  // setupDevice();
});

/* Callback to let us know Twilio Client is ready */
Twilio.Device.ready(function (device) {
  updateCallStatus("Ready");
});

/* Report any errors to the call status display */
Twilio.Device.error(function (error) {
  updateCallStatus("ERROR: " + error.messsage);
});

/* Callback to determine if "support_agent" is available or not */
// Twilio.Device.presence(function(presenceEvent) {
//   if (presenceEvent.from === 'client_connect') {
//     if (presenceEvent.available) {
//       $("#support-unavailable").hide();
//     } else {
//       $("#support-unavailable").show();
//     }
//   }
// });

/* Callback for when Twilio Client initiates a new connection */
Twilio.Device.connect(function (connection) {
  // Enable the hang up button and disable the call buttons
  hangUpButton.prop("disabled", false);
  callCustomerButtons.prop("disabled", true);
  callSupportButton.prop("disabled", true);
  answerButton.prop("disabled", true);
  notesTextArea.prop("disabled", true)

  // If phoneNumber is part of the connection, this is a call from a
  // support agent to a customer's phone
  if ("phoneNumber" in connection.message) {
    updateCallStatus("In call with " + connection.message.phoneNumber);
  } else {
    // This is a call from a website user to a support agent
    updateCallStatus("In call with LaunchPad Lab");
  }
});

/* Callback for when a call ends */
Twilio.Device.disconnect(function(connection) {
  // Disable the hangup button and enable the call buttons
  hangUpButton.prop("disabled", true);
  callCustomerButtons.prop("disabled", false);
  callSupportButton.prop("disabled", false);

  updateCallStatus("Ready");
});

/* Callback for when Twilio Client receives a new incoming call */
Twilio.Device.incoming(function(connection) {
  updateCallStatus("Incoming client call");

  console.log(connection.parameters);
  // Set a callback to be executed when the connection is accepted
  connection.accept(function() {
    updateCallStatus("In call with client");
  });

  // Set a callback on the answer button and enable it
  answerButton.click(function() {
    connection.accept();
  });
  answerButton.prop("disabled", false);
});

/**
  CC methods
*/

/* Helper function to update the call status bar */
function updateCallStatus(status) {
  callStatus.text(status);
}

/* Gets the Twilio Capability token by posting to our backend */
function setupDevice() {
  $.post("/token/generate", { page: window.location.pathname }, function(data) {
    // Set up the Twilio Client Device with the token
    Twilio.Device.setup(data.token, { debug: true });
  });
  // $.post("/call/create", )
}

/* Call a customer from a support ticket */
function callCustomer(phoneNumber) {
  updateCallStatus("Calling " + phoneNumber + "...");

  var params = { "phoneNumber": phoneNumber };
  Twilio.Device.connect(params);
}

/* Call the support_agent from the home page */
function callSupport() {
  updateCallStatus("Calling LaunchPad Lab...");

  // Our backend will assume that no params means a call to support_agent
  Twilio.Device.connect();
}

/* End a call */
function hangUp() {
  Twilio.Device.disconnectAll();
}
