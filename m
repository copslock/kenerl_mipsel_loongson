Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 15:50:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:63355 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20025235AbZEUOu1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 15:50:27 +0100
Received: from localhost (p3181-ipad208funabasi.chiba.ocn.ne.jp [60.43.104.181])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EE15EAD48; Thu, 21 May 2009 23:50:19 +0900 (JST)
Date:	Thu, 21 May 2009 23:50:20 +0900 (JST)
Message-Id: <20090521.235020.173372074.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	gerg@snapgear.com, linux-mips@linux-mips.org
Subject: Re: system lockup with 2.6.29 on Cavium/Octeon
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090520142604.GA29677@linux-mips.org>
References: <4A139F50.7050409@snapgear.com>
	<20090520142604.GA29677@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 20 May 2009 15:26:04 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Now the vmalloc area starts at 0xc000000000000000 and the kernel code
> > and data is all at 0xffffffff80000000 and above. I don't know if the
> > start and end are reasonable values, but I can see some logic as to
> > where they come from. The code path that leads to this is via
> > __vunmap() and __purge_vmap_area_lazy(). So it is not too difficult
> > to see how we end up with values like this.
> 
> Either start or end address is sensible but not the combination - both
> addresses should be in the same segment.  Start is in XKSEG, end in CKSEG2
> and in between there are vast wastelands of unused address space exabytes
> in size.
> 
> > But the size calculation above with these types of values will result
> > in still a large number. Larger than the 32bit "int" that is "size".
> > I see large negative values fall out as size, and so the following
> > tlbsize check becomes true, and the code spins inside the loop inside
> > that if statement for a _very_ long time trying to flush tlb entries.
> >
> > This is of course easily fixed, by making that size "unsigned long".
> > The patch below trivially does this.
> >
> > But is this analysis correct?
> 
> Yes - but I think we have two issues here.  The one is the calculation
> overflowing int for the arguments you're seeing.  The other being that
> the arguments simply are looking wrong.

The wrong combination comes from lazy vunmapping which was introduced
in 2.6.28 cycle.  Maybe we can add new API (non-lazy version of
vfree()) to vmalloc.c to implement module_free(), but I suppose
fallbacking to local_flush_tlb_all() in local_flush_tlb_kernel_range()
is enough().

---
Atsushi Nemoto
