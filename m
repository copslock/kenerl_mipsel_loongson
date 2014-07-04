Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 12:09:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55711 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837945AbaGDKJiKcgaA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jul 2014 12:09:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0F5CC33061726
        for <linux-mips@linux-mips.org>; Fri,  4 Jul 2014 11:09:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 4 Jul 2014 11:09:31 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 4 Jul 2014 11:09:30 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/2] MIPS: perf: Add hardware events for P5600
Date:   Fri, 4 Jul 2014 11:08:57 +0100
Message-ID: <1404468537-8808-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404468537-8808-1-git-send-email-markos.chandras@imgtec.com>
References: <1404468537-8808-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: James Hogan <james.hogan@imgtec.com>

Add cases in perf_event_mipsxx.c for CPU_P5600. All the event numbers
listed for proAptiv also apply to P5600, so we use mipsxxcore_event_map2
and mipsxxcore_cache_map2 too, but the P5600 has 8-bit event numbers so
bit 8 (256) of the user ABI config is used for the parity bit (to
specify odd/even counter events).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/perf_event_mipsxx.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index ef8b3d994c5a..14bf74b0f51c 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1386,6 +1386,9 @@ static irqreturn_t mipsxx_pmu_handle_irq(int irq, void *dev)
 /* proAptiv */
 #define IS_BOTH_COUNTERS_PROAPTIV_EVENT(b)				\
 	((b) == 0 || (b) == 1)
+/* P5600 */
+#define IS_BOTH_COUNTERS_P5600_EVENT(b)					\
+	((b) == 0 || (b) == 1)
 
 /* 1004K */
 #define IS_BOTH_COUNTERS_1004K_EVENT(b)					\
@@ -1488,6 +1491,19 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 		raw_event.range = P;
 #endif
 		break;
+	case CPU_P5600:
+		/* 8-bit event numbers */
+		raw_id = config & 0x1ff;
+		base_id = raw_id & 0xff;
+		if (IS_BOTH_COUNTERS_P5600_EVENT(base_id))
+			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		else
+			raw_event.cntr_mask =
+				raw_id > 255 ? CNTR_ODD : CNTR_EVEN;
+#ifdef CONFIG_MIPS_MT_SMP
+		raw_event.range = P;
+#endif
+		break;
 	case CPU_1004K:
 		if (IS_BOTH_COUNTERS_1004K_EVENT(base_id))
 			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
@@ -1638,6 +1654,11 @@ init_hw_perf_events(void)
 		mipspmu.general_event_map = &mipsxxcore_event_map2;
 		mipspmu.cache_event_map = &mipsxxcore_cache_map2;
 		break;
+	case CPU_P5600:
+		mipspmu.name = "mips/P5600";
+		mipspmu.general_event_map = &mipsxxcore_event_map2;
+		mipspmu.cache_event_map = &mipsxxcore_cache_map2;
+		break;
 	case CPU_1004K:
 		mipspmu.name = "mips/1004K";
 		mipspmu.general_event_map = &mipsxxcore_event_map;
-- 
2.0.0
