Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3G7el8d014236
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Apr 2002 00:40:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3G7elNj014235
	for linux-mips-outgoing; Tue, 16 Apr 2002 00:40:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3G7ei8d014232
	for <linux-mips@oss.sgi.com>; Tue, 16 Apr 2002 00:40:44 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g3G7faG31542;
	Tue, 16 Apr 2002 00:41:36 -0700
Date: Tue, 16 Apr 2002 00:41:36 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: William Jhun <wjhun@ayrnetworks.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: rm7k flush_icache_line() in rm7k_dma_cache_*
Message-ID: <20020416004136.A28097@dea.linux-mips.net>
References: <20020415113844.A21747@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020415113844.A21747@ayrnetworks.com>; from wjhun@ayrnetworks.com on Mon, Apr 15, 2002 at 11:38:44AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 15, 2002 at 11:38:44AM -0700, William Jhun wrote:

> We've been experiencing some problems with our RM7k cache code which is
> based on the sgi mm/rm7k.c from around kernel version 2.4.2. While
> trying to track this down, we noticed that someone added a call to
> flush_icache_line() in the rm7k_dma_cache_*() routines (now
> mm/c-rm7k.c). What is the reason for this? It is our understanding that
> the instruction cache does not write back, and so stale cache lines in
> the icache which are later used for data/dma would seem innocuous. Is
> this not true? We could not find a CVS log entry to explain this,
> either. Did anyone experience problems without these calls to
> flush_icache_line()?

All the DMA cache flushes are only supposed to be used from within the
PCI DMA API that is they don't have to deal with instruction caches ever.
As such these flushes are bogus and I'll remove them.

  Ralf
