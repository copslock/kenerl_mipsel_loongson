Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Oct 2002 16:03:49 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:56733 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123926AbSJWODs>; Wed, 23 Oct 2002 16:03:48 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA06859;
	Wed, 23 Oct 2002 16:04:12 +0200 (MET DST)
Date: Wed, 23 Oct 2002 16:04:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: KSeg0 coherency policy selection.
In-Reply-To: <AEC4671C8179D61194DE0002B328BDD2070C8C@ATLOPS>
Message-ID: <Pine.GSO.3.96.1021023154603.3179C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 23 Oct 2002, Dinesh Nagpure wrote:

> I am almost done with my porting of kernel 2.4.16 to our platform using
> RM5231A. But I had to make a couple of very basic hacks and I am trying to
> understand if there is any way I can avoid them.

 The kernel is almost a year old -- there were numerous fixes since then. 
Consider grabbing a recent (currently 2.4.20-pre6) version from the CVS. 
What I'm writing below refers to the current 2.4.x kernel. 

> First the memcpy wouldn't work for me properly, both the compiler generated
> and also the one under arch/mips/lib/memcpy.c, so I had to change the lib
> version to do byte copy. I know this is a very crude change but things
> worked.

 You mean arch/mips/lib/memcpy.S, don't you?  There were problems detected
and fixed there this year.

> Second, the Kseg0 coherency algorithm selection in the function
> ld_mmu_r4xx0( ) seems to be improper for RM5231A, This function sets the CP0
> config register K0 field to 3 which as per RM5231A user manual is Cacheable,
> noncoherent, write back policy Should this not be set to 0, which is
> cacheable, non-coherent, write-through, no write allocate? 

 See CONF_CM_DEFAULT in include/asm-mips/pgtable-bits.h for how to select
the KSEG0 caching policy in ld_mmu_r4xx0().  If that is not appropriate,
you probably need a separate function to do the initialization (e.g. 
ld_mmu_rm5231()) in a separate file (e.g. arch/mips/mm/c-rm5231.c).

> Also from the knowledge base I understand there is a cache aliasing problem
> associated with RM5231A when page size is set to 4KB. The document
> recommends to invalidate the cache before retiring a virtual page OR
> coloring of the pages. Can someone tell me if this fix is already taken care
> of? For me when I enable caching under "Kernel hacking" my kernel crashes
> with page fault, when it tries to run bin/init, consistently.

 I can't help here, but you definitely want to upgrade your kernel before
going any further -- you may hit bugs that were fixed long ago and you may
try handling problems someone else already resolved.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
