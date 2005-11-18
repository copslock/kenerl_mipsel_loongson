Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2005 17:16:56 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:53258 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133748AbVKRRQf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Nov 2005 17:16:35 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAIHH8gJ018000;
	Fri, 18 Nov 2005 17:17:09 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAIHH7LW017999;
	Fri, 18 Nov 2005 17:17:07 GMT
Date:	Fri, 18 Nov 2005 17:17:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>,
	Peter Horton <pdh@colonel-panic.org>
Subject: Re: MIPS - 64bit woes
Message-ID: <20051118171706.GD2707@linux-mips.org>
References: <436D0061.5070100@jg555.com> <Pine.LNX.4.55.0511071143210.28165@blysk.ds.pg.gda.pl> <4371B87A.9040101@jg555.com> <4371FB46.1000805@gentoo.org> <4372304A.9080608@jg555.com> <4379FBF4.1040505@jg555.com> <437D0AE2.9040706@jg555.com> <437D2C97.8070804@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437D2C97.8070804@jg555.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 17, 2005 at 05:21:27PM -0800, Jim Gifford wrote:

> Got a fix for 2.6.14, http://ftp.jg555.com/cobalt/fix-2.6.14.
> 
> Ralf, I know this is probably not the fix you would like to see, any 
> suggestions.
> 
> diff -Naur linux-mips-2.6.14.orig/arch/mips/kernel/cpu-probe.c 
> linux-mips-2.6.14/arch/mips/kernel/cpu-probe.c
> --- linux-mips-2.6.14.orig/arch/mips/kernel/cpu-probe.c    2005-11-17 
> 11:42:19.000000000 -0800
> +++ linux-mips-2.6.14/arch/mips/kernel/cpu-probe.c    2005-11-17 
> 15:00:11.000000000 -0800
> @@ -121,7 +105,6 @@
>     case CPU_24K:
>     case CPU_25KF:
>     case CPU_34K:
> -     case CPU_PR4450:
>         cpu_wait = r4k_wait;
>         printk(" available.\n");
>         break;

Ehhh?

As for the remainder of your patch - the fact that this actually works
made me notice that there is no cpu-features-override.h for Cobalt which
means that Cobalt kernels carry a rather heavyweight generic cachecode
including spinlocks and all sorts of atomic operations that will at
runtime select between ll/sc and non-ll/sc variants.  That's slow and
I would rather suggest you get rid of that overhead by simply
pretending not to have ll/sc at all on Cobalt but putting something like

#ifdef CONFIG_64BIT
#define cpu_has_llsc            0
#else
#define cpu_has_llsc            1
#endif

into the Cobalt cpu-features-override.h.

  Ralf
