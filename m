Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2003 22:59:41 +0100 (BST)
Received: from web11901.mail.yahoo.com ([IPv6:::ffff:216.136.172.185]:61229
	"HELO web11901.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225209AbTEWV7i>; Fri, 23 May 2003 22:59:38 +0100
Message-ID: <20030523215935.71373.qmail@web11901.mail.yahoo.com>
Received: from [209.243.184.182] by web11901.mail.yahoo.com via HTTP; Fri, 23 May 2003 14:59:35 PDT
Date: Fri, 23 May 2003 14:59:35 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: pci_alloc_consistent usage
To: Linux-MIPS <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wgowcher@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wgowcher@yahoo.com
Precedence: bulk
X-list: linux-mips

I am working on a driver that uses PCI DMA transfers
from system memory to the PCI device. On the 2.4.18
kernel it worked OK, but now when it is recompiled for
2.4.20 it doesn't. Digging into things I have found
that the function virt_to_phys() has been changed from
:
return PHYSADDR(address)

to
return (unsigned long)address - PAGE_OFFSET

Where PAGE_OFFSET is 0x8000 0000, and where PHYSADDR
would AND the address against 0x1FFF FFFF. As far as I
can tell the problem comes from pci_alloc_consistent
doing :

ret = UNCAC_ADDR(ret) 

which converts a 0x8xxx address to 0xAxxx, and then
when you pass this 0xAxxx_xxxx address through
virt_to_phys() you get an address of the form
0x2xxx_xxxx. This 0x2xxx_xxxx is passed to the dma
controller as the physical address to where it must
read / write data, and because it is 0x2xxx_xxxx and
not 0x0xxx_xxxx an exception occurs.

At first I just tried AND'ing out the 0xA.. like
PHYSADDR used to do it, but with that change i no
longer get the exception, but the driver does not dma
the data across - it just sits there.

I read DMA-mapping.txt and it says virt_to_phys() will
be phased out, and should be used, but doesn't
elaborate any further (like how you should do it now
).

So after that long intro, my question is :

Anybody know where I'm going wrong and how to fix
things ?

Also any tips on what drivers to look at for good
examples would also be appreciated.

TIA


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
