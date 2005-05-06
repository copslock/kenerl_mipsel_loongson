Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 08:12:46 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.187]:9962 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225262AbVEFHMb>; Fri, 6 May 2005 08:12:31 +0100
Received: from [213.39.254.68] (helo=tuxator.satorlaser-intern.com)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKxQS-1DTx0f0aim-00038l; Fri, 06 May 2005 09:12:29 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: CF custom implementation
Date:	Fri, 6 May 2005 09:13:50 +0200
User-Agent: KMail/1.7.2
References: <9DFF23E1E33391449FDC324526D1F259024380C6@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <9DFF23E1E33391449FDC324526D1F259024380C6@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505060913.50629.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

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
