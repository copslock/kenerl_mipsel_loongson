Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:15:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51163 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009110AbbIVSPOeVqPU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:15:14 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F3C78D61AA26C;
        Tue, 22 Sep 2015 19:15:04 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:15:07 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:15:06 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Bresticker <abrestic@chromium.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 09/10] MIPS: CM: make use of mips_cm_{lock,unlock}_other
Date:   Tue, 22 Sep 2015 11:12:17 -0700
Message-ID: <1442945538-26141-10-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
References: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49310
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

Document that CPC core-other accesses must take place within the bounds
of the CM lock, and begin using the CM lock functions where we access
the GCRs of other cores. This is required because with CM3 the CPC began
using GCR_CL_OTHER instead of CPC_CL_OTHER.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/mips-cpc.h | 3 ++-
 arch/mips/kernel/smp-cps.c       | 7 +++++--
 arch/mips/kernel/smp-gic.c       | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mips-cpc.h b/arch/mips/include/asm/mips-cpc.h
index f386f32..e090352 100644
--- a/arch/mips/include/asm/mips-cpc.h
+++ b/arch/mips/include/asm/mips-cpc.h
@@ -149,7 +149,8 @@ BUILD_CPC_Cx_RW(other,		0x10)
  * core: the other core to be accessed
  *
  * Call before operating upon a core via the 'other' register region in
- * order to prevent the region being moved during access. Must be followed
+ * order to prevent the region being moved during access. Must be called
+ * within the bounds of a mips_cm_{lock,unlock}_other pair, and followed
  * by a call to mips_cpc_unlock_other.
  */
 extern void mips_cpc_lock_other(unsigned int core);
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 48b1b75..e04c805 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -38,8 +38,9 @@ static unsigned core_vpe_count(unsigned core)
 	if (!config_enabled(CONFIG_MIPS_MT_SMP) || !cpu_has_mipsmt)
 		return 1;
 
-	write_gcr_cl_other(core << CM_GCR_Cx_OTHER_CORENUM_SHF);
+	mips_cm_lock_other(core, 0);
 	cfg = read_gcr_co_config() & CM_GCR_Cx_CONFIG_PVPE_MSK;
+	mips_cm_unlock_other();
 	return (cfg >> CM_GCR_Cx_CONFIG_PVPE_SHF) + 1;
 }
 
@@ -193,7 +194,7 @@ static void boot_core(unsigned core)
 	unsigned timeout;
 
 	/* Select the appropriate core */
-	write_gcr_cl_other(core << CM_GCR_Cx_OTHER_CORENUM_SHF);
+	mips_cm_lock_other(core, 0);
 
 	/* Set its reset vector */
 	write_gcr_co_reset_base(CKSEG1ADDR((unsigned long)mips_cps_core_entry));
@@ -238,6 +239,8 @@ static void boot_core(unsigned core)
 		write_gcr_co_reset_release(0);
 	}
 
+	mips_cm_unlock_other();
+
 	/* The core is now powered up */
 	bitmap_set(core_power, core, 1);
 }
diff --git a/arch/mips/kernel/smp-gic.c b/arch/mips/kernel/smp-gic.c
index 5f0ab5b..9b63829 100644
--- a/arch/mips/kernel/smp-gic.c
+++ b/arch/mips/kernel/smp-gic.c
@@ -46,9 +46,11 @@ void gic_send_ipi_single(int cpu, unsigned int action)
 
 	if (mips_cpc_present() && (core != current_cpu_data.core)) {
 		while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
+			mips_cm_lock_other(core, 0);
 			mips_cpc_lock_other(core);
 			write_cpc_co_cmd(CPC_Cx_CMD_PWRUP);
 			mips_cpc_unlock_other();
+			mips_cm_unlock_other();
 		}
 	}
 
-- 
2.5.3
