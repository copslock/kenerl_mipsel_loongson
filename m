Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2012 23:53:27 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:45511 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903748Ab2CWWv4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2012 23:51:56 +0100
Received: by yhjj52 with SMTP id j52so3640501yhj.36
        for <multiple recipients>; Fri, 23 Mar 2012 15:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0qXzXLsMyDO8fZD9UE96Vp0GJTPDxcJ+eHyobHd+ID0=;
        b=YtnSgekG1QFHfjrvkkGdatBCzJ1BmI0op+mE7Y5AFLNdIjH/85GQlsRsRwhDiZJtyt
         UUprPgKR1uDNr4THngOeQq8OtV3NH4I58/Uw7ivR+s062+iF15DfYDDucjYaBt1cEEuZ
         4VJxA8V0ImOVp4uEbWlRAKvi1j3NHLI7Qp55MNPXk1QGlmRW9DG7hR+116750zouMVh2
         QqsyWJk8JVoqSW+AKFUq9nuOkKFc30FULnZcoyByEIvFjm8jFcVUBjz+NpZgwpcsAO5b
         BmmKgO86uWLdToXf7MRSI2X3uu9zcQaD12NynUm0ebe0FuCYc8Ry18sPM5npzzL43h8c
         lMYQ==
Received: by 10.60.8.103 with SMTP id q7mr16096692oea.61.1332543109994;
        Fri, 23 Mar 2012 15:51:49 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id b3sm9041436obp.6.2012.03.23.15.51.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:51:48 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q2NMpksB019974;
        Fri, 23 Mar 2012 15:51:46 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q2NMpkdc019973;
        Fri, 23 Mar 2012 15:51:46 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/3] MIPS: OCTEON: Remove unneeded OCTEON_IRQ_* defines.
Date:   Fri, 23 Mar 2012 15:51:41 -0700
Message-Id: <1332543102-19922-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1332543102-19922-1-git-send-email-ddaney.cavm@gmail.com>
References: <1332543102-19922-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The follow-on patch to add irq_domain support will be the supported
method for using these irq lines, so get these defines out of the way
in preperation for that.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c           |   43 ------------------------
 arch/mips/include/asm/mach-cavium-octeon/irq.h |   40 +---------------------
 2 files changed, 2 insertions(+), 81 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 61980d0..7c16bff 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1036,23 +1036,11 @@ static void __init octeon_irq_init_ciu(void)
 
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TWSI, 0, 45, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RML, 0, 46, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TRACE0, 0, 47, chip, handle_level_irq);
-
-	for (i = 0; i < 2; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GMX_DRP0, 0, i + 48, chip_edge, handle_edge_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_IPD_DRP, 0, 50, chip_edge, handle_edge_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_KEY_ZERO, 0, 51, chip_edge, handle_edge_irq);
-
 	for (i = 0; i < 4; i++)
 		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_TIMER0, 0, i + 52, chip_edge, handle_edge_irq);
 
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB0, 0, 56, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PCM, 0, 57, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MPI, 0, 58, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TWSI2, 0, 59, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_POWIQ, 0, 60, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_IPDPPTHR, 0, 61, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MII0, 0, 62, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_BOOTDMA, 0, 63, chip, handle_level_irq);
 
@@ -1063,37 +1051,6 @@ static void __init octeon_irq_init_ciu(void)
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART2, 1, 16, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB1, 1, 17, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MII1, 1, 18, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_NAND, 1, 19, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MIO, 1, 20, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_IOB, 1, 21, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_FPA, 1, 22, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_POW, 1, 23, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_L2C, 1, 24, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_IPD, 1, 25, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PIP, 1, 26, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PKO, 1, 27, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_ZIP, 1, 28, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TIM, 1, 29, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RAD, 1, 30, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_KEY, 1, 31, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_DFA, 1, 32, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USBCTL, 1, 33, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_SLI, 1, 34, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_DPI, 1, 35, chip, handle_level_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_AGX0, 1, 36, chip, handle_level_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_AGL, 1, 46, chip, handle_level_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PTP, 1, 47, chip_edge, handle_edge_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PEM0, 1, 48, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PEM1, 1, 49, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_SRIO0, 1, 50, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_SRIO1, 1, 51, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_LMC0, 1, 52, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_DFM, 1, 56, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RST, 1, 63, chip, handle_level_irq);
 
 	/* Enable the CIU lines */
 	set_c0_status(STATUSF_IP3 | STATUSF_IP2);
diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index 5b05f18..f9bfb63 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -41,56 +41,20 @@ enum octeon_irq {
 	OCTEON_IRQ_TWSI,
 	OCTEON_IRQ_TWSI2,
 	OCTEON_IRQ_RML,
-	OCTEON_IRQ_TRACE0,
-	OCTEON_IRQ_GMX_DRP0 = OCTEON_IRQ_TRACE0 + 4,
-	OCTEON_IRQ_IPD_DRP = OCTEON_IRQ_GMX_DRP0 + 5,
-	OCTEON_IRQ_KEY_ZERO,
 	OCTEON_IRQ_TIMER0,
 	OCTEON_IRQ_TIMER1,
 	OCTEON_IRQ_TIMER2,
 	OCTEON_IRQ_TIMER3,
 	OCTEON_IRQ_USB0,
 	OCTEON_IRQ_USB1,
-	OCTEON_IRQ_PCM,
-	OCTEON_IRQ_MPI,
-	OCTEON_IRQ_POWIQ,
-	OCTEON_IRQ_IPDPPTHR,
 	OCTEON_IRQ_MII0,
 	OCTEON_IRQ_MII1,
 	OCTEON_IRQ_BOOTDMA,
-
-	OCTEON_IRQ_NAND,
-	OCTEON_IRQ_MIO,		/* Summary of MIO_BOOT_ERR */
-	OCTEON_IRQ_IOB,		/* Summary of IOB_INT_SUM */
-	OCTEON_IRQ_FPA,		/* Summary of FPA_INT_SUM */
-	OCTEON_IRQ_POW,		/* Summary of POW_ECC_ERR */
-	OCTEON_IRQ_L2C,		/* Summary of L2C_INT_STAT */
-	OCTEON_IRQ_IPD,		/* Summary of IPD_INT_SUM */
-	OCTEON_IRQ_PIP,		/* Summary of PIP_INT_REG */
-	OCTEON_IRQ_PKO,		/* Summary of PKO_REG_ERROR */
-	OCTEON_IRQ_ZIP,		/* Summary of ZIP_ERROR */
-	OCTEON_IRQ_TIM,		/* Summary of TIM_REG_ERROR */
-	OCTEON_IRQ_RAD,		/* Summary of RAD_REG_ERROR */
-	OCTEON_IRQ_KEY,		/* Summary of KEY_INT_SUM */
-	OCTEON_IRQ_DFA,		/* Summary of DFA */
-	OCTEON_IRQ_USBCTL,	/* Summary of USBN0_INT_SUM */
-	OCTEON_IRQ_SLI,		/* Summary of SLI_INT_SUM */
-	OCTEON_IRQ_DPI,		/* Summary of DPI_INT_SUM */
-	OCTEON_IRQ_AGX0,	/* Summary of GMX0*+PCS0_INT*_REG */
-	OCTEON_IRQ_AGL  = OCTEON_IRQ_AGX0 + 5,
-	OCTEON_IRQ_PTP,
-	OCTEON_IRQ_PEM0,
-	OCTEON_IRQ_PEM1,
-	OCTEON_IRQ_SRIO0,
-	OCTEON_IRQ_SRIO1,
-	OCTEON_IRQ_LMC0,
-	OCTEON_IRQ_DFM = OCTEON_IRQ_LMC0 + 4,		/* Summary of DFM */
-	OCTEON_IRQ_RST,
 };
 
 #ifdef CONFIG_PCI_MSI
-/* 152 - 407 represent the MSI interrupts 0-255 */
-#define OCTEON_IRQ_MSI_BIT0	(OCTEON_IRQ_RST + 1)
+/* 256 - 511 represent the MSI interrupts 0-255 */
+#define OCTEON_IRQ_MSI_BIT0	(256)
 
 #define OCTEON_IRQ_MSI_LAST      (OCTEON_IRQ_MSI_BIT0 + 255)
 #define OCTEON_IRQ_LAST          (OCTEON_IRQ_MSI_LAST + 1)
-- 
1.7.2.3
