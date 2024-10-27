# krs_idcard

*Framework:*
- Esx

*Dependencies:*
- ox_lib
- ox_inventory
- screenshot-basic

* Items ox_inventory

```lua
['idcard'] = {
		label = 'Documento',
		consume = 0,
		stack = false,
		close = true,
		weight = 1,
		client = {
			export = 'krs_idcard.idcard'
		}
	},


	['firearm_card'] = {
		label = 'Weapon License',
		consume = 0,
		stack = false,
		close = true,
		weight = 1,
		client = {
			export = 'krs_idcard.firearm_card'
		}
	},

	
	['drive_license'] = {
		label = 'Drive License',
		consume = 0,
		stack = false,
        close = true,
		weight = 1,
		client = {
			export = 'krs_idcard.drive_license'
		}
	},
```

![Screenshot 2024-10-26 215716](https://github.com/user-attachments/assets/d714d6cc-e780-4a39-9c04-c41a08d86be6)
![Screenshot 2024-10-26 215709](https://github.com/user-attachments/assets/87d6a36a-4c9b-40c9-a2fb-c05650439a4f)
![Screenshot 2024-10-26 215752](https://github.com/user-attachments/assets/92391470-4c19-4a4a-9423-aa38134ca81c)
