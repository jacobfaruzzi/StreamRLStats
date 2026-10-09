function client = connectRL(connIn)

fprintf('Attempting to connect to Rocket League on %s:%d...\n', connIn.host, connIn.port);

try
    client = tcpclient(connIn.host, connIn.port, 'Timeout', connIn.timeout_seconds);
    fprintf('Connected! Start a match or free play to stream data.\n\n');
catch CONN_ERR
    error('Could not connect to Rocket League. Ensure the game is running and TAStatsAPI.ini is configured.');
end

end