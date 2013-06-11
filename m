Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jun 2013 11:52:28 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:56268 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823001Ab3FKJwYQl9E8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jun 2013 11:52:24 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Kconfig: Set default value for the "Kernel code model"
Date:   Tue, 11 Jun 2013 10:52:16 +0100
Message-ID: <1370944336-13703-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_11_10_52_18
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36825
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

Certain randconfigs may not select neither CONFIG_32BIT nor
CONFIG_64BIT which can lead to build problems and to the following
Kbuild warning:

.config:154:warning: symbol value '' invalid for PHYSICAL_START

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7a58ab9..dffab77 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1714,6 +1714,7 @@ menu "Kernel type"
 
 choice
 	prompt "Kernel code model"
+	default 32BIT
 	help
 	  You should only select this option if you have a workload that
 	  actually benefits from 64-bit processing or if your machine has
-- 
1.8.2.1
