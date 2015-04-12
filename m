Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Apr 2015 12:26:14 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41264 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014480AbbDLKZbFdEer (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Apr 2015 12:25:31 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 2F77328BCA3;
        Sun, 12 Apr 2015 12:24:39 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-015-232.088.073.pools.vodafone-ip.de [88.73.15.232])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 20B8F28BFFB;
        Sun, 12 Apr 2015 12:24:28 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hartley <James.Hartley@imgtec.com>
Subject: [PATCH RFC v3 2/4] MIPS: add support for vmlinuz.bin appended dtb
Date:   Sun, 12 Apr 2015 12:24:59 +0200
Message-Id: <1428834301-12721-3-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1428834301-12721-1-git-send-email-jogo@openwrt.org>
References: <1428834301-12721-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46859
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

Add support for detecting a vmlinuz.bin appended dtb and overriding
the boot arguments to match the UHI interface.

To ensure _edata / __apendend_dtb points to the actual end of the
binary, align the data section to 16 bytes instead of the address
cursor.

Due to ld.script not going through the preprocessor, we can't check
for MIPS_ZBOOT_APPENDED_DTB being enabled, so always reserve space
for it. It should have no consequences for booting without it enabled
except 1 MiB more ram usage during the uncompressing stage.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/Kconfig                   |   18 ++++++++++++++++++
 arch/mips/boot/compressed/head.S    |   16 ++++++++++++++++
 arch/mips/boot/compressed/ld.script |    6 +++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0986619..8aef377 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2697,6 +2697,24 @@ choice
 		  look like a DTB header after a reboot if no actual DTB is appended
 		  to vmlinux.bin.  Do not leave this option active in a production kernel
 		  if you don't intend to always append a DTB.
+
+	config MIPS_ZBOOT_APPENDED_DTB
+		bool "vmlinuz.bin"
+		depends on SYS_SUPPORTS_ZBOOT
+		help
+		  With this option, the boot code will look for a device tree binary
+		  DTB) appended to raw vmlinuz.bin (with decompressor).
+		  (e.g. cat vmlinuz.bin <filename>.dtb > vmlinuz_w_dtb).
+
+		  This is meant as a backward compatibility convenience for those
+		  systems with a bootloader that can't be upgraded to accommodate
+		  the documented boot protocol using a device tree.
+
+		  Beware that there is very little in terms of protection against
+		  this option being confused by leftover garbage in memory that might
+		  look like a DTB header after a reboot if no actual DTB is appended
+		  to vmlinuz.bin.  Do not leave this option active in a production kernel
+		  if you don't intend to always append a DTB.
 endchoice
 
 endmenu
diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index 409cb48..c580e85 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -25,6 +25,22 @@ start:
 	move	s2, a2
 	move	s3, a3
 
+#ifdef CONFIG_MIPS_ZBOOT_APPENDED_DTB
+	PTR_LA	t0, __appended_dtb
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	li	t1, 0xd00dfeed
+#else
+	li	t1, 0xedfe0dd0
+#endif
+	lw	t2, (t0)
+	bne	t1, t2, not_found
+	 nop
+
+	move	s1, t0
+	PTR_LI	s0, -2
+not_found:
+#endif
+
 	/* Clear BSS */
 	PTR_LA	a0, _edata
 	PTR_LA	a2, _end
diff --git a/arch/mips/boot/compressed/ld.script b/arch/mips/boot/compressed/ld.script
index 5a33409..2ed08fb 100644
--- a/arch/mips/boot/compressed/ld.script
+++ b/arch/mips/boot/compressed/ld.script
@@ -29,8 +29,12 @@ SECTIONS
 		*(.image)
 		__image_end = .;
 		CONSTRUCTORS
+		. = ALIGN(16);
 	}
-	. = ALIGN(16);
+	__appended_dtb = .;
+	/* leave space for appended DTB */
+	. += 0x100000;
+
 	_edata = .;
 	/* End of data section */
 
-- 
1.7.10.4
