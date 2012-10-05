Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2012 15:26:30 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:47879 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870299Ab2JENZwf6ked (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Oct 2012 15:25:52 +0200
Received: by mail-pb0-f49.google.com with SMTP id xa7so1954243pbc.36
        for <multiple recipients>; Fri, 05 Oct 2012 06:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=27tVH/vheEQkXqlh4yAreYZxuYgUCEUg/OghlaZ5mOg=;
        b=W5GXTwF8VxFIog8OUVpRBsJa10AgJYtAesSQ0rVvqQc+IgAYnQ5qmt/E36yubCriJL
         eI+graLobOX/MFEFmmH2DDpR4bbztM/pW3UPixalECizMh4Vavu9Ql3lFd5sWDDW2Uia
         sJDLPPudXJkyUFESjN5EFCDuC+wMgJ1Kxdj1PyPgKMgVSSk4v6p6XIe++8RVMKLhsjV7
         4x2yG4fRYmgeczokV1oBI4o3/LJ8zy9tGoy+SfrZeWg2696AVvsjWu+yg00wlMkrUU9S
         v3GB5Tc/YkaXIFeuSSmSUvtdIx7gEyj6P6D+XEbXycuDylsrfiLDmF7y5wLThK1uye6g
         hzqw==
Received: by 10.66.86.2 with SMTP id l2mr21730243paz.70.1349443546057;
        Fri, 05 Oct 2012 06:25:46 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id op7sm270211pbc.52.2012.10.05.06.25.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 06:25:45 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V7 01/15] MIPS: Loongson: Add basic Loongson-3 definition
Date:   Fri,  5 Oct 2012 21:24:58 +0800
Message-Id: <1349443512-18340-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1349443512-18340-1-git-send-email-chenhc@lemote.com>
References: <1349443512-18340-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Loongson-3 is a multi-core MIPS family CPU, it support MIPS64 fully.
Loongson-3 has the same IMP field (0x6300) as Loongson-2.

Loongson-3 has a hardware-maintained cache, system software doesn't
need to maintain coherency.

Loongson-3A is the first revision of Loongson-3, and it is the quad-
core version of Loongson-2G. Loongson-3A has a simplified version named
Loongson-2Gq, the main difference between Loongson-3A/2Gq is 3A has two
HyperTransport controller but 2Gq has only one. HT0 is used for cross-
chip interconnection and HT1 is used to link PCI bus. Therefore, 2Gq
cannot support NUMA but 3A can. For software, Loongson-2Gq is simply
identified as Loongson-3A.

Exsisting Loongson family CPUs:
Loongson-1: Loongson-1A, Loongson-1B, they are 32-bit MIPS CPUs.
Loongson-2: Loongson-2E, Loongson-2F, Loongson-2G, they are 64-bit
            single-core MIPS CPUs.
Loongson-3: Loongson-3A(including so-called Loongson-2Gq), they are
            64-bit multi-core MIPS CPUs.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/include/asm/addrspace.h            |    6 ++++++
 arch/mips/include/asm/cpu.h                  |    5 +++--
 arch/mips/include/asm/mach-loongson/spaces.h |   15 +++++++++++++++
 arch/mips/include/asm/module.h               |    2 ++
 arch/mips/include/asm/pgtable-bits.h         |    7 +++++++
 arch/mips/loongson/Platform                  |    1 +
 6 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/spaces.h

diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
index 569f80a..cf62bfb 100644
--- a/arch/mips/include/asm/addrspace.h
+++ b/arch/mips/include/asm/addrspace.h
@@ -116,7 +116,13 @@
 #define K_CALG_UNCACHED		2
 #define K_CALG_NONCOHERENT	3
 #define K_CALG_COH_EXCL		4
+
+#ifdef CONFIG_CPU_LOONGSON3
+#define K_CALG_COH_SHAREABLE	3
+#else
 #define K_CALG_COH_SHAREABLE	5
+#endif
+
 #define K_CALG_NOTUSED		6
 #define K_CALG_UNCACHED_ACCEL	7
 
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index f21b7c0..92a33cf 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -200,6 +200,7 @@
 #define PRID_REV_LOONGSON1B	0x0020
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
+#define PRID_REV_LOONGSON3A	0x0005
 
 /*
  * Older processors used to encode processor version and revision in two
@@ -268,8 +269,8 @@ enum cpu_type_enum {
 	 * MIPS64 class processors
 	 */
 	CPU_5KC, CPU_5KE, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
-	CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS, CPU_CAVIUM_OCTEON2,
-	CPU_XLR, CPU_XLP,
+	CPU_LOONGSON3, CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS,
+	CPU_CAVIUM_OCTEON2, CPU_XLR, CPU_XLP,
 
 	CPU_LAST
 };
diff --git a/arch/mips/include/asm/mach-loongson/spaces.h b/arch/mips/include/asm/mach-loongson/spaces.h
new file mode 100644
index 0000000..1e82804
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/spaces.h
@@ -0,0 +1,15 @@
+#ifndef __ASM_MACH_LOONGSON_SPACES_H_
+#define __ASM_MACH_LOONGSON_SPACES_H_
+
+#ifndef CAC_BASE
+#if defined(CONFIG_64BIT)
+#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_CPU_LOONGSON3)
+#define CAC_BASE        _AC(0x9800000000000000, UL)
+#else
+#define CAC_BASE        _AC(0xa800000000000000, UL)
+#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_CPU_LOONGSON3 */
+#endif /* CONFIG_64BIT */
+#endif /* CONFIG_CAC_BASE */
+
+#include <asm/mach-generic/spaces.h>
+#endif
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index dca8bce..523600f 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -122,6 +122,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "LOONGSON1 "
 #elif defined CONFIG_CPU_LOONGSON2
 #define MODULE_PROC_FAMILY "LOONGSON2 "
+#elif defined CONFIG_CPU_LOONGSON3
+#define MODULE_PROC_FAMILY "LOONGSON3 "
 #elif defined CONFIG_CPU_CAVIUM_OCTEON
 #define MODULE_PROC_FAMILY "OCTEON "
 #elif defined CONFIG_CPU_XLR
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index e9fe7e9..1afd39a 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -206,6 +206,13 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 #define _CACHE_UNCACHED		    _CACHE_UC_B
 #define _CACHE_CACHABLE_NONCOHERENT _CACHE_WB
 
+#elif defined(CONFIG_CPU_LOONGSON3)
+
+#define _CACHE_UNCACHED             (2<<_CACHE_SHIFT)  /* LOONGSON       */
+#define _CACHE_CACHABLE_NONCOHERENT (3<<_CACHE_SHIFT)  /* LOONGSON       */
+#define _CACHE_CACHABLE_COHERENT    (3<<_CACHE_SHIFT)  /* LOONGSON-3     */
+#define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)  /* LOONGSON       */
+
 #else
 
 #define _CACHE_CACHABLE_NO_WA	    (0<<_CACHE_SHIFT)  /* R4600 only      */
diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
index 29692e5..6205372 100644
--- a/arch/mips/loongson/Platform
+++ b/arch/mips/loongson/Platform
@@ -30,3 +30,4 @@ platform-$(CONFIG_MACH_LOONGSON) += loongson/
 cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson -mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
 load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
+load-$(CONFIG_CPU_LOONGSON3) += 0xffffffff80200000
-- 
1.7.7.3
