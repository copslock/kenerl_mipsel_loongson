Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 07:24:41 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:32864 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491206Ab0CIGYg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Mar 2010 07:24:36 +0100
Received: from localhost.localdomain (pek-lpgbuild1.wrs.com [128.224.153.29])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o296ONxo028846;
        Mon, 8 Mar 2010 22:24:24 -0800 (PST)
From:   Yang Shi <yang.shi@windriver.com>
To:     ddaney@caviumnetworks.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Octeon: Fix wrong variable type in smp.c
Date:   Tue,  9 Mar 2010 14:24:22 +0800
Message-Id: <1268115862-25976-1-git-send-email-yang.shi@windriver.com>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <yang.shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Change cvmx_ciu_wdogx_t type to "union cvmx_ciu_wdogx".

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/mips/cavium-octeon/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 51e9802..52d61ba 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -281,7 +281,7 @@ static void octeon_cpu_die(unsigned int cpu)
 
 #ifdef CONFIG_CAVIUM_OCTEON_WATCHDOG
 	/* Disable the watchdog */
-	cvmx_ciu_wdogx_t ciu_wdog;
+	union cvmx_ciu_wdogx ciu_wdog;
 	ciu_wdog.u64 = cvmx_read_csr(CVMX_CIU_WDOGX(cpu));
 	ciu_wdog.s.mode = 0;
 	cvmx_write_csr(CVMX_CIU_WDOGX(cpu), ciu_wdog.u64);
-- 
1.6.3.3
