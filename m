Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2017 19:57:43 +0200 (CEST)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:33493
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993868AbdC1R5grkSZc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Mar 2017 19:57:36 +0200
Received: by mail-qk0-x241.google.com with SMTP id p22so13453578qka.0;
        Tue, 28 Mar 2017 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RE2oqDhbmG4XCFJzeYAU2dqDHqe8DhE4j0VgDuNDh20=;
        b=sThLNyhOmWRH4l/GACC8bb1Cxj5344DH3Ar9dQcHuTOi82xZj4jtCT04Fm7rMJXhoI
         bohCHFAHXvStNDUrvvEVN9iPl1xmjvcfweMGF6XsxuPLEVtHbsmmbYtdrDYJJLRMN/Iv
         3vQBAfQp1dCeJizrh3mJbcDzbYp78Owh/l9c34rnNr5J0UuxhtN32iz3I+fYWNWTrgkF
         b54mUDdinauEg4QDH+8IdaDMSbIta23e1taH0ywJZStq+DntYVolGTs85Ibc6Oa+kCWO
         gjUTVtU4Jp0Ms61sJcxdT7oYyp4blDV9iB5pajniGv7X6q6LthVqMmnM9lgye6mJUS4E
         UHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RE2oqDhbmG4XCFJzeYAU2dqDHqe8DhE4j0VgDuNDh20=;
        b=sqomc/7e09KnJjSugD1B3Cix5rwXOs0wfot7zJ5DEX6+cE0QuD2TihmKZ8TT7SnXuW
         J+xLzJbITUQj9c/jGi+v5+EGSH+yBwUDEfMamMS5Kjgw0JLBzxaq3/obiZaD+vRD5wN0
         73ujC5ke5qyP0KMvNcDd5TTV0GRMq5tTgpn0ZMLjqBZR3aPkSOwdo9pNCTo/dZiSGep4
         vxo/FNSGpnnoKQaVfU0W+zFFKoBmaLjfcILCDRX2jFYU7NBSUwesHN8Duoo1yCTjcaAb
         qM6LE11wWho601yvFN+htUVPyL+57TnADRk9VJIBJ7NRHHtWzgr2PVB6UVdT7fbGcqcF
         n8LQ==
X-Gm-Message-State: AFeK/H3kalFy3XUV430jeQodPDR2kQbFCWqwqOHqz9XgT9CgA3HSwI6cX3S9wjTlP8YM0Q==
X-Received: by 10.55.200.68 with SMTP id c65mr23877409qkj.179.1490723850237;
        Tue, 28 Mar 2017 10:57:30 -0700 (PDT)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id q188sm3125377qkf.20.2017.03.28.10.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2017 10:57:29 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com,
        paul.burton@imgtec.com, james.hogan@imgtec.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: Add support for CONFIG_DEBUG_VIRTUAL
Date:   Tue, 28 Mar 2017 10:57:18 -0700
Message-Id: <20170328175718.28629-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Provide hooks to intercept bad usages of virt_to_phys() and
__pa_symbol() throughout the kernel. To make this possible, we need to
rename the current implement of virt_to_phys() into
__virt_to_phys_nodebug() and wrap it around depending on
CONFIG_DEBUG_VIRTUAL.

A similar thing is needed for __pa_symbol() which is now aliased to
__phys_addr_symbol() whose implementation is either the direct return of
RELOC_HIDE or goes through the debug version.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/Kconfig            |  1 +
 arch/mips/include/asm/io.h   | 14 +++++++++++++-
 arch/mips/include/asm/page.h |  9 ++++++++-
 arch/mips/mm/Makefile        |  2 ++
 arch/mips/mm/physaddr.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/mm/physaddr.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2afb41c52ba0..724457b5a7eb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -70,6 +70,7 @@ config MIPS
 	select HAVE_EXIT_THREAD
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_ARCH_HARDENED_USERCOPY
+	select ARCH_HAS_DEBUG_VIRTUAL
 
 menu "Machine selection"
 
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index ecabc00c1e66..016e12161c9d 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -116,11 +116,23 @@ static inline void set_io_port_base(unsigned long base)
  *     almost all conceivable cases a device driver should not be using
  *     this function
  */
-static inline unsigned long virt_to_phys(volatile const void *address)
+static inline unsigned long __virt_to_phys_nodebug(volatile const void *address)
 {
 	return __pa(address);
 }
 
+#ifdef CONFIG_DEBUG_VIRTUAL
+extern phys_addr_t __virt_to_phys(volatile const void *x);
+#else
+#define __virt_to_phys(x)	__virt_to_phys_nodebug(x)
+#endif
+
+#define virt_to_phys virt_to_phys
+static inline phys_addr_t virt_to_phys(const volatile void *x)
+{
+	return __virt_to_phys(x);
+}
+
 /*
  *     phys_to_virt    -       map physical address to virtual
  *     @address: address to remap
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 5f987598054f..bf8bd7d77fce 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -205,9 +205,16 @@ static inline unsigned long ___pa(unsigned long x)
  * until GCC 3.x has been retired before we can apply
  * https://patchwork.linux-mips.org/patch/1541/
  */
+#define __pa_symbol_nodebug(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
+
+#ifdef CONFIG_DEBUG_VIRTUAL
+extern phys_addr_t __phys_addr_symbol(unsigned long x);
+#else
+#define __phys_addr_symbol(x)	__pa_symbol_nodebug(x)
+#endif
 
 #ifndef __pa_symbol
-#define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
+#define __pa_symbol(x)		__phys_addr_symbol((unsigned long)(x))
 #endif
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index b4cc8811a664..0a1d241c50fb 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -29,3 +29,5 @@ obj-$(CONFIG_R5000_CPU_SCACHE)	+= sc-r5k.o
 obj-$(CONFIG_RM7000_CPU_SCACHE) += sc-rm7k.o
 obj-$(CONFIG_MIPS_CPU_SCACHE)	+= sc-mips.o
 obj-$(CONFIG_SCACHE_DEBUGFS)	+= sc-debugfs.o
+
+obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
new file mode 100644
index 000000000000..6123a9b3b3c0
--- /dev/null
+++ b/arch/mips/mm/physaddr.c
@@ -0,0 +1,40 @@
+#include <linux/bug.h>
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/mmdebug.h>
+#include <linux/mm.h>
+
+#include <asm/sections.h>
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/dma.h>
+
+static inline bool __debug_virt_addr_valid(unsigned long x)
+{
+	if (x >= PAGE_OFFSET && x < (unsigned long)high_memory)
+		return true;
+
+	return false;
+}
+
+phys_addr_t __virt_to_phys(volatile const void *x)
+{
+	WARN(!__debug_virt_addr_valid((unsigned long)x),
+	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
+	     x, x);
+
+	return __virt_to_phys_nodebug(x);
+}
+EXPORT_SYMBOL(__virt_to_phys);
+
+phys_addr_t __phys_addr_symbol(unsigned long x)
+{
+	/* This is bounds checking against the kernel image only.
+	 * __pa_symbol should only be used on kernel symbol addresses.
+	 */
+	VIRTUAL_BUG_ON(x < (unsigned long)_text ||
+		       x > (unsigned long)_end);
+
+	return __pa_symbol_nodebug(x);
+}
+EXPORT_SYMBOL(__phys_addr_symbol);
-- 
2.9.3
