Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2004 17:56:34 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:8181 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225248AbUI3Q43>; Thu, 30 Sep 2004 17:56:29 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP id 00C47184FD
	for <linux-mips@linux-mips.org>; Thu, 30 Sep 2004 09:56:27 -0700 (PDT)
Message-ID: <415C3ABA.6080601@mvista.com>
Date: Thu, 30 Sep 2004 09:56:26 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [PATCH] 64-bit on Broadcom SWARM
Content-Type: multipart/mixed;
 boundary="------------070803090608090509040003"
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070803090608090509040003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello !

Attached patch gets the 64-bit to work on the Broadcom SWARM.

Thanks
Manish

--------------070803090608090509040003
Content-Type: text/plain;
 name="patch-swarm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-swarm"

--- arch/mips/Makefile.orig	2004-09-30 09:49:45.000000000 -0700
+++ arch/mips/Makefile	2004-09-30 09:50:27.000000000 -0700
@@ -35,7 +35,7 @@
 endif
 ifdef CONFIG_MIPS64
 gcc-abi			= 64
-gas-abi			= 32
+gas-abi			= 64
 tool-prefix		= $(64bit-tool-prefix)
 UTS_MACHINE		:= mips64
 endif
@@ -580,7 +580,11 @@
 libs-$(CONFIG_SIBYTE_SENTOSA)	+= arch/mips/sibyte/swarm/
 load-$(CONFIG_SIBYTE_SENTOSA)	:= 0x80100000
 libs-$(CONFIG_SIBYTE_SWARM)	+= arch/mips/sibyte/swarm/
+ifdef CONFIG_MIPS64
+load-$(CONFIG_SIBYTE_SWARM)	:= 0xffffffff80100000
+else
 load-$(CONFIG_SIBYTE_SWARM)	:= 0x80100000
+endif
 
 #
 # SNI RM200 PCI
@@ -651,7 +655,11 @@
 AFLAGS		+= $(cflags-y)
 CFLAGS		+= $(cflags-y)
 
+ifdef CONFIG_MIPS64
+LDFLAGS			+= --oformat $(64bit-bfd)
+else
 LDFLAGS			+= --oformat $(32bit-bfd)
+endif
 
 head-y := arch/mips/kernel/head.o arch/mips/kernel/init_task.o
 
--- arch/mips/Kconfig.orig	2004-09-30 09:49:51.000000000 -0700
+++ arch/mips/Kconfig	2004-09-30 09:50:34.000000000 -0700
@@ -1076,7 +1076,7 @@
 
 config BOOT_ELF64
 	bool
-	depends on SGI_IP27
+	depends on SGI_IP27 || SIBYTE_SB1xxx_SOC
 	default y
 
 #config MAPPED_PCI_IO y
--- arch/mips/sibyte/sb1250/irq_handler.S.orig	2004-09-30 09:50:03.000000000 -0700
+++ arch/mips/sibyte/sb1250/irq_handler.S	2004-09-30 09:50:58.000000000 -0700
@@ -123,7 +123,11 @@
 	 * check the 1250 interrupt registers to figure out what to do
 	 * Need to detect which CPU we're on, now that smp_affinity is supported.
 	 */
+#ifdef CONFIG_MIPS64
+	PTR_LA	v0, CKSEG1 + A_IMR_CPU0_BASE
+#else
 	PTR_LA	v0, KSEG1 + A_IMR_CPU0_BASE
+#endif
 #ifdef CONFIG_SMP
 	lw	t1, TI_CPU($28)
 	sll	t1, IMR_REGISTER_SPACING_SHIFT
--- arch/mips/mm/c-sb1.c.orig	2004-09-30 09:50:15.000000000 -0700
+++ arch/mips/mm/c-sb1.c	2004-09-30 09:50:43.000000000 -0700
@@ -488,7 +488,11 @@
 	/* Special cache error handler for SB1 */
 	memcpy((void *)(CAC_BASE   + 0x100), &except_vec2_sb1, 0x80);
 	memcpy((void *)(UNCAC_BASE + 0x100), &except_vec2_sb1, 0x80);
+#ifdef CONFIG_MIPS64
+	memcpy((void *)CKSEG1ADDR(&handle_vec2_sb1), &handle_vec2_sb1, 0x80);
+#else
 	memcpy((void *)KSEG1ADDR(&handle_vec2_sb1), &handle_vec2_sb1, 0x80);
+#endif
 
 	probe_cache_sizes();
 

--------------070803090608090509040003--
