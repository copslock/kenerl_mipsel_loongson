Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Feb 2005 00:28:27 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:23126
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225261AbVBFA2L>; Sun, 6 Feb 2005 00:28:11 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CxaHa-0006XM-00; Sun, 06 Feb 2005 01:28:10 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CxaHZ-0000sK-00; Sun, 06 Feb 2005 01:28:09 +0100
Date:	Sun, 6 Feb 2005 01:28:09 +0100
To:	Robert Michel <news@robertmichel.de>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: patch like kexec for MIPS possible?
Message-ID: <20050206002809.GV28252@rembrandt.csv.ica.uni-stuttgart.de>
References: <20050205165019.GC3071@mail.robertmichel.de> <20050205174150.GU28252@rembrandt.csv.ica.uni-stuttgart.de> <20050205191110.GD3071@mail.robertmichel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205191110.GD3071@mail.robertmichel.de>
User-Agent: Mutt/1.5.6+20040907i
From:	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Robert Michel wrote:
> Salve Thiemo!
> 
> Thiemo Seufer schrieb am Samstag, den 05. Februar 2005 um 18:41h:
> > MIPS kernels are usually position dependent code, and loaded in
> > unmapped memory, so a kernel would need to overwrite itself for
> > kexec. I don't know if kexec is flexible enough to handle this.
[snip]
> The task of overwriting the old kernel with the new one
> is done in three stages: 
> 
> 1. Copy the new kernel into memory. 
> 2. Move this kernel image into dynamic kernel memory. 
> 3. Copy this image into the real destination (overwriting the current
>    kernel), and start the new kernel. 

Ok, so is no exception WRT.

> > Frankly, I don't see what kexec is good for. Who else besides
> > kernel developers would need to reboot a machine continuously?
> 
> Does GRUB run on MIPS?

No.

> Does GRUB support SSH2?

No idea.

> Does most MIPS bootlaoders support USB-sticks or booting via VPNs?

There are various, and usually they are open source, ao adding such
features shouldn't be a problem.

[snip]
> - making developing and hacking more easy

Usually done via netboot or JTAG download.

> - booting with options
> - choice which kernel to boot
> - booting from original not supported devices (usb, network)
> - remote control for the boot process
> - bypassing memoryrestrictions of the bootloader
> - more flexibility - independance from proprietary bootloader

Those things should be fixed in the bootloader.

> - developing security, statistic features...
> - fail save boot
> - starting restore system, analyse tools....
> - option for modular system 

?

> - for upgrades lower downtimes (Router, Firewalls....)

30 seconds for the tftp, and you have to hope the previous
kernel left everything in a sane state.

> - perversive computing, the box could be on a place without
>   physicaly access

You don't want to do that without a safe fallback (aka serial console).

> - the kernel would be more often updated, than the bootloader
> - just for fun
> - just because it could be usefull - an implemented feature
>   may become the base for other features - unthinkable before
>   this first step
> - ...
> 
> So my point is not to boot a machine continuously,
> but to expand the bootchain:
> 
> IMHO would be the most powerfull and flexible way 
> to boot a linux kernel,
> to boot it just from an other linux kernel.
> ;)

What if any of both is buggy? Either you have a working fallback,
or you'll be screwed sooner or later.


Thiemo
