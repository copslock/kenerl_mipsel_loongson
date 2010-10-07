Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 01:05:03 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18301 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491186Ab0JGXE7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 01:04:59 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cae50d90000>; Thu, 07 Oct 2010 18:59:37 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:24 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:24 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o97N4At2026984;
        Thu, 7 Oct 2010 16:04:10 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o97N49ea026983;
        Thu, 7 Oct 2010 16:04:09 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 13/14] watchdog: octeon-wdt: Use I/O clock rate for timing calculations.
Date:   Thu,  7 Oct 2010 16:03:52 -0700
Message-Id: <1286492633-26885-14-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2010 23:04:24.0324 (UTC) FILETIME=[FBE03C40:01CB6673]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The creation of the I/O clock domain requires some adjustments.  Since
the watchdog counters are clocked by the I/O clock, use its rate for
timing calculations.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/octeon-wdt-main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 2a41017..fb0aed0 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -477,7 +477,7 @@ static void octeon_wdt_calc_parameters(int t)
 
 	countdown_reset = periods > 2 ? periods - 2 : 0;
 	heartbeat = t;
-	timeout_cnt = ((octeon_get_clock_rate() >> 8) * timeout_sec) >> 8;
+	timeout_cnt = ((octeon_get_io_clock_rate() >> 8) * timeout_sec) >> 8;
 }
 
 static int octeon_wdt_set_heartbeat(int t)
@@ -676,7 +676,7 @@ static int __init octeon_wdt_init(void)
 	max_timeout_sec = 6;
 	do {
 		max_timeout_sec--;
-		timeout_cnt = ((octeon_get_clock_rate() >> 8) * max_timeout_sec) >> 8;
+		timeout_cnt = ((octeon_get_io_clock_rate() >> 8) * max_timeout_sec) >> 8;
 	} while (timeout_cnt > 65535);
 
 	BUG_ON(timeout_cnt == 0);
-- 
1.7.2.3
