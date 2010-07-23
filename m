Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 19:45:58 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9763 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491924Ab0GWRoG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jul 2010 19:44:06 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c49d4ff0003>; Fri, 23 Jul 2010 10:44:31 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:44:04 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:44:04 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6NHhxmB024125;
        Fri, 23 Jul 2010 10:43:59 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6NHhxNU024124;
        Fri, 23 Jul 2010 10:43:59 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/5] MIPS: Octeon: Get rid of a bunch of MSI IRQ number definitions.
Date:   Fri, 23 Jul 2010 10:43:48 -0700
Message-Id: <1279907029-24071-5-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279907029-24071-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279907029-24071-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 23 Jul 2010 17:44:04.0409 (UTC) FILETIME=[A484F290:01CB2A8E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

MSI IRQ numbers are allocated dynamically, so there is no reason to
have all these static definitions.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mach-cavium-octeon/irq.h |   66 +-----------------------
 arch/mips/pci/msi-octeon.c                     |    4 +-
 2 files changed, 4 insertions(+), 66 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index d32220f..783dae7 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -172,71 +172,9 @@
 #ifdef CONFIG_PCI_MSI
 /* 152 - 215 represent the MSI interrupts 0-63 */
 #define OCTEON_IRQ_MSI_BIT0	152
-#define OCTEON_IRQ_MSI_BIT1	153
-#define OCTEON_IRQ_MSI_BIT2	154
-#define OCTEON_IRQ_MSI_BIT3	155
-#define OCTEON_IRQ_MSI_BIT4	156
-#define OCTEON_IRQ_MSI_BIT5	157
-#define OCTEON_IRQ_MSI_BIT6	158
-#define OCTEON_IRQ_MSI_BIT7	159
-#define OCTEON_IRQ_MSI_BIT8	160
-#define OCTEON_IRQ_MSI_BIT9	161
-#define OCTEON_IRQ_MSI_BIT10	162
-#define OCTEON_IRQ_MSI_BIT11	163
-#define OCTEON_IRQ_MSI_BIT12	164
-#define OCTEON_IRQ_MSI_BIT13	165
-#define OCTEON_IRQ_MSI_BIT14	166
-#define OCTEON_IRQ_MSI_BIT15	167
-#define OCTEON_IRQ_MSI_BIT16	168
-#define OCTEON_IRQ_MSI_BIT17	169
-#define OCTEON_IRQ_MSI_BIT18	170
-#define OCTEON_IRQ_MSI_BIT19	171
-#define OCTEON_IRQ_MSI_BIT20	172
-#define OCTEON_IRQ_MSI_BIT21	173
-#define OCTEON_IRQ_MSI_BIT22	174
-#define OCTEON_IRQ_MSI_BIT23	175
-#define OCTEON_IRQ_MSI_BIT24	176
-#define OCTEON_IRQ_MSI_BIT25	177
-#define OCTEON_IRQ_MSI_BIT26	178
-#define OCTEON_IRQ_MSI_BIT27	179
-#define OCTEON_IRQ_MSI_BIT28	180
-#define OCTEON_IRQ_MSI_BIT29	181
-#define OCTEON_IRQ_MSI_BIT30	182
-#define OCTEON_IRQ_MSI_BIT31	183
-#define OCTEON_IRQ_MSI_BIT32	184
-#define OCTEON_IRQ_MSI_BIT33	185
-#define OCTEON_IRQ_MSI_BIT34	186
-#define OCTEON_IRQ_MSI_BIT35	187
-#define OCTEON_IRQ_MSI_BIT36	188
-#define OCTEON_IRQ_MSI_BIT37	189
-#define OCTEON_IRQ_MSI_BIT38	190
-#define OCTEON_IRQ_MSI_BIT39	191
-#define OCTEON_IRQ_MSI_BIT40	192
-#define OCTEON_IRQ_MSI_BIT41	193
-#define OCTEON_IRQ_MSI_BIT42	194
-#define OCTEON_IRQ_MSI_BIT43	195
-#define OCTEON_IRQ_MSI_BIT44	196
-#define OCTEON_IRQ_MSI_BIT45	197
-#define OCTEON_IRQ_MSI_BIT46	198
-#define OCTEON_IRQ_MSI_BIT47	199
-#define OCTEON_IRQ_MSI_BIT48	200
-#define OCTEON_IRQ_MSI_BIT49	201
-#define OCTEON_IRQ_MSI_BIT50	202
-#define OCTEON_IRQ_MSI_BIT51	203
-#define OCTEON_IRQ_MSI_BIT52	204
-#define OCTEON_IRQ_MSI_BIT53	205
-#define OCTEON_IRQ_MSI_BIT54	206
-#define OCTEON_IRQ_MSI_BIT55	207
-#define OCTEON_IRQ_MSI_BIT56	208
-#define OCTEON_IRQ_MSI_BIT57	209
-#define OCTEON_IRQ_MSI_BIT58	210
-#define OCTEON_IRQ_MSI_BIT59	211
-#define OCTEON_IRQ_MSI_BIT60	212
-#define OCTEON_IRQ_MSI_BIT61	213
-#define OCTEON_IRQ_MSI_BIT62	214
-#define OCTEON_IRQ_MSI_BIT63	215
+#define OCTEON_IRQ_MSI_LAST	(OCTEON_IRQ_MSI_BIT0 + 63)
 
-#define OCTEON_IRQ_LAST         216
+#define OCTEON_IRQ_LAST		(OCTEON_IRQ_MSI_LAST + 1)
 #else
 #define OCTEON_IRQ_LAST         152
 #endif
diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index 1e31526..5ce1a6a 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -181,7 +181,7 @@ void arch_teardown_msi_irq(unsigned int irq)
 	int number_irqs;
 	uint64_t bitmask;
 
-	if ((irq < OCTEON_IRQ_MSI_BIT0) || (irq > OCTEON_IRQ_MSI_BIT63))
+	if ((irq < OCTEON_IRQ_MSI_BIT0) || (irq > OCTEON_IRQ_MSI_LAST))
 		panic("arch_teardown_msi_irq: Attempted to teardown illegal "
 		      "MSI interrupt (%d)", irq);
 	irq -= OCTEON_IRQ_MSI_BIT0;
@@ -337,7 +337,7 @@ static int __init octeon_msi_initialize(void)
 {
 	int irq;
 
-	for (irq = OCTEON_IRQ_MSI_BIT0; irq <= OCTEON_IRQ_MSI_BIT63; irq++) {
+	for (irq = OCTEON_IRQ_MSI_BIT0; irq <= OCTEON_IRQ_MSI_LAST; irq++) {
 		set_irq_chip_and_handler(irq, &octeon_irq_chip_msi,
 					 handle_percpu_irq);
 	}
-- 
1.7.1.1
