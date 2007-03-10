Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2007 09:45:12 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:1062 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20021427AbXCJJpF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Mar 2007 09:45:05 +0000
Received: from SNaIlmail.Peter (unknown [77.47.7.186])
	by mail1.pearl-online.net (Postfix) with ESMTP id 48C3AB09F
	for <linux-mips@linux-mips.org>; Sat, 10 Mar 2007 10:44:48 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id l2A9goB3000707
	for <linux-mips@linux-mips.org>; Sat, 10 Mar 2007 10:42:50 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id l2A9fxVF019022;
	Sat, 10 Mar 2007 10:42:00 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id l2A9fxAq019019;
	Sat, 10 Mar 2007 10:41:59 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Sat, 10 Mar 2007 10:41:59 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH], Re: IP32 prom crashes due to __pa() funkiness
In-Reply-To: <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0703101039420.19007@Indigo2.Peter>
References: <45D8B070.7070405@gentoo.org> <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Hi !

Watching the discussion about __pa(), CPHYSADDR and related stuff, with about
a hundred e-mails last October, and rising again several times recently (see
below), i wonder why we must cling so firmly to the "x - page_offset"
algorithm, the least capable one. AFAIK this method is taken over unaltered
from the i386 arch (yes, i know, the majority of archs did this), where we
have a situation quite different from MIPS:
A (preferably simple) mapping must be invented for kernel-memory with some,
more or less deliberately chosen, "page-offset". There exist no addresses
beside this mapping, no hardware "kernel-mappings" with (un)cached regions,
cached-attributes, unmapped spaces, etc. and "x - page_offset" is necessary
and sufficient to handle all addresses.

On the MIPS-side there isn't really something like "the" page-offset, and
the processor architecture already defines kernel spaces with respective
address-syntax. In other words, the definitions in asm-mips/addrspace.h
properly describe the virtual/physical conversions and masking, not some
subtracting, is the natural way to go.

Since __pa() and virt_to_phys() are currently "under construction" anyway,
i think it's time to submit robust versions (with kernel_physaddr() stolen
from the IP30 patch) for both, that handle any pitfall in one place and may
be used without pain throughout the kernel. I don't know, which one to prefer,
29 drivers are using __pa(), 60 are using virt_to_phys(), the uses in
arch/mips files are about equal.

Having a robust __pa()/virt_to_phys() avoids the need for local fixes, like
in sgiwd93.c and sgiseeq.c, which have to cope with at least one uncached
(usu. 0x9000...) address-type and at least one cached type (usu. 0xa800...)
in xkphys, and where virt_to_phys() blew up nicely. In some situation there
may be need to handle a ckseg0/1 address additionaly.


On Thu, 1 Mar 2007, Franck Bui-Huu wrote:

> Date: Thu, 1 Mar 2007 10:39:08 +0100
> From: Franck Bui-Huu <vagabon.xyz@gmail.com>
> To: Kumba <kumba@gentoo.org>
> Cc: Linux MIPS List <linux-mips@linux-mips.org>
> Subject: Re: IP32 prom crashes due to __pa() funkiness
>
> Hi,
>
> Kumba wrote:
> >
> > Initially, booting a straight git checkout on an IP32 will cause it to
> > prom crash, usually somewhere in between init_bootmem() and
> > init_bootmem_core().  I bisected git to trace this back to one of the
> > inital __pa() introduction patches from commit d4df6d4 (get ride of
> > CPHYSADDR()).  It actually appears that the actual commit that broke
> > things was 620a480 (Make __pa() aware of XKPHYS/CKSEG0 address mix for
> > 64 bit kernels).
> >
> > The [short-term] fix highlighted by Ilya is to make __pa()
> > unconditionally be defined to "((unsigned long)(x) < CKSEG0 ?
> > PAGE_OFFSET : CKSEG0)"; Discovered by building IP32 with
> > CONFIG_BUILD_ELF64=n.
> >
>
> Well, it means that you previously used CONFIG_BUILD_ELF64=y (this
> implied that PAGE_OFFSET is in XKPHYS) whereas your kernel has CKSEG
> load address (symbols need PAGE_OFFSET in CKSEG for address
> translation).
>
> ...



Signed-off-by: peter fuerst <post@pfrst.de>

========================================================================
--- c6275088cf65aaa1826e426e9e683b6c3e1f371c/include/asm-mips/addrspace.h	Sat Mar 10 08:38:53 2007
+++ kernelphysaddr-version/include/asm-mips/addrspace.h	Sat Mar 10 08:38:53 2007
@@ -54,6 +54,17 @@
 #define XPHYSADDR(a)            ((_ACAST64_(a)) &			\
 				 _CONST64_(0x000000ffffffffff))

+static inline unsigned long kernel_physaddr(unsigned long kva)
+{
+#ifdef CONFIG_64BIT
+	if((kva & 0xffffffff80000000UL) == 0xffffffff80000000UL)
+		return CPHYSADDR(kva);
+	return XPHYSADDR(kva);
+#else
+	return CPHYSADDR(kva);
+#endif
+}
+
 #ifdef CONFIG_64BIT

 /*
--- 92ec2618560c984355e653d33d5dc935e5e1488c/include/asm-mips/io.h	Sat Mar 10 08:41:06 2007
+++ kernelphysaddr-version/include/asm-mips/io.h	Sat Mar 10 08:41:06 2007
@@ -116,7 +116,7 @@ static inline void set_io_port_base(unsi
  */
 static inline unsigned long virt_to_phys(volatile const void *address)
 {
-	return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
+	return kernel_physaddr((unsigned long)address);
 }

 /*
--- d3fbd83ff545e49e2a0a5ca0f00dda4eedaf8be7/include/asm-mips/page.h	Sat Mar 10 08:43:17 2007
+++ kernelphysaddr-version/include/asm-mips/page.h	Sat Mar 10 08:43:17 2007
@@ -154,7 +154,7 @@ typedef struct { unsigned long pgprot; }
 #else
 #define __pa_page_offset(x)	PAGE_OFFSET
 #endif
-#define __pa(x)		((unsigned long)(x) - __pa_page_offset(x) + PHYS_OFFSET)
+#define __pa(x)		kernel_physaddr((unsigned long)(x))
 #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
 #define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x),0))
========================================================================
