RegisterServerEvent('radar:checkVehicle')
AddEventHandler('radar:checkVehicle', function(plate, model)
	local _source = source
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, 
	function (result)
		if result[1] ~= nil then
			MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
				['@identifier'] = result[1].owner
			}, 
			function (result2)
				TriggerClientEvent('esx:showNotification', _source, '~y~Tablice: ~w~' .. plate .. '\n~y~Właściciel: ~w~' .. result2[1].firstname .. ' ' .. result2[1].lastname .. '\n~y~Model: ~w~' .. model)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, '~w~Pojazd o numerze rejestracyjnym ~r~' .. plate ..' ~w~jest ~r~niezarejestrowany!' )
		end
	end)
end)