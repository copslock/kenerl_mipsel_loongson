Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:48:37 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34312 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825659Ab2JWRr7UPJ9v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:47:59 +0200
Received: by mail-lb0-f177.google.com with SMTP id gi11so520825lbb.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3r3rkKM4uIcQdmWHsDpvhKKnMD2U1+sRjvoM+4oFBA0=;
        b=qWYtu3GzsaUtG9JEk/ENoxx5PqU8JjamqbgXGaey2xZ0vY4DWc2Rc7zpLyFTCL4OTv
         +7W0I/4rziPex4t/oXj9PfRtL7qnpEArsdoSqmkIHWzBRrHG8FojGSAaep0ULRGqFnoy
         O/tHT8BGeNnpck/2plmxEutFrpML05Sh3yrD/DG9H9yktCCF0BuRL4UACg3CK7zNbGoN
         UD9zbxX+7isH/Qm1uJDYJJgL6AIAFzonk9uBDPgD9l7qVPf+/wBmhhGSWNnQkM6ylOMl
         olTovw2iecQ3M5Ws25K9q2XUOoPj2oN9Hjpy8NXV4aalu/Wm3kd/fuCBRcDCSuSvuqqY
         72xA==
Received: by 10.112.85.198 with SMTP id j6mr3734757lbz.132.1351014471602;
        Tue, 23 Oct 2012 10:47:51 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.47.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:47:50 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 01/13] MIPS: JZ4750D: Add base support for Ingenic JZ4750D System-on-a-Chip
Date:   Tue, 23 Oct 2012 21:43:49 +0400
Message-Id: <1351014241-3207-2-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Adds a new cpu type for the JZ4750D to the Linux MIPS architecture code.
It also adds the iomem addresses for the different components found on
a JZ4750D SoC.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/include/asm/bootinfo.h          |    1 +
 arch/mips/include/asm/mach-jz4750d/base.h |   12 ++++++++++++
 arch/mips/include/asm/mach-jz4750d/war.h  |   25 +++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-jz4750d/base.h
 create mode 100644 arch/mips/include/asm/mach-jz4750d/war.h

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 7a51d87..1d7fea3 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -76,6 +76,7 @@
  */
 #define  MACH_INGENIC_JZ4730	0	/* JZ4730 SOC		*/
 #define  MACH_INGENIC_JZ4740	1	/* JZ4740 SOC		*/
+#define  MACH_INGENIC_JZ4750D	3	/* JZ4750D SOC		*/
 
 extern char *system_type;
 const char *get_system_type(void);
diff --git a/arch/mips/include/asm/mach-jz4750d/base.h b/arch/mips/include/asm/mach-jz4750d/base.h
new file mode 100644
index 0000000..723b1d0
--- /dev/null
+++ b/arch/mips/include/asm/mach-jz4750d/base.h
@@ -0,0 +1,12 @@
+#ifndef __ASM_MACH_JZ4750D_BASE_H__
+#define __ASM_MACH_JZ4750D_BASE_H__
+
+#define JZ4750D_CPM_BASE_ADDR	0x10000000
+#define JZ4750D_INTC_BASE_ADDR	0x10001000
+#define JZ4750D_WDT_BASE_ADDR	0x10002000
+#define JZ4750D_TCU_BASE_ADDR	0x10002010
+#define JZ4750D_RTC_BASE_ADDR	0x10003000
+#define JZ4750D_UART0_BASE_ADDR	0x10030000
+#define JZ4750D_UART1_BASE_ADDR	0x10031000
+
+#endif
diff --git a/arch/mips/include/asm/mach-jz4750d/war.h b/arch/mips/include/asm/mach-jz4750d/war.h
new file mode 100644
index 0000000..7bbad65
--- /dev/null
+++ b/arch/mips/include/asm/mach-jz4750d/war.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MIPS_MACH_JZ4750D_WAR_H
+#define __ASM_MIPS_MACH_JZ4750D_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_JZ4750D_WAR_H */
-- 
1.7.10.4
