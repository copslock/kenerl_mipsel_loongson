Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jul 2013 10:21:56 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:33660 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835021Ab3GIIVzPPDe0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Jul 2013 10:21:55 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: pnx833x: PNX8335_PCI_ETHERNET_INT depends on CONFIG_SOC_PNX8335
Date:   Tue, 9 Jul 2013 09:21:35 +0100
Message-ID: <1373358095-14213-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.58]
X-SEF-Processed: 7_3_0_01192__2013_07_09_09_21_49
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37279
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

The PNX8335_PCI_ETHERNET_INT macro is defined in
arch/mips/include/asm/mach-pnx833x/irq-mapping.h
only if CONFIG_SOC_PNX8335 is selected.

Fixes the following randconfig problem:
arch/mips/pnx833x/common/platform.c:210:12:
error: 'PNX8335_PIC_ETHERNET_INT' undeclared here
(not in a function)

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/pnx833x/common/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/pnx833x/common/platform.c b/arch/mips/pnx833x/common/platform.c
index d22dc0d..2b7e837 100644
--- a/arch/mips/pnx833x/common/platform.c
+++ b/arch/mips/pnx833x/common/platform.c
@@ -206,11 +206,13 @@ static struct resource pnx833x_ethernet_resources[] = {
 		.end   = PNX8335_IP3902_PORTS_END,
 		.flags = IORESOURCE_MEM,
 	},
+#ifdef CONFIG_SOC_PNX8335
 	[1] = {
 		.start = PNX8335_PIC_ETHERNET_INT,
 		.end   = PNX8335_PIC_ETHERNET_INT,
 		.flags = IORESOURCE_IRQ,
 	},
+#endif
 };
 
 static struct platform_device pnx833x_ethernet_device = {
-- 
1.8.2.1
