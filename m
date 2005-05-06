Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 18:33:40 +0100 (BST)
Received: from mother.pmc-sierra.com ([IPv6:::ffff:216.241.224.12]:23800 "HELO
	mother.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8226009AbVEFRdY>; Fri, 6 May 2005 18:33:24 +0100
Received: (qmail 23887 invoked by uid 101); 6 May 2005 17:33:13 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by mother.pmc-sierra.com with SMTP; 6 May 2005 17:33:13 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id j46HXCOi015884;
	Fri, 6 May 2005 10:33:12 -0700
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JGC9C17D>; Fri, 6 May 2005 10:33:12 -0700
Message-ID: <9DFF23E1E33391449FDC324526D1F259024380CB@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
To:	"'Ulrich Eckhardt'" <eckhardt@satorlaser.com>,
	linux-mips@linux-mips.org
Subject: RE: CF custom implementation
Date:	Fri, 6 May 2005 10:32:40 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Kiran_Thota@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kiran_Thota@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Ulrich,
 The ide-patch i took is from ftp://ftp.buici.com/pub/arm/patch-linux-2.6.11/
Is that good enough?

Alan was referring to PIO mode in that thread but this implementation doesnt 
have IO mode and also no IDE support. It only has memory mode and I will 
have to support it as memory. How do I do that?

Another question: If I rework the board so that the wires coming to MEMR and MEMW
are rewired to IOR and IOW respectively, does it work in TrueIDE mode? Just a thought!


Thanks,
Kiran

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Ulrich Eckhardt
Sent: Friday, May 06, 2005 12:14 AM
To: linux-mips@linux-mips.org
Subject: Re: CF custom implementation


Kiran Thota wrote:
> I am working on a MIPS-based processor SoC which has a custom CF
> implementation over Local Bus. The CF doesnt support IO mode, interrupts, 
> 32-bit support.
> It has limited register support [no interface registers to reset the CF]. I
> am using 2.6.10 from linux-mips. I have already written a PCMCIA/CF socket
> socket for the same.
> The goal is to use the CF cards as memoy devices. Advise me on the path to
> take:
>
> PCMCIA/CF ->CS/DS -> IDE [I found a patch to make IDE work in polled mode]

Could you tell me where you found that patch?

> I am currently using Lexar and Hitachi Compact Flash cards.

CF is a standard, so this shouldn't matter.

> The CIS can be read and when the Linux boots up and I invoke cardmgr
> [v3.2.8], it sees the device as ATA/IDE Fixed Disk [Func = 4 (Fixed Disk) ]
> Is there a way to force it to come up in memory only mode? Please suggest.

I'm using a CF card attached to the PCMCIA interface of an Alchemy Au1100. 
Since my board only has a CF slot, I'm not using the whole PCMCIA stack at 
all - CONFIG_PCMCIA=no and no cardmgr. All I do is detect the card, parse the 
CIS and register the CF card with the IDE/ATA system of the kernel, just like 
Alan Cox suggested in the recent thread "ATA devices attached to arbitary 
busses". One good reason for me doing so is that I need to mount the root 
filesystem from the CF but the PCMCIA stack requires user-space helpers.

Uli
