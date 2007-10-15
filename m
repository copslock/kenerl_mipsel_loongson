Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 11:14:49 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:14107 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20034535AbXJOKOM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2007 11:14:12 +0100
Received: by mo.po.2iij.net (mo30) id l9FACjVi098302; Mon, 15 Oct 2007 19:12:45 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id l9FAChNp022243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 15 Oct 2007 19:12:43 +0900
Message-Id: <200710151012.l9FAChNp022243@po-mbox300.hop.2iij.net>
Date:	Mon, 15 Oct 2007 19:11:24 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp,
	linux-mips <linux-mips@linux-mips.org>,
	Jeff Garzik <jeff@garzik.org>
Subject: [PATCH][2/2][MIPS] add new prom.h for AU1x00
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add new prom.h for AU1x00.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/common/prom.c mips/arch/mips/au1000/common/prom.c
--- mips-orig/arch/mips/au1000/common/prom.c	2007-10-14 16:37:07.788781250 +0900
+++ mips/arch/mips/au1000/common/prom.c	2007-10-14 16:37:12.733090250 +0900
@@ -33,7 +33,6 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -41,18 +40,16 @@
 
 #include <asm/bootinfo.h>
 
-/* #define DEBUG_CMDLINE */
-
-extern int prom_argc;
-extern char **prom_argv, **prom_envp;
-
+int prom_argc;
+char **prom_argv;
+char **prom_envp;
 
 char * __init_or_module prom_getcmdline(void)
 {
 	return &(arcs_cmdline[0]);
 }
 
