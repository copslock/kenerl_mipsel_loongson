Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 16:03:06 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:32343 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835156Ab3FQOBdNXIqm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jun 2013 16:01:33 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <sibyte-users@bitmover.com>
Subject: [PATCH 4/7] MIPS: sibyte: Amend dependencies for SIBYTE_BUS_WATCHER
Date:   Mon, 17 Jun 2013 15:00:38 +0100
Message-ID: <1371477641-7989-5-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 36949
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

SIBYTE_BUS_WATCHER is only visible if CONFIG_SIBYTE_BCM112X
or CONFIG_SIBYTE_SB1250 is selected according to the
arch/mips/sibyte/Makefile.
This fixes the following build problem:

arch/mips/mm/cerr-sb1.c:254: undefined reference to `check_bus_watcher'

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: sibyte-users@bitmover.com
---
 arch/mips/sibyte/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/sibyte/Kconfig b/arch/mips/sibyte/Kconfig
index 01cc1a7..5fbd360 100644
--- a/arch/mips/sibyte/Kconfig
+++ b/arch/mips/sibyte/Kconfig
@@ -147,7 +147,8 @@ config SIBYTE_CFE_CONSOLE
 
 config SIBYTE_BUS_WATCHER
 	bool "Support for Bus Watcher statistics"
-	depends on SIBYTE_SB1xxx_SOC
+	depends on SIBYTE_SB1xxx_SOC && \
+		(SIBYTE_BCM112X || SIBYTE_SB1250)
 	help
 	  Handle and keep statistics on the bus error interrupts (COR_ECC,
 	  BAD_ECC, IO_BUS).
-- 
1.8.2.1
