Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JAQCU11662
	for linux-mips-outgoing; Thu, 19 Jul 2001 03:26:12 -0700
Received: from dea.waldorf-gmbh.de (u-233-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.233])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JAQ9V11650
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 03:26:09 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6JALEM04420;
	Thu, 19 Jul 2001 12:21:14 +0200
Date: Thu, 19 Jul 2001 12:21:14 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Chris Vandomelen <chrisv@b0rked.dhs.org>
Cc: linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: Patches to support 48M IBM Workpad z50?
Message-ID: <20010719122113.A2422@bacchus.dhis.org>
References: <Pine.LNX.4.31.0107182100140.9246-100000@b0rked.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0107182100140.9246-100000@b0rked.dhs.org>; from chrisv@b0rked.dhs.org on Wed, Jul 18, 2001 at 09:09:42PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 18, 2001 at 09:09:42PM -0700, Chris Vandomelen wrote:

> Since I can't seem to find any information about this anywhere else, I
> figured this would be the appropriate place to ask.
> 
> I'm using a moderately hacked 2.4.0-test9 kernel from the linux-vr
> repository (the only complete kernel, excluding NetBSD, that I've found
> which runs on CE devices at the moment), and it doesn't want to recognize
> all 48M of RAM in the device, only the 1st 16. The memory is mapped as
> such:
> 
> 0M  - 16M:	On-board memory
> 16M - 32M:	Unmapped region
> 32M - 64M:	Memory expansion card
> 
> When the first 16M is checked, the memory immediately after that is found
> to be non-existant.
> 
> Does anyone have a patch (other than the hack I tossed together to turn
> the 32M-64M chunk into an MTD device)

Now that hack took longer to implement than a proper solution ...

> that would be useful to work past the memory hole?

Put something like the following into your systems prom_meminit:

	add_memory_region(0UL       , 16UL << 20, BOOT_MEM_RAM);
	add_memory_region(16UL      , 16UL << 20, BOOT_MEM_RESERVED);
	add_memory_region(32UL << 20, 32UL << 20, BOOT_MEM_RAM);

You may want to account for additional memory areas and do a proper detection
etc., exclude area which are used by the firmware etc.

  Ralf
