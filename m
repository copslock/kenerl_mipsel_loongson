Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 12:10:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43829 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822197AbaGDKJhe0PUb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jul 2014 12:09:37 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 808E99083AFA8
        for <linux-mips@linux-mips.org>; Fri,  4 Jul 2014 11:09:27 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.10.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 4 Jul
 2014 11:09:29 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.10.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 4 Jul 2014 11:09:29 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 4 Jul 2014 11:09:29 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/2] MIPS: perf: Allow for more perf events
Date:   Fri, 4 Jul 2014 11:08:56 +0100
Message-ID: <1404468537-8808-2-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 41024
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

In mipsxx_pmu_map_raw_event(), set event_id to base_id after the cpu
type conditional code to allow that code to override the base_id to use
more bits from the config and a higher bit for parity.

This will allow cores with up to 512 events between all even/odd
counters (an 8-bit event id) such as P5600 to use bit 8 for parity.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/perf_event_mipsxx.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 4f2d9dece7ab..ef8b3d994c5a 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1420,20 +1420,23 @@ static irqreturn_t mipsxx_pmu_handle_irq(int irq, void *dev)
 
 
 /*
- * User can use 0-255 raw events, where 0-127 for the events of even
- * counters, and 128-255 for odd counters. Note that bit 7 is used to
- * indicate the parity. So, for example, when user wants to take the
- * Event Num of 15 for odd counters (by referring to the user manual),
- * then 128 needs to be added to 15 as the input for the event config,
- * i.e., 143 (0x8F) to be used.
+ * For most cores the user can use 0-255 raw events, where 0-127 for the events
+ * of even counters, and 128-255 for odd counters. Note that bit 7 is used to
+ * indicate the even/odd bank selector. So, for example, when user wants to take
+ * the Event Num of 15 for odd counters (by referring to the user manual), then
+ * 128 needs to be added to 15 as the input for the event config, i.e., 143 (0x8F)
+ * to be used.
+ *
+ * Some newer cores have even more events, in which case the user can use raw
+ * events 0-511, where 0-255 are for the events of even counters, and 256-511
+ * are for odd counters, so bit 8 is used to indicate the even/odd bank selector.
  */
 static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 {
+	/* currently most cores have 7-bit event numbers */
 	unsigned int raw_id = config & 0xff;
 	unsigned int base_id = raw_id & 0x7f;
 
-	raw_event.event_id = base_id;
-
 	switch (current_cpu_type()) {
 	case CPU_24K:
 		if (IS_BOTH_COUNTERS_24K_EVENT(base_id))
@@ -1523,6 +1526,8 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
 	}
 
+	raw_event.event_id = base_id;
+
 	return &raw_event;
 }
 
-- 
2.0.0
