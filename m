Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2018 13:16:58 +0200 (CEST)
Received: from mail-wr1-x442.google.com ([IPv6:2a00:1450:4864:20::442]:37706
        "EHLO mail-wr1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993016AbeIZLQocqCZW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2018 13:16:44 +0200
Received: by mail-wr1-x442.google.com with SMTP id u12-v6so26546519wrr.4;
        Wed, 26 Sep 2018 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xx99jVZLZXUYVYHjjp6BuWi1q2AI/wc9YpluOvrunK4=;
        b=bD4/d/dcMatxAPIXuQO53EtRDtE3lGTdb+q8LAt3XfVo3/OxJJgabyq5Lq+iYjm7WC
         3Z6USGaMYK95yuzpJoEsgLRH+4NsLhJQ8q+9nXqiYSw1SvxellPteWHrapBNMdN2FWln
         ok9sJixaN99kC1leehZZ0nabHrXmuC/jwuJc3ITqM8PJA4I21yj7dD956UlsxHaQE90+
         NxQViEl8Hazbl0bj3HuV+8/p50MKZd/rt89g8l4BvH6mhB/a0EQ+zV9s80QZxFpkORZC
         9eahOSlyvJdcFd4D0ClzsJEado0eCzhTl8ZqvegmQixVv3WRRJ5WxyKjdYr68CdCGKpi
         IuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xx99jVZLZXUYVYHjjp6BuWi1q2AI/wc9YpluOvrunK4=;
        b=PIEOMVGDDhHtL125UyeyTpwvuLUOp5XGHyoDi2IRYl4KbWkI1AryCSo5s9bDAMLDOU
         pGllATKd7XBDmVcssj8uYi9LSQwbw4qsMPmoaMjVazCTM8wY2ufAd5zaa68FSpb5Jej5
         CkGdIzMnk0QC5tYL5hYMiAerRHk+9Vkky1oWyPLmD3XWIFtLF3fSCw2dyP4vl+wzxozD
         Stj5kzyJWkAYymNSmXyxinwXm4UUMyIFlY+MFFDhu7Hc1jdPPzO0weBkxQjpBZdVyVLL
         /7QN2qJPC2CSkLJH6avA6rU6GftFJFmLKdh3Zar04AKygvS7o4vLM2WNaz6CYUxgQ/oB
         owKA==
X-Gm-Message-State: ABuFfohsPpjSEJ5g/X6siGUrE+uyT348Qt30AwjD0IDQBJqARIPOiquq
        BwYGSzfGE1p4ggsuCwZXIwCE7t0JAiU=
X-Google-Smtp-Source: ACcGV63u+ZUes7jkRPzBKrH9NcbwdwANr28jW3Kti/Pei3Epxzzb5EJ3oeyKw0VuXUIHXcQ3EaB+bA==
X-Received: by 2002:a5d:4143:: with SMTP id c3-v6mr4547550wrq.61.1537960598704;
        Wed, 26 Sep 2018 04:16:38 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id r64-v6sm3885724wme.42.2018.09.26.04.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 04:16:38 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] MIPS: Add Kconfig variable for CPUs with unaligned load/store instructions
Date:   Wed, 26 Sep 2018 14:16:15 +0300
Message-Id: <20180926111615.6780-2-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926111615.6780-1-yasha.che3@gmail.com>
References: <20180926111615.6780-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

MIPSR6 CPUs do not support unaligned load/store instructions
(LWL, LWR, SWL, SWR and LDL, LDR, SDL, SDR for 64bit).

Currently the MIPS tree has some special cases to avoid these
instructions, and the code is testing for !CONFIG_CPU_MIPSR6.

This patch declares a new Kconfig variable:
CONFIG_CPU_HAS_LOAD_STORE_LR.
This variable indicates that the CPU supports these instructions.

Then, the patch does the following:
- Carefully selects this option on all CPUs except MIPSR6.
- Switches all the special cases to test for the new variable,
  and inverts the logic:
    '#ifndef CONFIG_CPU_MIPSR6' turns into
    '#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR'
    and vice-versa.

Also, when this variable is NOT selected (e.g. MIPSR6),
CONFIG_GENERIC_CSUM will default to 'y', to compile generic
C checksum code (instead of special assembly code that uses the
unsupported instructions).

