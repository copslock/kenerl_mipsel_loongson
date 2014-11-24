Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 16:31:37 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:35598 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006832AbaKXPbdFi84F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Nov 2014 16:31:33 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id CEF652E32D;
        Mon, 24 Nov 2014 16:31:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 2HyHKpeni2ZS; Mon, 24 Nov 2014 16:31:22 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id A475B2E2E8;
        Mon, 24 Nov 2014 16:31:21 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 8CA7EF20;
        Mon, 24 Nov 2014 16:31:21 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id 7E05274F;
        Mon, 24 Nov 2014 16:31:21 +0100 (CET)
Received: from lnxrabinv.se.axis.com (lnxrabinv.se.axis.com [10.88.144.1])
        by thoth.se.axis.com (Postfix) with ESMTP id 7B9C134369;
        Mon, 24 Nov 2014 16:31:21 +0100 (CET)
Received: by lnxrabinv.se.axis.com (Postfix, from userid 10564)
        id 70417200BB; Mon, 24 Nov 2014 16:31:21 +0100 (CET)
From:   Rabin Vincent <rabin.vincent@axis.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rabin@rab.in,
        Rabin Vincent <rabinv@axis.com>
Subject: [PATCH] MIPS: provide sched_clock based on c0 counter
Date:   Mon, 24 Nov 2014 16:31:09 +0100
Message-Id: <1416843069-28789-1-git-send-email-rabin.vincent@axis.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <rabin.vincent@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rabin.vincent@axis.com
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

Provide a high-resolution sched_clock() based on the C0 counter using
the generic sched_clock infrastructure.

Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
---
 arch/mips/Kconfig           |    1 +
 arch/mips/kernel/csrc-r4k.c |    7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f43aa53..8068259 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -924,6 +924,7 @@ config CSRC_IOASIC
 	bool
 
 config CSRC_R4K
+	select GENERIC_SCHED_CLOCK
 	bool
 
 config CSRC_GIC
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index decd1fa..318fec6 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2007 by Ralf Baechle
  */
 #include <linux/clocksource.h>
+#include <linux/sched_clock.h>
 #include <linux/init.h>
 
 #include <asm/time.h>
@@ -22,6 +23,11 @@ static struct clocksource clocksource_mips = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static u64 c0_hpt_read_sched_clock(void)
+{
+	return read_c0_count();
+}
+
 int __init init_r4k_clocksource(void)
 {
 	if (!cpu_has_counter || !mips_hpt_frequency)
@@ -31,6 +37,7 @@ int __init init_r4k_clocksource(void)
 	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
 
 	clocksource_register_hz(&clocksource_mips, mips_hpt_frequency);
+	sched_clock_register(c0_hpt_read_sched_clock, 32, mips_hpt_frequency);
 
 	return 0;
 }
-- 
1.7.10.4
