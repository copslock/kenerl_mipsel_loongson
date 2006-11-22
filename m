Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2006 20:31:34 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:20170 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039265AbWKVUb1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Nov 2006 20:31:27 +0000
Received: (qmail 28969 invoked by uid 101); 22 Nov 2006 20:31:20 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 22 Nov 2006 20:31:20 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id kAMKVIJT011933;
	Wed, 22 Nov 2006 12:31:19 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <VY7SPBTG>; Wed, 22 Nov 2006 12:31:18 -0800
Message-ID: <E8C8A5231DDE104C816ADF532E0639120194F4EB@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Trevor Hamm <Trevor_Hamm@pmc-sierra.com>
To:	"'Atsushi Nemoto'" <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: RE: Problems booting Linux 2.6.18.1 on MIPS34K core
Date:	Wed, 22 Nov 2006 12:31:10 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Trevor_Hamm@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Trevor_Hamm@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

 

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Atsushi Nemoto
> Sent: Friday, November 17, 2006 4:13 AM
> To: Trevor Hamm
> Cc: linux-mips@linux-mips.org
> Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
> 
> Thanks.  I re-read your report and wonder why this happens only on
> power-up time.
> 
> If flush_data_cache_page or update_mmu_cache were broken, the problem
> can happen on every restart.
>

This page does eventually get flushed to main memory on the first boot, but unfortunately the call to __update_cache() happens after this page was copied through copy_user_highpage().

The source of the problem seems to be with squashfs.  When I compare booting a kernel using squashfs to one using cramfs (which always seems to boot successfully on power-up), both are reading the troublesome page from /lib/ld-uClibc.so, and both are calling flush_dcache_page() on this page.  But in the case of cramfs, flush_dcache_page() causes an immediate cache flush of that page (mapping_mapped(mapping) in __flush_dcache_page() is returning non-zero), while squashfs just marks the page as dirty and defers the cache flush (mapping_mapped(mapping) is returning zero).  I have no idea what causes this difference in behaviour, but right now it appears to be a bug in squashfs rather than the linux-mips kernel.

Trevor
