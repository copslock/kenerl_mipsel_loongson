Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Feb 2005 19:11:38 +0000 (GMT)
Received: from ms-1.rz.RWTH-Aachen.DE ([IPv6:::ffff:134.130.3.130]:18090 "EHLO
	ms-dienst.rz.rwth-aachen.de") by linux-mips.org with ESMTP
	id <S8225244AbVBETLO>; Sat, 5 Feb 2005 19:11:14 +0000
Received: from r220-1 (r220-1.rz.RWTH-Aachen.DE [134.130.3.31])
 by ms-dienst.rz.rwth-aachen.de
 (iPlanet Messaging Server 5.2 HotFix 1.12 (built Feb 13 2003))
 with ESMTP id <0IBG002CLDAORO@ms-dienst.rz.rwth-aachen.de> for
 linux-mips@linux-mips.org; Sat, 05 Feb 2005 20:11:13 +0100 (MET)
Received: from relay.rwth-aachen.de ([134.130.3.1])
	by r220-1 (MailMonitor for SMTP v1.2.2 ) ; Sat,
 05 Feb 2005 20:11:12 +0100 (MET)
Received: from robins (robins.karman5.RWTH-Aachen.DE [134.130.104.75])
	by relay.rwth-aachen.de (8.13.0/8.13.0/1) with ESMTP id j15JBBSe002712; Sat,
 05 Feb 2005 20:11:11 +0100 (MET)
Received: from rob by robins with local (Exim 3.36 #1 (Debian))
	id 1CxVKo-0004aT-00; Sat, 05 Feb 2005 20:11:10 +0100
Date:	Sat, 05 Feb 2005 20:11:10 +0100
From:	Robert Michel <news@robertmichel.de>
Subject: Re: patch like kexec for MIPS possible?
In-reply-to: <20050205174150.GU28252@rembrandt.csv.ica.uni-stuttgart.de>
To:	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc:	linux-mips <linux-mips@linux-mips.org>
Message-id: <20050205191110.GD3071@mail.robertmichel.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
References: <20050205165019.GC3071@mail.robertmichel.de>
 <20050205174150.GU28252@rembrandt.csv.ica.uni-stuttgart.de>
Return-Path: <news@robertmichel.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: news@robertmichel.de
Precedence: bulk
X-list: linux-mips

Salve Thiemo!

Thiemo Seufer schrieb am Samstag, den 05. Februar 2005 um 18:41h:
> MIPS kernels are usually position dependent code, and loaded in
> unmapped memory, so a kernel would need to overwrite itself for
> kexec. I don't know if kexec is flexible enough to handle this.

Kexec is written for x86 (yet) - but the (my) question is if
this would be possible with MIPS, too.

--snip--
The magic of kexec
One of the biggest challenges in the development of kexec comes from
the fact that the Linux kernel runs from a fixed address in memory.
This means that the new kernel needs to sit at the same place that the
current kernel is running from. On x86 systems, the kernel sits at the
physical address 0x100000 (virtual address 0xc0000000, known as
PAGE_OFFSET). The task of overwriting the old kernel with the new one
is done in three stages: 

1. Copy the new kernel into memory. 
2. Move this kernel image into dynamic kernel memory. 
3. Copy this image into the real destination (overwriting the current
   kernel), and start the new kernel. 
--snap--
http://www-106.ibm.com/developerworks/library/l-kexec.html?ca=dnt-518


> > IMHO would such a kernel patch would be handy, especialy for
> > small MIPS Linux boxes. For more info about kexec read e.g.
> > http://www-106.ibm.com/developerworks/linux/library/l-kexec.html
> 
> Frankly, I don't see what kexec is good for. Who else besides
> kernel developers would need to reboot a machine continuously?

Does GRUB run on MIPS? Does GRUB support SSH2? Does most MIPS
bootlaoders support USB-sticks or booting via VPNs?

LinuxBios is a "nice" project, but for most boards/boxes Linuxer
could be happy to be able to boot it - to develop a nice boadloader
is depended from the hard/firmware of the systems.

A kernel with a kexec like patch could be used into the bootchain
for several reasons:

- making developing and hacking more easy
- booting with options
- choice which kernel to boot
- booting from original not supported devices (usb, network)
- remote control for the boot process
- bypassing memoryrestrictions of the bootloader
- more flexibility - independance from proprietary bootloader
- developing security, statistic features...
- fail save boot
- starting restore system, analyse tools....
- option for modular system 
- for upgrades lower downtimes (Router, Firewalls....)
- perversive computing, the box could be on a place without
  physicaly access
- the kernel would be more often updated, than the bootloader
- just for fun
- just because it could be usefull - an implemented feature
  may become the base for other features - unthinkable before
  this first step
- ...

So my point is not to boot a machine continuously,
but to expand the bootchain:

IMHO would be the most powerfull and flexible way 
to boot a linux kernel,
to boot it just from an other linux kernel.
;)

Greetings
rob
