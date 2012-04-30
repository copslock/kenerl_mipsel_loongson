Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 13:37:27 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56988 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903714Ab2D3Lef (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 13:34:35 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 08/14] MIPS: lantiq: clear all irqs properly on boot
Date:   Mon, 30 Apr 2012 13:33:03 +0200
Message-Id: <1335785589-32532-8-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Due to a wrongly placed bracket, the irq modules were not properly reset on
boot.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/irq.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index d673731..b6b1c72 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -271,12 +271,13 @@ void __init arch_init_irq(void)
 	if (!ltq_eiu_membase)
 		panic("Failed to remap eiu memory");
 
-	/* make sure all irqs are turned off by default */
-	for (i = 0; i < 5; i++)
+	/* turn off all irqs by default */
+	for (i = 0; i < 5; i++) {
+		/* make sure all irqs are turned off by default */
 		ltq_icu_w32(0, LTQ_ICU_IM0_IER + (i * LTQ_ICU_OFFSET));
-
-	/* clear all possibly pending interrupts */
-	ltq_icu_w32(~0, LTQ_ICU_IM0_ISR + (i * LTQ_ICU_OFFSET));
+		/* clear all possibly pending interrupts */
+		ltq_icu_w32(~0, LTQ_ICU_IM0_ISR + (i * LTQ_ICU_OFFSET));
+	}
 
 	mips_cpu_irq_init();
 
-- 
1.7.9.1
