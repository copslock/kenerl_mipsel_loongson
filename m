Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5NCvOnC008255
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 23 Jun 2002 05:57:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5NCvNBP008254
	for linux-mips-outgoing; Sun, 23 Jun 2002 05:57:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.gmx.net (sproxy.gmx.net [213.165.64.20])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5NCvFnC008244
	for <linux-mips@oss.sgi.com>; Sun, 23 Jun 2002 05:57:16 -0700
Received: (qmail 5284 invoked by uid 0); 23 Jun 2002 13:00:24 -0000
Received: from pd9e41335.dip.t-dialin.net (HELO bogon.ms20.nix) (217.228.19.53)
  by mail.gmx.net (mp011-rz3) with SMTP; 23 Jun 2002 13:00:24 -0000
Received: by bogon.ms20.nix (Postfix, from userid 1000)
	id 0161E36562; Sun, 23 Jun 2002 14:58:11 +0200 (CEST)
Date: Sun, 23 Jun 2002 14:58:11 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Subject: 2.4.18: pgtable.h compile fix
Message-ID: <20020623125811.GA24851@bogon.ms20.nix>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
I need the following to make head.S compile again for IP22 on the 
current linux_2_4 branch:

Index: include/asm-mips/pgtable.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/pgtable.h,v
retrieving revision 1.63.2.12
diff -u -r1.63.2.12 pgtable.h
--- include/asm-mips/pgtable.h	2002/05/28 09:49:40	1.63.2.12
+++ include/asm-mips/pgtable.h	2002/06/23 12:48:50
@@ -13,6 +13,8 @@
 #include <asm/addrspace.h>
 #include <asm/page.h>
 
+#ifndef _LANGUAGE_ASSEMBLY
+
 #include <linux/linkage.h>
 #include <asm/cachectl.h>
 #include <asm/fixmap.h>
@@ -78,6 +80,7 @@
 extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 			       unsigned long entryhi, unsigned long pagemask);
 
+#endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 /* Basically we have the same two-level (which is the logical three level
  * Linux page table layout folded) page tables as the i386.  Some day
@@ -167,6 +170,8 @@
 #define __S110	PAGE_SHARED
 #define __S111	PAGE_SHARED
 
+#if !defined (_LANGUAGE_ASSEMBLY)
+
 #ifdef CONFIG_64BIT_PHYS_ADDR
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %016Lx.\n", __FILE__, __LINE__, pte_val(e))
@@ -472,6 +477,8 @@
 #define kern_addr_valid(addr)	(1)
 
 #include <asm-generic/pgtable.h>
+
+#endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 /*
  * We provide our own get_unmapped area to cope with the virtual aliasing

Is there a reason why the "_LANGUAGE_ASSEMBLY" ifdefs were removed?
Mips64 still has these #ifdefs though.
Regards, 
 -- Guido
