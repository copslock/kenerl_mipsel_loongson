Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 23:06:44 +0100 (CET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:35608 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006792AbcCGWGmGIRIK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Mar 2016 23:06:42 +0100
Received: from localhost.localdomain (85-76-14-12-nat.elisa-mobile.fi [85.76.14.12])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id C103018878A;
        Tue,  8 Mar 2016 00:06:40 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: fix build with DEBUG_ZBOOT and MACH_JZ4780
Date:   Tue,  8 Mar 2016 00:06:36 +0200
Message-Id: <1457388396-8259-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Ingenic SoC declares ZBOOT support, but debug definitions are missing
for MACH_JZ4780 resulting in a build failure when DEBUG_ZBOOT is set.
The UART addresses are same as with JZ4740, so fix by covering JZ4780
with those as well.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/boot/compressed/uart-16550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
index 408799a..f752114 100644
--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -17,7 +17,7 @@
 #define PORT(offset) (CKSEG1ADDR(AR7_REGS_UART0) + (4 * offset))
 #endif
 
-#ifdef CONFIG_MACH_JZ4740
+#if defined(CONFIG_MACH_JZ4740) || defined(CONFIG_MACH_JZ4780)
 #include <asm/mach-jz4740/base.h>
 #define PORT(offset) (CKSEG1ADDR(JZ4740_UART0_BASE_ADDR) + (4 * offset))
 #endif
-- 
2.4.0
