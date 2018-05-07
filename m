Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2018 15:16:57 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:43140 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993997AbeEGNQuoFF1A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 May 2018 15:16:50 +0200
From:   John Crispin <john@phrozen.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH] watchdog: ath79: fix maximum timeout
Date:   Mon,  7 May 2018 15:16:42 +0200
Message-Id: <20180507131642.11440-1-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

If the userland tries to set a timeout higher than the max_timeout,
then we should fallback to max_timeout.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/watchdog/ath79_wdt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index e2209bf5fa8a..c2fc6c3d0092 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -115,10 +115,14 @@ static inline void ath79_wdt_disable(void)
 
 static int ath79_wdt_set_timeout(int val)
 {
-	if (val < 1 || val > max_timeout)
+	if (val < 1)
 		return -EINVAL;
 
-	timeout = val;
+	if (val > max_timeout)
+		timeout = max_timeout;
+	else
+		timeout = val;
+
 	ath79_wdt_keepalive();
 
 	return 0;
-- 
2.11.0
