Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Apr 2015 12:25:39 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41247 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014467AbbDLKZXHBBjZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Apr 2015 12:25:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 28B5328BC81;
        Sun, 12 Apr 2015 12:24:32 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-015-232.088.073.pools.vodafone-ip.de [88.73.15.232])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 6F43C28BC9D;
        Sun, 12 Apr 2015 12:24:26 +0200 (CEST)
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
Subject: [PATCH RFC v3 1/4] MIPS: add support for vmlinux.bin appended dtb
Date:   Sun, 12 Apr 2015 12:24:58 +0200
Message-Id: <1428834301-12721-2-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1428834301-12721-1-git-send-email-jogo@openwrt.org>
References: <1428834301-12721-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46857
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

Add support for detecting a vmlinux.bin appended dtb and overriding
the boot arguments to match the UHI interface.

Due to the PERCPU section being empty for !SMP, but still modifying
the current address by aligning it to the page size, do not define
it for !SMP builds to allow __appended_dtb to still point to
the actual end of the data.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
Changes RFC v2 -> v3

* Switched to UHI interface instead of manipulating initial_boot_params
* fixed boot on !SMP
* Changed PTR_LW to lw and PTR_LI to li to ensure 32bit loads/
  comparisons are done on 64 bit

Changes RFC v1 -> v2

* changed all occurences of vmlinux to vmlinux.bin
* clarified this applies to the raw vmlinux.bin without decompressor
* s/initial_device_params/initial_boot_params/

 arch/mips/Kconfig              |   27 +++++++++++++++++++++++++++
 arch/mips/kernel/head.S        |   16 ++++++++++++++++
 arch/mips/kernel/vmlinux.lds.S |    8 +++++++-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 779dcae..0986619 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2672,6 +2672,33 @@ config USE_OF
 config BUILTIN_DTB
 	bool
 
+choice
+	prompt "Kernel appended dtb support" if OF
+	default MIPS_NO_APPENDED_DTB
+
+	config MIPS_NO_APPENDED_DTB
+		bool "None"
+		help
+		  Do not enable appended dtb support.
+
+	config MIPS_RAW_APPENDED_DTB
+		bool "vmlinux.bin"
+		help
+		  With this option, the boot code will look for a device tree binary
+		  DTB) appended to raw vmlinux.bin (without decompressor).
+		  (e.g. cat vmlinux.bin <filename>.dtb > vmlinux_w_dtb).
+
+		  This is meant as a backward compatibility convenience for those
+		  systems with a bootloader that can't be upgraded to accommodate
+		  the documented boot protocol using a device tree.
+
+		  Beware that there is very little in terms of protection against
+		  this option being confused by leftover garbage in memory that might
+		  look like a DTB header after a reboot if no actual DTB is appended
+		  to vmlinux.bin.  Do not leave this option active in a production kernel
+		  if you don't intend to always append a DTB.
+endchoice
+
 endmenu
 
 config LOCKDEP_SUPPORT
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 95afd66..4e4cc5b 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -94,6 +94,22 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	jr	t0
 0:
 
+#ifdef CONFIG_MIPS_RAW_APPENDED_DTB
+	PTR_LA		t0, __appended_dtb
+
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	li		t1, 0xd00dfeed
+#else
+	li		t1, 0xedfe0dd0
+#endif
+	lw		t2, (t0)
+	bne		t1, t2, not_found
+	 nop
+
+	move		a1, t0
+	PTR_LI		a0, -2
+not_found:
+#endif
 	PTR_LA		t0, __bss_start		# clear .bss
 	LONG_S		zero, (t0)
 	PTR_LA		t1, __bss_stop - LONGSIZE
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 3b46f7c..07d32a4 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -125,8 +125,14 @@ SECTIONS
 	.exit.data : {
 		EXIT_DATA
 	}
-
+#ifdef CONFIG_SMP
 	PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
+#endif
+#ifdef CONFIG_MIPS_RAW_APPENDED_DTB
+	__appended_dtb = .;
+	/* leave space for appended DTB */
+	. += 0x100000;
+#endif
 	/*
 	 * Align to 64K in attempt to eliminate holes before the
 	 * .bss..swapper_pg_dir section at the start of .bss.  This
-- 
1.7.10.4
