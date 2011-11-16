Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 14:29:52 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47388 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903813Ab1KPN2u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 14:28:50 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH V2 3/6] MIPS: lantiq: make irq.c support the FALC-ON
Date:   Wed, 16 Nov 2011 15:28:15 +0100
Message-Id: <1321453698-2598-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1321453698-2598-1-git-send-email-blogic@openwrt.org>
References: <1321453698-2598-1-git-send-email-blogic@openwrt.org>
X-archive-position: 31660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13391

There are minor differences in how irqs work on xway and falcon socs.
Xway needs 2 quirks that we need to disable for falcon to also work with
this code.

* EBU irq does not need to send a special ack to the EBU
* The EIU does not exist

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/irq.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index f9737bb..17c057f 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -195,7 +195,7 @@ static void ltq_hw_irqdispatch(int module)
 	do_IRQ((int)irq + INT_NUM_IM0_IRL0 + (INT_NUM_IM_OFFSET * module));
 
 	/* if this is a EBU irq, we need to ack it or get a deadlock */
-	if ((irq == LTQ_ICU_EBU_IRQ) && (module == 0))
+	if ((irq == LTQ_ICU_EBU_IRQ) && (module == 0) && LTQ_EBU_PCC_ISTAT)
 		ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_PCC_ISTAT) | 0x10,
 			LTQ_EBU_PCC_ISTAT);
 }
@@ -260,17 +260,19 @@ void __init arch_init_irq(void)
 	if (!ltq_icu_membase)
 		panic("Failed to remap icu memory\n");
 
-	if (insert_resource(&iomem_resource, &ltq_eiu_resource) < 0)
-		panic("Failed to insert eiu memory\n");
+	if (LTQ_EIU_BASE_ADDR) {
+		if (insert_resource(&iomem_resource, &ltq_eiu_resource) < 0)
+			panic("Failed to insert eiu memory\n");
 
-	if (request_mem_region(ltq_eiu_resource.start,
-			resource_size(&ltq_eiu_resource), "eiu") < 0)
-		panic("Failed to request eiu memory\n");
+		if (request_mem_region(ltq_eiu_resource.start,
+				resource_size(&ltq_eiu_resource), "eiu") < 0)
+			panic("Failed to request eiu memory\n");
 
-	ltq_eiu_membase = ioremap_nocache(ltq_eiu_resource.start,
+		ltq_eiu_membase = ioremap_nocache(ltq_eiu_resource.start,
 				resource_size(&ltq_eiu_resource));
-	if (!ltq_eiu_membase)
-		panic("Failed to remap eiu memory\n");
+		if (!ltq_eiu_membase)
+			panic("Failed to remap eiu memory\n");
+	}
 
 	/* make sure all irqs are turned off by default */
 	for (i = 0; i < 5; i++)
@@ -296,8 +298,8 @@ void __init arch_init_irq(void)
 
 	for (i = INT_NUM_IRQ0;
 		i <= (INT_NUM_IRQ0 + (5 * INT_NUM_IM_OFFSET)); i++)
-		if ((i == LTQ_EIU_IR0) || (i == LTQ_EIU_IR1) ||
-			(i == LTQ_EIU_IR2))
+		if (((i == LTQ_EIU_IR0) || (i == LTQ_EIU_IR1) ||
+			(i == LTQ_EIU_IR2)) && LTQ_EIU_BASE_ADDR)
 			irq_set_chip_and_handler(i, &ltq_eiu_type,
 				handle_level_irq);
 		/* EIU3-5 only exist on ar9 and vr9 */
-- 
1.7.7.1
