Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JAUDL11942
	for linux-mips-outgoing; Thu, 19 Jul 2001 03:30:13 -0700
Received: from b0rked.dhs.org (postfix@b0rked.dhs.org [216.99.196.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JAUAV11939;
	Thu, 19 Jul 2001 03:30:10 -0700
Received: by b0rked.dhs.org (Postfix, from userid 500)
	id 95E7C1DC5; Thu, 19 Jul 2001 03:30:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by b0rked.dhs.org (Postfix) with ESMTP
	id 91A9E1DC0; Thu, 19 Jul 2001 03:30:08 -0700 (PDT)
Date: Thu, 19 Jul 2001 03:30:08 -0700 (PDT)
From: Chris Vandomelen <chrisv@b0rked.dhs.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>, <linux-mips-kernel@lists.sourceforge.net>
Subject: Re: Patches to support 48M IBM Workpad z50?
In-Reply-To: <20010719122113.A2422@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.31.0107190328000.9246-100000@b0rked.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Now that hack took longer to implement than a proper solution ...

Yeah, that hack did take longer to implement than a proper solution. But
it was what I could come up with at the time, as I haven't gone digging
that far down into the kernel sources yet (and unfortunately, the prom.c
source wasn't very helpful either.

> > that would be useful to work past the memory hole?
>
> Put something like the following into your systems prom_meminit:
>
> 	add_memory_region(0UL       , 16UL << 20, BOOT_MEM_RAM);
> 	add_memory_region(16UL      , 16UL << 20, BOOT_MEM_RESERVED);
> 	add_memory_region(32UL << 20, 32UL << 20, BOOT_MEM_RAM);
>
> You may want to account for additional memory areas and do a proper detection
> etc., exclude area which are used by the firmware etc.

I'm pretty sure that 16M region in the 16-32M area is unused: it's
possible to solder another 2 8M dram chips on the board and increase the
memory to 64M..

Thanks for the help. :)

Chris
