Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 16:43:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11208 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20023957AbZDXPnw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2009 16:43:52 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3OFhna8008277;
	Fri, 24 Apr 2009 17:43:50 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3OFhnFP008275;
	Fri, 24 Apr 2009 17:43:49 +0200
Date:	Fri, 24 Apr 2009 17:43:49 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jon Fraser <jfraser@broadcom.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: HIGHMEM fix for r24k
Message-ID: <20090424154349.GB3614@linux-mips.org>
References: <1240525424.15448.33.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1240525424.15448.33.camel@chaos.ne.broadcom.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 23, 2009 at 06:23:44PM -0400, Jon Fraser wrote:

> For all you guys working on HIGMEM.
> 
> I found a bug that was keeping HIGHMEM from working on mips 24k
> processors starting at 2.6.26.  
> 
> 
> 2008-04-28 Chris Dearman [MIPS] Allow setting of the cache attribute at
> run ...
> 
> This commit introduces the variable _page_cachable_default, which
> defaults to zero.
> 
> arch/mips/mm/cache.c:
> 	unsigned long _page_cachable_default;
> 
> The variable is used to create the prototype PTE for __kmap_atomic in
> arch/mips/mm/init.c:kmap_init.
> 
> The variable is initialized in arch/mips/mm/c-r4k.c:coherency_setup.
> 
> Unfortunately, the variable is used before it is initialized properly.
> As a result, all kmap_atomic PTE have the cache coherency algorithm mode set to 0.  
> Mode 0 is "cacheable, nocoherent, write-through, no write allocate".
> This is not valid on my r24k and my not be on any r24k.
> 
> The result is that writes to kmap_atomic pages get corrupted.  This was confirmed
> using a jtag probe, examining uncached memory, the D cache itself, and cached memory.
> 
> I've changed the variable declaration to be:
>   unsigned long _page_cachable_default = _CACHE_CACHABLE_NONCOHERENT;

There is no safe value of _page_cachable_default; it's all processor and
even platform dependent.  What you found is essentially an ordering bug
so let's fix the ordering!

  Ralf
