Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 22:22:26 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:50933 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225425AbTIRVWY>;
	Thu, 18 Sep 2003 22:22:24 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA12994;
	Thu, 18 Sep 2003 14:22:18 -0700
Message-ID: <3F6A21FD.9040508@mvista.com>
Date: Thu, 18 Sep 2003 14:22:05 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bruno Randolf <bruno.randolf@4g-systems.biz>
CC: linux-mips@linux-mips.org
Subject: Re: 2.4.22 pci on au1500
References: <200309181645.00676.bruno.randolf@4g-systems.biz>
In-Reply-To: <200309181645.00676.bruno.randolf@4g-systems.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Hi Bruno,

>i just tried 2.4.22 on my au1500 (mtx-1) board and it seems like pci is 
>broken. is there anything that has changed for the board initialization, 
>which i might have missed?
>
Yes, I changed 2.4.22 because we were calling ioremap inside the 
pci_config routine, and this is a problem for drivers that call pci 
config routines from interrupt context -- like the ide driver. I tested 
the new approach on the db1500...

>it woked fine with 2.4.21, there i got:
>
>Autoconfig PCI channel 0x802eaf28
>Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x44000000
>00:00.0 Class 0280: 1260:3873 (rev 01)
>        Mem at 0x40000000 [size=0x1000]
>
>with 2.4.22 and debugging output enabled, i get:
>
>Autoconfig PCI channel 0x802f0e88
>Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x50000000
>config_access: 0 bus 0 device 0 at 0 *data 18000057, conf 0
>config_access: 0 bus 0 device 1 at 0 *data 18000057, conf 0
>config_access: 0 bus 0 device 2 at 0 *data 180000d7, conf 0
>config_access: 0 bus 0 device 3 at 0 *data 18000157, conf 0
>config_access: 0 bus 0 device 4 at 0 *data 18000257, conf 0
>config_access: 0 bus 0 device 5 at 0 *data 18000457, conf 0
>config_access: 0 bus 0 device 6 at 0 *data 18000857, conf 0
>config_access: 0 bus 0 device 7 at 0 *data 18001057, conf 0
>config_access: 0 bus 0 device 8 at 0 *data 18002057, conf 0
>config_access: 0 bus 0 device 9 at 0 *data 18004057, conf 0
>config_access: 0 bus 0 device 10 at 0 *data 18008057, conf 0
>config_access: 0 bus 0 device 11 at 0 *data 18010057, conf 0
>config_access: 0 bus 0 device 12 at 0 *data 18020057, conf 0
>config_access: 0 bus 0 device 13 at 0 *data 18040057, conf 0
>config_access: 0 bus 0 device 14 at 0 *data 18080057, conf 0
>config_access: 0 bus 0 device 15 at 0 *data 18100057, conf 0
>config_access: 0 bus 0 device 16 at 0 *data 18200057, conf 0
>config_access: 0 bus 0 device 17 at 0 *data 18400057, conf 0
>config_access: 0 bus 0 device 18 at 0 *data 18800057, conf 0
>config_access: 0 bus 0 device 0 at e *data 18000057, conf c
>config_access: 0 bus 0 device 1 at e *data 18000057, conf c
>config_access: 0 bus 0 device 2 at e *data 180000d7, conf c
>config_access: 0 bus 0 device 3 at e *data 18000157, conf c
>config_access: 0 bus 0 device 4 at e *data 18000257, conf c
>config_access: 0 bus 0 device 5 at e *data 18000457, conf c
>config_access: 0 bus 0 device 6 at e *data 18000857, conf c
>config_access: 0 bus 0 device 7 at e *data 18001057, conf c
>config_access: 0 bus 0 device 8 at e *data 18002057, conf c
>config_access: 0 bus 0 device 9 at e *data 18004057, conf c
>config_access: 0 bus 0 device 10 at e *data 18008057, conf c
>config_access: 0 bus 0 device 11 at e *data 18010057, conf c
>config_access: 0 bus 0 device 12 at e *data 18020057, conf c
>config_access: 0 bus 0 device 13 at e *data 18040057, conf c
>config_access: 0 bus 0 device 14 at e *data 18080057, conf c
>config_access: 0 bus 0 device 15 at e *data 18100057, conf c
>config_access: 0 bus 0 device 16 at e *data 18200057, conf c
>config_access: 0 bus 0 device 17 at e *data 18400057, conf c
>config_access: 0 bus 0 device 18 at e *data 18800057, conf c
>config_access: 0 bus 0 device 19 at e *data 19000057, conf c
>
>thanks for your help - again :)
>  
>
Let me test it one more time on the db1500 to make sure something didn't 
get broken after I pushed the patch. I'll get back to you in a couple of 
days since I just got back from a long trip.

Pete
