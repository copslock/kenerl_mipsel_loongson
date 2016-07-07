Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2016 09:51:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63657 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992308AbcGGHvYQeUH6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jul 2016 09:51:24 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 44034629E804A;
        Thu,  7 Jul 2016 08:51:15 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 7 Jul 2016 08:51:17 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/3] MIPS: smp-cps: Allow booting of CPU other than VP0 within a core
Date:   Thu, 7 Jul 2016 08:50:38 +0100
Message-ID: <1467877840-32569-2-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1467877840-32569-1-git-send-email-matt.redfearn@imgtec.com>
References: <1467877840-32569-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54240
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

The boot_core function was hardcoded to always start VP0 when starting
a core via the CPC. When hotplugging a CPU this may not be the desired
behaviour.

Make boot_core receive the VP ID to start running on the core, such that
alternate VPs can be started via CPU hotplug.
Also ensure that all other VPs within the core are stopped before
bringing the core out of reset so that only the desired VP starts.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/smp-cps.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 4ed36f288d64..006e99de170d 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -206,7 +206,7 @@ err_out:
 	}
 }
 
-static void boot_core(unsigned core)
+static void boot_core(unsigned int core, unsigned int vpe_id)
 {
 	u32 access, stat, seq_state;
 	unsigned timeout;
@@ -233,8 +233,9 @@ static void boot_core(unsigned core)
 		mips_cpc_lock_other(core);
 
 		if (mips_cm_revision() >= CM_REV_CM3) {
-			/* Run VP0 following the reset */
-			write_cpc_co_vp_run(0x1);
+			/* Run only the requested VP following the reset */
+			write_cpc_co_vp_stop(0xf);
+			write_cpc_co_vp_run(1 << vpe_id);
 
 			/*
 			 * Ensure that the VP_RUN register is written before the
@@ -306,7 +307,7 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 
 	if (!test_bit(core, core_power)) {
 		/* Boot a VPE on a powered down core */
-		boot_core(core);
+		boot_core(core, vpe_id);
 		goto out;
 	}
 
-- 
2.7.4
