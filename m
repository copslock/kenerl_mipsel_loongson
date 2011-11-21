Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 13:37:26 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:58340 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903749Ab1KUMgD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 13:36:03 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH V2 3/6] MIPS: lantiq: make irq.c support the FALC-ON
Date:   Mon, 21 Nov 2011 14:35:22 +0100
Message-Id: <1321882525-13780-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1321882525-13780-1-git-send-email-blogic@openwrt.org>
References: <1321882525-13780-1-git-send-email-blogic@openwrt.org>
X-archive-position: 31860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17234

There are minor differences in how irqs work on xway and falcon socs.
Xway needs 2 quirks that we need to disable for falcon to also work with
this code.

* EBU irq does not need to send a special ack to the EBU
* The EIU does not exist

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
Changes in V2:
* remove trailing \n in panic calls

 arch/mips/lantiq/irq.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index f9737bb..c139a6e 100644
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
@@ -249,28 +249,30 @@ void __init arch_init_irq(void)
 	int i;
 
 	if (insert_resource(&iomem_resource, &ltq_icu_resource) < 0)
-		panic("Failed to insert icu memory\n");
+		panic("Failed to insert icu memory");
 
 	if (request_mem_region(ltq_icu_resource.start,
 			resource_size(&ltq_icu_resource), "icu") < 0)
-		panic("Failed to request icu memory\n");
+		panic("Failed to request icu memory");
 
 	ltq_icu_membase = ioremap_nocache(ltq_icu_resource.start,
 				resource_size(&ltq_icu_resource));
 	if (!ltq_icu_membase)
-		panic("Failed to remap icu memory\n");
+		panic("Failed to remap icu memory");
 
-	if (insert_resource(&iomem_resource, &ltq_eiu_resource) < 0)
-		panic("Failed to insert eiu memory\n");
+	if (LTQ_EIU_BASE_ADDR) {
+		if (insert_resource(&iomem_resource, &ltq_eiu_resource) < 0)
+			panic("Failed to insert eiu memory");
 
-	if (request_mem_region(ltq_eiu_resource.start,
-			resource_size(&ltq_eiu_resource), "eiu") < 0)
-		panic("Failed to request eiu memory\n");
+		if (request_mem_region(ltq_eiu_resource.start,
+				resource_size(&ltq_eiu_resource), "eiu") < 0)
+			panic("Failed to request eiu memory");
 
-	ltq_eiu_membase = ioremap_nocache(ltq_eiu_resource.start,
+		ltq_eiu_membase = ioremap_nocache(ltq_eiu_resource.start,
 				resource_size(&ltq_eiu_resource));
-	if (!ltq_eiu_membase)
-		panic("Failed to remap eiu memory\n");
+		if (!ltq_eiu_membase)
+			panic("Failed to remap eiu memory");
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
