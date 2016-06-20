Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2016 11:28:17 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:59770 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27043113AbcFTJ14LbIhT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Jun 2016 11:27:56 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 070D4B91CE6;
        Mon, 20 Jun 2016 11:27:55 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-007-040.088.073.pools.vodafone-ip.de [88.73.7.40])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 4BAD6B91CB2;
        Mon, 20 Jun 2016 11:27:40 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alban Bedel <albeu@free.fr>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH v2 1/2] MIPS: ZBOOT: copy appended dtb to the end of the kernel
Date:   Mon, 20 Jun 2016 11:27:36 +0200
Message-Id: <1466414857-30456-2-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1466414857-30456-1-git-send-email-jogo@openwrt.org>
References: <1466414857-30456-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Instead of rewriting the arguments, just move the appended dtb to where
the decompressed kernel expects it. This eliminates the need for special
casing vmlinuz.bin appended dtb files.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
v1 -> v2:
 * drop #ifdefs and use IS_ENABLED
 * drop accidentally added empty line

 arch/mips/Kconfig                      | 22 ++--------------------
 arch/mips/boot/compressed/decompress.c | 17 +++++++++++++++++
 arch/mips/boot/compressed/head.S       | 16 ----------------
 3 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ac91939..0d0f71e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2885,10 +2885,10 @@ choice
 		  the documented boot protocol using a device tree.
 
 	config MIPS_RAW_APPENDED_DTB
-		bool "vmlinux.bin"
+		bool "vmlinux.bin or vmlinuz.bin"
 		help
 		  With this option, the boot code will look for a device tree binary
-		  DTB) appended to raw vmlinux.bin (without decompressor).
+		  DTB) appended to raw vmlinux.bin or vmlinuz.bin.
 		  (e.g. cat vmlinux.bin <filename>.dtb > vmlinux_w_dtb).
 
 		  This is meant as a backward compatibility convenience for those
@@ -2900,24 +2900,6 @@ choice
 		  look like a DTB header after a reboot if no actual DTB is appended
 		  to vmlinux.bin.  Do not leave this option active in a production kernel
 		  if you don't intend to always append a DTB.
-
-	config MIPS_ZBOOT_APPENDED_DTB
-		bool "vmlinuz.bin"
-		depends on SYS_SUPPORTS_ZBOOT
-		help
-		  With this option, the boot code will look for a device tree binary
-		  DTB) appended to raw vmlinuz.bin (with decompressor).
-		  (e.g. cat vmlinuz.bin <filename>.dtb > vmlinuz_w_dtb).
-
-		  This is meant as a backward compatibility convenience for those
-		  systems with a bootloader that can't be upgraded to accommodate
-		  the documented boot protocol using a device tree.
-
-		  Beware that there is very little in terms of protection against
-		  this option being confused by leftover garbage in memory that might
-		  look like a DTB header after a reboot if no actual DTB is appended
-		  to vmlinuz.bin.  Do not leave this option active in a production kernel
-		  if you don't intend to always append a DTB.
 endchoice
 
 choice
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 080cd53..fdf99e9 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/libfdt.h>
 
 #include <asm/addrspace.h>
 
@@ -36,6 +37,8 @@ extern void puthex(unsigned long long val);
 #define puthex(val) do {} while (0)
 #endif
 
+extern char __appended_dtb[];
+
 void error(char *x)
 {
 	puts("\n\n");
@@ -114,6 +117,20 @@ void decompress_kernel(unsigned long boot_heap_start)
 	__decompress((char *)zimage_start, zimage_size, 0, 0,
 		   (void *)VMLINUX_LOAD_ADDRESS_ULL, 0, 0, error);
 
+	if (IS_ENABLED(CONFIG_MIPS_RAW_APPENDED_DTB) &&
+	    fdt_magic((void *)&__appended_dtb) == FDT_MAGIC) {
+		unsigned int image_size, dtb_size;
+
+		dtb_size = fdt_totalsize((void *)&__appended_dtb);
+
+		/* last four bytes is always image size in little endian */
+		image_size = le32_to_cpup((void *)&__image_end - 4);
+
+		/* copy dtb to where the booted kernel will expect it */
+		memcpy((void *)VMLINUX_LOAD_ADDRESS_ULL + image_size,
+		       __appended_dtb, dtb_size);
+	}
+
 	/* FIXME: should we flush cache here? */
 	puts("Now, booting the kernel...\n");
 }
diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index c580e85..409cb48 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -25,22 +25,6 @@ start:
 	move	s2, a2
 	move	s3, a3
 
-#ifdef CONFIG_MIPS_ZBOOT_APPENDED_DTB
-	PTR_LA	t0, __appended_dtb
-#ifdef CONFIG_CPU_BIG_ENDIAN
-	li	t1, 0xd00dfeed
-#else
-	li	t1, 0xedfe0dd0
-#endif
-	lw	t2, (t0)
-	bne	t1, t2, not_found
-	 nop
-
-	move	s1, t0
-	PTR_LI	s0, -2
-not_found:
-#endif
-
 	/* Clear BSS */
 	PTR_LA	a0, _edata
 	PTR_LA	a2, _end
-- 
2.1.4
