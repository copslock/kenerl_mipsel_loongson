Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 10:37:07 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:53114 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990633AbdLOJgxI8un1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Dec 2017 10:36:53 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 15 Dec 2017 09:36:40 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 15 Dec 2017 01:35:59 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] MIPS: pm-cps: Warn if JTAG presence will block power gating
Date:   Fri, 15 Dec 2017 09:34:54 +0000
Message-ID: <1513330494-21249-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513330494-21249-1-git-send-email-matt.redfearn@mips.com>
References: <1513330494-21249-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513330597-637138-4364-79173-11
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187999
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

If a JTAG probe is connected to a MIPS cluster, then the CPC detects it
and latches the CPC.STAT_CONF.EJTAG_PROBE bit to 1. While set,
attempting to send a power-down command to a core will be blocked, and
the CPC will instead send the core to clock-off state. This can
interfere with systems fully entering a low power state where all cores,
CM, GIC, etc are powered down.

Detect that a JTAG probe is / has been connected to the cluster and emit
a warning that the attempted power down will fail, to aid debugging
system suspend where it is not currently obvious that a core has not
really powered down and will block a full power down of the cluster. We
use a ratelimited pr_warn since this path will also be hit by cpu idle
if it attempts to put cores into the powered down state.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/kernel/pm-cps.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 421e06dfee72..45776613a5be 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -11,6 +11,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 
 #include <asm/asm-offsets.h>
@@ -143,6 +144,18 @@ int cps_pm_enter_state(enum cps_pm_state state)
 
 	/* Setup the VPE to run mips_cps_pm_restore when started again */
 	if (IS_ENABLED(CONFIG_CPU_PM) && state == CPS_PM_POWER_GATED) {
+		unsigned int stat = read_cpc_cl_stat_conf();
+
+		if (stat & CPC_Cx_STAT_CONF_EJTAG_PROBE) {
+			/*
+			 * If we're attempting to gate power to the core, the
+			 * JTAG detect bit indicates that the CPC will instead
+			 * put the core into clock-off state. Emit a warning.
+			 */
+			pr_warn_ratelimited("JTAG probe present - core%d will clock off instead of powering down\n",
+					    core);
+		}
+
 		/* Power gating relies upon CPS SMP */
 		if (!mips_cps_smp_in_use())
 			return -EINVAL;
-- 
2.7.4
