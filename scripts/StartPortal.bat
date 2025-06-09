@echo off

REM Check if docker-compose-override file exists
if not exist "../docker-compose-override.yml" (
    echo docker-compose-override.yml not found, using default configuration.
    docker compose -f ../docker-compose.yml up -d --pull=never
) else (
    echo docker-compose-override.yml found, using custom configuration.
    docker compose -f ../docker-compose.yml -f ../docker-compose-override.yml up -d --pull=never
)

REM Wait for Docker to start
timeout /t 10 /nobreak > NUL

powershell -ExecutionPolicy -ByPass "$profile = [Windows.Networking.Connectivity.NetworkInformation,Windows.Networking.Connectivity,ContentType=WindowsRuntime]::GetConnectionProfiles() | where {$_.profilename -eq 'loopback'}; $tether = [Windows.Networking.NetworkOperators.NetworkOperatorTetheringManager,Windows.Networking.NetworkOperators,ContentType=WindowsRuntime]::CreateFromConnectionProfile($profile); $tether.StartTetheringAsync()"

exit