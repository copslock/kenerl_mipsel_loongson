Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 10:52:28 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54321 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819996Ab3DMIw06k21C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 10:52:26 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH V3 01/14] MIPS: ralink: add PCI IRQ handling
Date:   Sat, 13 Apr 2013 10:48:12 +0200
Message-Id: <1365842905-10906-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

From: Gabor Juhos <juhosg@openwrt.org>

The Ralink IRQ code was not handling the PCI IRQ yet. Add this functionaility
to make PCI work on rt3883.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ralink/irq.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 6d054c5..d9807d0 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -31,6 +31,7 @@
 #define INTC_INT_GLOBAL		BIT(31)
 
 #define RALINK_CPU_IRQ_INTC	(MIPS_CPU_IRQ_BASE + 2)
+#define RALINK_CPU_IRQ_PCI	(MIPS_CPU_IRQ_BASE + 4)
 #define RALINK_CPU_IRQ_FE	(MIPS_CPU_IRQ_BASE + 5)
 #define RALINK_CPU_IRQ_WIFI	(MIPS_CPU_IRQ_BASE + 6)
 #define RALINK_CPU_IRQ_COUNTER	(MIPS_CPU_IRQ_BASE + 7)
@@ -104,6 +105,9 @@ asmlinkage void plat_irq_dispatch(void)
 	else if (pending & STATUSF_IP6)
 		do_IRQ(RALINK_CPU_IRQ_WIFI);
 
+	else if (pending & STATUSF_IP4)
+		do_IRQ(RALINK_CPU_IRQ_PCI);
+
 	else if (pending & STATUSF_IP2)
 		do_IRQ(RALINK_CPU_IRQ_INTC);
 
-- 
1.7.10.4
