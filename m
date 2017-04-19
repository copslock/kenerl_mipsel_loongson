Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Apr 2017 14:08:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36400 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990924AbdDSMHxtklRL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Apr 2017 14:07:53 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 85BAA5DAE965D;
        Wed, 19 Apr 2017 13:07:44 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 19 Apr 2017 13:07:47 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH] MIPS: perf: remove odd/even counter handling for I6400
Date:   Wed, 19 Apr 2017 14:07:43 +0200
Message-ID: <1492603663-26855-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

All performance counters on I6400 (odd and even) are capable of counting
any of the available events, so drop current logic of using the extra
bit to determine which counter to use.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Fixes: 4e88a8621301 ("MIPS: Add cases for CPU_I6400")
Fixes: fd716fca10fc ("MIPS: perf: Fix I6400 event numbers")
---
 arch/mips/kernel/perf_event_mipsxx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 8c35b31..2374cda 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1597,7 +1597,6 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 		break;
 	case CPU_P5600:
 	case CPU_P6600:
-	case CPU_I6400:
 		/* 8-bit event numbers */
 		raw_id = config & 0x1ff;
 		base_id = raw_id & 0xff;
@@ -1610,6 +1609,11 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 		raw_event.range = P;
 #endif
 		break;
+	case CPU_I6400:
+		/* 8-bit event numbers */
+		base_id = config & 0xff;
+		raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		break;
 	case CPU_1004K:
 		if (IS_BOTH_COUNTERS_1004K_EVENT(base_id))
 			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
-- 
2.7.4
