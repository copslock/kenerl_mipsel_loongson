Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 May 2004 13:57:56 +0100 (BST)
Received: from p508B632F.dip.t-dialin.net ([IPv6:::ffff:80.139.99.47]:26182
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225768AbUEIM5z>; Sun, 9 May 2004 13:57:55 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i49CvqxT024041;
	Sun, 9 May 2004 14:57:52 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i49Cvof9024040;
	Sun, 9 May 2004 14:57:50 +0200
Date: Sun, 9 May 2004 14:57:50 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jun Sun <jsun@mvista.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: semaphore woes in 2.6, 32bit
Message-ID: <20040509125750.GA19225@linux-mips.org>
References: <20040507181031.F9702@mvista.com> <20040508071822.GA29554@linux-mips.org> <20040508224806.A24682@mvista.com> <Pine.GSO.4.58.0405091108150.26985@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0405091108150.26985@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 09, 2004 at 11:09:29AM +0200, Geert Uytterhoeven wrote:

> > Kernel is yesterday's CVS. gcc is 3.3.1.  config is ddb5477.  No
> > additional patch.  See below.
> >
> > In any case if you look at the uart code you should see there
> > is a problem already.  'state' is allocated through kmalloc() which only
> > gives 4-byte alignement.  The only puzzling thing is that why this
> > did not show up before.  Maybe kmalloc() was giving 8-byte aligned block?
> 
> AFAIK, kmaloc() always[*] returns 8-byte (or higher, for archs that need it)
> aligned blocks.

We got tripped by a change in 2.6.6-rc2.  Before that change the kmalloc
slab caches were being created with SLAB_HWCACHE_ALIGN which results in
L1_CACHE_SHIFT alignment for allocations of L1_CACHE_SHIFT for slab caches
that are at least that size.  For the sake of S390 this behaviour was
changed; new it defaults to BYTES_PER_WORD alignment which is four bytes.

Fixed by defining ARCH_KMALLOC_MINALIGN as 8.

  Ralf

Index: include/asm-mips/cache.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/cache.h,v
retrieving revision 1.16
diff -u -r1.16 cache.h
--- include/asm-mips/cache.h	10 Oct 2003 20:37:35 -0000	1.16
+++ include/asm-mips/cache.h	9 May 2004 12:57:38 -0000
@@ -18,4 +18,6 @@
 #define SMP_CACHE_SHIFT		L1_CACHE_SHIFT
 #define SMP_CACHE_BYTES		L1_CACHE_BYTES
 
+#define ARCH_KMALLOC_MINALIGN	8
+
 #endif /* _ASM_CACHE_H */
