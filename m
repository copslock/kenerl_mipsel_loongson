Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2005 07:17:11 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.176]:6879 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225244AbVCPHQz>; Wed, 16 Mar 2005 07:16:55 +0000
Received: from [212.227.126.160] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DBSly-0001oS-00
	for linux-mips@linux-mips.org; Wed, 16 Mar 2005 08:16:54 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DBSlx-00081P-00
	for linux-mips@linux-mips.org; Wed, 16 Mar 2005 08:16:54 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: need help with CompactFlash/PCMCIA
Date:	Wed, 16 Mar 2005 08:16:52 +0100
User-Agent: KMail/1.7.1
References: <200503151245.15920.eckhardt@satorlaser.com> <200503160651.42705.eckhardt@satorlaser.com> <4237CCDC.1030104@embeddedalley.com>
In-Reply-To: <4237CCDC.1030104@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503160816.52467.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:
> Ulrich Eckhardt wrote:
> > Hmmm, I just had a scary thought: I don't have any userspace programs
> > running yet, meaning also no cardmgr, because I intend to boot from that
> > CF card - is that possible at all? FYI, I don't need any hotplugging at
> > all.
>
> Do you really mean "boot" from it or "root" from it? If you want to "boot"
> from it, you need to work on your boot loader to be able to fetch the
> kernel from CF. 

I have two MiB of flash on board, which contains the bootloader (YAMON) and 
some free space for a kernel. This is used to boot from. IOW, I mean to root 
from the CF card, not to boot from it.

> If you mean "root" from it, then you are approaching this 
> the wrong way -- it won't work through the pcmcia stack and cardmgr because
> that means you already have a root fs up and mounted. You could do this by
> creating a small ramdisk to serve as the root fs, run a special script on
> startup that loads the driver, starts cardmgr, cardmgr then detects the
> card and loads ide-cs.o, and finally the script exits back to the kernel.
> At that point the kernel mounts the real rootfs which is on the card
> itself.

Sounds like the way to go.

> Or, you use the ide mode/feature of CF and get it to work that way, but
> I've never had to do that myself. Then the card looks like an ide device.
> That's something one of our guys at Embedded Alley has done in the past.
> Don't know how easy it is; I'll ping him.

Sounds like another way to go, in particular since I don't need hotplugging 
and other PCMCIA features (and their overhead).

Pete, I owe you a beer. I can see a few things much, much clearer now, thanks!

Uli
