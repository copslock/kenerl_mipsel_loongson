Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Sep 2015 16:49:45 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:54990 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013762AbbIKOtoB3BVk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Sep 2015 16:49:44 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd002.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id t8BEncx1028589
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 11 Sep 2015 14:49:38 GMT
Received: from localhost.localdomain ([10.144.44.120])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t8BEnbHb008588;
        Fri, 11 Sep 2015 16:49:38 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/2] MIPS: vmlinux: create a section for appended DTB
Date:   Fri, 11 Sep 2015 17:46:14 +0300
Message-Id: <1441982775-9703-1-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 2414
X-purgate-ID: 151667::1441982978-0000538C-3BAAA588/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

For bootloaders that support booting only ELF kernels and load only ELF
segments to memory there is no easy way to supply DTB without kernel
recompilation. For that purpose, create a section called .appended_dtb
that can be later updated with board-specific DTB using binutils e.g. at
kernel installation time.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/mips/Kconfig              | 14 ++++++++++++++
 arch/mips/kernel/setup.c       |  4 ++++
 arch/mips/kernel/vmlinux.lds.S |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 199a835..f22ff1b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2686,6 +2686,20 @@ choice
 		help
 		  Do not enable appended dtb support.
 
+	config MIPS_ELF_APPENDED_DTB
+		bool "vmlinux"
+		help
+		  With this option, the boot code will look for a device tree binary
+		  DTB) included in the vmlinux ELF section .appended_dtb. By default
+		  it is empty and the DTB can be appended using binutils command
+		  objcopy:
+
+		    objcopy --update-section .appended_dtb=<filename>.dtb vmlinux
+
+		  This is meant as a backward compatiblity convenience for those
+		  systems with a bootloader that can't be upgraded to accommodate
+		  the documented boot protocol using a device tree.
+
 	config MIPS_RAW_APPENDED_DTB
 		bool "vmlinux.bin"
 		help
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 008b337..fb022f4 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -38,6 +38,10 @@
 #include <asm/smp-ops.h>
 #include <asm/prom.h>
 
+#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
+const char __section(.appended_dtb) __appended_dtb[0x100000];
+#endif /* CONFIG_MIPS_ELF_APPENDED_DTB */
+
 struct cpuinfo_mips cpu_data[NR_CPUS] __read_mostly;
 
 EXPORT_SYMBOL(cpu_data);
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 07d32a4..f4c23d9 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -132,6 +132,11 @@ SECTIONS
 	__appended_dtb = .;
 	/* leave space for appended DTB */
 	. += 0x100000;
+#elif defined(CONFIG_MIPS_ELF_APPENDED_DTB)
+	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
+		*(.appended_dtb)
+		KEEP(*(.appended_dtb))
+	}
 #endif
 	/*
 	 * Align to 64K in attempt to eliminate holes before the
-- 
2.4.3
