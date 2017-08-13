Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:56:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20329 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993911AbdHMCyWiHlk6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:54:22 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 82914E8F0A442;
        Sun, 13 Aug 2017 03:54:14 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:54:15 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 14/19] MIPS: Add CPU cluster number accessors
Date:   Sat, 12 Aug 2017 19:49:38 -0700
Message-ID: <20170813024943.14989-15-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813024943.14989-1-paul.burton@imgtec.com>
References: <20170813024943.14989-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Introduce cpu_cluster() & cpu_set_cluster() accessor functions in the
same vein as cpu_core(), cpu_vpe_id() & their set variants. These will
be used in further patches to allow users to get or set a CPUs cluster
number.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/cpu-info.h | 11 +++++++++++
 arch/mips/kernel/cpu-probe.c     | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 0c61bdc82a53..a41059d47d31 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -139,6 +139,16 @@ struct proc_cpuinfo_notifier_args {
 	unsigned long n;
 };
 
+static inline unsigned int cpu_cluster(struct cpuinfo_mips *cpuinfo)
+{
+	/* Optimisation for systems where multiple clusters aren't used */
+	if (!IS_ENABLED(CONFIG_CPU_MIPSR6))
+		return 0;
+
+	return (cpuinfo->globalnumber & MIPS_GLOBALNUMBER_CLUSTER) >>
+		MIPS_GLOBALNUMBER_CLUSTER_SHF;
+}
+
 static inline unsigned int cpu_core(struct cpuinfo_mips *cpuinfo)
 {
 	return (cpuinfo->globalnumber & MIPS_GLOBALNUMBER_CORE) >>
@@ -155,6 +165,7 @@ static inline unsigned int cpu_vpe_id(struct cpuinfo_mips *cpuinfo)
 		MIPS_GLOBALNUMBER_VP_SHF;
 }
 
+extern void cpu_set_cluster(struct cpuinfo_mips *cpuinfo, unsigned int cluster);
 extern void cpu_set_core(struct cpuinfo_mips *cpuinfo, unsigned int core);
 extern void cpu_set_vpe_id(struct cpuinfo_mips *cpuinfo, unsigned int vpe);
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d428e856085c..a5fd5c2162e1 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -2099,6 +2099,16 @@ void cpu_report(void)
 		pr_info("MSA revision is: %08x\n", c->msa_id);
 }
 
+void cpu_set_cluster(struct cpuinfo_mips *cpuinfo, unsigned int cluster)
+{
+	/* Ensure the core number fits in the field */
+	WARN_ON(cluster > (MIPS_GLOBALNUMBER_CLUSTER >>
+			   MIPS_GLOBALNUMBER_CLUSTER_SHF));
+
+	cpuinfo->globalnumber &= ~MIPS_GLOBALNUMBER_CLUSTER;
+	cpuinfo->globalnumber |= cluster << MIPS_GLOBALNUMBER_CLUSTER_SHF;
+}
+
 void cpu_set_core(struct cpuinfo_mips *cpuinfo, unsigned int core)
 {
 	/* Ensure the core number fits in the field */
-- 
2.14.0
