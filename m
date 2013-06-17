Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 16:03:47 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:32343 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835256Ab3FQOBdYn70f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jun 2013 16:01:33 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <sibyte-users@bitmover.com>, <netdev@vger.kernel.org>,
        Michael Buesch <m@bues.ch>
Subject: [PATCH 6/7] drivers: ssb: Kconfig: Amend SSB_EMBEDDED dependencies
Date:   Mon, 17 Jun 2013 15:00:40 +0100
Message-ID: <1371477641-7989-7-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 36951
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

SSB_EMBEDDED needs functions from driver_pcicore which are only
available if SSD_DRIVER_HOSTMODE is selected so make it
depend on that symbol.

Fixes the following linking problem:

drivers/ssb/embedded.c:202:
undefined reference to `ssb_pcicore_plat_dev_init'
drivers/built-in.o: In function `ssb_pcibios_map_irq':
drivers/ssb/embedded.c:247:
undefined reference to `ssb_pcicore_pcibios_map_irq'

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: sibyte-users@bitmover.com
Cc: netdev@vger.kernel.org
Cc: Michael Buesch <m@bues.ch>
---
 drivers/ssb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index 5ff3a4f..36171fd 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -144,7 +144,7 @@ config SSB_SFLASH
 # Assumption: We are on embedded, if we compile the MIPS core.
 config SSB_EMBEDDED
 	bool
-	depends on SSB_DRIVER_MIPS
+	depends on SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
 	default y
 
 config SSB_DRIVER_EXTIF
-- 
1.8.2.1
