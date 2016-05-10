Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 00:50:10 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:53723 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028773AbcEJWuIx4A1d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 May 2016 00:50:08 +0200
Received: from [2001:bc8:30d7:121:cc44:2c6c:4d9c:42c0] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <aurelien@aurel32.net>)
        id 1b0GTe-0001qG-24; Wed, 11 May 2016 00:50:06 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.87)
        (envelope-from <aurelien@aurel32.net>)
        id 1b0GTd-0004ZQ-Df; Wed, 11 May 2016 00:50:05 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@linux-mips.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2] MIPS: Octeon: detect and fix byte swapped initramfs
Date:   Wed, 11 May 2016 00:50:03 +0200
Message-Id: <1462920603-17512-1-git-send-email-aurelien@aurel32.net>
X-Mailer: git-send-email 2.8.1
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

Octeon machines support running in little endian mode. U-Boot usually
runs in big endian-mode. Therefore the initramfs is loaded in big endian
mode, and the kernel later tries to access it in little endian mode.

This patch fixes that by detecting byte swapped initramfs using either the
CPIO header or the header from standard compression methods, and
byte swaps it if needed. It first checks that the header doesn't match
in the native endianness to avoid false detections. It uses the kernel
decompress library so that we don't have to maintain the list of magics
if some decompression methods are added to the kernel.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/kernel/setup.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4f60734..8841d7982 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -26,6 +26,7 @@
 #include <linux/sizes.h>
 #include <linux/device.h>
 #include <linux/dma-contiguous.h>
+#include <linux/decompress/generic.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -250,6 +251,35 @@ disable:
 	return 0;
 }
 
+/* In some conditions (e.g. big endian bootloader with a little endian
+   kernel), the initrd might appear byte swapped.  Try to detect this and
+   byte swap it if needed.  */
+static void __init maybe_bswap_initrd(void)
+{
+#if defined(CONFIG_CPU_CAVIUM_OCTEON)
+	u64 buf;
+
+	/* Check for CPIO signature */
+	if (!memcmp((void *)initrd_start, "070701", 6))
+		return;
+
+	/* Check for compressed initrd */
+	if (decompress_method((unsigned char *)initrd_start, 8, NULL))
+		return;
+
+	/* Try again with a byte swapped header */
+	buf = swab64p((u64 *)initrd_start);
+	if (!memcmp(&buf, "070701", 6) ||
+	    decompress_method((unsigned char *)(&buf), 8, NULL)) {
+		unsigned long i;
+
+		pr_info("Byteswapped initrd detected\n");
+		for (i = initrd_start; i < ALIGN(initrd_end, 8); i += 8)
+			swab64s((u64 *)i);
+	}
+#endif
+}
+
 static void __init finalize_initrd(void)
 {
 	unsigned long size = initrd_end - initrd_start;
@@ -263,6 +293,8 @@ static void __init finalize_initrd(void)
 		goto disable;
 	}
 
+	maybe_bswap_initrd();
+
 	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
 	initrd_below_start_ok = 1;
 
-- 
2.8.1
