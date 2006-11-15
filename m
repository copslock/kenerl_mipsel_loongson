Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Nov 2006 19:24:17 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:50940 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20038663AbWKOTYM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Nov 2006 19:24:12 +0000
Received: (qmail 3622 invoked by uid 101); 15 Nov 2006 19:24:01 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 15 Nov 2006 19:24:01 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id kAFJO1hg004859;
	Wed, 15 Nov 2006 11:24:01 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <VY7SGYY9>; Wed, 15 Nov 2006 11:24:00 -0800
Message-ID: <E8C8A5231DDE104C816ADF532E0639120194F4D0@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Trevor Hamm <Trevor_Hamm@pmc-sierra.com>
To:	"'Atsushi Nemoto'" <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: RE: Problems booting Linux 2.6.18.1 on MIPS34K core
Date:	Wed, 15 Nov 2006 11:23:58 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Trevor_Hamm@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Trevor_Hamm@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

 

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Atsushi Nemoto
> Sent: Wednesday, November 15, 2006 8:07 AM
> To: Trevor Hamm
> Cc: linux-mips@linux-mips.org
> Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
> 
> Then, I can imagine three (hardly possible) case:
> 
> A.  PG_dcache_dirty bit was cleared accidently.
> 
> B.  The page is accessed by user process without page_mapping()
> 
> C.  kernel forgot to call update_mmu_cache() at somewhere.
> 
> If case A, removing "&& Page_dcache_dirty(page)" condition from
> __update_cache() will hide your problem.  If case B, calling
> flush_dcache_page() unconditionally in __update_cache() will hide your
> problem.
> 
> Anyway for now I can not see why this can happen...
> 

I've been doing more probing with our FS2 probe, and now have a much better understanding of what is going on.  I used the probe to step through the copy_user_highpage() function while it's copying in the page which seems to be corrupted.  What I found seems to suggest a problem with cache aliases.  In copy_user_highpage(), it calls copy_page() with "vfrom" computed from the new kmap_coherent() function:
	if (cpu_has_dc_aliases) {
		vfrom = kmap_coherent(from, vaddr);
		copy_page(vto, vfrom);
		kunmap_coherent(from);
	}

In my case, for the page of interest:
 	vaddr = 0x2aaecb5c
	vfrom = 0xfffdc000
	Phys. address of this page is 0x011ca000

When I examine the data in this page from both 0x011ca000 and 0xfffdc000, the contents are close to identical.  When I look at the page through address 0x811ca000, I get completely different data, but it's the data I expect to see.  So this tells me that data I want in the page is still in the dcache, but aliased address 0xfffdc000 cannot get at it.  It just so happens that this aliasing is still occurring on the re-boot following a software reset, but some event between the lock-up and re-boot caused the cache contents to be written back into main memory, so the aliased page is getting the correct data by accident on the re-boot.  If I flush the entire dcache with the FS2 probe just before entering copy_page(), the board boots from power-up without any issues.

The log entry for the patch which introduced the kmap_coherent() function explains that the patch was a fix for dcache aliasing, yet it seems to be introducing a dcache alias here.  Any idea why?

> Just for confirm:
> 1. This can happen on latest lmo git tree or 2.6.19-rc5.
> 2. UP kernel.
> 3. No L2 cache.
> 4. icache and dcache are both virtually indexed and physically tagged.
> All correct?
> 

Except for #1 which I haven't tried (we need to get this working with 2.6.18), all correct.  The caches are 64k, 4-way.

Thanks,
Trevor
