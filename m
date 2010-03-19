Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2010 18:52:53 +0100 (CET)
Received: from apfelkorn.psychaos.be ([195.144.77.38]:55974 "EHLO
        apfelkorn.psychaos.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492061Ab0CSRwt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Mar 2010 18:52:49 +0100
Received: from p2 by apfelkorn.psychaos.be with local (Exim 4.69)
        (envelope-from <p2@psychaos.be>)
        id 1NsgNJ-0007Af-52; Fri, 19 Mar 2010 19:52:45 +0200
Date:   Fri, 19 Mar 2010 19:52:45 +0200
From:   Peter 'p2' De Schrijver <p2@debian.org>
To:     Jan Rovins <janr@adax.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: linux 2.6.33 on movidis x16
Message-ID: <20100319175244.GH2437@apfelkorn>
References: <20100305141113.GD2437@apfelkorn> <4B9EB45D.8050106@adax.com> <20100318181734.GG2437@apfelkorn> <4BA27048.2010707@caviumnetworks.com> <4BA277FB.6080808@adax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BA277FB.6080808@adax.com>
X-Unexpected-Header: The spanish inquisition !
X-mate: Mate, mann gewohnt sich an alles
X-Paddo: Munch, Munch
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <p2@psychaos.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips

Hi,

> You are right, it is called an x16.  My memory is failing me, I should  
> have looked at the machine first.
>

Ok :)

> from dmesg:
>
> cavium-ethernet: Cavium Networks Octeon SDK version 1.8.1, build 294
> Interface 0 has 4 ports (RGMII)
> Interface 1 has 4 ports (RGMII)
> Interface 2 has 4 ports (NPI)
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>
>
> looks like the PHYAD field has what you are loohing for,
> ethtool output: ---------------------------
>
> for i in 0 1 2 3 4 5 6 7; do ethtool eth$i; done
> Settings for eth0:
>        Supported ports: [ TP MII ]
>        Supported link modes:   10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>                                1000baseT/Half 1000baseT/Full
>        Supports auto-negotiation: Yes
>        Advertised link modes:  10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>                                1000baseT/Half 1000baseT/Full
>        Advertised auto-negotiation: Yes
>        Speed: 10Mb/s
>        Duplex: Half
>        Port: MII
>        PHYAD: 1
>        Transceiver: internal
>        Auto-negotiation: on
>        Link detected: no
> Settings for eth1:
>        Supported ports: [ TP MII ]
>        Supported link modes:   10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>                                1000baseT/Half 1000baseT/Full
>        Supports auto-negotiation: Yes
>        Advertised link modes:  10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>                                1000baseT/Half 1000baseT/Full
>        Advertised auto-negotiation: Yes
>        Speed: 10Mb/s
>        Duplex: Half
>        Port: MII
>        PHYAD: 2
>        Transceiver: internal
>        Auto-negotiation: on
>        Link detected: no
> Settings for eth2:
>        Supported ports: [ TP MII ]
>        Supported link modes:   10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>                                1000baseT/Half 1000baseT/Full
>        Supports auto-negotiation: Yes
>        Advertised link modes:  10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>                                1000baseT/Half 1000baseT/Full
>        Advertised auto-negotiation: Yes
>        Speed: 10Mb/s
>        Duplex: Half
>        Port: MII
>        PHYAD: 3
>        Transceiver: internal
>        Auto-negotiation: on
>        Link detected: no
> Settings for eth3:
>        Supported ports: [ TP MII ]
>        Supported link modes:   10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>                                1000baseT/Half 1000baseT/Full
>        Supports auto-negotiation: Yes
>        Advertised link modes:  10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>                                1000baseT/Half 1000baseT/Full
>        Advertised auto-negotiation: Yes
>        Speed: 10Mb/s
>        Duplex: Half
>        Port: MII
>        PHYAD: 4
>        Transceiver: internal
>        Auto-negotiation: on
>        Link detected: no
> Settings for eth4:
>        Supported ports: [ TP MII ]
>        Supported link modes:   10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>        Supports auto-negotiation: Yes
>        Advertised link modes:  10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>        Advertised auto-negotiation: Yes
>        Speed: 100Mb/s
>        Duplex: Full
>        Port: MII
>        PHYAD: 0
>        Transceiver: internal
>        Auto-negotiation: on
>        Link detected: yes
> Settings for eth5:
>        Supported ports: [ TP MII ]
>        Supported link modes:   10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>        Supports auto-negotiation: Yes
>        Advertised link modes:  10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>        Advertised auto-negotiation: Yes
>        Speed: 100Mb/s
>        Duplex: Full
>        Port: MII
>        PHYAD: 0
>        Transceiver: internal
>        Auto-negotiation: on
>        Link detected: yes
> Settings for eth6:
>        Supported ports: [ TP MII ]
>        Supported link modes:   10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>        Supports auto-negotiation: Yes
>        Advertised link modes:  10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>        Advertised auto-negotiation: Yes
>        Speed: 100Mb/s
>        Duplex: Full
>        Port: MII
>        PHYAD: 0
>        Transceiver: internal
>        Auto-negotiation: on
>        Link detected: yes
> Settings for eth7:
>        Supported ports: [ TP MII ]
>        Supported link modes:   10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>        Supports auto-negotiation: Yes
>        Advertised link modes:  10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>        Advertised auto-negotiation: Yes
>        Speed: 100Mb/s
>        Duplex: Full
>        Port: MII
>        PHYAD: 0
>        Transceiver: internal
>        Auto-negotiation: on
>        Link detected: yes
>

PHYAD 0 for ports 4 - 7 seems a bit strange to me. Do you have the sources of the
kernel you're running on those machines ? If so, could you look at 
int cvmx_helper_board_get_mii_address(int ipd_port) in cvmx-helper-board.c ?
It contains a large switch statement. case CVMX_BOARD_TYPE_CUST_WSX16: is what I'm
interested in.


> ----------------------------------------------------------
> You may want to re-map the interfaces so that they show up in a sane  
> order, there is a cluster of 8 ethernet ports, 4 per row.  Right now on  
> our boxes , eth0 shows up on the bottom row, second  from the right.

Thanks,

Peter.
