Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 11:22:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:49514 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823984AbaCXKVd3yFSo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Mar 2014 11:21:33 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 01D0DAF24234B
        for <linux-mips@linux-mips.org>; Mon, 24 Mar 2014 10:21:26 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:21:27 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:21:27 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 08/12] MIPS: smp-mt: use common GIC IPI implementation
Date:   Mon, 24 Mar 2014 10:19:31 +0000
Message-ID: <1395656375-9300-9-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
References: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39568
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

Rather than duplicating the GIC IPI send function, share the one already
used by CONFIG_MIPS_CPS & CONFIG_MIPS_CMP.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig         |  1 +
 arch/mips/kernel/smp-mt.c | 23 +----------------------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index be78fedf..318720c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1902,6 +1902,7 @@ config MIPS_MT_SMP
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K
+	select MIPS_GIC_IPI
 	select MIPS_MT
 	select SMP
 	select SMP_UP
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 0fb8cef..34d3c6b 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -113,27 +113,6 @@ static void __init smvp_tc_init(unsigned int tc, unsigned int mvpconf0)
 	write_tc_c0_tchalt(TCHALT_H);
 }
 
-#ifdef CONFIG_IRQ_GIC
-static void mp_send_ipi_single(int cpu, unsigned int action)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	switch (action) {
-	case SMP_CALL_FUNCTION:
-		gic_send_ipi(plat_ipi_call_int_xlate(cpu));
-		break;
-
-	case SMP_RESCHEDULE_YOURSELF:
-		gic_send_ipi(plat_ipi_resched_int_xlate(cpu));
-		break;
-	}
-
-	local_irq_restore(flags);
-}
-#endif
-
 static void vsmp_send_ipi_single(int cpu, unsigned int action)
 {
 	int i;
@@ -142,7 +121,7 @@ static void vsmp_send_ipi_single(int cpu, unsigned int action)
 
 #ifdef CONFIG_IRQ_GIC
 	if (gic_present) {
-		mp_send_ipi_single(cpu, action);
+		gic_send_ipi_single(cpu, action);
 		return;
 	}
 #endif
-- 
1.8.5.3
