Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2003 15:34:05 +0100 (BST)
Received: from ftp.ckdenergo.cz ([IPv6:::ffff:80.95.97.155]:2021 "EHLO simek")
	by linux-mips.org with ESMTP id <S8225233AbTFPOeD>;
	Mon, 16 Jun 2003 15:34:03 +0100
Received: from ladis by simek with local (Exim 3.36 #1 (Debian))
	id 19Rv2n-0004mS-00
	for <linux-mips@linux-mips.org>; Mon, 16 Jun 2003 16:33:13 +0200
Date: Mon, 16 Jun 2003 16:33:03 +0200
To: linux-mips@linux-mips.org
Subject: [PATCH] kill prom_printf
Message-ID: <20030616143303.GA18363@simek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi,

I was told by many people that prom_printf and friends should die and
early_printk should be used instead. this patch (against 2.5) does first
part of job. compiles and works on IP22 (SNI RM200 and IP32 don't
compile anyway). Feedback appreciated, as always.


Index: arch/mips/Kconfig-shared
===================================================================
RCS file: /home/cvs/linux/arch/mips/Kconfig-shared,v
retrieving revision 1.50
diff -u -r1.50 Kconfig-shared
--- arch/mips/Kconfig-shared	16 Jun 2003 13:54:54 -0000	1.50
+++ arch/mips/Kconfig-shared	16 Jun 2003 14:26:37 -0000
@@ -679,11 +679,6 @@
 	depends on SNI_RM200_PCI || SGI_IP32
 	default y
 
-config ARC_PROMLIB
-	bool
-	depends on SNI_RM200_PCI || SGI_IP32 || SGI_IP22
-	default y
-
 config BOARD_SCACHE
 	bool
 	depends on MIPS_EV96100 || MOMENCO_OCELOT || SGI_IP22
Index: arch/mips/arc/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/arc/Makefile,v
retrieving revision 1.9
diff -u -r1.9 Makefile
--- arch/mips/arc/Makefile	2 Jan 2003 14:18:47 -0000	1.9
+++ arch/mips/arc/Makefile	16 Jun 2003 14:26:37 -0000
@@ -8,5 +8,4 @@
 				   misc.o time.o tree.o
 
 obj-$(CONFIG_ARC_MEMORY)	+= memory.o
-obj-$(CONFIG_ARC_CONSOLE)	+= arc_con.o
-obj-$(CONFIG_ARC_PROMLIB)	+= promlib.o
+obj-$(CONFIG_ARC_CONSOLE)	+= console.o
Index: arch/mips/arc/arc_con.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/arc/arc_con.c,v
retrieving revision 1.10
diff -u -r1.10 arc_con.c
--- arch/mips/arc/arc_con.c	6 Jun 2003 00:15:18 -0000	1.10
+++ arch/mips/arc/arc_con.c	16 Jun 2003 14:26:37 -0000
@@ -1,50 +0,0 @@
-/*
- * Wrap-around code for a console using the
- * ARC io-routines.
- *
- * Copyright (c) 1998 Harald Koerfgen
- * Copyright (c) 2001 Ralf Baechle
- * Copyright (c) 2002 Thiemo Seufer
- */
-#include <linux/tty.h>
-#include <linux/major.h>
-#include <linux/init.h>
-#include <linux/console.h>
-#include <linux/fs.h>
-#include <asm/sgialib.h>
-
-static void prom_console_write(struct console *co, const char *s,
-			       unsigned count)
-{
-	/* Do each character */
-	while (count--) {
-		if (*s == '\n')
-			prom_putchar('\r');
-		prom_putchar(*s++);
-	}
-}
-
-static int __init prom_console_setup(struct console *co, char *options)
-{
-	return !(prom_flags & PROM_FLAG_USE_AS_CONSOLE);
-}
-
-static struct console arc_cons = {
-	.name		= "arc",
-	.write		= prom_console_write,
-	.setup		= prom_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-};
-
-/*
- *    Register console.
- */
-
-static int __init arc_console_init(void)
-{
-	register_console(&arc_cons);
-
-	return 0;
-}
-console_initcall(arc_console_init);
Index: arch/mips/arc/console.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/arc/console.c,v
retrieving revision 1.12
diff -u -r1.12 console.c
--- arch/mips/arc/console.c	2 Jul 2002 13:13:54 -0000	1.12
+++ arch/mips/arc/console.c	16 Jun 2003 14:26:37 -0000
@@ -6,7 +6,11 @@
  * Copyright (C) 1996 David S. Miller (dm@sgi.com)
  * Compability with board caches, Ulf Carlsson
  */
+
+#include <linux/console.h>
 #include <linux/kernel.h>
+#include <linux/init.h>
+
 #include <asm/sgialib.h>
 #include <asm/bcache.h>
 
@@ -20,44 +24,26 @@
  * in some way. You should be careful with them.
  */
 
-void prom_putchar(char c)
+static void arc_console_write(struct console *co, const char *s,
+			      unsigned count)
 {
-	ULONG cnt;
-	CHAR it = c;
-
-	bc_disable();
-	ArcWrite(1, &it, 1, &cnt);
-	bc_enable();
-}
+	CHAR buf[512];
+	ULONG cnt = 0;
 
-char prom_getchar(void)
-{
-	ULONG cnt;
-	CHAR c;
+	while (count--) {
+		if (*s == '\n')
+			buf[cnt++] = '\r';
+		buf[cnt++] = *s++;
+	}
 
 	bc_disable();
-	ArcRead(0, &c, 1, &cnt);
+	ArcWrite(1, &buf, cnt, &cnt);
 	bc_enable();
-
-	return c;
 }
 
-void prom_printf(char *fmt, ...)
-{
-	va_list args;
-	char ppbuf[1024];
-	char *bptr;
-
-	va_start(args, fmt);
-	vsprintf(ppbuf, fmt, args);
-
-	bptr = ppbuf;
-
-	while (*bptr != 0) {
-		if (*bptr == '\n')
-			prom_putchar('\r');
-
-		prom_putchar(*bptr++);
-	}
-	va_end(args);
-}
+struct console arc_console = {
+	.name		= "arc",
+	.write		= arc_console_write,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+};
Index: arch/mips/arc/init.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/arc/init.c,v
retrieving revision 1.13
diff -u -r1.13 init.c
--- arch/mips/arc/init.c	1 Aug 2002 22:25:22 -0000	1.13
+++ arch/mips/arc/init.c	16 Jun 2003 14:26:37 -0000
@@ -12,8 +12,6 @@
 
 #include <asm/sgialib.h>
 
-#undef DEBUG_PROM_INIT
-
 /* Master romvec interface. */
 struct linux_romvec *romvec;
 int prom_argc;
@@ -28,9 +26,9 @@
 	_prom_envp = (LONG *) envp;
 
 	if (pb->magic != 0x53435241) {
-		prom_printf("Aieee, bad prom vector magic %08lx\n", pb->magic);
-		while(1)
-			;
+		printk(KERN_EMERG "Aieee, bad prom vector magic %08lx\n",
+			pb->magic);
+		while(1) ;
 	}
 
 	prom_init_cmdline();
@@ -38,10 +36,4 @@
 	printk(KERN_INFO "PROMLIB: ARC firmware Version %d Revision %d\n",
 	       pb->ver, pb->rev);
 	prom_meminit();
-
-#ifdef DEBUG_PROM_INIT
-	prom_printf("Press a key to reboot\n");
-	prom_getchar();
-	ArcEnterInteractiveMode();
-#endif
 }
