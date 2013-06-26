Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 21:12:53 +0200 (CEST)
Received: from mail-wg0-f46.google.com ([74.125.82.46]:52792 "EHLO
        mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834871Ab3FZTMl4nYVt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Jun 2013 21:12:41 +0200
Received: by mail-wg0-f46.google.com with SMTP id c11so10530364wgh.13
        for <multiple recipients>; Wed, 26 Jun 2013 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=pW4g7tDguBk1Xs4WWsU0uGCNKHSv0IlEUImt93YQhAs=;
        b=gMhhr9sMD/vHQfaWBh5/MUkmjFB9U+8ISdVyHfsg7b+vdrqpYouvhAl4DhEfns7TmP
         CKVzNRKc20YAzyvTOoN3o68FLoTSD1hHuTif3dcBpZuLen4PVVCKjpJvnTx2BE+cWhc7
         uQAz3QevpxofaGQxQycIETo4vDvfdIljqrxzwJ/ik55oAusOgwmmHrj7D04hU0voVmAt
         MTMXzMrZd1IrH3BrA96taHAdDzcy49jVqabm7Y5YO89sXWSLVqTikIj5HVJE2a9mWM4S
         U5ZKVcffLitnmArb9MG8ZT8jBK/6rnoNXwlr1ZPQtDTYcO3W4QqHCdcYTipE8SzEVvrt
         O45Q==
X-Received: by 10.194.174.4 with SMTP id bo4mr3837502wjc.40.1372273956441;
        Wed, 26 Jun 2013 12:12:36 -0700 (PDT)
Received: from localhost.localdomain (cpc24-aztw25-2-0-cust938.aztw.cable.virginmedia.com. [92.233.35.171])
        by mx.google.com with ESMTPSA id ev19sm12832280wid.2.2013.06.26.12.12.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Jun 2013 12:12:35 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     jogo@openwrt.org, ralf@linux-mips.org, blogic@openwrt.org,
        cernekee@gmail.com, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: BMIPS: support booting from physical CPU other than 0
Date:   Wed, 26 Jun 2013 20:11:56 +0100
Message-Id: <1372273916-7147-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.1.2
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

BMIPS43xx CPUs have two hardware threads, and on some SoCs such as 3368,
the bootloader has configured the system to boot from TP1 instead of the
more usual TP0. Create the physical to logical CPU mapping to cope with
that, do not remap the software interrupts to be cross CPUs such that we
do not have to do use the logical CPU mapping further down the code, and
finally, reset the slave TP1 only if booted from TP0.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/kernel/smp-bmips.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 8e393b8..62c5c7c 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -63,7 +63,7 @@ static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id);
 
 static void __init bmips_smp_setup(void)
 {
-	int i;
+	int i, cpu = 1, boot_cpu = 0;
 
 #if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
 	/* arbitration priority */
@@ -72,13 +72,22 @@ static void __init bmips_smp_setup(void)
 	/* NBK and weak order flags */
 	set_c0_brcm_config_0(0x30000);
 
+	/* Find out if we are running on TP0 or TP1 */
+	boot_cpu = !!(read_c0_brcm_cmt_local() & (1 << 31));
+
 	/*
 	 * MIPS interrupts 0,1 (SW INT 0,1) cross over to the other thread
 	 * MIPS interrupt 2 (HW INT 0) is the CPU0 L1 controller output
 	 * MIPS interrupt 3 (HW INT 1) is the CPU1 L1 controller output
+	 *
+	 * If booting from TP1, leave the existing CMT interrupt routing
+	 * such that TP0 responds to SW1 and TP1 responds to SW0.
 	 */
-	change_c0_brcm_cmt_intr(0xf8018000,
-		(0x02 << 27) | (0x03 << 15));
+	if (boot_cpu == 0)
+		change_c0_brcm_cmt_intr(0xf8018000,
+					(0x02 << 27) | (0x03 << 15));
+	else
+		change_c0_brcm_cmt_intr(0xf8018000, (0x1d << 27));
 
 	/* single core, 2 threads (2 pipelines) */
 	max_cpus = 2;
@@ -106,9 +115,15 @@ static void __init bmips_smp_setup(void)
 	if (!board_ebase_setup)
 		board_ebase_setup = &bmips_ebase_setup;
 
+	__cpu_number_map[boot_cpu] = 0;
+	__cpu_logical_map[0] = boot_cpu;
+
 	for (i = 0; i < max_cpus; i++) {
-		__cpu_number_map[i] = 1;
-		__cpu_logical_map[i] = 1;
+		if (i != boot_cpu) {
+			__cpu_number_map[i] = cpu;
+			__cpu_logical_map[cpu] = i;
+			cpu++;
+		}
 		set_cpu_possible(i, 1);
 		set_cpu_present(i, 1);
 	}
@@ -132,6 +147,7 @@ static void bmips_prepare_cpus(unsigned int max_cpus)
  */
 static void bmips_boot_secondary(int cpu, struct task_struct *idle)
 {
+	int tpid = cpu_logical_map(cpu);
 	bmips_smp_boot_sp = __KSTK_TOS(idle);
 	bmips_smp_boot_gp = (unsigned long)task_thread_info(idle);
 	mb();
@@ -157,7 +173,9 @@ static void bmips_boot_secondary(int cpu, struct task_struct *idle)
 		bmips_send_ipi_single(cpu, 0);
 	else {
 #if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
-		set_c0_brcm_cmt_ctrl(0x01);
+		/* Reset slave TP1 if booting from TP0 */
+		if (tpid == 0)
+			set_c0_brcm_cmt_ctrl(0x01);
 #elif defined(CONFIG_CPU_BMIPS5000)
 		if (cpu & 0x01)
 			write_c0_brcm_action(ACTION_BOOT_THREAD(cpu));
-- 
1.8.1.2
