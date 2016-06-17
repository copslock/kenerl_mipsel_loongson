Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 14:08:27 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:39342 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27042824AbcFQMHwvLEXA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 14:07:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 5273FB92087;
        Fri, 17 Jun 2016 14:07:52 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-007-040.088.073.pools.vodafone-ip.de [88.73.7.40])
        by arrakis.dune.hu (Postfix) with ESMTPSA id B3888B92072;
        Fri, 17 Jun 2016 14:07:35 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alban Bedel <albeu@free.fr>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Subject: [PATCH 2/2] MIPS: store the appended dtb address in a variable
Date:   Fri, 17 Jun 2016 14:07:40 +0200
Message-Id: <1466165260-6897-3-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1466165260-6897-1-git-send-email-jogo@openwrt.org>
References: <1466165260-6897-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54092
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

Instead of rewriting the arguments to match the UHI spec, store the
address of a appended or UHI supplied dtb in fw_supplied_dtb.

That way the original bootloader arguments are kept intact while still
making the use of an appended dtb invisible for mach code.

Mach code can still find out if it is an appended dtb by comparing
fw_arg1 with fw_supplied_dtb.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/ath79/setup.c          |  4 ++--
 arch/mips/bmips/setup.c          |  4 ++--
 arch/mips/include/asm/bootinfo.h |  4 ++++
 arch/mips/kernel/head.S          | 21 ++++++++++++++-------
 arch/mips/kernel/setup.c         |  4 ++++
 arch/mips/lantiq/prom.c          |  4 ++--
 arch/mips/pic32/pic32mzda/init.c |  4 ++--
 7 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 7adab18..2ec9100 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -204,8 +204,8 @@ void __init plat_mem_setup(void)
 	fdt_start = fw_getenvl("fdt_start");
 	if (fdt_start)
 		__dt_setup_arch((void *)KSEG0ADDR(fdt_start));
-	else if (fw_arg0 == -2)
-		__dt_setup_arch((void *)KSEG0ADDR(fw_arg1));
+	else if (fw_passed_dtb)
+		__dt_setup_arch((void *)KSEG0ADDR(fw_passed_dtb));
 
 	if (mips_machtype != ATH79_MACH_GENERIC_OF) {
 		ath79_reset_base = ioremap_nocache(AR71XX_RESET_BASE,
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index f146d12..6776042 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -162,8 +162,8 @@ void __init plat_mem_setup(void)
 	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
 	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
 		dtb = phys_to_virt(fw_arg2);
-	else if (fw_arg0 == -2) /* UHI interface */
-		dtb = (void *)fw_arg1;
+	else if (fw_passed_dtb) /* UHI interface */
+		dtb = (void *)fw_passed_dtb;
 	else if (__dtb_start != __dtb_end)
 		dtb = (void *)__dtb_start;
 	else
diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 9f67033..ee9f5f2 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -127,6 +127,10 @@ extern char arcs_cmdline[COMMAND_LINE_SIZE];
  */
 extern unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
 
+#ifdef CONFIG_USE_OF
+extern unsigned long fw_passed_dtb;
+#endif
+
 /*
  * Platform memory detection hook called by setup_arch
  */
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 56e8fed..cf05220 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -93,21 +93,24 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	jr	t0
 0:
 
+#ifdef CONFIG_USE_OF
 #ifdef CONFIG_MIPS_RAW_APPENDED_DTB
-	PTR_LA		t0, __appended_dtb
+	PTR_LA		t2, __appended_dtb
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
 	li		t1, 0xd00dfeed
 #else
 	li		t1, 0xedfe0dd0
 #endif
-	lw		t2, (t0)
-	bne		t1, t2, not_found
-	 nop
+	lw		t0, (t2)
+	beq		t0, t1, dtb_found
+#endif
+	li		t1, -2
+	beq		a0, t1, dtb_found
+	move		t2, a1
 
-	move		a1, t0
-	PTR_LI		a0, -2
-not_found:
+	li		t2, 0
+dtb_found:
 #endif
 	PTR_LA		t0, __bss_start		# clear .bss
 	LONG_S		zero, (t0)
@@ -122,6 +125,10 @@ not_found:
 	LONG_S		a2, fw_arg2
 	LONG_S		a3, fw_arg3
 
+#ifdef CONFIG_USE_OF
+	LONG_S		t2, fw_passed_dtb
+#endif
+
 	MTC0		zero, CP0_CONTEXT	# clear context register
 	PTR_LA		$28, init_thread_union
 	/* Set the SP after an empty pt_regs.  */
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index ef408a0..36cf8d6 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -875,6 +875,10 @@ void __init setup_arch(char **cmdline_p)
 unsigned long kernelsp[NR_CPUS];
 unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
 
+#ifdef CONFIG_USE_OF
+unsigned long fw_passed_dtb;
+#endif
+
 #ifdef CONFIG_DEBUG_FS
 struct dentry *mips_debugfs_dir;
 static int __init debugfs_mips(void)
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 5f693ac..4cbb000 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -74,8 +74,8 @@ void __init plat_mem_setup(void)
 
 	set_io_port_base((unsigned long) KSEG1);
 
-	if (fw_arg0 == -2) /* UHI interface */
-		dtb = (void *)fw_arg1;
+	if (fw_passed_dtb) /* UHI interface */
+		dtb = (void *)fw_passed_dtb;
 	else if (__dtb_start != __dtb_end)
 		dtb = (void *)__dtb_start;
 	else
diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
index 775ff90..a794037 100644
--- a/arch/mips/pic32/pic32mzda/init.c
+++ b/arch/mips/pic32/pic32mzda/init.c
@@ -33,8 +33,8 @@ static ulong get_fdtaddr(void)
 {
 	ulong ftaddr = 0;
 
-	if ((fw_arg0 == -2) && fw_arg1 && !fw_arg2 && !fw_arg3)
-		return (ulong)fw_arg1;
+	if (fw_passed_dtb && !fw_arg2 && !fw_arg3)
+		return (ulong)fw_passed_dtb;
 
 	if (__dtb_start < __dtb_end)
 		ftaddr = (ulong)__dtb_start;
-- 
2.1.4
