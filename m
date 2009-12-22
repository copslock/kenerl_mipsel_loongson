Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2009 02:43:53 +0100 (CET)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:47018 "EHLO
        sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1495728AbZLVBnt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2009 02:43:49 +0100
Authentication-Results: sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAPOyL0urRN+J/2dsb2JhbADAG5ZBhC4E
X-IronPort-AV: E=Sophos;i="4.47,434,1257120000"; 
   d="scan'208";a="66031987"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-4.cisco.com with ESMTP; 22 Dec 2009 01:43:43 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id nBM1hhX6010842;
        Tue, 22 Dec 2009 01:43:43 GMT
Date:   Mon, 21 Dec 2009 17:43:42 -0800
From:   David VomLehn <dvomlehn@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] powertv: Remove extra r4k_clockevent_init() call
Message-ID: <20091222014342.GA29079@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

A call to r4k_clocksource_init() was added to plat_time_init(), but
when init_mips_clock_source() calls the same function, boot fails in
clockevents_register_device(). This patch removes the extraneous call.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/powertv/time.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/powertv/time.c b/arch/mips/powertv/time.c
index 1e0a5ef..9fd7b67 100644
--- a/arch/mips/powertv/time.c
+++ b/arch/mips/powertv/time.c
@@ -33,5 +33,4 @@ unsigned int __cpuinit get_c0_compare_int(void)
 void __init plat_time_init(void)
 {
 	powertv_clocksource_init();
-	r4k_clockevent_init();
 }
