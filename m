Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 15:05:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:61645 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039679AbWJXOFr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Oct 2006 15:05:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9OE6F2b030642;
	Tue, 24 Oct 2006 15:06:15 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9OE6EBU030641;
	Tue, 24 Oct 2006 15:06:14 +0100
Date:	Tue, 24 Oct 2006 15:06:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Karl-Johan Karlsson <creideiki+linux-mips@ferretporn.se>
Cc:	linux-mips@linux-mips.org
Subject: Re: Extreme system overhead on large IP27
Message-ID: <20061024140614.GB27800@linux-mips.org>
References: <200610212159.04965.creideiki+linux-mips@ferretporn.se> <20061022232316.GA19127@linux-mips.org> <20061023001947.GA10853@linux-mips.org> <200610232330.23498.creideiki+linux-mips@ferretporn.se> <20061023224318.GA1732@linux-mips.org> <53979.136.163.203.3.1161698036.squirrel@www.ferretporn.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53979.136.163.203.3.1161698036.squirrel@www.ferretporn.se>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 24, 2006 at 03:53:56PM +0200, Karl-Johan Karlsson wrote:

> I can't get physical access to the system to pull out CPU boards today, so
> I did the best I could do remotely - powered down all modules but one and
> am now running a kernel built with support for only 4 of the 8 remaining
> R12000 CPU:s.

The kernel has a maxcpus=<somenumber> option which is even easier.
You also can disable processors at the boot prompt.

Pulling node boards is strongly disrecommended; the connectors are very
fragile.

> Overhead is not as extreme as with more CPU:s, but still high. Running
> four copies of "md5sum /dev/zero", top shows around 95% useful work and 5%
> system overhead per CPU, while a "make -j4" of the kernel gives me 20-30%
> system and 70-80% user time (down from a maximum of 80% system time with
> all 32 CPU:s).
> 
> This is still on the Gentoo 2.6.17.10 kernel, by the way (which is a
> mips-git snapshot from 2006-06-18 plus extra patches from e.g.
> <URL:http://ftp.du.se/pub/os/gentoo/distfiles/mips-sources-generic_patches-1.25.tar.bz2>).
> I tried a git snapshot from earlier today, but the only thing that kernel
> did was print the NUMA-link topology and then hang.

To use the linux-mips.org git kernel you also need my IP27 patchset
available from /pub/linux/mips/people/ralf/ip27/ on ftp.linux-mips.org.

> Now that I actually look at Gentoo's patchset, I see there's a large patch
> (misc-2.6.17-ioc3-metadriver-r26.patch) touching serial and ethernet
> drivers for the IOC3. Perhaps the snapshot actually did boot, but just
> couldn't talk to me without that patch? The patch doesn't apply to the
> current git, though, so I think I'll leave that to someone who knows what
> they're doing.

That metadriver thing is primarily necessary for the sake of Octanes.

  Ralf
