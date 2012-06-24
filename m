Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jun 2012 14:22:25 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:60499 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901351Ab2FXMWU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Jun 2012 14:22:20 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1SilpW-0003O4-00; Sun, 24 Jun 2012 14:22:14 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 24FAB1BB7B1; Sun, 24 Jun 2012 14:18:02 +0200 (CEST)
Date:   Sun, 24 Jun 2012 14:18:02 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: booting linux-3.3 or linux 3.4 on an SGI O2?
Message-ID: <20120624121802.GA27839@alpha.franken.de>
References: <20120605190047.GA6263@alumni-linux.ccs.neu.edu>
 <4FCE593B.10808@cavium.com>
 <4FE6195F.7030505@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FE6195F.7030505@gentoo.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 33798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Jun 23, 2012 at 03:30:39PM -0400, Joshua Kinard wrote:
> On 06/05/2012 3:08 PM, David Daney wrote:
> > On 06/05/2012 12:00 PM, Jim Faulkner wrote:
> >> Hi all, I haven't been able to boot any kernels after linux 3.2 on my
> >> SGI O2.  I've tried linux-3.3.5 and linux-3.4.0, but neither would boot.
> >> Unfortunately I don't have further information such as a kernel panic,
> >> since I don't get any video output after the kernel is loaded.  I've
> >> attached my linux-3.4 .config.  Anybody know what patches I might need
> >> to get the latest kernels booting on this system?
> >>
> > 
> > I have had problems as well.
> > 
> > Someone should configure a serial console and early printk to see if they
> > can see what is happening.
> 
> Early printk on O2 systems probably has the same issues as on IP22/IP28
> where it's overwriting PROM memory somewhere.  The system will hang very
> early in the bootmem allocator if you kludge early printk to work on these
> systems:

O2 is easy since it's simply a 16550 as console port chip, so no PROM
is needed and no problems like on IP22/28.

> CPU revision is: 00002733 (RM7000)

I guess the problem is here, iirc there was another RM7000 error report
due to some cache code restructering or it's RM7000 O2 problem in general.
I don't own a RM7000 cpu module for O2 ...

On my R5k O2 3.4.3 runs without problems like early 3.5 did:

mips:~# uname -a
Linux mips.franken.de 3.4.3 #2 Sun Jun 24 14:12:05 CEST 2012 mips64 GNU/Linux
mips:~# cat /proc/cpuinfo 
system type		: SGI O2
processor		: 0
cpu model		: R5000 V2.1  FPU V1.0
BogoMIPS		: 179.45

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
