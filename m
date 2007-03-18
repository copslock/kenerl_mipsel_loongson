Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2007 09:44:33 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:7468 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20021660AbXCRJo3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Mar 2007 09:44:29 +0000
Received: from SNaIlmail.Peter (unknown [77.47.7.128])
	by mail1.pearl-online.net (Postfix) with ESMTP id CCB9FAF6E;
	Sun, 18 Mar 2007 10:44:05 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id l2I9gmnR000644;
	Sun, 18 Mar 2007 10:42:49 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id l2I9g4EH000410;
	Sun, 18 Mar 2007 10:42:04 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id l2I9g4Qe000407;
	Sun, 18 Mar 2007 10:42:04 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Sun, 18 Mar 2007 10:42:04 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Kumba <kumba@gentoo.org>, Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP32 prom crashes due to __pa() funkiness
In-Reply-To: <45FC3923.2080207@gentoo.org>
Message-ID: <Pine.LNX.4.58.0703181006450.396@Indigo2.Peter>
References: <45D8B070.7070405@gentoo.org> <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>
 <45FC3923.2080207@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Hi!

Did you try to use PHYS_OFFSET > 0 ?  __pa() ist still (as of
d3fbd83ff545e49e2a0a5ca0f00dda4eedaf8be7) defined as (casts omitted):

#define __pa(x) (x - (x < CKSEG0 ? PAGE_OFFSET:CKSEG0) + PHYS_OFFSET)

This gives __pa(CKSEG0) == PHYS_OFFSET, which will never work for
PHYS_OFFSET > 0. A quick fix (assuming this was the cause for failure)
could be:

========================================================================
--- d3fbd83ff545e49e2a0a5ca0f00dda4eedaf8be7/include/asm-mips/page.h	Sat Mar 10 08:43:17 2007
+++ quickfix/include/asm-mips/page.h	Sun Mar 18 10:24:34 2007
@@ -150,7 +150,7 @@ typedef struct { unsigned long pgprot; }
  * __pa()/__va() should be used only during mem init.
  */
 #if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
-#define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
+#define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0+PHYS_OFFSET)
 #else
 #define __pa_page_offset(x)	PAGE_OFFSET
 #endif


Signed-off-by: peter fuerst <post@pfrst.de>

========================================================================

Of course, "#define PAGE_OFFSET (CAC_BASE + PHYS_OFFSET)" is also needed.

kind regards

peter


On Sat, 17 Mar 2007, Kumba wrote:

> Date: Sat, 17 Mar 2007 14:53:23 -0400
> From: Kumba <kumba@gentoo.org>
> To: Franck Bui-Huu <vagabon.xyz@gmail.com>
> Cc: peter fuerst <post@pfrst.de>
> Subject: Re: IP32 prom crashes due to __pa() funkiness
>
> Franck Bui-Huu wrote:
> > Hi,
> >
> [snip]
> >
> > Well, it means that you previously used CONFIG_BUILD_ELF64=y (this
> > implied that PAGE_OFFSET is in XKPHYS) whereas your kernel has CKSEG
> > load address (symbols need PAGE_OFFSET in CKSEG for address
> > translation).
> >
> > So the question is why can't you use CONFIG_BUILD_ELF64=n (and
> > reagarding the current definition of CONFIG_BUILD_ELF64).
> >
> [snip]
> >
> > It makes me think that I posted a patch for that a couple of weeks ago:
> >
> > http://marc.theaimsgroup.com/?l=linux-mips&m=117154480225936&w=2
> > http://marc.theaimsgroup.com/?l=linux-mips&m=117154480126802&w=2
> > http://marc.theaimsgroup.com/?l=linux-mips&m=117154587014827&w=2
> >
> > Basically this patch removes CONFIG_BUILD_ELF64 and makes Kbuild to use
> > '-msym32' switch if you really need it. Kbuild makes its choice according
> > the load address of your kernel image.
> >
> > Could you give it a try ? This patch was based on 2.6.20 but it should
> > apply fine on a 2.6.21-rc[12].
>
> Tested, and it still failed.
>
> And I didn't always use CONFIG_BUILD_ELF64.  In fact, for the longest time (up
> until 2.6.17) I built IP32 and 64bit IP22 kernels without CONFIG_BUILD_eLF64,
> passing -mabi=o64 (a.k.a., the binutils hack).  This let me use the plain
> 'vmlinux' target w/o the need for an objcopy to boot these systems.  After
> 2.6.17, the nature of o64 was mostly neutered, so I switched to using
> CONFIG_BUILD_ELF64 and the 'vmlinux.32' target, as this is apparently the way
> Debian builds their IP32 kernels (and was the way geoman/spbecker said I
> should've been using all along).
>
> So with the changes brought in by __pa(), I suppose a new, RightWay(TM) to build
> IP32 (and conversely, 64bit IP22) kernels needs to be found.  These two systems
> are particularly wacky, hence why they need a bit more special care than more
> traditional, proper, 64bit systems like Origin and Octane.
>
> Also, Peter raises a good point in this case.  It sounds like a re-thinking of
> how all this address stuff is handled will fix not only special cases like
> IP32/IP22, but the really weird systems, like IP28, as well.  Which would be a
> big plus in my opinion.
>
>
> --Kumba
>
> --
> Gentoo/MIPS Team Lead
>
> "Such is oft the course of deeds that move the wheels of the world: small hands
> do them because they must, while the eyes of the great are elsewhere."  --Elrond
>
>
