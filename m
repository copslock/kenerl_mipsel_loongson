Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 14:41:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14781 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993905AbdEWMlH6zL-F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2017 14:41:07 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 5BAE031757502;
        Tue, 23 May 2017 13:40:58 +0100 (IST)
Received: from [10.20.78.51] (10.20.78.51) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 23 May 2017
 13:40:59 +0100
Date:   Tue, 23 May 2017 13:40:23 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 4/4] MIPS16e2: Provide feature overrides for non-MIPS16
 systems
In-Reply-To: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1705230345530.2590@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.51]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hardcode the absence of the MIPS16e2 ASE for all the systems that do so 
for the MIPS16 ASE already, providing for code to be optimized away.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips16e2-ase-optim.diff
Index: linux-sfr-test/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h	2017-05-22 22:57:28.987400000 +0100
@@ -40,6 +40,7 @@
 #endif
 
 #define cpu_has_mips16			0
+#define cpu_has_mips16e2		0
 #define cpu_has_mdmx			0
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
Index: linux-sfr-test/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h	2017-05-22 22:57:28.991406000 +0100
@@ -31,6 +31,7 @@
 #define cpu_has_ejtag			1
 #define cpu_has_llsc			1
 #define cpu_has_mips16			0
+#define cpu_has_mips16e2		0
 #define cpu_has_mdmx			0
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
Index: linux-sfr-test/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h	2017-05-22 22:57:28.995412000 +0100
@@ -19,6 +19,7 @@
 #define cpu_has_ejtag			1
 #define cpu_has_llsc			1
 #define cpu_has_mips16			0
+#define cpu_has_mips16e2		0
 #define cpu_has_mdmx			0
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
Index: linux-sfr-test/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h	2017-05-22 22:57:29.001406000 +0100
@@ -37,6 +37,7 @@
 #endif
 
 #define cpu_has_mips16		0
+#define cpu_has_mips16e2	0
 #define cpu_has_mdmx		0
 #define cpu_has_mips3d		0
 #define cpu_has_smartmips	0
Index: linux-sfr-test/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h	2017-05-22 22:57:29.006398000 +0100
@@ -27,6 +27,7 @@
 #define cpu_has_mcheck			0
 #define cpu_has_ejtag			0
 #define cpu_has_mips16			0
+#define cpu_has_mips16e2		0
 #define cpu_has_mdmx			0
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
Index: linux-sfr-test/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h	2017-05-22 22:57:29.010397000 +0100
@@ -19,6 +19,7 @@
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
 #define cpu_has_mips16		0
+#define cpu_has_mips16e2	0
 #define cpu_has_divec		0
 #define cpu_has_cache_cdex_p	1
 #define cpu_has_prefetch	0
Index: linux-sfr-test/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h	2017-05-22 22:57:29.020398000 +0100
@@ -43,6 +43,7 @@
 #define cpu_has_ejtag			0
 #define cpu_has_llsc			1
 #define cpu_has_mips16			0
+#define cpu_has_mips16e2		0
 #define cpu_has_mdmx			0
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
Index: linux-sfr-test/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h	2017-05-22 22:57:29.024398000 +0100
@@ -16,6 +16,7 @@
  */
 #define cpu_has_watch		1
 #define cpu_has_mips16		0
+#define cpu_has_mips16e2	0
 #define cpu_has_divec		0
 #define cpu_has_vce		0
 #define cpu_has_cache_cdex_p	0
Index: linux-sfr-test/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h	2017-05-22 22:57:29.028408000 +0100
@@ -29,6 +29,7 @@
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
 #define cpu_has_mips16		0
+#define cpu_has_mips16e2	0
 #define cpu_has_vce		0
 #define cpu_has_cache_cdex_s	0
 #define cpu_has_mcheck		0
Index: linux-sfr-test/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h	2017-05-22 22:57:29.032407000 +0100
@@ -23,6 +23,7 @@
 #define cpu_has_ejtag 1
 #define cpu_has_llsc		1
 #define cpu_has_mips16 0
+#define cpu_has_mips16e2	0
 #define cpu_has_mdmx 0
 #define cpu_has_mips3d 0
 #define cpu_has_smartmips 0
Index: linux-sfr-test/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h	2017-05-22 22:42:16.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h	2017-05-22 22:57:29.043398000 +0100
@@ -32,6 +32,7 @@
 #define cpu_has_mcheck		0
 #define cpu_has_mdmx		0
 #define cpu_has_mips16		0
+#define cpu_has_mips16e2	0
 #define cpu_has_mips3d		0
 #define cpu_has_mipsmt		0
 #define cpu_has_smartmips	0
Index: linux-sfr-test/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h	2017-05-22 22:42:16.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h	2017-05-22 22:57:29.047397000 +0100
@@ -13,6 +13,7 @@
 #define cpu_has_4k_cache	1
 #define cpu_has_watch		1
 #define cpu_has_mips16		0
+#define cpu_has_mips16e2	0
 #define cpu_has_counter		1
 #define cpu_has_divec		1
 #define cpu_has_vce		0
Index: linux-sfr-test/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h	2017-05-22 22:42:16.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h	2017-05-22 22:57:29.051411000 +0100
@@ -48,6 +48,7 @@
 #define cpu_has_llsc			1
 
 #define cpu_has_mips16			0
+#define cpu_has_mips16e2		0
 #define cpu_has_mdmx			0
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
Index: linux-sfr-test/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h	2017-05-22 22:42:16.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h	2017-05-22 22:57:29.066402000 +0100
@@ -17,6 +17,7 @@
 #define cpu_has_counter		1
 #define cpu_has_watch		0
 #define cpu_has_mips16		0
+#define cpu_has_mips16e2	0
 #define cpu_has_divec		0
 #define cpu_has_cache_cdex_p	1
 #define cpu_has_prefetch	0
Index: linux-sfr-test/arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h	2017-05-22 22:42:16.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h	2017-05-22 22:57:29.070404000 +0100
@@ -13,6 +13,7 @@
  */
 #define cpu_has_watch		1
 #define cpu_has_mips16		0
+#define cpu_has_mips16e2	0
 #define cpu_has_divec		1
 #define cpu_has_vce		0
 #define cpu_has_cache_cdex_p	0
Index: linux-sfr-test/arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h	2017-05-22 22:42:16.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h	2017-05-22 22:57:29.074404000 +0100
@@ -6,6 +6,7 @@
 #define cpu_has_inclusive_pcaches	0
 
 #define cpu_has_mips16		0
+#define cpu_has_mips16e2	0
 #define cpu_has_mdmx		0
 #define cpu_has_mips3d		0
 #define cpu_has_smartmips	0
