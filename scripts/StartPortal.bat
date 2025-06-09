@echo off

docker compose -f ../docker-compose.yml -f ../docker-compose-override.yml up -d --pull=never

timeout /t 10 /nobreak > NUL

powershell -ExecutionPolicy -ByPass "$profile = [Windows.Networking.Connectivity.NetworkInformation,Windows.Networking.Connectivity,ContentType=WindowsRuntime]::GetConnectionProfiles() | where {$_.profilename -eq 'loopback'}; $tether = [Windows.Networking.NetworkOperators.NetworkOperatorTetheringManager,Windows.Networking.NetworkOperators,ContentType=WindowsRuntime]::CreateFromConnectionProfile($profile); $tether.StartTetheringAsync()"

exit