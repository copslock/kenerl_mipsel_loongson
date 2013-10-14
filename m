Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2013 10:49:19 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:48530 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817315Ab3JNItPi0d-5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Oct 2013 10:49:15 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Malta: Remove ttyS2 serial for CMP platforms
Date:   Mon, 14 Oct 2013 09:49:25 +0100
Message-ID: <1381740565-17243-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_14_09_49_07
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38319
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Commit 225ae5fd9a320e22841410049c3bdb6cf14a5841
"MIPS: Malta: Fix interupt number of CBUS UART"

fixed the IRQ number for the ttyS2 CBUS UART. However, this now
conflicts with the GIC IPI1 interrupt in CMP platforms. The Malta
interrupt code arbitrarily binds IPIs to INT2 and INT3 and since
ttyS2 uses the INT2 IRQ line, closing the device disables the
INT2 interrupt and this effectively disables the IPI1 interrupt
as well. This patch is mainly a workaround until the Malta code
is fixed properly.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mti-malta/malta-platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/mti-malta/malta-platform.c b/arch/mips/mti-malta/malta-platform.c
index 132f866..e1dd1c1 100644
--- a/arch/mips/mti-malta/malta-platform.c
+++ b/arch/mips/mti-malta/malta-platform.c
@@ -47,6 +47,7 @@
 static struct plat_serial8250_port uart8250_data[] = {
 	SMC_PORT(0x3F8, 4),
 	SMC_PORT(0x2F8, 3),
+#ifndef CONFIG_MIPS_CMP
 	{
 		.mapbase	= 0x1f000900,	/* The CBUS UART */
 		.irq		= MIPS_CPU_IRQ_BASE + MIPSCPU_INT_MB2,
@@ -55,6 +56,7 @@ static struct plat_serial8250_port uart8250_data[] = {
 		.flags		= CBUS_UART_FLAGS,
 		.regshift	= 3,
 	},
+#endif
 	{ },
 };
 
-- 
1.8.3.2
