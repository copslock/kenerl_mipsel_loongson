Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2004 08:32:25 +0100 (BST)
Received: from bay15-f40.bay15.hotmail.com ([IPv6:::ffff:65.54.185.40]:6672
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8224989AbUIPHcU>; Thu, 16 Sep 2004 08:32:20 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Wed, 15 Sep 2004 22:59:38 -0700
Received: from 82.200.0.252 by by15fd.bay15.hotmail.msn.com with HTTP;
	Thu, 16 Sep 2004 05:55:11 GMT
X-Originating-IP: [82.200.0.252]
X-Originating-Email: [alexshinkin@hotmail.com]
X-Sender: alexshinkin@hotmail.com
From: "Alexey Shinkin" <alexshinkin@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Au1550 -  Problem access Shared memory from PCI card 
Date: Thu, 16 Sep 2004 12:55:11 +0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY15-F40hAOylhgnFZ0009083e@hotmail.com>
X-OriginalArrivalTime: 16 Sep 2004 05:59:38.0256 (UTC) FILETIME=[5993D100:01C49BB2]
Return-Path: <alexshinkin@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexshinkin@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi All !

Could anybody help me with the following problem:

I have AMD Au1550 MIPS board, running MontaVista Linux 2.4.20-mvl31.1550.
I have also a PCI card , Linux driver for the card and some user-level 
application.
All work fine on x86 platform.

After I recompiled the driver and the application for MIPS platform I got 
the following:
1. The driver on the MIPS board (host) finds the PCI card (target)
2. I download an executable code into target and start target application 
(application starts, debug info is written to target memory).
3. Target starts to communicate with host using shared memory,allocated on 
host, (target accesses the memory through PCI).

After that I get the following problem:

4. Target writes some values into Host's shared memory and generates 
interrupt on Host.
5. Host catches the interrupt and in interrupt handler reads the values, 
written by target.
6. Host writes some replay to the shared memory, generates PCI interrupt on 
Target.
7. Target gets interrupt but can not see the latest values, written by Host. 
Reading the shared memory several times doesn' t help.

Looks like target reads values that are cached somewhere . I tried to insert 
au_sync(), au_sync_delay(), flush_cache_all() on Host side after writting 
values - nothing helps.

On x86 this approach works fine.

What could be the reason? Could this be hardware problem or can be fixed by 
fine-tuning of caching parameters or PCI controller ?

Thank you in advance!

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE* 
http://join.msn.com/?page=features/junkmail
