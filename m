Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 13:22:54 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:4356 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225073AbTDAMWx>;
	Tue, 1 Apr 2003 13:22:53 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id 7B87DB61E
	for <linux-mips@linux-mips.org>; Tue,  1 Apr 2003 14:22:49 +0200 (CEST)
Message-ID: <3E898652.2717AEF2@ekner.info>
Date: Tue, 01 Apr 2003 14:30:10 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Patch to disable PCI coherency on AU1500 platforms
Content-Type: multipart/mixed;
 boundary="------------02EB40955D3FB734AD1AF292"
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------02EB40955D3FB734AD1AF292
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The patch below sets the NC bit in the PCI_CFG register to disable HW coherency when
running non-coherent. Until now, this bit was cleared which means corruption when using PCI
DMA masters, even if the kernel was correctly compiled with CONFIG_NONCOHERENT_IO.

Pb1500 specific notes: I don't have a PB1500, so I cannot test if it works there. Note: I also
removed what I think was an extraneous write to the PCI_CMEM register, so if somebody
could test this on a PB1500 it would be great.

/Hartvig



--------------02EB40955D3FB734AD1AF292
Content-Type: text/plain; charset=us-ascii;
 name="setup_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup_patch"

Index: db1x00/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/db1x00/Attic/setup.c,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 setup.c
--- db1x00/setup.c	21 Mar 2003 19:00:46 -0000	1.1.2.4
+++ db1x00/setup.c	1 Apr 2003 12:14:54 -0000
@@ -78,9 +78,8 @@
 void __init au1x00_setup(void)
 {
 	char *argptr;
-	u32 pin_func, static_cfg0;
-	u32 sys_freqctrl, sys_clksrc;
-	u32 prid = read_c0_prid();
+	u32 pin_func;
+//	u32 prid = read_c0_prid();
 
 	argptr = prom_getcmdline();
 
@@ -187,6 +186,19 @@
 
 #ifdef CONFIG_BLK_DEV_IDE
 	ide_ops = &std_ide_ops;
+#endif
+
+#ifdef CONFIG_PCI
+	/* Although YAMON has setup the PCI controller, some things
+	   may need to change. Eventually, all the PCI initialization
+	   should be done here (as in eg. ../pb1500/setup.c)
+	*/
+
+#ifdef CONFIG_NONCOHERENT_IO
+	/* Must disable PCI coherency if running non-coherent */
+
+	au_writel(au_readl(Au1500_PCI_CFG) | (1<<16), Au1500_PCI_CFG);
+#endif
 #endif
 
 #if 0
Index: pb1500/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/pb1500/setup.c,v
retrieving revision 1.1.2.12
diff -u -r1.1.2.12 setup.c
--- pb1500/setup.c	21 Mar 2003 19:00:47 -0000	1.1.2.12
+++ pb1500/setup.c	1 Apr 2003 12:14:54 -0000
@@ -35,6 +35,7 @@
 #include <linux/console.h>
 #include <linux/mc146818rtc.h>
 #include <linux/delay.h>
+#include <linux/proc_fs.h>
 
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
@@ -90,6 +91,7 @@
 	char *argptr;
 	u32 pin_func, static_cfg0;
 	u32 sys_freqctrl, sys_clksrc;
+	u32 pcicfg;
 
 	argptr = prom_getcmdline();
 
@@ -232,15 +234,25 @@
 
 #ifdef CONFIG_PCI
 	// Setup PCI bus controller
-	au_writel(0, Au1500_PCI_CMEM);
-	au_writel(0x00003fff, Au1500_CFG_BASE);
+
+	au_writel(0x00003fff, Au1500_PCI_CMEM);
+
 #if defined(__MIPSEB__)
-	au_writel(0xf | (2<<6) | (1<<4), Au1500_PCI_CFG);
+	pcicfg = 0xf | (2<<6) | (1<<4);
 #else
-	au_writel(0xf, Au1500_PCI_CFG);
+	pcicfg = 0xf;
 #endif
+
+#ifdef CONFIG_NONCOHERENT_IO
+	/* Must disable PCI coherency if running non-coherent */
+
+	pcicfg |= (1<<16);
+#endif
+
+	au_writel(pcicfg,     Au1500_PCI_CFG);
+
 	au_writel(0xf0000000, Au1500_PCI_MWMASK_DEV);
-	au_writel(0, Au1500_PCI_MWBASE_REV_CCL);
+	au_writel(0,          Au1500_PCI_MWBASE_REV_CCL);
 	au_writel(0x02a00356, Au1500_PCI_STATCMD);
 	au_writel(0x00003c04, Au1500_PCI_HDRTYPE);
 	au_writel(0x00000008, Au1500_PCI_MBAR);

--------------02EB40955D3FB734AD1AF292--
