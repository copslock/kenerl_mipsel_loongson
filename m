Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2005 17:35:23 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:61726 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225361AbVHCQfH>; Wed, 3 Aug 2005 17:35:07 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j73GcK2H010307;
	Wed, 3 Aug 2005 17:38:20 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j73GcKOP010306;
	Wed, 3 Aug 2005 17:38:20 +0100
Date:	Wed, 3 Aug 2005 17:38:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Joshua Wise <mips@joshuawise.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: SMP badness on 5kc
Message-ID: <20050803163820.GA3530@linux-mips.org>
References: <200508031016.28227.mips@joshuawise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508031016.28227.mips@joshuawise.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 03, 2005 at 10:16:27AM -0400, Joshua Wise wrote:

> I have been setting up a simulation of a multiprocessor 5kc board that my 
> company is developing using gxemul, and I've come across a few problems with 
> the MIPS SMP support.

The 5Kc has no cache coherency, so I don't see how it could be done other
than by offloading that into software - which performancewise I would
expect to be an unatractive solution.  Well, there's always the option of
disabling caches which is the easiest way but probably even slower.

> The first issue that I came across was that 5kc does not have an scache, and 
> hence r4k_blast_scache will be null, and hence local_r4k_flush_icache_range 
> crashes the system with a kernel NULL dereference. (Actually, that happens 
> early enough that it drops back into YAMON, without even giving me a kernel 
> panic.) Strangely enough, this only happens on SMP... My solution for this 
> was to put a switch statement like the one in local_r4k___flush_cache_all 
> into local_r4k_flush_icache_range around the if 
> (!cpu_icache_snoops_remote_store). This seemed to cause the crash to stop 
> happening.

That is acutally somewhat similar to another problem somebody found
recently for a uniprocessor configuration.  The whole second level cache
flushing thing only really is needed at all if a system has such a cache
at all, so something like:

  if (!cpu_icache_snoops_remote_store && cpu_has_sc) {
     [...]
  }

would be sensible.  Well, there's no cpu_has_sc but cpu_scache_line_size()
would serve the same purpose.

> My second issue, unresolved to date, is that we are calling 
> on_each_cpu(local_r4k___flush_cache_all) (called from r4k_flush_cache_all) 
> while interrupts are disabled. This doesn't happen while we are bringing up 
> CPUs 0 or 1 -- it seems to only happen when bringing up CPU2. This causes a 
> "badness" message, followed by either a lot of oopses, or a deadlock. Below 
> my sig is a boot log from serial, complete with debug messages written by the 
> Sirius Cybernetics Corporation. :)

Who were the first to be shot when the great revolution came, says the
Hitchhiker's Guide to The Galaxy ;-)

I recently modified the code to avoid such SMP cacheflushes during startup.
As it turned out only a local_* flush was needed which nicely dealt with
the warnings.

  Ralf