This commit should not affect any existing CPU, and is required
for future Lexra CPU support, that misses these instructions too.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/Kconfig            | 35 +++++++++++++++++++++++++--
 arch/mips/kernel/unaligned.c | 47 ++++++++++++++++++------------------
 arch/mips/lib/memcpy.S       | 10 ++++----
 arch/mips/lib/memset.S       | 12 ++++-----
 4 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35511999156a..a81811b67ab3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1148,6 +1148,7 @@ config NO_IOPORT_MAP
 
 config GENERIC_CSUM
 	bool
+	default y if !CPU_HAS_LOAD_STORE_LR
 
 config GENERIC_ISA_DMA
 	bool
@@ -1366,6 +1367,7 @@ config CPU_LOONGSON3
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
+	select CPU_HAS_LOAD_STORE_LR
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
 	select MIPS_PGD_C0_CONTEXT
@@ -1442,6 +1444,7 @@ config CPU_MIPS32_R1
 	bool "MIPS32 Release 1"
 	depends on SYS_HAS_CPU_MIPS32_R1
 	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	help
@@ -1459,6 +1462,7 @@ config CPU_MIPS32_R2
 	bool "MIPS32 Release 2"
 	depends on SYS_HAS_CPU_MIPS32_R2
 	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_MSA
@@ -1477,7 +1481,6 @@ config CPU_MIPS32_R6
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_MSA
-	select GENERIC_CSUM
 	select HAVE_KVM
 	select MIPS_O32_FP64_SUPPORT
 	help
@@ -1490,6 +1493,7 @@ config CPU_MIPS64_R1
 	bool "MIPS64 Release 1"
 	depends on SYS_HAS_CPU_MIPS64_R1
 	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
@@ -1509,6 +1513,7 @@ config CPU_MIPS64_R2
 	bool "MIPS64 Release 2"
 	depends on SYS_HAS_CPU_MIPS64_R2
 	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
@@ -1530,7 +1535,6 @@ config CPU_MIPS64_R6
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_MSA
-	select GENERIC_CSUM
 	select MIPS_O32_FP64_SUPPORT if 32BIT || MIPS32_O32
 	select HAVE_KVM
 	help
@@ -1543,6 +1547,7 @@ config CPU_R3000
 	bool "R3000"
 	depends on SYS_HAS_CPU_R3000
 	select CPU_HAS_WB
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	help
@@ -1557,12 +1562,14 @@ config CPU_TX39XX
 	bool "R39XX"
 	depends on SYS_HAS_CPU_TX39XX
 	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_HAS_LOAD_STORE_LR
 
 config CPU_VR41XX
 	bool "R41xx"
 	depends on SYS_HAS_CPU_VR41XX
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_HAS_LOAD_STORE_LR
 	help
 	  The options selects support for the NEC VR4100 series of processors.
 	  Only choose this option if you have one of these processors as a
@@ -1574,6 +1581,7 @@ config CPU_R4300
 	depends on SYS_HAS_CPU_R4300
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_HAS_LOAD_STORE_LR
 	help
 	  MIPS Technologies R4300-series processors.
 
@@ -1583,6 +1591,7 @@ config CPU_R4X00
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HUGEPAGES
+	select CPU_HAS_LOAD_STORE_LR
 	help
 	  MIPS Technologies R4000-series processors other than 4300, including
 	  the R4000, R4400, R4600, and 4700.
@@ -1591,6 +1600,7 @@ config CPU_TX49XX
 	bool "R49XX"
 	depends on SYS_HAS_CPU_TX49XX
 	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HUGEPAGES
@@ -1601,6 +1611,7 @@ config CPU_R5000
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HUGEPAGES
+	select CPU_HAS_LOAD_STORE_LR
 	help
 	  MIPS Technologies R5000-series processors other than the Nevada.
 
@@ -1610,6 +1621,7 @@ config CPU_R5432
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HUGEPAGES
+	select CPU_HAS_LOAD_STORE_LR
 
 config CPU_R5500
 	bool "R5500"
@@ -1617,6 +1629,7 @@ config CPU_R5500
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HUGEPAGES
+	select CPU_HAS_LOAD_STORE_LR
 	help
 	  NEC VR5500 and VR5500A series processors implement 64-bit MIPS IV
 	  instruction set.
@@ -1627,6 +1640,7 @@ config CPU_NEVADA
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HUGEPAGES
+	select CPU_HAS_LOAD_STORE_LR
 	help
 	  QED / PMC-Sierra RM52xx-series ("Nevada") processors.
 
@@ -1634,6 +1648,7 @@ config CPU_R8000
 	bool "R8000"
 	depends on SYS_HAS_CPU_R8000
 	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_64BIT_KERNEL
 	help
 	  MIPS Technologies R8000 processors.  Note these processors are
