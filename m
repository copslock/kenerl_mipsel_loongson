Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2004 23:22:17 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:24036 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225228AbUAHXWQ>;
	Thu, 8 Jan 2004 23:22:16 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id IAA02786;
	Fri, 9 Jan 2004 08:22:12 +0900 (JST)
Received: 4UMDO01 id i08NMCC05667; Fri, 9 Jan 2004 08:22:12 +0900 (JST)
Received: 4UMRO00 id i08NMBs03712; Fri, 9 Jan 2004 08:22:11 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Fri, 9 Jan 2004 08:22:06 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] cache workaround for VR4131
Message-Id: <20040109082206.429ff300.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for cache workaround of VR4131 for 2.6 too.
This patch moves cache workaround to common part from board dependence part.

Please apply this patch.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/mm/c-r4k.c linux/arch/mips/mm/c-r4k.c
--- linux-orig/arch/mips/mm/c-r4k.c	Mon Jan  5 17:27:29 2004
+++ linux/arch/mips/mm/c-r4k.c	Fri Jan  9 08:09:17 2004
@@ -707,6 +707,13 @@
 	case CPU_VR4133:
 		write_c0_config(config & ~CONF_EB);
 	case CPU_VR4131:
+		/* Workaround for cache instruction bug of VR4131 */
+		if (c->processor_id == 0x0c80U || c->processor_id == 0x0c81U ||
+		    c->processor_id == 0x0c82U) {
+			config &= ~0x00000030U;
+			config |= 0x00410000U;
+			write_c0_config(config);
+		}
 		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
 		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 2;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/init.c linux/arch/mips/vr41xx/tanbac-tb0226/init.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/init.c	Tue Nov 18 12:34:23 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0226/init.c	Fri Jan  9 08:09:18 2004
@@ -33,7 +33,6 @@
 {
 	int argc = fw_arg0;
 	char **argv = (char **) fw_arg1;
-	u32 config;
 	int i;
 
 	/*
@@ -47,17 +46,6 @@
 
 	mips_machgroup = MACH_GROUP_NEC_VR41XX;
 	mips_machtype = MACH_TANBAC_TB0226;
-
-	switch (current_cpu_data.processor_id) {
-	case PRID_VR4131_REV1_2:
-		config = read_c0_config();
-		config &= ~0x00000030UL;
-		config |= 0x00410000UL;
-		write_c0_config(config);
-		break;
-	default:
-		break;
-	}
 }
 
 unsigned long __init prom_free_prom_memory(void)
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/init.c linux/arch/mips/vr41xx/tanbac-tb0229/init.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/init.c	Tue Nov 18 12:34:23 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0229/init.c	Fri Jan  9 08:09:18 2004
@@ -38,7 +38,6 @@
 {
 	int argc = fw_arg0;
 	char **argv = (char **) fw_arg1;
-	u32 config;
 	int i;
 
 	/*
@@ -52,17 +51,6 @@
 
 	mips_machgroup = MACH_GROUP_NEC_VR41XX;
 	mips_machtype = MACH_TANBAC_TB0229;
-
-	switch (current_cpu_data.processor_id) {
-	case PRID_VR4131_REV1_2:
-		config = read_c0_config();
-		config &= ~0x00000030UL;
-		config |= 0x00410000UL;
-		write_c0_config(config);
-		break;
-	default:
-		break;
-	}
 }
 
 unsigned long __init prom_free_prom_memory(void)
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/init.c linux/arch/mips/vr41xx/zao-capcella/init.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/init.c	Tue Nov 18 12:34:23 2003
+++ linux/arch/mips/vr41xx/zao-capcella/init.c	Fri Jan  9 08:09:18 2004
@@ -33,7 +33,6 @@
 {
 	int argc = fw_arg0;
 	char **argv = (char **) fw_arg1;
-	u32 config;
 	int i;
 
 	/*
@@ -47,17 +46,6 @@
 
 	mips_machgroup = MACH_GROUP_NEC_VR41XX;
 	mips_machtype = MACH_ZAO_CAPCELLA;
-
-	switch (current_cpu_data.processor_id) {
-	case PRID_VR4131_REV1_2:
-		config = read_c0_config();
-		config &= ~0x00000030UL;
-		config |= 0x00410000UL;
-		write_c0_config(config);
-		break;
-	default:
-		break;
-	}
 }
 
 unsigned long __init prom_free_prom_memory(void)
