Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2003 10:42:51 +0000 (GMT)
Received: from p508B7274.dip.t-dialin.net ([IPv6:::ffff:80.139.114.116]:13963
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225192AbTBRKmv>; Tue, 18 Feb 2003 10:42:51 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1IAgic27097;
	Tue, 18 Feb 2003 11:42:44 +0100
Date: Tue, 18 Feb 2003 11:42:44 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: weirdness in bootmem_init(), arch/mips64/kernel/setup.c
Message-ID: <20030218114244.B25047@linux-mips.org>
References: <20030218065427.GA915@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030218065427.GA915@pureza.melbourne.sgi.com>; from clausen@melbourne.sgi.com on Tue, Feb 18, 2003 at 05:54:27PM +1100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 18, 2003 at 05:54:27PM +1100, Andrew Clausen wrote:

> This code isn't really relevant to what I'm working on (it isn't compiled
> in to kernels for the ip27), but I just noticed it, and it looks broken:
> 
>         /* Find the highest page frame number we have available.  */
>         max_pfn = 0;
>         for (i = 0; i < boot_mem_map.nr_map; i++) {
>                 unsigned long start, end;
> 
>                 if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
>                         continue;
> 
> *****           start = PFN_UP(boot_mem_map.map[i].addr);
> *****           end = PFN_DOWN(boot_mem_map.map[i].addr
>                       + boot_mem_map.map[i].size);
> 
> *****           if (start >= end)
>                         continue;
>                 if (end > max_pfn)
>                         max_pfn = end;
>         }
> 
> 
> That test looks like it will always succeed... and it looks like the
> author wanted it to be a sanity check.

> Why all this business with PFN_UP and PFN_DOWN?  (They are bit
> shifts... PFN_UP shifts left, PFN_DOWN shifts right)

Read again.  PFN_PHYS is shifting left, the others shift right.

Mm is based on complete pages and page numbers.  This code simply discards
partial pages before initializing mm with the list of available memory.
The case start > end cannot happen but start = end is possible for small
areas near the end of a page - but such an area is not usable for mm so
it's ignored.

  Ralf