@@ -1643,6 +1658,7 @@ config CPU_R10000
 	bool "R10000"
 	depends on SYS_HAS_CPU_R10000
 	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
@@ -1654,6 +1670,7 @@ config CPU_RM7000
 	bool "RM7000"
 	depends on SYS_HAS_CPU_RM7000
 	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
@@ -1662,6 +1679,7 @@ config CPU_RM7000
 config CPU_SB1
 	bool "SB1"
 	depends on SYS_HAS_CPU_SB1
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
@@ -1672,6 +1690,7 @@ config CPU_CAVIUM_OCTEON
 	bool "Cavium Octeon processor"
 	depends on SYS_HAS_CPU_CAVIUM_OCTEON
 	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
@@ -1701,6 +1720,7 @@ config CPU_BMIPS
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_CPUFREQ
 	select MIPS_EXTERNAL_TIMER
 	help
@@ -1709,6 +1729,7 @@ config CPU_BMIPS
 config CPU_XLR
 	bool "Netlogic XLR SoC"
 	depends on SYS_HAS_CPU_XLR
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
@@ -1727,6 +1748,7 @@ config CPU_XLP
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
 	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_MIPSR2
 	select CPU_SUPPORTS_HUGEPAGES
 	select MIPS_ASID_BITS_VARIABLE
@@ -1832,12 +1854,14 @@ config CPU_LOONGSON2
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
 	select ARCH_HAS_PHYS_TO_DMA
+	select CPU_HAS_LOAD_STORE_LR
 
 config CPU_LOONGSON1
 	bool
 	select CPU_MIPS32
 	select CPU_MIPSR1
 	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_CPUFREQ
@@ -2451,6 +2475,13 @@ config XKS01
 config CPU_HAS_RIXI
 	bool
 
+config CPU_HAS_LOAD_STORE_LR
+	bool
+	help
+	  CPU has support for unaligned load and store instructions:
+	  LWL, LWR, SWL, SWR (Load/store word left/right).
+	  LDL, LDR, SDL, SDR (Load/store doubleword left/right, for 64bit systems).
+
 #
 # Vectored interrupt mode is an R2 feature
 #
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 2d0b912f9e3e..ce446eed62d2 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -130,7 +130,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR
 #define     _LoadW(addr, value, res, type)   \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -151,8 +151,8 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#else
-/* MIPSR6 has no lwl instruction */
+#else /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
+/* For CPUs without lwl instruction */
 #define     _LoadW(addr, value, res, type) \
 do {                                                        \
 		__asm__ __volatile__ (			    \
@@ -186,7 +186,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
 
 #define     _LoadHWU(addr, value, res, type) \
 do {                                                        \
@@ -212,7 +212,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR
 #define     _LoadWU(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -255,8 +255,8 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#else
-/* MIPSR6 has not lwl and ldl instructions */
+#else /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
+/* For CPUs without lwl and ldl instructions */
 #define	    _LoadWU(addr, value, res, type) \
 do {                                                        \
 		__asm__ __volatile__ (			    \
@@ -339,7 +339,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
 
 
 #define     _StoreHW(addr, value, res, type) \
@@ -365,7 +365,7 @@ do {                                                        \
 			: "r" (value), "r" (addr), "i" (-EFAULT));\
 } while(0)
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR
 #define     _StoreW(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -406,8 +406,7 @@ do {                                                        \
 		: "r" (value), "r" (addr), "i" (-EFAULT));  \
 } while(0)
 
-#else
-/* MIPSR6 has no swl and sdl instructions */
+#else /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
 #define     _StoreW(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -483,7 +482,7 @@ do {                                                        \
 		: "memory");                                \
 } while(0)
 
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
 
 #else /* __BIG_ENDIAN */
 
@@ -509,7 +508,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR
 #define     _LoadW(addr, value, res, type)   \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -530,8 +529,8 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#else
