Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jul 2013 17:11:44 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:48097 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823013Ab3GYPLiFfUfc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Jul 2013 17:11:38 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: powertv: Fix arguments for free_reserved_area()
Date:   Thu, 25 Jul 2013 16:11:28 +0100
Message-ID: <1374765088-27101-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.58]
X-SEF-Processed: 7_3_0_01192__2013_07_25_16_11_32
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37371
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

Commit 6e7582bf35b8a5a330fd08b398ae445bac86917a
"MIPS: PowerTV: use free_reserved_area() to simplify code"

merged in 3.11-rc1, broke the build for the powertv defconfig with
the following build error:

arch/mips/powertv/asic/asic_devices.c: In function 'platform_release_memory':
arch/mips/powertv/asic/asic_devices.c:533:7: error: passing argument 1 of
'free_reserved_area' makes pointer from integer without a cast [-Werror]

The free_reserved_area() function expects a void * pointer for the start
address and a void * pointer for the end one.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/powertv/asic/asic_devices.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
index 9f64c23..0238af1 100644
--- a/arch/mips/powertv/asic/asic_devices.c
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -529,8 +529,7 @@ EXPORT_SYMBOL(asic_resource_get);
  */
 void platform_release_memory(void *ptr, int size)
 {
-	free_reserved_area((unsigned long)ptr, (unsigned long)(ptr + size),
-			   -1, NULL);
+	free_reserved_area(ptr, ptr + size, -1, NULL);
 }
 EXPORT_SYMBOL(platform_release_memory);
 
-- 
1.8.3.2
