Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2010 19:59:27 +0100 (CET)
Received: from mail1.adax.com ([208.201.231.104]:22267 "EHLO mail1.adax.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492435Ab0CRS7X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Mar 2010 19:59:23 +0100
Received: from static-151-204-189-187.pskn.east.verizon.net (static-151-204-189-187.pskn.east.verizon.net [151.204.189.187])
        by mail1.adax.com (Postfix) with ESMTP id 93CE5120AB9;
        Thu, 18 Mar 2010 11:59:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id 9E825400589;
        Thu, 18 Mar 2010 14:59:13 -0400 (EDT)
X-Virus-Scanned: amavisd-new at pskn.east.verizon.net
Received: from static-151-204-189-187.pskn.east.verizon.net ([127.0.0.1])
        by localhost (static-151-204-189-187.pskn.east.verizon.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SNDwZvZ66lil; Thu, 18 Mar 2010 14:58:52 -0400 (EDT)
Received: from [192.168.1.76] (jr001327.mtl-nj.adax [192.168.1.76])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id D95F1400588;
        Thu, 18 Mar 2010 14:58:51 -0400 (EDT)
Message-ID: <4BA277FB.6080808@adax.com>
Date:   Thu, 18 Mar 2010 14:59:07 -0400
From:   Jan Rovins <janr@adax.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Peter 'p2' De Schrijver <p2@debian.org>, linux-mips@linux-mips.org
Subject: Re: linux 2.6.33 on movidis x16
References: <20100305141113.GD2437@apfelkorn> <4B9EB45D.8050106@adax.com> <20100318181734.GG2437@apfelkorn> <4BA27048.2010707@caviumnetworks.com>
In-Reply-To: <4BA27048.2010707@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <janr@adax.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: janr@adax.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> On 03/18/2010 11:17 AM, Peter 'p2' De Schrijver wrote:
>> On 2010-03-15 18:27:41 (-0400), Jan Rovins<janr@adax.com>  wrote:
>>> Peter 'p2' De Schrijver wrote:
>>>> Hi,
>>>>
>>>> We are trying to get linux 2.6.33 to work on the movidis x16 board. 
>>>> Main thing
>>>> missing is the addresses of the PHYs. Does anyone know those ?
>>>> Unfortunately I don't have physical access to the board so I can't 
>>>> just look
>>>> for the PHY components being used.
>>>>
>>>> Thanks,
>>>>
>>>> Peter.
>>>>
>>>>
>>> Do you mean the Movidis x19 ?
>>
>> Maybe. AFAIK ours is called x16, and uses a cavium octeon CN3860 chip.
>>
>>> We have 2 of these in our lab. They are running the old 2.6.21.7  from
>>> the CnUsers 1.8.1  tool chain.
>>> They are currently being used by other developers for some application
>>> testing, but I can grab the serial console boot-up messages and send
>>> them to you, if the PHY info is in there.
>>
>> That would be helpful. Otherwise you could also try running ethtool 
>> on all the
>> interfaces. That should give you the PHY address as well.
>>
>
> I just found one of these.  Current theory is that the PHY addresses 
> are 0-7
>
> I don't think the PHY numbers are printed anywhere.
>
> David Daney
You are right, it is called an x16.  My memory is failing me, I should 
have looked at the machine first.

from dmesg:

cavium-ethernet: Cavium Networks Octeon SDK version 1.8.1, build 294
Interface 0 has 4 ports (RGMII)
Interface 1 has 4 ports (RGMII)
Interface 2 has 4 ports (NPI)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2


looks like the PHYAD field has what you are loohing for,
ethtool output: ---------------------------

for i in 0 1 2 3 4 5 6 7; do ethtool eth$i; done
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 10Mb/s
        Duplex: Half
        Port: MII
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: on
        Link detected: no
Settings for eth1:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 10Mb/s
        Duplex: Half
        Port: MII
        PHYAD: 2
        Transceiver: internal
        Auto-negotiation: on
        Link detected: no
Settings for eth2:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 10Mb/s
        Duplex: Half
        Port: MII
        PHYAD: 3
        Transceiver: internal
        Auto-negotiation: on
        Link detected: no
Settings for eth3:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 10Mb/s
        Duplex: Half
        Port: MII
        PHYAD: 4
        Transceiver: internal
        Auto-negotiation: on
        Link detected: no
Settings for eth4:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Link detected: yes
Settings for eth5:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Link detected: yes
Settings for eth6:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Link detected: yes
Settings for eth7:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Link detected: yes

----------------------------------------------------------
You may want to re-map the interfaces so that they show up in a sane 
order, there is a cluster of 8 ethernet ports, 4 per row.  Right now on 
our boxes , eth0 shows up on the bottom row, second  from the right.

Jan
