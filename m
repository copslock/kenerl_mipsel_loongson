Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2005 15:10:21 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.177]:57555
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225403AbVDHOKF>; Fri, 8 Apr 2005 15:10:05 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKxQS-1DJuBO1uU0-0001bP; Fri, 08 Apr 2005 16:10:02 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: CompactFlash on PCMCIA problems
Date:	Fri, 8 Apr 2005 16:10:30 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504081610.32088.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Hi!

I'm trying to code the glue to connect the vanilla ATA drivers with a CF card 
connected to an Au1100. I managed to access the CIS parts of the card but 
then the problems start: the area where I'd expect to find the ATA 
controller's registers mirrors every byte twice, just as if the address used 
was first shifted by one.

Here's a sketch of what I'm doing:

1. Setup SYS_PINFUNC so the PCMCIA interface is used
2. Setup GPIO and GPIO2, they are used for e.g. card detection and power
3. apply power to card via GPIO
4. reset card via GPIO, waiting for it to finish
5. ioremap all three PCMCIA_*_PHYS_ADDR ranges[1]
6. parse CIS in ioremapped PCMCIA_ATTR_PHYS_ADDR
7. setup CISREG_CCSR with 0x00, in particular to reset CCSR_POWER_DOWN
8. setup CISREG_COR with 0x01, configuration #1 is the contiguous memory[1] 
configuration parsed from the CIS

At this moment, I think I should be able to talk to the ATA controller via the 
first few bytes of the ioremapped PCMCIA_IO_PHYS_ADDR, but that area has this 
weird mirrored byte behaviour which I don't understand.


Another thing I don't fully understand yet is the meaning of the three memory 
areas. These are called 'IO', 'attrib' and 'mem'. The 'attrib' area contains 
the CIS and presents no problem. The 'IO' area is where I'd expect to find 
the ATA controller's registers. Now, what I don't understand is the meaning 
of the 'mem' area (PCMCIA_MEM_PHYS_ADDR). The documents I found on the web 
always referred to a 'common memory' area, but funnily they also only 
distinguished between two areas!?

Yet another thing I'm missing is the meaning of CISREG_IOBASE_* and 
CISREG_IOSIZE. When exactly and how do I have to setup those?

I'm pretty lost, I have tried everything I could think of without any success. 
I'll also send this to the PCMCIA mailinglist at sourceforge's, in case it is 
not related to MIPS but rather to PCMCIA.

greetings

Uli

[1] is a particular size required? Also, I used ioremap_nocache(), does that 
matter or should I use plain ioremap()?
[2] yes, it might be more interesting to use one of the non-contiguous modes, 
but that still doesn't solve my problems.
