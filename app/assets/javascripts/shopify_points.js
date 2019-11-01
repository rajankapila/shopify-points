$(document).ready(() => {
  const $form = $('#points_earned_per_dollar_form');
  const $pointsPerDollarInput = $('#points_per_dollar');

  // Force a number as an input
  $pointsPerDollarInput.on('keyup.points', () => {
    const val = parseInt($pointsPerDollarInput.val());
    $pointsPerDollarInput.val(isNaN(val) ? 0 : val);
  });

  // Submit form event for updating points per dollar spent
  $form.submit(e => {
    // Prevent form from submitting
    e.preventDefault();

    // Initialize variables
    const pointsPerDollar = parseInt($pointsPerDollarInput.val());
    const data = { points_per_dollar: pointsPerDollar };
    const url = '/update_points_per_dollar';
    const token = $('meta[name="csrf-token"]').attr('content');
    const successMessage = 'Points per dollar spent update successfully';
    const errorMessage =
      'Points must be a number 0 or greater and less than 1000.';
    const successMessageClass = 'alert-success';
    const errorMessageClass = 'alert-danger';

    const minPointsPerDollarValue = 0;
    const maxPointsPerDollarValue = 1000;

    // Check if input is number
    if (
      !Number.isInteger(pointsPerDollar) ||
      minPointsPerDollarValue < 0 ||
      pointsPerDollar > maxPointsPerDollarValue
    ) {
      showMessage(errorMessage, errorMessageClass);
      return;
    }

    // Send ajax request to update points spent per dollar value
    $.ajax({
      type: 'post',
      url: url,
      data: data,
      headers: {
        'X-CSRF-Token': token
      }
    })
      .done(response => {
        if (response.success) {
          showMessage(successMessage, successMessageClass);
        } else {
          showMessage(errorMessage, errorMessageClass);
        }
      })
      .fail(() => {
        showMessage(errorMessage, errorMessageClass);
      });
  });
});

/**
 * Show a message based on response from server
 * @message text message
 * @type alert-success or alert-danger
 */
showMessage = (message, type) => {
  const $alertContainer = $('.alert-container');
  const $message = $('<div>');
  $message.attr('id', 'message');
  $message.addClass(`alert ${type}`);
  const $dismiss = $('<a/>');
  $dismiss.addClass('close');
  $dismiss.attr('data-dismiss', 'alert');
  $dismiss.text('x');
  const $messageText = $('<span/>');
  $messageText.text(message);
  $message.append($dismiss).append($messageText);

  // Empy alert container and then append new message
  $alertContainer.empty().append($message);

  // Fade out message after 5 seconds
  setTimeout(() => {
    $message.remove();
  }, 5000);
};
