Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jul 2016 04:45:20 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43652 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992256AbcGICpMgdsBj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Jul 2016 04:45:12 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <steven.hill@cavium.com>)
        id 1bLiAj-0002w4-Nt; Fri, 08 Jul 2016 21:39:13 -0500
Subject: [PATCH] MIPS: OCTEON: Changes to support readq()/writeq() usage.
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
From:   "Steven J. Hill" <steven.hill@cavium.com>
Message-ID: <5780652D.2030604@cavium.com>
Date:   Fri, 8 Jul 2016 21:45:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <steven.hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

Update OCTEON port mangling code to support readq() and
writeq() functions to allow driver code to be more portable.
Updates also for word and long function pairs. We also
remove SWAP_IO_SPACE for OCTEON platforms as the function
macros are redundant with the new mangling code.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig                                  |  1 -
 arch/mips/cavium-octeon/setup.c                    | 20 ++++++++++-
 .../include/asm/mach-cavium-octeon/mangle-port.h   | 42 +++++++---------------
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ac91939..ab255dd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -880,7 +880,6 @@ config CAVIUM_OCTEON_SOC
 	select SYS_SUPPORTS_HOTPLUG_CPU if CPU_BIG_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_HAS_CPU_CAVIUM_OCTEON
-	select SWAP_IO_SPACE
 	select HW_HAS_PCI
 	select ZONE_DMA32
 	select HOLES_IN_ZONE
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 64f852b..cb16fcc 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -40,9 +40,27 @@
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/pci-octeon.h>
-#include <asm/octeon/cvmx-mio-defs.h>
 #include <asm/octeon/cvmx-rst-defs.h>
 
+/*
+ * TRUE for devices having registers with little-endian byte
+ * order, FALSE for registers with native-endian byte order.
+ * PCI mandates little-endian, USB and SATA are configuraable,
+ * but we chose little-endian for these.
+ */
+const bool octeon_should_swizzle_table[256] = {
+	[0x00] = true,	/* bootbus/CF */
+	[0x1b] = true,	/* PCI mmio window */
+	[0x1c] = true,	/* PCI mmio window */
+	[0x1d] = true,	/* PCI mmio window */
+	[0x1e] = true,	/* PCI mmio window */
+	[0x68] = true,	/* OCTEON III USB */
+	[0x69] = true,	/* OCTEON III USB */
+	[0x6c] = true,	/* OCTEON III SATA */
+	[0x6f] = true,	/* OCTEON II USB */
+};
+EXPORT_SYMBOL(octeon_should_swizzle_table);
+
 #ifdef CONFIG_PCI
 extern void pci_console_init(const char *arg);
 #endif
diff --git a/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h b/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h
index 374eefa..0cf5ac1 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h
@@ -12,6 +12,14 @@
 
 #ifdef __BIG_ENDIAN
 
+static inline bool __should_swizzle_bits(volatile void *a)
+{
+	extern const bool octeon_should_swizzle_table[];
+
+	unsigned long did = ((unsigned long)a >> 40) & 0xff;
+	return octeon_should_swizzle_table[did];
+}
+
 # define __swizzle_addr_b(port)	(port)
 # define __swizzle_addr_w(port)	(port)
 # define __swizzle_addr_l(port)	(port)
@@ -19,6 +27,8 @@
 
 #else /* __LITTLE_ENDIAN */
 
+#define __should_swizzle_bits(a)	false
+
 static inline bool __should_swizzle_addr(unsigned long p)
 {
 	/* boot bus? */
@@ -35,40 +45,14 @@ static inline bool __should_swizzle_addr(unsigned long p)
 
 #endif /* __BIG_ENDIAN */
 
-/*
- * Sane hardware offers swapping of PCI/ISA I/O space accesses in hardware;
- * less sane hardware forces software to fiddle with this...
- *
- * Regardless, if the host bus endianness mismatches that of PCI/ISA, then
- * you can't have the numerical value of data and byte addresses within
- * multibyte quantities both preserved at the same time.  Hence two
- * variations of functions: non-prefixed ones that preserve the value
- * and prefixed ones that preserve byte addresses.  The latters are
- * typically used for moving raw data between a peripheral and memory (cf.
- * string I/O functions), hence the "__mem_" prefix.
- */
-#if defined(CONFIG_SWAP_IO_SPACE)
 
 # define ioswabb(a, x)		(x)
 # define __mem_ioswabb(a, x)	(x)
-# define ioswabw(a, x)		le16_to_cpu(x)
+# define ioswabw(a, x)		(__should_swizzle_bits(a) ? le16_to_cpu(x) : x)
 # define __mem_ioswabw(a, x)	(x)
-# define ioswabl(a, x)		le32_to_cpu(x)
+# define ioswabl(a, x)		(__should_swizzle_bits(a) ? le32_to_cpu(x) : x)
 # define __mem_ioswabl(a, x)	(x)
-# define ioswabq(a, x)		le64_to_cpu(x)
+# define ioswabq(a, x)		(__should_swizzle_bits(a) ? le64_to_cpu(x) : x)
 # define __mem_ioswabq(a, x)	(x)
 
-#else
-
-# define ioswabb(a, x)		(x)
-# define __mem_ioswabb(a, x)	(x)
-# define ioswabw(a, x)		(x)
-# define __mem_ioswabw(a, x)	cpu_to_le16(x)
-# define ioswabl(a, x)		(x)
-# define __mem_ioswabl(a, x)	cpu_to_le32(x)
-# define ioswabq(a, x)		(x)
-# define __mem_ioswabq(a, x)	cpu_to_le32(x)
-
-#endif
-
 #endif /* __ASM_MACH_GENERIC_MANGLE_PORT_H */
-- 
1.9.1
