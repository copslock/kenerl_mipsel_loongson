Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 16:38:19 +0000 (GMT)
Received: from ms-1.rz.RWTH-Aachen.DE ([IPv6:::ffff:134.130.3.130]:47293 "EHLO
	ms-dienst.rz.rwth-aachen.de") by linux-mips.org with ESMTP
	id <S8224807AbVBGQh7>; Mon, 7 Feb 2005 16:37:59 +0000
Received: from r220-1 (r220-1.rz.RWTH-Aachen.DE [134.130.3.31])
 by ms-dienst.rz.rwth-aachen.de
 (iPlanet Messaging Server 5.2 HotFix 1.12 (built Feb 13 2003))
 with ESMTP id <0IBJ00J8HVJAHO@ms-dienst.rz.rwth-aachen.de> for
 linux-mips@linux-mips.org; Mon, 07 Feb 2005 17:37:58 +0100 (MET)
Received: from relay.rwth-aachen.de ([134.130.3.1])
	by r220-1 (MailMonitor for SMTP v1.2.2 ) ; Mon,
 07 Feb 2005 17:37:58 +0100 (MET)
Received: from robins (robins.karman5.RWTH-Aachen.DE [134.130.104.75])
	by relay.rwth-aachen.de (8.13.0/8.13.0/1) with ESMTP id j17GbvmT028394; Mon,
 07 Feb 2005 17:37:57 +0100 (MET)
Received: from rob by robins with local (Exim 3.36 #1 (Debian))
	id 1CyBtd-00032O-00; Mon, 07 Feb 2005 17:37:57 +0100
Date:	Mon, 07 Feb 2005 17:37:57 +0100
From:	Robert Michel <news@robertmichel.de>
Subject: Re: patch like kexec for MIPS possible?
In-reply-to: <20050206002809.GV28252@rembrandt.csv.ica.uni-stuttgart.de>
To:	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc:	linux-mips <linux-mips@linux-mips.org>
Message-id: <20050207163757.GA1741@mail.robertmichel.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
References: <20050205165019.GC3071@mail.robertmichel.de>
 <20050205174150.GU28252@rembrandt.csv.ica.uni-stuttgart.de>
 <20050205191110.GD3071@mail.robertmichel.de>
 <20050206002809.GV28252@rembrandt.csv.ica.uni-stuttgart.de>
Return-Path: <news@robertmichel.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: news@robertmichel.de
Precedence: bulk
X-list: linux-mips

Salve all & Thiemo!

First thank you all for your answers, as I understud you right,
is there no restriction by the MIPS CPU/Memory architecture that
makes a patch for starting another kernel unpossible.

This was the focus of my question - not the use of this. ;)


Thiemo Seufer schrieb am Sonntag, den 06. Februar 2005 um 01:28h:
> 30 seconds for the tftp, and you have to hope the previous
> kernel left everything in a sane state.

I know now (due your answers) u-boot which supports tftp like grub.
But both lake SSH2 to access and control the bootloader during
boot time.

> > - perversive computing, the box could be on a place without
> >   physicaly access
> 
> You don't want to do that without a safe fallback (aka serial console).

I _will_ be able to to this - not because I need it today - I'm just
shure that it will be a handy feature.

You are right, it's usefull to have a safe fallback, but on many
embedded systems you need a screw driver, maby soldering iron and
a RS232 port for "debricking a box".

Beside of a hardware-hangup a box could have a hangup because of a
user software error, kernel error or a black hat attack. Kernel do
have security updates - so if your box does have any kind of 
interface/network it will need kernelupgrades and it exist the danger,
that someone attack and "ownz" this box.

When you have a watchdog or just a timer to reboot the box
the primary kernel form a secure, read-only medium (CD-Rom,
Floppy, E-Prom...).
After booting a clean system, this box could ask a server
via a secure Network what it should do:
- booting the lokal system
- overwrite the lokal system with a clean/newer system.

Now the question, should the bootloader runs SSH2 or
would it better to have an old, sercure, rudimental kernel 
to do this. (Hardcore paranoiacs would use multiple tricks
to make the box secure)
IMHO is it not only more easy to use a kernel instead of
forking a bootloader - also in case of unsecure code, it
is more easier to use a normal kernel/dep patch, than
write this myself for my personal bootloader-fork.

Today you could realise this with RS232 and a second
box, second IP..... this would make the systems more
expensive, bigger, create a higher power consumption -
so somethink that nobody likes for perversive computing.


Probably the link to the IBM article without expaining
my idea was not so good, that article is IMHO concentrating
to much on the speed of reboot.
My point is that such a feature could have a use for
different cases (even more that I can imagine).

I just see that it would be nice to have this feature
also on non x86 platforms - so this is why I ask you
if it would be principle possible to run it on the
MIPS platform.


> > So my point is not to boot a machine continuously,
> > but to expand the bootchain:
> > 
> > IMHO would be the most powerfull and flexible way 
> > to boot a linux kernel,
> > to boot it just from an other linux kernel.
> > ;)
> 
> What if any of both is buggy? Either you have a working fallback,
> or you'll be screwed sooner or later.

No question, sooner or later will fail every system,
but the question is to make the probability as low as possible.

Greetings,
rob



PS: The radio for the  Huygens to Cassini communications had a small
bandwidth and the frequencies was written in ROM (to minimice the power
consumption). But the enginneers forgot to calculate the doppler effect
- so on the first look it seems that no data receiving on Cassini would 
be possible. The workaround was a changed flight path of Cassini to 
change the doppler effect.
http://www.thespacereview.com/article/306/1
