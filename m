Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0C95e813387
	for linux-mips-outgoing; Sat, 12 Jan 2002 01:05:40 -0800
Received: from skip-ext.ab.videon.ca (skip-ext.ab.videon.ca [206.75.216.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0C95Zg13384
	for <linux-mips@oss.sgi.com>; Sat, 12 Jan 2002 01:05:36 -0800
Received: (qmail 10633 invoked from network); 12 Jan 2002 08:05:31 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.82.81.190]) (envelope-sender <jgg@debian.org>)
          by skip-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <linux-mips@oss.sgi.com>; 12 Jan 2002 08:05:31 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16PJAQ-0003fE-00
	for <linux-mips@oss.sgi.com>; Sat, 12 Jan 2002 01:05:30 -0700
Date: Sat, 12 Jan 2002 01:05:30 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
To: linux-mips@oss.sgi.com
Subject: Quick Q about caches
Message-ID: <Pine.LNX.3.96.1020112002634.14010A-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi All,

I've been working on some cache code for a new processor and I just
quickly wanted to ensure I'm reading the existing stuff right, I hope that
someone who knows a bit more about this codes history could just confirm
some of my guesses :>

So here is what I'm thinking: (read virtually indexed == cache aliasing
problems)

The stuff in c-mips32 is for a processor with virtually indexed primary
and secondary caches, seperate i/d caches and no io-coherancy

The stuff in c-rm7k describes a processor with physically indexed
caches, but seperate non-snooping i and d caches. The IO coherancy stuff
does too much flushing, notably DMA should never be done to regions that
are executing, and the flush_scache also does the flush_dcache as in
c-mips32 (presumably this is what the XXX comment is talking about)

The SB1 reference tells me that it has a virtually indexed icache that
also tags ASID's, the CONFIG_VTAG_ICACHE option invokes the special code
to manage this ASID caching. The rest of the caches are physically indexed
and IO coherant (woop!). The comment for sb1_flush_page_to_ram does 
not jive with the stuff in Documentation/cachetlb.txt - I think the
latter is right and the function should be a nop on a physically tagged
dcache..

The one thing I don't quite get yet is why flush_dcache_page is a NOP for
everyone? That must mean the dcache is always physically indexed if
Documentation/cachetlb.txt is correct.. 

Anyhow, the chip I've got is largely sane, the only annoyance is that 
the SR7100 has physically tagged but virtually indexed i/d-caches that
can alias if the page size is less than 8K, the rest seems 
straightforward..

Thanks,
Jason
