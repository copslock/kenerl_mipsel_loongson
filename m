Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2005 17:08:30 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.187]:20194
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224817AbVCPRIN>; Wed, 16 Mar 2005 17:08:13 +0000
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKwh2-1DBc0C1zqu-0001uz; Wed, 16 Mar 2005 18:08:12 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: need help with CompactFlash/PCMCIA
Date:	Wed, 16 Mar 2005 18:08:09 +0100
User-Agent: KMail/1.7.1
References: <200503151245.15920.eckhardt@satorlaser.com> <200503160816.52467.eckhardt@satorlaser.com> <4237E80F.90305@embeddedalley.com>
In-Reply-To: <4237E80F.90305@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503161808.10088.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:
> >>Or, you use the ide mode/feature of CF and get it to work that way, but
> >>I've never had to do that myself. Then the card looks like an ide device.
> >>That's something one of our guys at Embedded Alley has done in the past.
> >>Don't know how easy it is; I'll ping him.
> >
> > Sounds like another way to go, in particular since I don't need
> > hotplugging and other PCMCIA features (and their overhead).
>
> Right. And it shouldn't be that hard, but the support just isn't there so
> some work is involved. Finding an example would be the way to go.

OK, I'm just giving a short update on what I've found. In 
asm-mips/mach-generic/ide.h is a function ide_probe_legacy() which is called 
to determine IDE support but which returns 0 for my setup. I simply 
hard-wired this value to 1 and now at least it tries to probe something.

However, it is looking at ioports in the range 366-3f6, which are already 
reserved by something else. Anyway, that is rather a legacy PC-style layout 
and thus probably doesn't apply to the PCMCIA version, if I'm not mistaken. I 
also tried simply removing the check whether they are reserved, but that just 
OOPSed.

Looking at EBOOT (a bootloader for win CE that boots off the compactflash), it 
tries to access the IDE interface at address 0x1a00000 for io_addr and 
0x1a00000e for control, let's see if I can find any IDE hardware at that 
address...


Uli
