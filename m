Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 14:47:50 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:32907 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823068Ab3DOMreQw0DU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 14:47:34 +0200
Received: by mail-pd0-f177.google.com with SMTP id u11so2464959pdi.22
        for <multiple recipients>; Mon, 15 Apr 2013 05:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=yoyUWf3lUw4G2GHPALFgQVXiuId85Oi2z7LYm1lSxNU=;
        b=uDj6YVt4/xoIoW36YUxWi3jC8UryVSU2Z1PYAxEYYGnZbIAyj/eWTLh3JvXwsXvdkP
         OP2u14efk++IsSx1cuJxNk2dQnGUo2oQo6q0AIe5sQpoovWKtBKcu15Fw7XCufIEDj9W
         lBHjRjYLUqQcZmAfVWflTK9fYKtuyJTUSchycH1zhuPD8eNYeAhzDotD04noSQn74cxv
         yoHhsVWoqhFpchnXuL/a2nyAqE5QJJe7u3NQC5h5qgCRjVmU64/HwxCz1rTxysWdPkSd
         F9WNsPWqLgFyFgy3oRmZXBGauy+S9ia4vPaX4xeAVWwT0S7jb5PxRc2lwDfUoLrNFzp6
         mLog==
X-Received: by 10.68.43.35 with SMTP id t3mr29129499pbl.202.1366030047245;
        Mon, 15 Apr 2013 05:47:27 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id xz4sm20242580pbb.18.2013.04.15.05.47.23
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 05:47:26 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V10 01/13] MIPS: Loongson: Add basic Loongson-3 definition
Date:   Mon, 15 Apr 2013 20:46:56 +0800
Message-Id: <1366030028-5084-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36182
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
index 13d61c0..fdbadf3 100644
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
index dd86ab2..82fa73a 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -202,6 +202,7 @@
 #define PRID_REV_LOONGSON1B	0x0020
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
+#define PRID_REV_LOONGSON3A	0x0005
 
 /*
  * Older processors used to encode processor version and revision in two
@@ -271,8 +272,8 @@ enum cpu_type_enum {
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
index 44b705d..c2edae3 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -126,6 +126,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "LOONGSON1 "
 #elif defined CONFIG_CPU_LOONGSON2
 #define MODULE_PROC_FAMILY "LOONGSON2 "
+#elif defined CONFIG_CPU_LOONGSON3
+#define MODULE_PROC_FAMILY "LOONGSON3 "
 #elif defined CONFIG_CPU_CAVIUM_OCTEON
 #define MODULE_PROC_FAMILY "OCTEON "
 #elif defined CONFIG_CPU_XLR
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 32aea48..6c1e99e 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -235,6 +235,13 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 #define _CACHE_CACHABLE_NONCOHERENT (5<<_CACHE_SHIFT)
 #define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)
 
+#elif defined(CONFIG_CPU_LOONGSON3)
+
+#define _CACHE_UNCACHED             (2<<_CACHE_SHIFT)  /* LOONGSON       */
+#define _CACHE_CACHABLE_NONCOHERENT (3<<_CACHE_SHIFT)  /* LOONGSON       */
+#define _CACHE_CACHABLE_COHERENT    (3<<_CACHE_SHIFT)  /* LOONGSON-3     */
+#define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)  /* LOONGSON       */
+
 #else
 
 #define _CACHE_CACHABLE_NO_WA	    (0<<_CACHE_SHIFT)  /* R4600 only	  */
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
