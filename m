Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0D1LCu26173
	for linux-mips-outgoing; Sat, 12 Jan 2002 17:21:12 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0D1L8g26169
	for <linux-mips@oss.sgi.com>; Sat, 12 Jan 2002 17:21:08 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0CNp2q05396;
	Sat, 12 Jan 2002 15:51:02 -0800
Date: Sat, 12 Jan 2002 15:51:02 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jason Gunthorpe <jgg@debian.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Quick Q about caches
Message-ID: <20020112155102.A1569@dea.linux-mips.net>
References: <Pine.LNX.3.96.1020112002634.14010A-100000@wakko.deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020112002634.14010A-100000@wakko.deltatee.com>; from jgg@debian.org on Sat, Jan 12, 2002 at 01:05:30AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jan 12, 2002 at 01:05:30AM -0700, Jason Gunthorpe wrote:

> So here is what I'm thinking: (read virtually indexed == cache aliasing
> problems)

Right.

> The stuff in c-mips32 is for a processor with virtually indexed primary
> and secondary caches, seperate i/d caches and no io-coherancy
> 
> The stuff in c-rm7k describes a processor with physically indexed
> caches, but seperate non-snooping i and d caches. The IO coherancy stuff
> does too much flushing, notably DMA should never be done to regions that
> are executing, and the flush_scache also does the flush_dcache as in
> c-mips32 (presumably this is what the XXX comment is talking about)
> 
> The SB1 reference tells me that it has a virtually indexed icache that
> also tags ASID's, the CONFIG_VTAG_ICACHE option invokes the special code
> to manage this ASID caching. The rest of the caches are physically indexed
> and IO coherant (woop!). The comment for sb1_flush_page_to_ram does 
> not jive with the stuff in Documentation/cachetlb.txt - I think the
> latter is right and the function should be a nop on a physically tagged
> dcache..
>
> The one thing I don't quite get yet is why flush_dcache_page is a NOP for
> everyone? That must mean the dcache is always physically indexed if
> Documentation/cachetlb.txt is correct.. 

You either need to implement flush_page_to_ram or flush_dcache_page.

> Anyhow, the chip I've got is largely sane, the only annoyance is that 
> the SR7100 has physically tagged but virtually indexed i/d-caches that
> can alias if the page size is less than 8K, the rest seems 
> straightforward..

  Ralf
