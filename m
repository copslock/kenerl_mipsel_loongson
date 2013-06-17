Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 16:03:25 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:32336 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835182Ab3FQOBdNqBhl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jun 2013 16:01:33 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <sibyte-users@bitmover.com>, Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 5/7] drivers: watchdog: sb_wdog: Fix 32bit linking problems
Date:   Mon, 17 Jun 2013 15:00:39 +0100
Message-ID: <1371477641-7989-6-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1371477641-7989-1-git-send-email-markos.chandras@imgtec.com>
References: <1371477641-7989-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_17_15_01_27
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36950
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

Fixes the following linking problem:
drivers/watchdog/sb_wdog.c:211: undefined reference to `__udivdi3'

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: sibyte-users@bitmover.com
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/sb_wdog.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
index 25c7a3f..2ea0427 100644
--- a/drivers/watchdog/sb_wdog.c
+++ b/drivers/watchdog/sb_wdog.c
@@ -170,6 +170,7 @@ static long sbwdog_ioctl(struct file *file, unsigned int cmd,
 						unsigned long arg)
 {
 	int ret = -ENOTTY;
+	u64 tmp_user_dog;
 	unsigned long time;
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
@@ -208,7 +209,9 @@ static long sbwdog_ioctl(struct file *file, unsigned int cmd,
 		 * get the remaining count from the ... count register
 		 * which is 1*8 before the config register
 		 */
-		ret = put_user(__raw_readq(user_dog - 8) / 1000000, p);
+		tmp_user_dog = __raw_readq(user_dog - 8);
+		tmp_user_dog = do_div(tmp_user_dog, 1000000);
+		ret = put_user(tmp_user_dog, p);
 		break;
 	}
 	return ret;
-- 
1.8.2.1
