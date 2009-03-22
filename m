Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Mar 2009 22:13:38 +0000 (GMT)
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:46998 "EHLO
	gw01.mail.saunalahti.fi") by ftp.linux-mips.org with ESMTP
	id S21370132AbZCVWMo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Mar 2009 22:12:44 +0000
Received: from localhost.localdomain (a88-114-245-69.elisa-laajakaista.fi [88.114.245.69])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 696C4151410;
	Mon, 23 Mar 2009 00:12:41 +0200 (EET)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH 2/3] [MIPS] Fix global namespace pollution in arch/mips/kernel/smp-up.c
Date:	Mon, 23 Mar 2009 00:12:28 +0200
Message-Id: <1237759949-8223-3-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1237759949-8223-2-git-send-email-dmitri.vorobiev@movial.com>
References: <1237759949-8223-1-git-send-email-dmitri.vorobiev@movial.com>
 <1237759949-8223-2-git-send-email-dmitri.vorobiev@movial.com>
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

The following symbols in arch/mips/kernel/smp-up.c are needlessly
defined global:

up_send_ipi_single()
up_init_secondary()
up_smp_finish()
up_cpus_done()
up_boot_secondary()
up_smp_setup()
up_prepare_cpus()

This patch makes the symbols static.

Build-tested using malta_defconfig.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/kernel/smp-up.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/smp-up.c b/arch/mips/kernel/smp-up.c
index ead6c30..878e373 100644
--- a/arch/mips/kernel/smp-up.c
+++ b/arch/mips/kernel/smp-up.c
@@ -13,7 +13,7 @@
 /*
  * Send inter-processor interrupt
  */
-void up_send_ipi_single(int cpu, unsigned int action)
+static void up_send_ipi_single(int cpu, unsigned int action)
 {
 	panic(KERN_ERR "%s called", __func__);
 }
@@ -27,31 +27,31 @@ static inline void up_send_ipi_mask(cpumask_t mask, unsigned int action)
  *  After we've done initial boot, this function is called to allow the
  *  board code to clean up state, if needed
  */
-void __cpuinit up_init_secondary(void)
+static void __cpuinit up_init_secondary(void)
 {
 }
 
-void __cpuinit up_smp_finish(void)
+static void __cpuinit up_smp_finish(void)
 {
 }
 
 /* Hook for after all CPUs are online */
-void up_cpus_done(void)
+static void up_cpus_done(void)
 {
 }
 
 /*
  * Firmware CPU startup hook
  */
-void __cpuinit up_boot_secondary(int cpu, struct task_struct *idle)
+static void __cpuinit up_boot_secondary(int cpu, struct task_struct *idle)
 {
 }
 
-void __init up_smp_setup(void)
+static void __init up_smp_setup(void)
 {
 }
 
-void __init up_prepare_cpus(unsigned int max_cpus)
+static void __init up_prepare_cpus(unsigned int max_cpus)
 {
 }
 
-- 
1.5.6.3
