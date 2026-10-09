function client = connectRL(connIn)

fprintf('Attempting to connect to Rocket League on %s:%d...\n', connIn.host, connIn.port);

while true
    try
        client = tcpclient(connIn.host, connIn.port, 'Timeout', connIn.timeout_seconds);
        fprintf('Connected! Start a match or free play to stream data.\n\n');
        break;
    catch CONN_ERR
    end
end
end