Index: arch/mips/arc/memory.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/arc/memory.c,v
retrieving revision 1.24
diff -u -r1.24 memory.c
--- arch/mips/arc/memory.c	1 Aug 2002 22:25:22 -0000	1.24
+++ arch/mips/arc/memory.c	16 Jun 2003 14:26:37 -0000
@@ -112,11 +112,11 @@
 #ifdef DEBUG
 	int i = 0;
 
-	prom_printf("ARCS MEMORY DESCRIPTOR dump:\n");
+	printk(KERN_DEBUG "ARCS MEMORY DESCRIPTOR dump:\n");
 	p = ArcGetMemoryDescriptor(PROM_NULL_MDESC);
 	while(p) {
-		prom_printf("[%d,%p]: base<%08lx> pages<%08lx> type<%s>\n",
-			    i, p, p->base, p->pages, mtypes(p->type));
+		printk("[%d,%p]: base<%08lx> pages<%08lx> type<%s>\n",
+			i, p, p->base, p->pages, mtypes(p->type));
 		p = ArcGetMemoryDescriptor(p);
 		i++;
 	}
Index: arch/mips/arc/promlib.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/arc/promlib.c,v
retrieving revision 1.2
diff -u -r1.2 promlib.c
--- arch/mips/arc/promlib.c	29 Sep 2002 01:43:16 -0000	1.2
+++ arch/mips/arc/promlib.c	16 Jun 2003 14:26:37 -0000
@@ -1,43 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1996 David S. Miller (dm@sgi.com)
- * Compability with board caches, Ulf Carlsson
- */
-#include <linux/kernel.h>
-#include <asm/sgialib.h>
-#include <asm/bcache.h>
-
-/*
- * IP22 boardcache is not compatible with board caches.  Thus we disable it
- * during romvec action.  Since r4xx0.c is always compiled and linked with your
- * kernel, this shouldn't cause any harm regardless what MIPS processor you
- * have.
- *
- * The ARC write and read functions seem to interfere with the serial lines
- * in some way. You should be careful with them.
- */
-
-void prom_putchar(char c)
-{
-	ULONG cnt;
-	CHAR it = c;
-
-	bc_disable();
-	ArcWrite(1, &it, 1, &cnt);
-	bc_enable();
-}
-
-char prom_getchar(void)
-{
-	ULONG cnt;
-	CHAR c;
-
-	bc_disable();
-	ArcRead(0, &c, 1, &cnt);
-	bc_enable();
-
-	return c;
-}
Index: arch/mips/arc/tree.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/arc/tree.c,v
retrieving revision 1.4
diff -u -r1.4 tree.c
--- arch/mips/arc/tree.c	26 Dec 2001 23:03:06 -0000	1.4
+++ arch/mips/arc/tree.c	16 Jun 2003 14:26:37 -0000
@@ -93,11 +93,11 @@
 static void __init
 dump_component(pcomponent *p)
 {
-	prom_printf("[%p]:class<%s>type<%s>flags<%s>ver<%d>rev<%d>",
-		    p, classes[p->class], types[p->type],
-		    iflags[p->iflags], p->vers, p->rev);
-	prom_printf("key<%08lx>\n\tamask<%08lx>cdsize<%d>ilen<%d>iname<%s>\n",
-		    p->key, p->amask, (int)p->cdsize, (int)p->ilen, p->iname);
+	printk(KERN_DEBUG "[%p]:class<%s>type<%s>flags<%s>ver<%d>rev<%d>",
+		p, classes[p->class], types[p->type],
+		iflags[p->iflags], p->vers, p->rev);
+	printk("key<%08lx>\n\tamask<%08lx>cdsize<%d>ilen<%d>iname<%s>\n",
+		p->key, p->amask, (int)p->cdsize, (int)p->ilen, p->iname);
 }
 
 static void __init
