Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2005 15:51:33 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.183]:29159
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225851AbVDMOvS>; Wed, 13 Apr 2005 15:51:18 +0100
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DLjCD-0003gx-00
	for linux-mips@linux-mips.org; Wed, 13 Apr 2005 16:50:25 +0200
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DLjCC-0004Nt-00
	for linux-mips@linux-mips.org; Wed, 13 Apr 2005 16:50:24 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: CompactFlash on PCMCIA problems
Date:	Wed, 13 Apr 2005 16:51:04 +0200
User-Agent: KMail/1.7.2
References: <200504081610.32088.eckhardt@satorlaser.com>
In-Reply-To: <200504081610.32088.eckhardt@satorlaser.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504131651.05113.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:
> I'm trying to code the glue to connect the vanilla ATA drivers with a CF
> card connected to an Au1100. I managed to access the CIS parts of the card
> but then the problems start: the area where I'd expect to find the ATA
> controller's registers mirrors every byte twice, just as if the address
> used was first shifted by one.
>
> Here's a sketch of what I'm doing:
>
> 1. Setup SYS_PINFUNC so the PCMCIA interface is used

Well, at least I tried to...

[...]
> At this moment, I think I should be able to talk to the ATA controller via
> the first few bytes of the ioremapped PCMCIA_IO_PHYS_ADDR, but that area
> has this weird mirrored byte behaviour which I don't understand.

Setting the PC flag in SYS_PINFUNC in fact DISables the PCMCIA driver, leaving 
PREG, PCE1, PCE2 and PWE as GPIO pins. These seem unused for 16 bit accesses 
to the attribute memory but required for the 8 bit accesses to the ATA 
controller's registers, causing the funny behaviour.

"Principle of maximum surprise."

oh, well....

Uli
