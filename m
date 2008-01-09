Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jan 2008 18:58:11 +0000 (GMT)
Received: from host.infinivid.com ([64.119.179.76]:31635 "EHLO
	host.infinivid.com") by ftp.linux-mips.org with ESMTP
	id S28576191AbYAIS6C (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Jan 2008 18:58:02 +0000
Received: (qmail 8182 invoked from network); 9 Jan 2008 18:57:59 -0000
Received: from 75-144-238-166-atlanta.hfc.comcastbusiness.net (HELO ?10.41.13.3?) (75.144.238.166)
  by host.infinivid.com with (RC4-MD5 encrypted) SMTP; 9 Jan 2008 11:57:57 -0700
Subject: Linux mips and DMA
From:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Wed, 09 Jan 2008 13:57:17 -0500
Message-Id: <1199905038.3572.8.camel@microwave.infinitevideocorporation.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jon.dufresne@infinitevideocorporation.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.dufresne@infinitevideocorporation.com
Precedence: bulk
X-list: linux-mips

Hello,

I am in the process of porting a known working linux driver for a pci
device from an x86 machine to a mips machine. This is my first time
developing a driver under mips (but not the first time with x86) so I am
learning some of the differences and gotchas that exist when porting a
driver like this.

My most recent problem exists when setting up dma between the host and
the device. I am using the following two websites as guides for doing
this:

https://lwn.net/Articles/28230/
https://lwn.net/Articles/28092/

In addition I am using LDD.

To create the dma memory area I am using the function
"pci_alloc_consistent". When I pass the "dma_handle" (as I understand it
the host's physical address of the dma memory), to the pci device, the
device in the x86 box correctly access this memory, not so in the mips
box.

Not sure if this is helpful, but the fuction returns the following
addresses on the mips when I use it:

dma_handle=0x026f0000 size=0x00010000 cpu_addr=0xa26f0000

Does this physical address seem abnormally low? It is well outside the
range of the PCI BARs which exist around 0x20000000.

Anything I should know about using pci_alloc_consistent on a mips?

If you need more information to understand the situation I'd be happy to
supply it but right now I'm not sure what to supply.

Thanks,
Jon
