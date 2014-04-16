Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:57:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:60561 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834699AbaDPM5HXrMUC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:57:07 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6B81D27ADAF11
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:56:57 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:56:59 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:56:59 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 11/39] MIPS: support for generic clockevents broadcast
Date:   Wed, 16 Apr 2014 13:53:02 +0100
Message-ID: <1397652810-4336-12-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39818
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

This patch adds support for generic clockevents broadcast using the a
dummy clockevent device and the tick_broadcast function introduced by
commit 12ad10004645 "clockevents: Add generic timer broadcast function".

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig      |  1 +
 arch/mips/kernel/smp.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 322bbe1..5cdc53b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -51,6 +51,7 @@ config MIPS
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_CC_STACKPROTECTOR
 	select CPU_PM if CPU_IDLE
+	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 
 menu "Machine selection"
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 0a022ee..9a52264 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -404,3 +404,46 @@ void dump_send_ipi(void (*dump_ipi_callback)(void *))
 }
 EXPORT_SYMBOL(dump_send_ipi);
 #endif
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+
+static DEFINE_PER_CPU(atomic_t, tick_broadcast_count);
+static DEFINE_PER_CPU(struct call_single_data, tick_broadcast_csd);
+
+void tick_broadcast(const struct cpumask *mask)
+{
+	atomic_t *count;
+	struct call_single_data *csd;
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		count = &per_cpu(tick_broadcast_count, cpu);
+		csd = &per_cpu(tick_broadcast_csd, cpu);
+
+		if (atomic_inc_return(count) == 1)
+			smp_call_function_single_async(cpu, csd);
+	}
+}
+
+static void tick_broadcast_callee(void *info)
+{
+	int cpu = smp_processor_id();
+	tick_receive_broadcast();
+	atomic_set(&per_cpu(tick_broadcast_count, cpu), 0);
+}
+
+static int __init tick_broadcast_init(void)
+{
+	struct call_single_data *csd;
+	int cpu;
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		csd = &per_cpu(tick_broadcast_csd, cpu);
+		csd->func = tick_broadcast_callee;
+	}
+
+	return 0;
+}
+early_initcall(tick_broadcast_init);
+
+#endif /* CONFIG_GENERIC_CLOCKEVENTS_BROADCAST */
-- 
1.8.5.3
