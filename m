Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2004 20:50:03 +0100 (BST)
Received: from natnoddy.rzone.de ([IPv6:::ffff:81.169.145.166]:5312 "EHLO
	natnoddy.rzone.de") by linux-mips.org with ESMTP
	id <S8225235AbUIWTt7>; Thu, 23 Sep 2004 20:49:59 +0100
Received: from mondschein.dominikbrodowski.de (pD9F8CB6E.dip.t-dialin.net [217.248.203.110])
	by post.webmailer.de (8.12.10/8.12.10) with ESMTP id i8NJnuNK022200;
	Thu, 23 Sep 2004 21:49:56 +0200 (MEST)
Received: by mondschein.dominikbrodowski.de (Postfix, from userid 1111)
	id B90BA30E0A; Thu, 23 Sep 2004 21:48:29 +0200 (CEST)
Date: Thu, 23 Sep 2004 21:48:29 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: ralf@linux-mips.org, linux-mips@linux-mips.org
Cc: cpufreq@www.linux.org.uk
Subject: CPU frequency scaling on MIPS (au1000/common/power.c)
Message-ID: <20040923194829.GA32270@dominikbrodowski.de>
Mail-Followup-To: ralf@linux-mips.org, linux-mips@linux-mips.org,
	cpufreq@www.linux.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Return-Path: <brodo@dominikbrodowski.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@dominikbrodowski.de
Precedence: bulk
X-list: linux-mips

Hi,

While grepping for CPU_FREQ in the kernel sources I found some CPU frequency
scaling code in
arch/mips/au1000/common/power.c

As a common cross-architecture CPU frequency scaling infrastructure exists
in 2.6. kernels, and it offers a few interesting tidbits:

- support for dynamic frequency scaling if the hardware allows for it (low
	latencies caused by switching, and many switchings in a second are
	possible)
- handling of loops_per_jiffy updates, i.e. no need to do a lengthy
	calibrate_delay() 
- unified user interface, i.e. developers/users switching from ARM to MIPS
	will find the CPU frequency interface at the same place in sysfs
- informs "notifiers" of frequency switches. While the baud rate update
	in au1000/common/power.c seems to be a good candidate for such a
	notifier, it might be necessary to update the baud rate so fast
	that it needs to be done inside the are locked by pm_lock, and
	without a few function calls' overhead in between. Or isn't this
	a problem?

Therefore, I'd suggest that we update arch/mips/au1000/common/power.c to
use the cpufreq infrastructure. It is located at drivers/cpufreq/, besides
cpufreq.c one or more governors (currently [2.6.9-rc2] four exist,
powersave, performance, userspace and ondemand) are needed. Keeping the
old ctl_table interface around as a wrapper for the cpufreq interfaces looks
to be possible[*]; I'd like to #ifdef CONFIG_... and deprecate it, though.

As I don't have MIPS hardware [well, I do, inside a WRT54G router, but
that's besides the point], don't have and don't want to have a
cross-compiling infrastructure here, I can neither compile-test nor
real-life-test any patches I submit. Nonetheless I'd be willing to write
a "suggestion" on how to update arch/mips/au1000/common/power.c, and
somebody with compiler and hardware could test it then.

Are there other MIPS CPUs which support CPU frequency scaling? If so, it'd
be great if the maintainers for these specific platforms are aware of the
CPUfreq infrastructure, evaluate whether it's good enough for their needs,
and possibly add cpufreq drivers for these CPUs. 

For any questions, comments or patches regarding the cpufreq core or cpufreq 
drivers, there's a mailing list at cpufreq AT www DOT linux DOT org DOT uk, 
which is also CC'ed on this message. Maintainer of cpufreq is Dave Jones.

Thanks for listening,
	Dominik

[*] we already keep a few such old interfaces around, but they'll be removed
soon after 2005 begins. They'll not become available on MIPS in the
meantime, of course.
