Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 23:52:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39674 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993943AbdFBVv2c9UDF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 23:51:28 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E607FAFB929C1;
        Fri,  2 Jun 2017 22:51:17 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 22:51:22
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 7/7] MIPS: CPS: Handle spurious VP starts more gracefully
Date:   Fri, 2 Jun 2017 14:48:55 -0700
Message-ID: <20170602214856.4545-8-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602214856.4545-1-paul.burton@imgtec.com>
References: <20170602214856.4545-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58161
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

On pre-r6 systems with the MT ASE the CPS SMP code included checks to
halt the VPE running mips_cps_boot_vpes() if its bit in the struct
core_boot_config vpe_mask field is clear. This was largely done in order
to allow us to start arbitrary VPEs within a core despite the fact that
hardware is typically configured to run only VPE0 after powering up a
core. VPE0 would start the desired other VPEs, halt itself, and the fact
that VPE0 started would be largely hidden & irrelevant.

In MIPSr6 multithreading we have control over which VPs start executing
when a core powers up via the cores CPC registers accessed remotely
through the redirect block. For this reason the MIPSr6 multithreading
path in mips_cps_boot_vpes() hasn't bothered up until now to handle
halting the VP running it.

However it is possible to power up cores entirely in hardware by using a
pwr_up pin associated with the core. Unfortunately some systems wire
this pin to a logic 1, which means that it is possible for a core to
power up at a point that software doesn't expect. The result is that we
generally go execute the kernel on a CPU that ought not to be running &
the results can be unpredictable.

Handle this case by stopping VPs that we don't expect to be running in
mips_cps_boot_vpes() - with this change even if a core powers up it will
do nothing useful & all VPs within it will stop running before they
proceed to run general kernel code & do any damage. Ideally we would
produce some sort of warning here, but given the stage of core bringup
this happens at that would be non-trivial. We also will only hit this if
a core starts up after being offlined via hotplug, and when that happens
we will already produce a warning that the CPU didn't power down in
cps_cpu_die() which seems sufficient.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/kernel/cps-vec.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index a00e87b0256d..b849fe6aad94 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -22,6 +22,7 @@
 #define GCR_CL_COHERENCE_OFS	0x2008
 #define GCR_CL_ID_OFS		0x2028
 
+#define CPC_CL_VC_STOP_OFS	0x2020
 #define CPC_CL_VC_RUN_OFS	0x2028
 
 .extern mips_cm_base
@@ -376,8 +377,12 @@ LEAF(mips_cps_boot_vpes)
 	PTR_LI	t2, UNCAC_BASE
 	PTR_ADD	t1, t1, t2
 
-	/* Set VC_RUN to the VPE mask */
+	/* Start any other VPs that ought to be running */
 	PTR_S	ta2, CPC_CL_VC_RUN_OFS(t1)
+
+	/* Ensure this VP stops running if it shouldn't be */
+	not	ta2
+	PTR_S	ta2, CPC_CL_VC_STOP_OFS(t1)
 	ehb
 
 #elif defined(CONFIG_MIPS_MT)
-- 
2.13.0