-/* MIPSR6 has no lwl instruction */
+#else  /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
+/* For CPUs without lwl instruction */
 #define     _LoadW(addr, value, res, type) \
 do {                                                        \
 		__asm__ __volatile__ (			    \
@@ -565,7 +564,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
 
 
 #define     _LoadHWU(addr, value, res, type) \
@@ -592,7 +591,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR
 #define     _LoadWU(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -635,8 +634,8 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#else
-/* MIPSR6 has not lwl and ldl instructions */
+#else /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
+/* For CPUs without lwl and ldl instructions */
 #define	    _LoadWU(addr, value, res, type) \
 do {                                                        \
 		__asm__ __volatile__ (			    \
@@ -718,7 +717,7 @@ do {                                                        \
 			: "=&r" (value), "=r" (res)	    \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
 
 #define     _StoreHW(addr, value, res, type) \
 do {                                                        \
@@ -743,7 +742,7 @@ do {                                                        \
 			: "r" (value), "r" (addr), "i" (-EFAULT));\
 } while(0)
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR
 #define     _StoreW(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -784,8 +783,8 @@ do {                                                        \
 		: "r" (value), "r" (addr), "i" (-EFAULT));  \
 } while(0)
 
-#else
-/* MIPSR6 has no swl and sdl instructions */
+#else /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
+/* For CPUs without swl and sdl instructions */
 #define     _StoreW(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -861,7 +860,7 @@ do {                                                        \
 		: "memory");                                \
 } while(0)
 
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
 #endif
 
 #define LoadHWU(addr, value, res)	_LoadHWU(addr, value, res, kernel)
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 03e3304d6ae5..207b320aa81d 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -297,7 +297,7 @@
 	 and	t0, src, ADDRMASK
 	PREFS(	0, 2*32(src) )
 	PREFD(	1, 2*32(dst) )
-#ifndef CONFIG_CPU_MIPSR6
+#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR
 	bnez	t1, .Ldst_unaligned\@
 	 nop
 	bnez	t0, .Lsrc_unaligned_dst_aligned\@
@@ -385,7 +385,7 @@
 	bne	rem, len, 1b
 	.set	noreorder
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR
 	/*
 	 * src and dst are aligned, need to copy rem bytes (rem < NBYTES)
 	 * A loop would do only a byte at a time with possible branch
@@ -487,7 +487,7 @@
 	bne	len, rem, 1b
 	.set	noreorder
 
-#endif /* !CONFIG_CPU_MIPSR6 */
+#endif /* CONFIG_CPU_HAS_LOAD_STORE_LR */
 .Lcopy_bytes_checklen\@:
 	beqz	len, .Ldone\@
 	 nop
@@ -516,7 +516,7 @@
 	jr	ra
 	 nop
 
-#ifdef CONFIG_CPU_MIPSR6
+#ifndef CONFIG_CPU_HAS_LOAD_STORE_LR
 .Lcopy_unaligned_bytes\@:
 1:
 	COPY_BYTE(0)
@@ -530,7 +530,7 @@
 	ADD	src, src, 8
 	b	1b
 	 ADD	dst, dst, 8
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
 	.if __memcpy == 1
 	END(memcpy)
 	.set __memcpy, 0
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 3a6f34ef5ffc..fd37f718bb1f 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -112,7 +112,7 @@
 	.set		at
 #endif
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR
 	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
 	EX(LONG_S_L, a1, (a0), .Lfirst_fixup\@)	/* make word/dword aligned */
@@ -122,7 +122,7 @@
 	PTR_SUBU	a0, t0			/* long align ptr */
 	PTR_ADDU	a2, t0			/* correct size */
 
-#else /* CONFIG_CPU_MIPSR6 */
+#else /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
 #define STORE_BYTE(N)				\
 	EX(sb, a1, N(a0), .Lbyte_fixup\@);	\
 	beqz		t0, 0f;			\
@@ -145,7 +145,7 @@
 	ori		a0, STORMASK
 	xori		a0, STORMASK
 	PTR_ADDIU	a0, STORSIZE
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
 1:	ori		t1, a2, 0x3f		/* # of full blocks */
 	xori		t1, 0x3f
 	beqz		t1, .Lmemset_partial\@	/* no block to fill */
@@ -185,7 +185,7 @@
 	andi		a2, STORMASK		/* At most one long to go */
 
 	beqz		a2, 1f
-#ifndef CONFIG_CPU_MIPSR6
+#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR
 	 PTR_ADDU	a0, a2			/* What's left */
 	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
@@ -230,7 +230,7 @@
 	.hidden __memset
 	.endif
 
-#ifdef CONFIG_CPU_MIPSR6
+#ifndef CONFIG_CPU_HAS_LOAD_STORE_LR
 .Lbyte_fixup\@:
 	/*
 	 * unset_bytes = (#bytes - (#unaligned bytes)) - (-#unaligned bytes remaining + 1) + 1
@@ -239,7 +239,7 @@
 	PTR_SUBU	a2, t0
 	jr		ra
 	 PTR_ADDIU	a2, 1
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* !CONFIG_CPU_HAS_LOAD_STORE_LR */
 
 .Lfirst_fixup\@:
 	/* unset_bytes already in a2 */
-- 
2.19.0