-void  prom_init_cmdline(void)
+void prom_init_cmdline(void)
 {
 	char *cp;
 	int actr;
@@ -61,7 +58,7 @@ void  prom_init_cmdline(void)
 
 	cp = &(arcs_cmdline[0]);
 	while(actr < prom_argc) {
-	        strcpy(cp, prom_argv[actr]);
+		strcpy(cp, prom_argv[actr]);
 		cp += strlen(prom_argv[actr]);
 		*cp++ = ' ';
 		actr++;
@@ -70,10 +67,8 @@ void  prom_init_cmdline(void)
 		--cp;
 	if (prom_argc > 1)
 		*cp = '\0';
-
 }
 
-
 char *prom_getenv(char *envname)
 {
 	/*
@@ -95,17 +90,19 @@ char *prom_getenv(char *envname)
 		}
 		env++;
 	}
+
 	return NULL;
 }
 
 static inline unsigned char str2hexnum(unsigned char c)
 {
-	if(c >= '0' && c <= '9')
+	if (c >= '0' && c <= '9')
 		return c - '0';
-	if(c >= 'a' && c <= 'f')
+	if (c >= 'a' && c <= 'f')
 		return c - 'a' + 10;
-	if(c >= 'A' && c <= 'F')
+	if (c >= 'A' && c <= 'F')
 		return c - 'A' + 10;
+
 	return 0; /* foo */
 }
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/common/setup.c mips/arch/mips/au1000/common/setup.c
--- mips-orig/arch/mips/au1000/common/setup.c	2007-10-14 16:25:09.983921250 +0900
+++ mips/arch/mips/au1000/common/setup.c	2007-10-14 16:44:05.478885250 +0900
@@ -40,10 +40,11 @@
 #include <asm/mipsregs.h>
 #include <asm/reboot.h>
 #include <asm/pgtable.h>
-#include <asm/mach-au1x00/au1000.h>
 #include <asm/time.h>
 
-extern char * prom_getcmdline(void);
+#include <au1000.h>
+#include <prom.h>
+
 extern void __init board_setup(void);
 extern void au1000_restart(char *);
 extern void au1000_halt(void);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/db1x00/init.c mips/arch/mips/au1000/db1x00/init.c
--- mips-orig/arch/mips/au1000/db1x00/init.c	2007-10-14 16:25:10.023923750 +0900
+++ mips/arch/mips/au1000/db1x00/init.c	2007-10-14 16:44:28.256308750 +0900
@@ -31,15 +31,13 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/bootmem.h>
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-int prom_argc;
-char **prom_argv, **prom_envp;
-extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+#include <prom.h>
 
 const char *get_system_type(void)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/mtx-1/init.c mips/arch/mips/au1000/mtx-1/init.c
--- mips-orig/arch/mips/au1000/mtx-1/init.c	2007-10-14 16:25:10.027924000 +0900
+++ mips/arch/mips/au1000/mtx-1/init.c	2007-10-14 16:44:46.133426000 +0900
@@ -34,13 +34,11 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
+
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
-int prom_argc;
-char **prom_argv, **prom_envp;
-extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
+#include <prom.h>
 
 const char *get_system_type(void)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/pb1000/init.c mips/arch/mips/au1000/pb1000/init.c
--- mips-orig/arch/mips/au1000/pb1000/init.c	2007-10-14 16:25:10.027924000 +0900
+++ mips/arch/mips/au1000/pb1000/init.c	2007-10-14 16:45:03.842532750 +0900
@@ -30,15 +30,13 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/bootmem.h>
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-int prom_argc;
-char **prom_argv, **prom_envp;
-extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+#include <prom.h>
 
 const char *get_system_type(void)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/pb1100/init.c mips/arch/mips/au1000/pb1100/init.c
--- mips-orig/arch/mips/au1000/pb1100/init.c	2007-10-14 16:25:10.031924250 +0900
+++ mips/arch/mips/au1000/pb1100/init.c	2007-10-14 16:45:21.687648000 +0900
@@ -31,15 +31,13 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/bootmem.h>
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-int prom_argc;
-char **prom_argv, **prom_envp;
-extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+#include <prom.h>
 
 const char *get_system_type(void)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/pb1200/board_setup.c mips/arch/mips/au1000/pb1200/board_setup.c
--- mips-orig/arch/mips/au1000/pb1200/board_setup.c	2007-10-14 16:25:10.047925250 +0900
+++ mips/arch/mips/au1000/pb1200/board_setup.c	2007-10-14 16:46:47.248995250 +0900
@@ -41,8 +41,10 @@
 #include <asm/mipsregs.h>
 #include <asm/reboot.h>
 #include <asm/pgtable.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/au1xxx_dbdma.h>
+
+#include <au1000.h>
+#include <au1xxx_dbdma.h>
+#include <prom.h>
 
 #ifdef CONFIG_MIPS_PB1200
 #include <asm/mach-pb1x00/pb1200.h>
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/pb1200/init.c mips/arch/mips/au1000/pb1200/init.c
--- mips-orig/arch/mips/au1000/pb1200/init.c	2007-10-14 16:25:10.071926750 +0900
+++ mips/arch/mips/au1000/pb1200/init.c	2007-10-14 16:45:47.137238500 +0900
@@ -31,15 +31,13 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/bootmem.h>
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-int prom_argc;
-char **prom_argv, **prom_envp;
-extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+#include <prom.h>
 
 const char *get_system_type(void)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/pb1500/init.c mips/arch/mips/au1000/pb1500/init.c
--- mips-orig/arch/mips/au1000/pb1500/init.c	2007-10-14 16:25:10.167932750 +0900
+++ mips/arch/mips/au1000/pb1500/init.c	2007-10-14 16:47:10.422443500 +0900
@@ -31,15 +31,13 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/bootmem.h>
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-int prom_argc;
-char **prom_argv, **prom_envp;
-extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+#include <prom.h>
 
 const char *get_system_type(void)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/pb1550/init.c mips/arch/mips/au1000/pb1550/init.c
--- mips-orig/arch/mips/au1000/pb1550/init.c	2007-10-14 16:25:10.171933000 +0900
+++ mips/arch/mips/au1000/pb1550/init.c	2007-10-14 16:47:28.775590500 +0900
@@ -31,15 +31,13 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/bootmem.h>
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-int prom_argc;
-char **prom_argv, **prom_envp;
-extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+#include <prom.h>
 
 const char *get_system_type(void)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/xxs1500/init.c mips/arch/mips/au1000/xxs1500/init.c
--- mips-orig/arch/mips/au1000/xxs1500/init.c	2007-10-14 16:25:10.367945250 +0900
+++ mips/arch/mips/au1000/xxs1500/init.c	2007-10-14 16:47:43.724524750 +0900
@@ -30,15 +30,13 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/bootmem.h>
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-int prom_argc;
-char **prom_argv, **prom_envp;
-extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+#include <prom.h>
 
 const char *get_system_type(void)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/net/au1000_eth.c mips/drivers/net/au1000_eth.c
--- mips-orig/drivers/net/au1000_eth.c	2007-10-14 16:37:08.052797750 +0900
+++ mips/drivers/net/au1000_eth.c	2007-10-14 16:43:13.931663750 +0900
@@ -54,13 +54,16 @@
 #include <linux/delay.h>
 #include <linux/crc32.h>
 #include <linux/phy.h>
+
+#include <asm/cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/cpu.h>
+#include <au1000.h>
+#include <prom.h>
+
 #include "au1000_eth.h"
 
 #ifdef AU1000_ETH_DEBUG
@@ -96,9 +99,6 @@ static void mdio_write(struct net_device
 static void au1000_adjust_link(struct net_device *);
 static void enable_mac(struct net_device *, int);
 
-// externs
-extern int prom_get_ethernet_addr(char *ethernet_addr);
-
 /*
  * Theory of operation
  *
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-au1x00/prom.h mips/include/asm-mips/mach-au1x00/prom.h
--- mips-orig/include/asm-mips/mach-au1x00/prom.h	1970-01-01 09:00:00.000000000 +0900
+++ mips/include/asm-mips/mach-au1x00/prom.h	2007-10-14 16:37:13.453135250 +0900
@@ -0,0 +1,13 @@
+#ifndef __AU1X00_PROM_H
+#define __AU1X00_PROM_H
+
+extern int prom_argc;
+extern char **prom_argv;
+extern char **prom_envp;
+
+extern void prom_init_cmdline(void);
+extern char *prom_getcmdline(void);
+extern char *prom_getenv(char *envname);
+extern int prom_get_ethernet_addr(char *ethernet_addr);
+
+#endif
