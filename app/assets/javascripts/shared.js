$(document).ready(function() {
    $("#new_student").validate({
        rules: {
            "student[user_attributes][email]": {
                required: true,
            },
            "student[user_attributes][password]": {
                required: true,
                minlength: 8
            },
            "student[first_name]": {
                required: true
            },
            "student[last_name]": {
                required: true
            },

        },
    });
    $("#new_tutor").validate({
        rules: {
            "tutor[user_attributes][email]": {
                required: true,
            },
            "tutor[user_attributes][password]": {
                required: true,
                minlength: 8
            },
            "tutor[first_name]": {
                required: true
            },
            "tutor[last_name]": {
                required: true
            },
        },
    });
    $("#tutor_profile_form").validate({
        rules: {
            "tutor[description]": {
                required: true,
                maxlength: 500

            },
            "tutor[about_me]": {
                required: true,
                maxlength: 500
            },
            "tutor[duration]": {
                required: true,
                number: true,
                max: 100,
                min: 1
            },
            "tutor[skills]": {
                required: true,
                maxlength: 250
            },
            "tutor[teaching_philosophy]": {
                required: true,
                maxlength: 250
            },
            "tutor[credentials_and_affiliations]": {
                required: true,
                maxlength: 200
            },
            "tutor[age_group]": {
                required: true,
                maxlength: 50
            },
            "tutor[instruments]": {
                required: true,
                maxlength: 50
            },
            "tutor[experience]": {
                required: true,
                maxlength: 50
            },
            "tutor[image]": {
                accept: "image/*"
            },
            "tutor[address]":{
                required: true
            }
        },
    });
    $("#student_profile_form").validate({
        rules: {
            "student[address]": {
                required: true,
                maxlength: 50
            },
            "student[image]": {
                accept: "image/*"
            },
        },
    });


    $("#lesson_form").validate({
        rules: {
            "lesson[name]": {
                required: true,
                maxlength: 50
            },
            "lesson[description]": {
                required: true,
                maxlength: 500
            },
            "lesson[neighbourhood]": {
                required: true,
                maxlength: 100
            },
            "lesson[address]": {
                required: true,
                maxlength: 100
            },
            "lesson[phone_no]": {
                required: true
                // phoneUS: true

            },
            "lesson[price]": {
                required: true,
                number: true,
                max: 100,
                min: 1
            },
            "lesson[duration]": {
                required: true,
                number: true,
                max: 100,
                min: 1
            },
            // "lesson[publish]": {
            //     required: true
            // },
            "lesson[maximum_people]": {
                required: true
            },
        },
    });


    $("#sign_in_form").validate({
        rules: {
            "user_email": {
                required: true,
            },
            "user_password": {
                required: true
            },
        },
    });

    $("#new_user").validate({
        rules: {
            "user[email]": {
                required: true,
            },
            "user[password]": {
                required: true
            },
        },
    });

    $("#edit_user").validate({
        rules: {
            "user[current_password]": {
                required: true
            },
            "user[password]": {
                required: true,
                minlength: 8
            },
            "user[password_confirmation]": {
                required: true,
                equalTo: "#user_password",
                minlength: 8
            },
        },
    })

});