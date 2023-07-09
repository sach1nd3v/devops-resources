Any changes to configuration file will make the older inftstructure to destroy and new to be created with changes.
This is called immutable infrstructure.
For example created a file using `local` provider then chnage the `file_permission` then apply the plan. It will delete older file then crated new file with given apermissions.