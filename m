Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 18:45:32 +0100 (BST)
Received: from bay7-f117.bay7.hotmail.com ([IPv6:::ffff:64.4.11.117]:25872
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225567AbTIXRp2>; Wed, 24 Sep 2003 18:45:28 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Wed, 24 Sep 2003 10:45:19 -0700
Received: from 203.195.196.66 by by7fd.bay7.hotmail.msn.com with HTTP;
	Wed, 24 Sep 2003 17:45:18 GMT
X-Originating-IP: [203.195.196.66]
X-Originating-Email: [invictus_rm@hotmail.com]
From: "invictus rm" <invictus_rm@hotmail.com>
To: guangxing@ict.ac.cn
Cc: linux-mips@linux-mips.org
Subject: Re: help, question on pci communication!
Date: Wed, 24 Sep 2003 23:15:18 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F117FH0ulWwcRI00008269@hotmail.com>
X-OriginalArrivalTime: 24 Sep 2003 17:45:19.0197 (UTC) FILETIME=[9EDC30D0:01C382C3]
Return-Path: <invictus_rm@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: invictus_rm@hotmail.com
Precedence: bulk
X-list: linux-mips

hi,

  If the BCM1250 is operating in the device mode in the peripheral slot of 
the CPCI chassis, u need t get the enumeration of the PCI being done from 
MCP 750 right.
  The code for MCP750 alread exists in the linux kernel ( if i remember 
correctly).

U can proceed in the following directions-->
(a) Get the PCI enumeration working properly on the MCP750 ( look at the 
ouput of lspci -vvv to decide whether resource allocation is proper or not) 
. The powerpc provides a fairly comprehensive PCI enumeration code( 
including scanning beyond the bridge).

(b) Once u are able to see ur device in the lspci output on the MCP board , 
u can load the driver ( ur custom driver ) to do the transfer from the 
BCM1250 to MCP and vice versa.

(v) Look at the few PCI based drivers about the way the data transfers is 
handled specially pci_alloc_* / pci_map_*/pci_resource_*.........

Hope this helps




>From: "Guangxing Zhang" <guangxing@ict.ac.cn>
>To: Fuxin Zhang <fxzhang@ict.ac.cn>
>CC: linux-mips@linux-mips.org <linux-mips@linux-mips.org>, angela 
><jhyang@ict.ac.cn>
>Subject: help, question on pci communication!
>Date: Wed, 24 Sep 2003 16:29:32 +0800
>
>Hi, Fuxin and everyone see this mail,
>     In linux world ,newbies always like to ask and the veterans will 
>always be enthusiastic.:)~~
>     Now there is a "ask", of course i am a newbie.
>     Follow is the  architecture  which we are working on.
>     Now i want to transfer the data from the "sb1250" to mcp750 through 
>the PCI bus with the help of 21555 bridge.
>I want to implement it in kernel module.Although knowing "use the force 
>,read source",but i really do not know
>how and where to begin.
>     Is there any advice on it ? How to implement the communication through 
>PCI (or PCI-to-PCI bridge) in kernel
>moudle?
>     Any help will be appreciated!Thank in advance!
>
>                       -------------
>	                  |  MCP 750  |  (Power PC)
>                       -------------
>                             |
>　	    -------------------------------------------CPCI
>                          |
>              ---------------|--------------------------------
>              |      --------|-----                         |
>              |      |Intel 21555 |(PCI-TO-PCI Bridge)      |
>              |      --------------                         |
>              |        |                					   |
>              |      --------(PCI bus)					   |
>			 |          |                                  |
>			 |       --------                              |
>			 |		 |SB1250|(CPU)                         |
>			 |       --------                              |
>              ----------------------------------------------
>　　　　　　　　Guangxing Zhang
>　　　　　　　　guangxing@ict.ac.cn
>			    2003-09-24 16:03:04
>　　　　　　　　　　
>
>
>
>

_________________________________________________________________
Talk to Karthikeyan. Watch his stunning feats. 
http://server1.msn.co.in/sp03/tataracing/index.asp Download images.
