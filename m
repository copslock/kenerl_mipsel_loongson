Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2003 15:31:46 +0100 (BST)
Received: from bay7-f20.bay7.hotmail.com ([IPv6:::ffff:64.4.11.20]:62731 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225379AbTIYObl>;
	Thu, 25 Sep 2003 15:31:41 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 25 Sep 2003 07:31:33 -0700
Received: from 67.89.219.146 by by7fd.bay7.hotmail.msn.com with HTTP;
	Thu, 25 Sep 2003 14:31:33 GMT
X-Originating-IP: [67.89.219.146]
X-Originating-Email: [invictus_rm@hotmail.com]
From: "invictus rm" <invictus_rm@hotmail.com>
To: guangxing@ict.ac.cn
Cc: linux-mips@linux-mips.org
Subject: Re: Re: help, question on pci communication!
Date: Thu, 25 Sep 2003 20:01:33 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F204nyQ7AjUbnd0001abab@hotmail.com>
X-OriginalArrivalTime: 25 Sep 2003 14:31:33.0475 (UTC) FILETIME=[B7CD8B30:01C38371]
Return-Path: <invictus_rm@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: invictus_rm@hotmail.com
Precedence: bulk
X-list: linux-mips

http://www.xml.com/ldd/chapter/book/ch13.html
search for ioermap in this web page

hope this helps

rm


>From: "Guangxing Zhang" <guangxing@ict.ac.cn>
>To: invictus rm <invictus_rm@hotmail.com>
>CC: linux-mips@linux-mips.org <linux-mips@linux-mips.org>, angela 
><jhyang@ict.ac.cn>, Fuxin Zhang <fxzhang@ict.ac.cn>
>Subject: Re: Re: help, question on pci communication!
>Date: Thu, 25 Sep 2003 9:41:35 +0800
>
>Hi, invictus rm
>       Thank you very much for your enthusiastic help.
>       I think it will be BIG help to me.Thank you.
>       There is some thing i want to see your advise and help again.
>       In BCM1250 we run the mips-linux which is customer compiled by us,
>and in the  MCP750 there is linux too.What i want to implement is
>transfering  data from BCM1250 to MCP750 through PCI.And using "dmesg"
>i found the following info:(In BCM1250 ,MIPS-LINUX)
>---------------------------------------------------------------------------------------------------------------------
>.............
>     Jan  1 00:00:11 (none) kernel: Determined physical RAM map:
>     Jan  1 00:00:11 (none) kernel:  memory: 003a7000 @ 00000000 (usable)
>Jan  1 00:00:11 (none) kernel:  memory: 0f711000 @ 0075c000 (usable)
>Jan  1 00:00:11 (none) kernel:  memory: 1ffffe00 @ 80000000 (usable)
>Jan  1 00:00:11 (none) kernel:  memory: 0ffffe00 @ c0000000 (usable)
>Jan  1 00:00:11 (none) kernel:  memory: 003b5000 @ 003a7000 (reserved)
>Jan  1 00:00:11 (none) kernel: 2815MB HIGHMEM available.
>Jan  1 00:00:11 (none) kernel: Initial ramdisk at: 0x803a7000 (3887104 
>bytes)
>Jan  1 00:00:11 (none) kernel: On node 0 totalpages: 851967
>Jan  1 00:00:11 (none) kernel: zone(0): 131072 pages.
>Jan  1 00:00:11 (none) kernel: zone(1): 0 pages.
>Jan  1 00:00:11 (none) kernel: zone(2): 720895 pages.
>@ Jan  1 00:00:11 (none) kernel: Kernel command line: root=/dev/ram0 rw 
>bigphysarea=8192 pcisharesize=16
>@ Jan  1 00:00:11 (none) kernel: pcisharemem allocated @ 85800000
>...................
>---------------------------------------------------------------------------------------------------------------------
>     In the above lines tagged with @ i notice that there is 
>"bigphysarea=8192 pcisharesize=16",
>I have read "kernel/include/linux/mm/bigphysarea.h" ,and known that 
>bigphysarea can be used
>to reserve some amount of physical memory at boot-time for PCI 
>communication.A friend told me
>using it is simple ,but he did not tell me kow :-)~(Of course i think he 
>knows it from others).
>And i think in my kernel module i can implement it.Without any knowledge on 
>it ,I am swamped now.
>Can you give me some info on how to do that ,such as how to use the 
>"bigphysarea"?How the MCP750
>see the "bigphysarea" in BCM1250 and access it (read it)?
>     I think i am so avaricious , but i really thirst for the help and 
>advice.
>     Thank you again and in advance again.:-)~
>
>
>======= invictus_rm@hotmail.com 2003-09-24 23:15:00 WROTE��=======
>
> >hi,
> >
> >  If the BCM1250 is operating in the device mode in the peripheral slot 
>of
> >the CPCI chassis, u need t get the enumeration of the PCI being done from
> >MCP 750 right.
> >  The code for MCP750 alread exists in the linux kernel ( if i remember
> >correctly).
> >
> >U can proceed in the following directions-->
> >(a) Get the PCI enumeration working properly on the MCP750 ( look at the
> >ouput of lspci -vvv to decide whether resource allocation is proper or 
>not)
> >.. The powerpc provides a fairly comprehensive PCI enumeration code(
> >including scanning beyond the bridge).
> >
> >(b) Once u are able to see ur device in the lspci output on the MCP board 
>,
> >u can load the driver ( ur custom driver ) to do the transfer from the
> >BCM1250 to MCP and vice versa.
> >
> >(v) Look at the few PCI based drivers about the way the data transfers is
> >handled specially pci_alloc_* / pci_map_*/pci_resource_*.........
> >
> >Hope this helps
> >
> >
> >
> >
> >>From: "Guangxing Zhang" <guangxing@ict.ac.cn>
> >>To: Fuxin Zhang <fxzhang@ict.ac.cn>
> >>CC: linux-mips@linux-mips.org <linux-mips@linux-mips.org>, angela
> >><jhyang@ict.ac.cn>
> >>Subject: help, question on pci communication!
> >>Date: Wed, 24 Sep 2003 16:29:32 +0800
> >>
> >>Hi, Fuxin and everyone see this mail,
> >>     In linux world ,newbies always like to ask and the veterans will
> >>always be enthusiastic.:)~~
> >>     Now there is a "ask", of course i am a newbie.
> >>     Follow is the  architecture  which we are working on.
> >>     Now i want to transfer the data from the "sb1250" to mcp750 through
> >>the PCI bus with the help of 21555 bridge.
> >>I want to implement it in kernel module.Although knowing "use the force
> >>,read source",but i really do not know
> >>how and where to begin.
> >>     Is there any advice on it ? How to implement the communication 
>through
> >>PCI (or PCI-to-PCI bridge) in kernel
> >>moudle?
> >>     Any help will be appreciated!Thank in advance!
> >>
> >>                       -------------
> >>                   |  MCP 750  |  (Power PC)
> >>                       -------------
> >>                             |
> >>　     -------------------------------------------CPCI
> >>                          |
> >>              ---------------|--------------------------------
> >>              |      --------|-----                         |
> >>              |      |Intel 21555 |(PCI-TO-PCI Bridge)      |
> >>              |      --------------                         |
> >>              |        |                        |
> >>              |      --------(PCI bus)        |
> >>    |          |                                  |
> >>    |       --------                              |
> >>    |   |SB1250|(CPU)                         |
> >>    |       --------                              |
> >>              ----------------------------------------------
> >>　　　　　　　　Guangxing Zhang
> >>　　　　　　　　guangxing@ict.ac.cn
> >>       2003-09-24 16:03:04
> >>　　　　　　　　　　
> >>
> >>
> >>
> >>
> >
> >_________________________________________________________________
> >Talk to Karthikeyan. Watch his stunning feats.
> >http://server1.msn.co.in/sp03/tataracing/index.asp Download images.
>
>= = = = = = = = = = = = = = = = = = = =
>
>
>
>　　　　　　　　Guangxing Zhang
>　　　　　　　　guangxing@ict.ac.cn
>　　　　　　　　2003-09-25 08:43:44
>
>
>

_________________________________________________________________
MSN Hotmail now on your Mobile phone. 
http://server1.msn.co.in/sp03/mobilesms/ Click here.
