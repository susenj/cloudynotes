**Why 53?**

DNS uses TCP port number 53, that's why

You can use Amazon Route53 to

1. **Register** new domains,  - Domain registraion
2. **transfer** existing domains - DNS management
3. **route traffic** for your domains to your AWS and external resources, - Traffic management
4. **monitor the health** of your resources. - Availability monitoring


500 Hosted zones - Soft limit
10k record sets

Hosted zone will get created automatically if you buy your domain from AWS Route53. If you bought the same from elsewhere and you wish to delegate it to the Route53, you have to create the hosted zone manually.

Then update your domain registrar with the correct name servers for your Route53 hosted zone.
You need to update the name servers appropriately into your other domain provider's settings.
You can transfer a domain to Route53, if the TLD is included in the list.
If the TLD is not incuded, you can't transfer the domain to Route53
For most of the TLDs, you need to get an authorization code from the current registrar to transfer the domain.

When you create a hosted zone, Route53 automatically creates an NS and an SOA record for the zone.

![image](https://user-images.githubusercontent.com/291550/168254213-ff42b477-bf83-4475-b299-08cc0d9a0223.png)
![image](https://user-images.githubusercontent.com/291550/168254235-4a7073b8-edaf-409b-81e4-2e9af669b755.png)

The NS record identified the four name servers that you give to your registrar or your DNS service so that the DNS queries are routed to the Route53 name servers.

By default, Route53 assigns a unique swt of 4 name servers(known collectively as a delegation set) to each hosted zone that you create

Example: 

- ns-1337 awsdns-39 .com
- ns-655 awsdns-66 .net
- ns-909 awsdns-87 .org
- ns-4112 awsdns-07 .co.in


