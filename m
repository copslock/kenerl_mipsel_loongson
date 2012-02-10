Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2012 14:43:55 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:60936 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903554Ab2BJNnt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Feb 2012 14:43:49 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id C731146278D;
        Fri, 10 Feb 2012 14:43:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8NGCCeY7HFPd; Fri, 10 Feb 2012 14:43:48 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 6A46B4626DF;
        Fri, 10 Feb 2012 14:43:48 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, david.daney@cavium.com,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: perf: remove unused counters_per_cpu_to_total function
Date:   Fri, 10 Feb 2012 14:42:53 +0100
Message-Id: <1328881373-16716-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 32415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This function is currently unused and causes a build error:
cc1: warnings being treated as errors
arch/mips/kernel/perf_event_mipsxx.c:166: error: 'counters_per_cpu_to_total' defined but not used
make[2]: *** [arch/mips/kernel/perf_event_mipsxx.o] Error 1
make[2]: *** Waiting for unfinished jobs....

It was first introduced in commit:
82091564: MIPS: perf: Add support for 64-bit perf counters.
and is applicable to 3.2 onwards.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/kernel/perf_event_mipsxx.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index e3b897a..25e8fae 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -162,11 +162,6 @@ static unsigned int counters_total_to_per_cpu(unsigned int counters)
 	return counters >> vpe_shift();
 }
 
-static unsigned int counters_per_cpu_to_total(unsigned int counters)
-{
-	return counters << vpe_shift();
-}
-
 #else /* !CONFIG_MIPS_MT_SMP */
 #define vpe_id()	0
 
-- 
1.7.5.4
