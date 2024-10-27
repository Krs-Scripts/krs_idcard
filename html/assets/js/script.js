$(document).ready(function() {
    window.addEventListener('message', function(event) {
        const action = event.data.action; 
        if (action === 'open') {
            OpenAction(event.data); 
        } else if (action === 'close') {
            CloseAction(); 
        }
    });

    function OpenAction(data) {
        const type = data.type || 'Unknown'; 
        const firstName = data.firstName || 'Unknown';
        const lastName = data.lastName || 'Unknown';
        const dateOfBirth = data.dateOfBirth || 'Unknown';
        const sex = data.sex || 'Unknown'; 
        const height = data.height || 'Unknown';
        const screenshot = data.screenshot;

        // console.log(JSON.stringify(`url(./assets/images/${data.type}.png)`))
        $('#container_idcard').css('background-image', `url(./assets/images/${data.type}.png)`);
        $('#container_idcard').show();
        $('#photo').show(screenshot).attr('src', screenshot || ''); 
        $('#name').text(`${firstName} ${lastName}`);
        $('#dob').text(dateOfBirth);
        $('#height').text(`${height}cm`);
        $('#signature').text(`${firstName} ${lastName}`);
        $('#sex').text(sex); 
    }

    function CloseAction() {
        console.log('Handling close action');
        $('#name, #dob, #height, #signature, #sex').text('');
        $('#licenses').empty();
        $('#photo').hide();
        $('#container_idcard').hide();
    }
});



