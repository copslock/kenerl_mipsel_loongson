Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2010 12:18:24 +0200 (CEST)
Received: from mgw2.diku.dk ([130.225.96.92]:43223 "EHLO mgw2.diku.dk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491030Ab0JZKSU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Oct 2010 12:18:20 +0200
Received: from localhost (localhost [127.0.0.1])
        by mgw2.diku.dk (Postfix) with ESMTP id E405C4DC0F3;
        Tue, 26 Oct 2010 12:18:18 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31747-16; Tue, 26 Oct 2010 12:18:17 +0200 (CEST)
Received: from palace.topps.diku.dk (palace.ekstranet.diku.dk [192.38.115.202])
        by mgw2.diku.dk (Postfix) with ESMTP id 932C14DC0F5;
        Tue, 26 Oct 2010 12:18:14 +0200 (CEST)
From:   Julia Lawall <julia@diku.dk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/14] arch/mips/pmc-sierra/yosemite/setup.c: delete double assignment
Date:   Tue, 26 Oct 2010 12:25:35 +0200
Message-Id: <1288088743-3725-7-git-send-email-julia@diku.dk>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1288088743-3725-1-git-send-email-julia@diku.dk>
References: <1288088743-3725-1-git-send-email-julia@diku.dk>
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

Delete successive assignments to the same location.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression i;
@@

*i = ...;
 i = ...;
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
This change also makes the variable cpu_clock_freq be not used in the
current file.  If this is the correct change to plat_time_init, then
perhaps the declaration of that variable should be moved elsewhere, or the
variable should be deleted completely.

 arch/mips/pmc-sierra/yosemite/setup.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/pmc-sierra/yosemite/setup.c b/arch/mips/pmc-sierra/yosemite/setup.c
index 3498ac9..b56a924 100644
--- a/arch/mips/pmc-sierra/yosemite/setup.c
+++ b/arch/mips/pmc-sierra/yosemite/setup.c
@@ -140,8 +140,7 @@ int rtc_mips_set_time(unsigned long tim)
 
 void __init plat_time_init(void)
 {
-	mips_hpt_frequency = cpu_clock_freq / 2;
-mips_hpt_frequency = 33000000 * 3 * 5;
+	mips_hpt_frequency = 33000000 * 3 * 5;
 }
 
 unsigned long ocd_base;
