Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2003 03:41:03 +0100 (BST)
Received: from Iris.Adtech-Inc.COM ([IPv6:::ffff:63.165.80.18]:6684 "EHLO
	iris.Adtech-Inc.COM") by linux-mips.org with ESMTP
	id <S8225377AbTH3ClB> convert rfc822-to-8bit; Sat, 30 Aug 2003 03:41:01 +0100
content-class: urn:content-classes:message
Subject: RE: Using more than 256 MB of memory on SB1250 in 32-bit mode
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Fri, 29 Aug 2003 16:40:58 -1000
Message-ID: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB73D@iris.adtech-inc.com>
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Using more than 256 MB of memory on SB1250 in 32-bit mode
Thread-Index: AcNueSiTz/62aUoOQay7j1spfQAwsQAJaNnA
From: "Finney, Steve" <Steve.Finney@SpirentCom.COM>
To: "Steve Madsen" <madsen@tadpole.com>, <linux-mips@linux-mips.org>
Return-Path: <Steve.Finney@SpirentCom.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steve.Finney@SpirentCom.COM
Precedence: bulk
X-list: linux-mips

Not sure what you mean by "system memory". You can turn on CONFIG_HIGHMEM and get access to 512 MB physical memory  or more on the BCM with a 32-bit kernel, but you can't access memory above the low 256 MB  directly through KSEG0/1, so there are some things that the kernel can't use it for (though it can be allocated to user processes). Also, since CONFIG_DISCONTIGMEM isn't supported, you end up wasting a bunch of RAM on useless page table space (36MB for 512 MB physical), and there's also some caching weirdness if you try and mmap() /dev/mem to get user access to the >0x10000000 I/O registers. Also, your startup will report "1792 MB HIGHMEM available".

sf

> -----Original Message-----
> From: Steve Madsen [mailto:madsen@tadpole.com]
> Sent: Friday, August 29, 2003 12:00 PM
> To: linux-mips@linux-mips.org
> Subject: Using more than 256 MB of memory on SB1250 in 32-bit mode
> 
> 
> Is it possible to use more than 256 MB of system memory with 
> the Broadcom 
> SB1250 in 32-bit mode?  The memory map I'm looking at shows 
> me that the 
> second 256 MB of memory is at physical address 0x80000000.  I 
> suspect that 
> due to the 2G/2G split in the kernel, I can't use memory this 
> high without 
> moving to the 64-bit kernel.
> 
> Would someone confirm this for me?
> 
> -- 
> Steve Madsen <madsen@tadpole.com>
> Tadpole Computer, Inc.  http://www.tadpole.com
> 
> 
