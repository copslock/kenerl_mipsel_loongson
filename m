Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2003 20:08:16 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:13477 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225330AbTKUUIE>; Fri, 21 Nov 2003 20:08:04 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id A593C49BFE; Fri, 21 Nov 2003 21:07:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 94B7A46A83; Fri, 21 Nov 2003 21:07:58 +0100 (CET)
Date: Fri, 21 Nov 2003 21:07:58 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] 2.4, head: PAGE_SHIFT changes break glibc
In-Reply-To: <20031121185035.GC8318@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0311212021420.32551@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0311211550270.32551@jurand.ds.pg.gda.pl>
 <20031121185035.GC8318@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 21 Nov 2003, Ralf Baechle wrote:

> >  Recent changes made to <asm/page.h> break a build of glibc 2.2.5 for me.  
> > Compilation bails out due to PAGE_SHIFT being undeclared -- glibc pulls it
> > as it uses PAGE_SIZE in linuxthreads/internals.h.  The PAGE_SHIFT macro
> > depends on configuration now (I use an empty cofinguration for glibc
> > headers, hence the error) and thus it'd better be simply private to the
> > kernel.  Glibc will then use sysconf(_SC_PAGE_SIZE) which now better
> > reflects actual configuration of the system it's run on.
> 
> Interesting.  IA-64 does the same thing, for example.  Wonder why they
> seem to be able to get away with that.  At the very least including the
> kernel header file may pick up a wrong value for PAGE_SHIFT.

 I think people (this may include distributors as well) build glibc with
Linux headers fully configured or, worse yet, with whatever happens to be
grabbed by gcc as <linux/...> and <asm/...> (i.e. usually headers from the
previous installation).  So in this case PAGE_SHIFT gets defined somehow,
although not necessarily reflecting what will be true for the host system.

 The question is which one is the *right* full configuration.  I think all
are valid, so none is the single right, so I chose not to define kernel
configuration macros for the userland -- the userland ABI shouldn't depend
on a particular kernel configuration.  I hope this issue will disappear
automatically once the kernel header space gets divided into an internal
part and one forming the ABI.

 If you look at my spec file for glibc, you'll see it only does:

echo "#define AUTOCONF_INCLUDED" > linux/include/linux/autoconf.h

to get kernel headers working.

> >  Additionally, I think we should also implement the getpagesize syscall to
> > benefit statically linked programs (and make glibc use it like for other
> > platforms that use variable page sizes).
> 
> The kernel is already passing AT_PAGESZ to ELF binaries.  Wouldn't that
> be sufficient?  Currently it's passing the largest supported page size,

 Well, AFAICS in glibc it's ld.so that is responsible for interpreting the
auxiliary vector -- see _dl_aux_init() in elf/dl-support.c.  If the
dynamic linker isn't run (which is the usual case for static binaries,
although calling dlopen() from them might complicate things), the
dl_pagesize variable remains set to zero.  Please prove me wrong if I am
missing anything.

> that is 64k.  However this constant is always passed even when a smaller
> page size is configured.

 Are you sure?  I can see create_elf_tables() in fs/binfmt_elf.c sets 
AT_PAGESZ to ELF_EXEC_PAGESIZE, which, in turn, is set in 
include/asm-mips/elf.h to PAGE_SIZE.  Which is the currently used page 
size and probably the optimal solution.

> >  Finally, I'm not sure such a
> > noticeable change was a good move in these late days of 2.4...
> 
> TLB reloads have been shown to be a major performance problem; this is an
> not yet completed attempt to improve the situation so people don't need
> to go for crude hacks such as wired TLB entires and similar.

 OK, but the safe (and practiced in the mainline) procedure is to test
with the development version and do a backport if necessary.  Well, it
might not work that well this time, as apparently I'm the only one to come
upon such oddities ;-) and, as you probably know, I haven't switched to
2.6, yet.

> Other parts of improvments such as hugetlbfs are available in 2.6 only
> anyway.  I'm also thinking of changing the pagetable structure back to
> the aggressivly optmized thing we were using before Linux 2.0.14 - but
> certainly not for 2.4 - too intrusive, as you say.  With most MIPS users
> being embedded users I still expect 2.4 to live for quite a while -
> certainly longer than I'd like to see ...

 As I wrote, such changes may get backported if there's a need and a
volunteer to do the task.  I won't support 2.4 for a long time, yet -- I
just want to upgrade the toolchain before I upgrade the kernel.  After
then I may only backport some DECstation driver fixes.

 BTW, can you imagine how huge gcc 3.4 is? -- for the i386 it needs 1GB of 
disk space and plenty of hours to be built on a reasonable system.  For 
MIPS I suppose the disk space needed will be yet larger and building may 
require a few days...

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
