Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Nov 2006 23:09:57 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:56769 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039023AbWKOXJw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Nov 2006 23:09:52 +0000
Received: (qmail 11900 invoked by uid 101); 15 Nov 2006 23:09:41 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 15 Nov 2006 23:09:41 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id kAFN9bUX027040;
	Wed, 15 Nov 2006 15:09:41 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <VY7SHD0K>; Wed, 15 Nov 2006 15:09:37 -0800
Message-ID: <E8C8A5231DDE104C816ADF532E0639120194F4D2@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Trevor Hamm <Trevor_Hamm@pmc-sierra.com>
To:	"'Atsushi Nemoto'" <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: RE: Problems booting Linux 2.6.18.1 on MIPS34K core
Date:	Wed, 15 Nov 2006 15:09:34 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Trevor_Hamm@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13210
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

Okay, so after writing up that long explanation, reading through some more kernel code, and re-reading what you wrote above, I realize that all I've done was to verify what you've already suspected all along -- that a flush_dcache_page on this page somehow doesn't flush the page.  This is my first time studying the cache/memory management code in Linux 2.6; thanks for being so patient with me :-)

I tried the remedies you suggested for Case A and B, but neither one produces a kernel which can boot from power-up.  So far, the only work-around that works is calling flush_data_cache_page unconditionally from __flush_dcache_page.  This would imply that Case C is the culprit.  I'll see what I can do to verify this.

Thanks,
Trevor
