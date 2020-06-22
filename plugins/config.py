from pritunl import logger

def user_config(host_id, host_name, org_id, user_id, user_name, server_id,
        server_name, server_port, server_protocol, server_ipv6,
        server_ipv6_firewall, server_network, server_network6,
        server_network_mode, server_network_start, server_network_stop,
        server_restrict_routes, server_bind_address, server_onc_hostname,
        server_dh_param_bits, server_multi_device, server_dns_servers,
        server_search_domain, server_otp_auth, server_cipher, server_hash,
        server_inter_client, server_ping_interval, server_ping_timeout,
        server_link_ping_interval, server_link_ping_timeout,
        server_allowed_devices, server_max_clients, server_replica_count,
        server_dns_mapping, server_debug, **kwargs):
    return '''
#viscosity dns full
'''
