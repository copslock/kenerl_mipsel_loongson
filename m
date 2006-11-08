Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2006 19:10:13 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:44242 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20038516AbWKHTKG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Nov 2006 19:10:06 +0000
Received: (qmail 13552 invoked by uid 101); 8 Nov 2006 19:09:53 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 8 Nov 2006 19:09:53 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id kA8J9hn4000592;
	Wed, 8 Nov 2006 11:09:47 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <VY7R80VW>; Wed, 8 Nov 2006 11:09:43 -0800
Message-ID: <E8C8A5231DDE104C816ADF532E0639120194F4C6@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Trevor Hamm <Trevor_Hamm@pmc-sierra.com>
To:	"'Atsushi Nemoto'" <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: RE: Problems booting Linux 2.6.18.1 on MIPS34K core
Date:	Wed, 8 Nov 2006 11:09:37 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Trevor_Hamm@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Trevor_Hamm@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

 

> -----Original Message-----
> From: Atsushi Nemoto [mailto:anemo@mba.ocn.ne.jp] 
> Sent: Wednesday, November 01, 2006 8:19 PM
> To: Trevor Hamm
> Cc: linux-mips@linux-mips.org
> Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
> 
> If dcache aliasing patch caused this problem, it might be due to
> missing flush_dcache_page() in squashfs.
> 
> With a quick look at squashfs/inode.c, it seems flush_dcache_page() is
> needed at end of squashfs_symlink_readpage() as other functions.
> Could you try it?
> 
> skip_read:
> 	memset(pageaddr + bytes, 0, PAGE_CACHE_SIZE - bytes);
> 	kunmap(page);
> 	flush_dcache_page(page);	/* THIS */
> 	SetPageUptodate(page);
> 	unlock_page(page);
> 
> ---
> Atsushi Nemoto
> 

Thanks for the suggestion Atsushi.  Unfortunately, this did not solve the problem.

I recently got my hands on a FS2 EJTAG probe, and with it was able to find the "exact" instruction causing the fault.  Which instruction is dependent on the particular linux image I'm using at the time, but usually happens while running /lib/ld-uClibc-0.9.28.so when starting up /sbin/init.  Typically what happens is that the program reads a pointer value out of memory (which returns 0 or some other random value), then when a later instruction attempts to use that address to load in a value, that's where it goes into an endless loop of TLBS or AdEL exceptions.  When I examine the memory contents where the program loads this pointer value from, after power-up both the main memory and cache appear to be loaded with random values, but after software reset the cache at least has values that look more like valid program addresses.

So just for fun, I built a linux image to use a write-through caching policy, and it boots from power-up every time.

With this information, I would conclude the problem is due to cache management, either in the way we're initializing the cache, or something else in the squashfs code.  Or is there another explanation that I'm overlooking?

Thanks,
Trevor
