Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Oct 2002 20:05:23 +0200 (CEST)
Received: from [64.238.111.99] ([64.238.111.99]:14600 "EHLO mail.ivivity.com")
	by linux-mips.org with ESMTP id <S1123926AbSJWSFX>;
	Wed, 23 Oct 2002 20:05:23 +0200
Received: by ATLOPS with Internet Mail Service (5.5.2653.19)
	id <VPJJFDWV>; Wed, 23 Oct 2002 14:05:10 -0400
Message-ID: <AEC4671C8179D61194DE0002B328BDD2070C8D@ATLOPS>
From: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
To: "'Maciej W. Rozycki'" <macro@ds2.pg.gda.pl>,
	Dinesh Nagpure <dinesh_nagpure@ivivity.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: KSeg0 coherency policy selection.
Date: Wed, 23 Oct 2002 14:05:09 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <dinesh_nagpure@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dinesh_nagpure@ivivity.com
Precedence: bulk
X-list: linux-mips

:) my typo. Infact there is no memcpy.c under arch/mips/lib. I may not have
the liberty to upgrade to the latest kernel version but I sure want to try
using arch/mips/lib from a newer version, If that's not of "Don't do that"
kind. Are there any changes made lately in the way I can download sources
from the anonymous cvs server at oss.sgi.com?

I tried following the instructions :
   cvs -d :pserver:cvs@oss.sgi.com:/cvs login
   (Only needed the first time you use anonymous CVS, the password is "cvs")
   cvs -d :pserver:cvs@oss.sgi.com:/cvs co linux

where you insert linux, libc, gdb or faq for <repository>. 

That responded with :
	cvs server : can not find module 'linux' - ignored
	cvs [checkout aborted] can not expand modules.

Thanks,
Dinesh

-----Original Message-----
From: Maciej W. Rozycki [mailto:macro@ds2.pg.gda.pl]
Sent: Wednesday, October 23, 2002 10:04 AM
To: Dinesh Nagpure
Cc: 'linux-mips@linux-mips.org'
Subject: Re: KSeg0 coherency policy selection.


On Wed, 23 Oct 2002, Dinesh Nagpure wrote:

> I am almost done with my porting of kernel 2.4.16 to our platform using
> RM5231A. But I had to make a couple of very basic hacks and I am trying to
> understand if there is any way I can avoid them.

 The kernel is almost a year old -- there were numerous fixes since then. 
Consider grabbing a recent (currently 2.4.20-pre6) version from the CVS. 
What I'm writing below refers to the current 2.4.x kernel. 

> First the memcpy wouldn't work for me properly, both the compiler
generated
> and also the one under arch/mips/lib/memcpy.c, so I had to change the lib
> version to do byte copy. I know this is a very crude change but things
> worked.

 You mean arch/mips/lib/memcpy.S, don't you?  There were problems detected
and fixed there this year.

> Second, the Kseg0 coherency algorithm selection in the function
> ld_mmu_r4xx0( ) seems to be improper for RM5231A, This function sets the
CP0
> config register K0 field to 3 which as per RM5231A user manual is
Cacheable,
> noncoherent, write back policy Should this not be set to 0, which is
> cacheable, non-coherent, write-through, no write allocate? 

 See CONF_CM_DEFAULT in include/asm-mips/pgtable-bits.h for how to select
the KSEG0 caching policy in ld_mmu_r4xx0().  If that is not appropriate,
you probably need a separate function to do the initialization (e.g. 
ld_mmu_rm5231()) in a separate file (e.g. arch/mips/mm/c-rm5231.c).

> Also from the knowledge base I understand there is a cache aliasing
problem
> associated with RM5231A when page size is set to 4KB. The document
> recommends to invalidate the cache before retiring a virtual page OR
> coloring of the pages. Can someone tell me if this fix is already taken
care
> of? For me when I enable caching under "Kernel hacking" my kernel crashes
> with page fault, when it tries to run bin/init, consistently.

 I can't help here, but you definitely want to upgrade your kernel before
going any further -- you may hit bugs that were fixed long ago and you may
try handling problems someone else already resolved.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
