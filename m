Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2005 15:26:23 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.190]:5101 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225477AbVCQP0C>; Thu, 17 Mar 2005 15:26:02 +0000
Received: from [212.227.126.206] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DBwsq-0004xo-00
	for linux-mips@linux-mips.org; Thu, 17 Mar 2005 16:26:00 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DBwsq-00069l-00
	for linux-mips@linux-mips.org; Thu, 17 Mar 2005 16:26:00 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: need help with CompactFlash/PCMCIA
Date:	Thu, 17 Mar 2005 16:26:00 +0100
User-Agent: KMail/1.7.1
References: <200503151245.15920.eckhardt@satorlaser.com> <200503161808.10088.eckhardt@satorlaser.com> <42386B0A.5070006@embeddedalley.com>
In-Reply-To: <42386B0A.5070006@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503171626.01092.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:
>> Looking at EBOOT (a bootloader for win CE that boots off the
>> compactflash), it tries to access the IDE interface at address 0x1a00000
>> for io_addr and 0x1a00000e for control, let's see if I can find any IDE
>> hardware at that address...
>
> Uhm, I don't think you'll resolve this that easily. There is some code that
> needs to go in the au1x00 socket driver which means  you would have to
> understand pretty well how this thing works. Ultimately the addresses
> you'll probe are very high ioremapped addresses, since the pcmcia
> attribute, common mem, and i/o are 36 bit physical addresses.

Looking at EBOOT, it creates these mappings here in the TLB:
  0xf 0000 0000  -> 0x1a00 0000 (IO)
  0xf 4000 0000  -> 0x1c00 0000 (attrib)
  0xf 8000 0000  -> 0x1e00 0000 (mem)
each time mapping 32MiB.

In the Linux PCMCIA code, I see that only the IO range above gets ioremap()ed, 
and only 4KiB thereof. For the other two ranges, it uses two addresses that 
are intended for use with fixup_bigphys_addr()[1] but seem to target the 
equivalent physical addresses as in EBOOT.

I tried simply ioremap()ing the IO region and looked for an ATA interface at 
the beginning of that range, but the contents of that memory seem to be 
rather random. I'll next try to remove both PCMCIA and IDE drivers, just to 
make sure they don't interact in any unforseeable way with my ad-hoc code, 
but that's scheduled for tuesday.

I also found www.ata-atapi.com/atadrvr.zip, which contains low-level driver 
sourcecode and examples, so I have something to read over the weekend. ;)

Thank you all for your help!

Uli

[1] Why the difference in the handling of the three ranges? Also, what 
additional effect does ioremap() have when compared to using the TLB? Is it 
that ioremap() is the Right Way(tm) on any architecture while TLB is the way 
that works only on MIPS?
