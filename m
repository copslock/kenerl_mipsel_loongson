Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 17:16:08 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:54539 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008821AbbCTQPv3Txtq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2015 17:15:51 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 20 Mar
 2015 19:15:46 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/3] MIPS: OCTEON: Add mach-cavium-octeon/mangle-port.h
Date:   Fri, 20 Mar 2015 19:11:57 +0300
Message-ID: <1426867920-7907-3-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1426867920-7907-1-git-send-email-aleksey.makarov@auriga.com>
References: <1426867920-7907-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

From: David Daney <david.daney@cavium.com>

Needed for little-endian ioport access.
This fixes NOR flash in little-endian mode

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 .../include/asm/mach-cavium-octeon/mangle-port.h   | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/mangle-port.h

diff --git a/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h b/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h
new file mode 100644
index 0000000..374eefa
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h
@@ -0,0 +1,74 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003, 2004 Ralf Baechle
+ */
+#ifndef __ASM_MACH_GENERIC_MANGLE_PORT_H
+#define __ASM_MACH_GENERIC_MANGLE_PORT_H
+
+#include <asm/byteorder.h>
+
+#ifdef __BIG_ENDIAN
+
+# define __swizzle_addr_b(port)	(port)
+# define __swizzle_addr_w(port)	(port)
+# define __swizzle_addr_l(port)	(port)
+# define __swizzle_addr_q(port)	(port)
+
+#else /* __LITTLE_ENDIAN */
+
+static inline bool __should_swizzle_addr(unsigned long p)
+{
+	/* boot bus? */
+	return ((p >> 40) & 0xff) == 0;
+}
+
+# define __swizzle_addr_b(port)	\
+	(__should_swizzle_addr(port) ? (port) ^ 7 : (port))
+# define __swizzle_addr_w(port)	\
+	(__should_swizzle_addr(port) ? (port) ^ 6 : (port))
+# define __swizzle_addr_l(port)	\
+	(__should_swizzle_addr(port) ? (port) ^ 4 : (port))
+# define __swizzle_addr_q(port)	(port)
+
+#endif /* __BIG_ENDIAN */
+
+/*
+ * Sane hardware offers swapping of PCI/ISA I/O space accesses in hardware;
+ * less sane hardware forces software to fiddle with this...
+ *
+ * Regardless, if the host bus endianness mismatches that of PCI/ISA, then
+ * you can't have the numerical value of data and byte addresses within
+ * multibyte quantities both preserved at the same time.  Hence two
+ * variations of functions: non-prefixed ones that preserve the value
+ * and prefixed ones that preserve byte addresses.  The latters are
+ * typically used for moving raw data between a peripheral and memory (cf.
+ * string I/O functions), hence the "__mem_" prefix.
+ */
+#if defined(CONFIG_SWAP_IO_SPACE)
+
+# define ioswabb(a, x)		(x)
+# define __mem_ioswabb(a, x)	(x)
+# define ioswabw(a, x)		le16_to_cpu(x)
+# define __mem_ioswabw(a, x)	(x)
+# define ioswabl(a, x)		le32_to_cpu(x)
+# define __mem_ioswabl(a, x)	(x)
+# define ioswabq(a, x)		le64_to_cpu(x)
+# define __mem_ioswabq(a, x)	(x)
+
+#else
+
+# define ioswabb(a, x)		(x)
+# define __mem_ioswabb(a, x)	(x)
+# define ioswabw(a, x)		(x)
+# define __mem_ioswabw(a, x)	cpu_to_le16(x)
+# define ioswabl(a, x)		(x)
+# define __mem_ioswabl(a, x)	cpu_to_le32(x)
+# define ioswabq(a, x)		(x)
+# define __mem_ioswabq(a, x)	cpu_to_le32(x)
+
+#endif
+
+#endif /* __ASM_MACH_GENERIC_MANGLE_PORT_H */
-- 
2.3.3
