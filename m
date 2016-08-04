Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2016 18:20:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7314 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992249AbcHDQUkWhlLf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Aug 2016 18:20:40 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2B044F7080C9D;
        Thu,  4 Aug 2016 17:20:18 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 4 Aug 2016 17:20:21 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: Move identification of VP(E) into proc.c from smp-mt.c
Date:   Thu, 4 Aug 2016 17:19:38 +0100
Message-ID: <1470327578-31260-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

The addition of VPE information to /proc/cpuinfo used to be in smp-mt.c.
This file is not used by MIPS r6 kernels, so the Virtual Processor
information was not present for these CPU types.

Move the code to print VPE information into proc.c, add a case for MIPS
r6 CPUS, and remove the block from smp-mt.c.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>

---

 arch/mips/kernel/proc.c   |  7 +++++++
 arch/mips/kernel/smp-mt.c | 23 -----------------------
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 97dc01b03631..4eff2aed7360 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -135,6 +135,13 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
 	seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
 
+#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
+	if (cpu_has_mipsmt)
+		seq_printf(m, "VPE\t\t\t: %d\n", cpu_data[n].vpe_id);
+	else if (cpu_has_vp)
+		seq_printf(m, "VP\t\t\t: %d\n", cpu_data[n].vpe_id);
+#endif
+
 	sprintf(fmt, "VCE%%c exceptions\t\t: %s\n",
 		      cpu_has_vce ? "%u" : "not available");
 	seq_printf(m, fmt, 'D', vced_count);
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 4f9570a57e8d..e077ea3e11fb 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -289,26 +289,3 @@ struct plat_smp_ops vsmp_smp_ops = {
 	.prepare_cpus		= vsmp_prepare_cpus,
 };
 
-#ifdef CONFIG_PROC_FS
-static int proc_cpuinfo_chain_call(struct notifier_block *nfb,
-	unsigned long action_unused, void *data)
-{
-	struct proc_cpuinfo_notifier_args *pcn = data;
-	struct seq_file *m = pcn->m;
-	unsigned long n = pcn->n;
-
-	if (!cpu_has_mipsmt)
-		return NOTIFY_OK;
-
-	seq_printf(m, "VPE\t\t\t: %d\n", cpu_data[n].vpe_id);
-
-	return NOTIFY_OK;
-}
-
-static int __init proc_cpuinfo_notifier_init(void)
-{
-	return proc_cpuinfo_notifier(proc_cpuinfo_chain_call, 0);
-}
-
-subsys_initcall(proc_cpuinfo_notifier_init);
-#endif
-- 
2.7.4
