Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Sep 2002 23:05:08 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:31225 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122958AbSIFVFH>;
	Fri, 6 Sep 2002 23:05:07 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g86KrO601586;
	Fri, 6 Sep 2002 13:53:24 -0700
Date: Fri, 6 Sep 2002 13:53:24 -0700
From: Jun Sun <jsun@mvista.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, jsun@mvista.com
Subject: Re: LOADADDR and low physical addresses?
Message-ID: <20020906135324.D1382@mvista.com>
References: <NEBBLJGMNKKEEMNLHGAIAENHCIAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIAENHCIAA.mdharm@momenco.com>; from mdharm@momenco.com on Fri, Sep 06, 2002 at 01:04:28PM -0700
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Sep 06, 2002 at 01:04:28PM -0700, Matthew Dharm wrote:
> So, I've got an interesting problem... which has forced me to look at
> the use of the LOADADDR variable in the Makefile, and try (quickly) to
> brush up on my linker scripting...
> 
> Basically I've got a processor with on-chip registers that need to be
> located in the first 512MByte of _physical_ address.  To make things
> difficult, they cannot be re-located once placed (configuration is
> done by a hardware config stream at reset).  It's only 16KBytes of
> address, but since I recall that linux on mips can't (well, probably
> can't) handle discontiguous memory maps (we discussed this about a
> year ago, I think), I was looking for a good place to put them.
> 
> Now, I think my problems are solved if the LOADADDR variable works the
> way I think it does -- that the kernel loads at that address, and only
> uses memory from that point upwards.  So, if my LOADADDR is
> 0x80100000, then the first 0x100000 won't get used.  Of course, the
> exception vectors are there, but that doesn't take up that much space.
> So there should be a chunk of address space I can use for other
> things, like this register bank.
> 
> Yes? No?  Is my understanding even close?
> 

That is right.

The only catch is that if you make LOADADDR very high (as in the case
system ram starts at a high address), the kernel page
table will be very high too.  It starts from phys address 0.

Also if you map your control registers at near-zero phy address, don't you 
also have system RAM there too?  Normally it is not ok to have two
devices decoded at the same phys address.

> P.S. Of course, if this is right, then I need to figure out the
> proper/best way to use the add_memory_region() function....

Unless I misunderstand something here, I don't think you need 
to mess with add_memory_region().

Jun
