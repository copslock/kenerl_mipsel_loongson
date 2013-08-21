Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 12:48:54 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:2894 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826530Ab3HUKswZ4RG9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 12:48:52 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2] MIPS: ath79: Avoid using unitialized 'reg' variable
Date:   Wed, 21 Aug 2013 11:47:22 +0100
Message-ID: <1377082042-4219-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.130]
X-SEF-Processed: 7_3_0_01192__2013_08_21_11_48_47
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37616
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

Fixes the following build error:
arch/mips/include/asm/mach-ath79/ath79.h:139:20: error: 'reg' may be used
uninitialized in this function [-Werror=maybe-uninitialized]
arch/mips/ath79/common.c:62:6: note: 'reg' was declared here
In file included from arch/mips/ath79/common.c:20:0:
arch/mips/ath79/common.c: In function 'ath79_device_reset_clear':
arch/mips/include/asm/mach-ath79/ath79.h:139:20:
error: 'reg' may be used uninitialized in this function
[-Werror=maybe-uninitialized]
arch/mips/ath79/common.c:90:6: note: 'reg' was declared here

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Changes since v1:
http://www.linux-mips.org/archives/linux-mips/2013-08/msg00126.html
- Remove BUG(). panic() is enough.
http://www.linux-mips.org/archives/linux-mips/2013-08/msg00133.html
- Change panic() message to be more accurate.
http://www.linux-mips.org/archives/linux-mips/2013-08/msg00164.html
---
 arch/mips/ath79/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index eb3966c..6d7a9d4 100644
--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -75,7 +75,7 @@ void ath79_device_reset_set(u32 mask)
 	else if (soc_is_qca955x())
 		reg = QCA955X_RESET_REG_RESET_MODULE;
 	else
-		BUG();
+		panic("Reset register not defined for this SOC");
 
 	spin_lock_irqsave(&ath79_device_reset_lock, flags);
 	t = ath79_reset_rr(reg);
@@ -103,7 +103,7 @@ void ath79_device_reset_clear(u32 mask)
 	else if (soc_is_qca955x())
 		reg = QCA955X_RESET_REG_RESET_MODULE;
 	else
-		BUG();
+		panic("Reset register not defined for this SOC");
 
 	spin_lock_irqsave(&ath79_device_reset_lock, flags);
 	t = ath79_reset_rr(reg);
-- 
1.8.3.2
