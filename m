Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA04948 for <linux-archive@neteng.engr.sgi.com>; Sun, 12 Jul 1998 12:44:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA59452
	for linux-list;
	Sun, 12 Jul 1998 12:44:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA75070
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 12 Jul 1998 12:44:07 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA09221
	for <linux@cthulhu.engr.sgi.com>; Sun, 12 Jul 1998 12:44:06 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0yvS2V-0027oLC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 12 Jul 1998 21:44:03 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0yvS2O-002OoWC; Sun, 12 Jul 98 21:43 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id UAA05074;
	Sun, 12 Jul 1998 20:55:23 +0200
Message-ID: <19980712205523.42509@alpha.franken.de>
Date: Sun, 12 Jul 1998 20:55:23 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: One good and some bad news
References: <19980712112949.25350@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980712112949.25350@alpha.franken.de>; from Thomas Bogendoerfer on Sun, Jul 12, 1998 at 11:29:49AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jul 12, 1998 at 11:29:49AM +0200, Thomas Bogendoerfer wrote:
> This was the first bad news. To get XF68_FBDev to work, I had to
> discover, that the logic with MAP_MASK is broken. When you look in

ok, I've found a solution for this problem by just using what the other
ports are using for MAP_NR(). I also fixed the mk_pte_phys(), which was
broken, too. Below is the patch I'm currently using. The problem with
the dbe after quiting the X server, didn't happen again. 

Thomas.

Index: include/asm/page.h
===================================================================
RCS file: /var/mips/linus/cvs/linux/include/asm-mips/page.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 page.h
--- page.h	1997/06/01 03:17:11	1.1.1.1
+++ page.h	1998/07/12 18:50:11
@@ -76,8 +76,7 @@
 #define PAGE_OFFSET	0x80000000UL
 #define __pa(x)		((unsigned long) (x) - PAGE_OFFSET)
 #define __va(x)		((void *)((unsigned long) (x) + PAGE_OFFSET))
-#define MAP_MASK        0x1fffffffUL
-#define MAP_NR(addr)	((((unsigned long)(addr)) & MAP_MASK) >> PAGE_SHIFT)
+#define MAP_NR(addr)	(__pa(addr) >> PAGE_SHIFT)
 
 #endif /* defined (__KERNEL__) */
 
Index: include/asm/pgtable.h
===================================================================
RCS file: /var/mips/linus/cvs/linux/include/asm-mips/pgtable.h,v
retrieving revision 1.11
diff -u -r1.11 pgtable.h
--- pgtable.h	1998/03/17 22:16:15	1.11
+++ pgtable.h	1998/07/12 17:57:22
@@ -346,7 +346,7 @@
 
 extern inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
 {
-	return __pte((physpage - PAGE_OFFSET) | pgprot_val(pgprot));
+	return __pte(physpage | pgprot_val(pgprot));
 }
 
 extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)


-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
