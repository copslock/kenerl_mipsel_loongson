Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g76C5VRw016341
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 6 Aug 2002 05:05:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g76C5Vtm016340
	for linux-mips-outgoing; Tue, 6 Aug 2002 05:05:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g76C5GRw016306;
	Tue, 6 Aug 2002 05:05:16 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g76C5QXb011093;
	Tue, 6 Aug 2002 05:05:30 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA26213;
	Tue, 6 Aug 2002 05:05:26 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g76C5Qb21112;
	Tue, 6 Aug 2002 14:05:26 +0200 (MEST)
Message-ID: <3D4FBB85.FA28A0C7@mips.com>
Date: Tue, 06 Aug 2002 14:05:25 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   linux-mips@oss.sgi.com
Subject: 64-bit kernel
Content-Type: multipart/mixed;
 boundary="------------5760143622786E77B5EF0B2D"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------5760143622786E77B5EF0B2D
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Here is a patch, which have a more cosmetic value rather than fixing
anything, but it makes the compiler happier.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------5760143622786E77B5EF0B2D
Content-Type: text/plain; charset=iso-8859-15;
 name="cosmetic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cosmetic.patch"

Index: include/asm-mips64/irq.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/irq.h,v
retrieving revision 1.4
diff -u -r1.4 irq.h
--- include/asm-mips64/irq.h	2001/03/02 03:04:55	1.4
+++ include/asm-mips64/irq.h	2002/08/06 11:35:06
@@ -46,6 +46,13 @@
 struct irqaction;
 extern int i8259_setup_irq(int irq, struct irqaction * new);
 extern void disable_irq(unsigned int);
+
+#ifndef CONFIG_NEW_IRQ
+#define disable_irq_nosync      disable_irq
+#else
+extern void disable_irq_nosync(unsigned int);
+#endif
+
 extern void enable_irq(unsigned int);
 
 /* Machine specific interrupt initialization  */
Index: include/asm-mips64/pgtable.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/pgtable.h,v
retrieving revision 1.47.2.16
diff -u -r1.47.2.16 pgtable.h
--- include/asm-mips64/pgtable.h	2002/08/05 23:53:39	1.47.2.16
+++ include/asm-mips64/pgtable.h	2002/08/06 11:35:07
@@ -77,10 +77,6 @@
 
 #else
 
-extern void (*_flush_icache_all)(void);
-extern void (*_flush_icache_range)(unsigned long start, unsigned long end);
-extern void (*_flush_icache_page)(struct vm_area_struct *vma, struct page *page);
-
 #define flush_cache_mm(mm)		_flush_cache_mm(mm)
 #define flush_cache_range(mm,start,end)	_flush_cache_range(mm,start,end)
 #define flush_cache_page(vma,page)	_flush_cache_page(vma, page)
@@ -89,12 +85,6 @@
 #define flush_icache_user_range(vma, page, addr, len) \
 	flush_icache_page((vma), (page))
 #define flush_icache_page(vma, page)	_flush_icache_page(vma, page)
-#ifdef CONFIG_VTAG_ICACHE
-#define flush_icache_all()		_flush_icache_all()
-#else
-#define flush_icache_all()		do { } while(0)
-#endif
-
 
 #endif /* !CONFIG_CPU_R10000 */
 

--------------5760143622786E77B5EF0B2D--
