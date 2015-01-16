Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:12:01 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16359 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010992AbbAPLLFbzbBG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 12:11:05 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7F39D86105CAD;
        Fri, 16 Jan 2015 11:10:57 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 11:10:59 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 11:10:57 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v3.19] MIPS: smp-mt,smp-cmp: Enable all HW IRQs on secondary CPUs
Date:   Fri, 16 Jan 2015 11:10:46 +0000
Message-ID: <1421406646-28920-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Commit 18743d2781d0 ("irqchip: mips-gic: Stop using per-platform mapping
tables") in v3.19-rc1 changed the routing of IPIs through the GIC to go
to the HW0 IRQ pin along with the rest of the GIC interrupts, rather
than to HW1 and HW2 pins.

This breaks SMP boot using the CMP or MT SMP implementations because HW0
doesn't get unmasked when secondary CPUs are initialised so the IPIs
will never interrupt secondary CPUs (nor any other interrupts routed
through the GIC).

Commit ff1e29ade4c6 ("MIPS: smp-cps: Enable all hardware interrupts on
secondary CPUs") fixed this in advance for the CPS SMP implementation by
unmasking all hardware interrupt lines for secondary CPUs, so lets do
the same for the CMP and MT implementations.

Fixes: 18743d2781d0 ("irqchip: mips-gic: Stop using per-platform mapping tables")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Qais Yousef <qais.yousef@imgtec.com>
Cc: linux-mips@linux-mips.org
---
Note that CMP is still broken with Malta since the GIC driver now routes
the local timer interrupt to a different IRQ pin to that expected by the
CMP wait loop (see commit e9de688dac65 ("irqchip: mips-gic: Support
local interrupts")), so the secondary CPU never completes its wait
instruction to poll the LAUNCH_FGO flag, but that is a different issue.
---
 arch/mips/kernel/smp-cmp.c | 4 ++--
 arch/mips/kernel/smp-mt.c  | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index 1e0a93c5a3e7..e36a859af666 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -44,8 +44,8 @@ static void cmp_init_secondary(void)
 	struct cpuinfo_mips *c __maybe_unused = &current_cpu_data;
 
 	/* Assume GIC is present */
-	change_c0_status(ST0_IM, STATUSF_IP3 | STATUSF_IP4 | STATUSF_IP6 |
-				 STATUSF_IP7);
+	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
+				 STATUSF_IP5 | STATUSF_IP6 | STATUSF_IP7);
 
 	/* Enable per-cpu interrupts: platform specific */
 
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index ad86951b73bd..17ea705f6c40 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -161,7 +161,8 @@ static void vsmp_init_secondary(void)
 #ifdef CONFIG_MIPS_GIC
 	/* This is Malta specific: IPI,performance and timer interrupts */
 	if (gic_present)
-		change_c0_status(ST0_IM, STATUSF_IP3 | STATUSF_IP4 |
+		change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 |
+					 STATUSF_IP4 | STATUSF_IP5 |
 					 STATUSF_IP6 | STATUSF_IP7);
 	else
 #endif
-- 
2.0.5
