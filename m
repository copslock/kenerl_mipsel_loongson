Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2010 21:27:49 +0100 (CET)
Received: from mail1.adax.com ([208.201.231.104]:8954 "EHLO mail1.adax.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492562Ab0CSU1q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Mar 2010 21:27:46 +0100
Received: from static-151-204-189-187.pskn.east.verizon.net (static-151-204-189-187.pskn.east.verizon.net [151.204.189.187])
        by mail1.adax.com (Postfix) with ESMTP id 1C97F1209A9;
        Fri, 19 Mar 2010 13:27:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id 35FA3400571;
        Fri, 19 Mar 2010 16:27:41 -0400 (EDT)
X-Virus-Scanned: amavisd-new at pskn.east.verizon.net
Received: from static-151-204-189-187.pskn.east.verizon.net ([127.0.0.1])
        by localhost (static-151-204-189-187.pskn.east.verizon.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oV-iuyrlJkkD; Fri, 19 Mar 2010 16:27:09 -0400 (EDT)
Received: from [192.168.1.76] (jr001327.mtl-nj.adax [192.168.1.76])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id 35DD4400589;
        Fri, 19 Mar 2010 16:27:09 -0400 (EDT)
Message-ID: <4BA3DE2D.1070801@adax.com>
Date:   Fri, 19 Mar 2010 16:27:25 -0400
From:   Jan Rovins <janr@adax.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Peter 'p2' De Schrijver <p2@debian.org>
CC:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: linux 2.6.33 on movidis x16
References: <20100305141113.GD2437@apfelkorn> <4B9EB45D.8050106@adax.com> <20100318181734.GG2437@apfelkorn> <4BA27048.2010707@caviumnetworks.com> <4BA277FB.6080808@adax.com> <20100319175244.GH2437@apfelkorn>
In-Reply-To: <20100319175244.GH2437@apfelkorn>
Content-Type: multipart/mixed;
 boundary="------------010407080309010906040908"
Return-Path: <janr@adax.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: janr@adax.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010407080309010906040908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter 'p2' De Schrijver wrote:
> Hi,
>
>   
>> You are right, it is called an x16.  My memory is failing me, I should  
>> have looked at the machine first.
>>
>>     
>
> Ok :)
>
>   
>> from dmesg:
>>
>> cavium-ethernet: Cavium Networks Octeon SDK version 1.8.1, build 294
>> Interface 0 has 4 ports (RGMII)
>> Interface 1 has 4 ports (RGMII)
>> Interface 2 has 4 ports (NPI)
>> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>>
>>
>> looks like the PHYAD field has what you are loohing for,
>> ethtool output: ---------------------------
>>
>> for i in 0 1 2 3 4 5 6 7; do ethtool eth$i; done
>> Settings for eth0:
>>        Supported ports: [ TP MII ]
>>        Supported link modes:   10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>                                1000baseT/Half 1000baseT/Full
>>        Supports auto-negotiation: Yes
>>        Advertised link modes:  10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>                                1000baseT/Half 1000baseT/Full
>>        Advertised auto-negotiation: Yes
>>        Speed: 10Mb/s
>>        Duplex: Half
>>        Port: MII
>>        PHYAD: 1
>>        Transceiver: internal
>>        Auto-negotiation: on
>>        Link detected: no
>> Settings for eth1:
>>        Supported ports: [ TP MII ]
>>        Supported link modes:   10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>                                1000baseT/Half 1000baseT/Full
>>        Supports auto-negotiation: Yes
>>        Advertised link modes:  10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>                                1000baseT/Half 1000baseT/Full
>>        Advertised auto-negotiation: Yes
>>        Speed: 10Mb/s
>>        Duplex: Half
>>        Port: MII
>>        PHYAD: 2
>>        Transceiver: internal
>>        Auto-negotiation: on
>>        Link detected: no
>> Settings for eth2:
>>        Supported ports: [ TP MII ]
>>        Supported link modes:   10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>                                1000baseT/Half 1000baseT/Full
>>        Supports auto-negotiation: Yes
>>        Advertised link modes:  10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>                                1000baseT/Half 1000baseT/Full
>>        Advertised auto-negotiation: Yes
>>        Speed: 10Mb/s
>>        Duplex: Half
>>        Port: MII
>>        PHYAD: 3
>>        Transceiver: internal
>>        Auto-negotiation: on
>>        Link detected: no
>> Settings for eth3:
>>        Supported ports: [ TP MII ]
>>        Supported link modes:   10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>                                1000baseT/Half 1000baseT/Full
>>        Supports auto-negotiation: Yes
>>        Advertised link modes:  10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>                                1000baseT/Half 1000baseT/Full
>>        Advertised auto-negotiation: Yes
>>        Speed: 10Mb/s
>>        Duplex: Half
>>        Port: MII
>>        PHYAD: 4
>>        Transceiver: internal
>>        Auto-negotiation: on
>>        Link detected: no
>> Settings for eth4:
>>        Supported ports: [ TP MII ]
>>        Supported link modes:   10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>        Supports auto-negotiation: Yes
>>        Advertised link modes:  10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>        Advertised auto-negotiation: Yes
>>        Speed: 100Mb/s
>>        Duplex: Full
>>        Port: MII
>>        PHYAD: 0
>>        Transceiver: internal
>>        Auto-negotiation: on
>>        Link detected: yes
>> Settings for eth5:
>>        Supported ports: [ TP MII ]
>>        Supported link modes:   10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>        Supports auto-negotiation: Yes
>>        Advertised link modes:  10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>        Advertised auto-negotiation: Yes
>>        Speed: 100Mb/s
>>        Duplex: Full
>>        Port: MII
>>        PHYAD: 0
>>        Transceiver: internal
>>        Auto-negotiation: on
>>        Link detected: yes
>> Settings for eth6:
>>        Supported ports: [ TP MII ]
>>        Supported link modes:   10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>        Supports auto-negotiation: Yes
>>        Advertised link modes:  10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>        Advertised auto-negotiation: Yes
>>        Speed: 100Mb/s
>>        Duplex: Full
>>        Port: MII
>>        PHYAD: 0
>>        Transceiver: internal
>>        Auto-negotiation: on
>>        Link detected: yes
>> Settings for eth7:
>>        Supported ports: [ TP MII ]
>>        Supported link modes:   10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>        Supports auto-negotiation: Yes
>>        Advertised link modes:  10baseT/Half 10baseT/Full
>>                                100baseT/Half 100baseT/Full
>>        Advertised auto-negotiation: Yes
>>        Speed: 100Mb/s
>>        Duplex: Full
>>        Port: MII
>>        PHYAD: 0
>>        Transceiver: internal
>>        Auto-negotiation: on
>>        Link detected: yes
>>
>>     
>
> PHYAD 0 for ports 4 - 7 seems a bit strange to me. Do you have the sources of the
> kernel you're running on those machines ? If so, could you look at 
> int cvmx_helper_board_get_mii_address(int ipd_port) in cvmx-helper-board.c ?
> It contains a large switch statement. case CVMX_BOARD_TYPE_CUST_WSX16: is what I'm
> interested in.
>
>   
I have attached the source of  cvmx_helper_board_get_mii_address().

In looking at it, it is all coming back to me now.  I had to modify that 
function to get the Ethernet to work. The Movidis folk had a working 
kernel based on the  CaviumNetworks 1.6.X or 1.7.X toolchain.  I ported 
it up to the 1.8.1 toolchain, and had to add the 
CVMX_BOARD_TYPE_CUST_WSX16 entry to get the ethernet working, so the 
strangeness is my fault, but it got the first 4 Ehernets working. I 
thought I patterned it after what they did in their earlier kernels, but 
perhaps I never saw the Movidis mods, and just did it by trial & error. 
(it was a few years ago).  If I have a chance I will dig around to see 
if I can find the source to the origonal 1.6.1 Movidis kernel that they 
provided. 
>   
>> ----------------------------------------------------------
>> You may want to re-map the interfaces so that they show up in a sane  
>> order, there is a cluster of 8 ethernet ports, 4 per row.  Right now on  
>> our boxes , eth0 shows up on the bottom row, second  from the right.
>>     
>
> Thanks,
>
> Peter.
>   


--------------010407080309010906040908
Content-Type: text/plain;
 name="cvmx_helper_board_get_mii_address.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cvmx_helper_board_get_mii_address.txt"


/**
 * Return the MII PHY address associated with the given IPD
 * port. A result of -1 means there isn't a MII capable PHY
 * connected to this port. On chips supporting multiple MII
 * busses the bus number is encoded in bits <15:8>.
 *
 * This function must be modified for every new Octeon board.
 * Internally it uses switch statements based on the cvmx_sysinfo
 * data to determine board types and revisions. It replies on the
 * fact that every Octeon board receives a unique board type
 * enumeration from the bootloader.
 *
 * @param ipd_port Octeon IPD port to get the MII address for.
 *
 * @return MII PHY address and bus number or -1.
 */
int cvmx_helper_board_get_mii_address(int ipd_port)
{
    switch (cvmx_sysinfo_get()->board_type)
    {
        case CVMX_BOARD_TYPE_SIM:
            /* Simulator doesn't have MII */
            return -1;
        case CVMX_BOARD_TYPE_EBT3000:
        case CVMX_BOARD_TYPE_EBT5800:
        case CVMX_BOARD_TYPE_THUNDER:
        case CVMX_BOARD_TYPE_NICPRO2:
            /* Interface 0 is SPI4, interface 1 is RGMII */
            if ((ipd_port >= 16) && (ipd_port < 20))
                return ipd_port - 16;
            else
                return -1;
        case CVMX_BOARD_TYPE_KODAMA:
        case CVMX_BOARD_TYPE_EBH3100:
        case CVMX_BOARD_TYPE_HIKARI:
        case CVMX_BOARD_TYPE_CN3010_EVB_HS5:
        case CVMX_BOARD_TYPE_CN3005_EVB_HS5:
        case CVMX_BOARD_TYPE_CN3020_EVB_HS5:
            /* Port 0 is WAN connected to a PHY, Port 1 is GMII connected to a
                switch */
            if (ipd_port == 0)
                return 4;
            else if (ipd_port == 1)
                return 9;
            else
                return -1;
        case CVMX_BOARD_TYPE_NAC38:
            /* Board has 8 RGMII ports PHYs are 0-7 */
            if ((ipd_port >= 0) && (ipd_port < 4))
                return ipd_port;
            else if ((ipd_port >= 16) && (ipd_port < 20))
                return ipd_port - 16 + 4;
            else
                return -1;
        case CVMX_BOARD_TYPE_EBH3000:
            /* Board has dual SPI4 and no PHYs */
            return -1;
        case CVMX_BOARD_TYPE_EBH5200:
        case CVMX_BOARD_TYPE_EBH5201:
        case CVMX_BOARD_TYPE_EBT5200:
            /* Board has 4 SGMII ports. The PHYs start right after the MII
                ports MII0 = 0, MII1 = 1, SGMII = 2-5 */
            if ((ipd_port >= 0) && (ipd_port < 4))
                return ipd_port+2;
            else
                return -1;
        case CVMX_BOARD_TYPE_EBH5600:
        case CVMX_BOARD_TYPE_EBH5601:
        case CVMX_BOARD_TYPE_KBP: /* JLR first Movidis X16 */
	case CVMX_BOARD_TYPE_CUST_WSX16: /* JLR second Movidis X16 */
            /* Board has 8 SGMII ports. 4 connect out, two connect to a switch,
                and 2 loop to each other */
            if ((ipd_port >= 0) && (ipd_port < 4))
                return ipd_port+1;
            else
                return -1;
        case CVMX_BOARD_TYPE_CUST_NB5:
            if (ipd_port == 2)
                return 4;
            else
                return -1;
        case CVMX_BOARD_TYPE_NIC_XLE_4G:
            /* Board has 4 SGMII ports. connected QLM3(interface 1) */
            if ((ipd_port >= 16) && (ipd_port < 20))
                return ipd_port - 16 + 1;
            else
                return -1;
        case CVMX_BOARD_TYPE_BBGW_REF:
            return -1;  /* No PHYs are connected to Octeon, everything is through switch */
    }

    /* Some unknown board. Somebody forgot to update this function... */
    cvmx_dprintf("cvmx_helper_board_get_mii_address: Unknown board type %d\n",
                 cvmx_sysinfo_get()->board_type);
    return -1;
}



--------------010407080309010906040908--
