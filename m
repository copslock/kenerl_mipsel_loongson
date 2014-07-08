Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 17:16:12 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:39328 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861335AbaGHPOtngRMD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Jul 2014 17:14:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 8B78028B952;
        Tue,  8 Jul 2014 17:12:44 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (p5081183E.dip0.t-ipconnect.de [80.129.24.62])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 1C954280941;
        Tue,  8 Jul 2014 17:12:38 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC] MIPS: add support for vmlinux appended DTB
Date:   Tue,  8 Jul 2014 17:14:06 +0200
Message-Id: <1404832446-31028-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41084
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

Add support for populating initial_device_params through a dtb
blob appended to vmlinux.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
Mostly adapted from how ARM is doing it.

Sent as an RFC PATCH because I am not sure if this is the right way to
it, and whether storing the pointer in initial_device_params is a good
idea, or a new variable should be introduced.

The reasoning for initial_device_params is that there is no common
MIPS interface yet, so the next best thing was using that. This also
has the advantage of keeping the original fw_args intact.

This patch works for me on bcm63xx, where the bootloade expects
an lzma compressed kernel, so I wanted to not double compress using
the in-kernel compressed kernel support.

Completely untested on anything except MIPS32 / big endian.

 arch/mips/Kconfig              | 18 ++++++++++++++++++
 arch/mips/kernel/head.S        | 19 +++++++++++++++++++
 arch/mips/kernel/vmlinux.lds.S |  6 ++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3f05b56..58527cd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2476,6 +2476,24 @@ config USE_OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
 
+config MIPS_APPENDED_DTB
+	bool "Use appended device tree blob to vmlinux (EXPERIMENTAL)"
+	depends on OF
+	help
+	  With this option, the boot code will look for a device tree binary
+	  DTB) appended to vmlinux
+	  (e.g. cat vmlinux <filename>.dtb > vmlinux_w_dtb).
+
+	  This is meant as a backward compatibility convenience for those
+	  systems with a bootloader that can't be upgraded to accommodate
+	  the documented boot protocol using a device tree.
+
+	  Beware that there is very little in terms of protection against
+	  this option being confused by leftover garbage in memory that might
+	  look like a DTB header after a reboot if no actual DTB is appended
+	  to vmlinux.  Do not leave this option active in a production kernel
+	  if you don't intend to always append a DTB.
+
 endmenu
 
 config LOCKDEP_SUPPORT
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 95afd66..72c1049 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -93,7 +93,22 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	PTR_LA	t0, 0f
 	jr	t0
 0:
+#ifdef CONFIG_MIPS_APPENDED_DTB
+	PTR_LA		t0, __appended_dtb
+	PTR_LI		t3, 0
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	PTR_LI		t1, 0xd00dfeed
+#else
+	PTR_LI		t1, 0xedfe0dd0
+#endif
+	LONG_L		t2, (t0)
+	bne		t1, t2, not_found
+
+	PTR_LA		t3, __appended_dtb
+
+not_found:
+#endif
 	PTR_LA		t0, __bss_start		# clear .bss
 	LONG_S		zero, (t0)
 	PTR_LA		t1, __bss_stop - LONGSIZE
@@ -107,6 +122,10 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	LONG_S		a2, fw_arg2
 	LONG_S		a3, fw_arg3
 
+#ifdef CONFIG_MIPS_APPENDED_DTB
+	LONG_S		t3, initial_boot_params
+#endif
+
 	MTC0		zero, CP0_CONTEXT	# clear context register
 	PTR_LA		$28, init_thread_union
 	/* Set the SP after an empty pt_regs.  */
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 3b46f7c..8009530 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -127,6 +127,12 @@ SECTIONS
 	}
 
 	PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
+
+#ifdef CONFIG_MIPS_APPENDED_DTB
+	__appended_dtb = .;
+	/* leave space for appended DTB */
+	. = . + 0x100000;
+#endif
 	/*
 	 * Align to 64K in attempt to eliminate holes before the
 	 * .bss..swapper_pg_dir section at the start of .bss.  This
-- 
2.0.0
