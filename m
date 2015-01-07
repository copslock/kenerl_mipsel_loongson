Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:25:38 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:2763 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010172AbbAGLVlI0UJH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 12:21:41 +0100
X-IronPort-AV: E=Sophos;i="5.07,714,1413270000"; 
   d="scan'208";a="54466618"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 07 Jan 2015 05:25:36 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 7 Jan 2015 03:21:55 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 7 Jan 2015 03:21:54 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 087D840FE6;    Wed,  7 Jan 2015 03:20:51 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 15/17] MIPS: Netlogic: Add irq mapping and setup for XHCI port 3
Date:   Wed, 7 Jan 2015 16:58:36 +0530
Message-ID: <1420630118-17198-16-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

Add support for third XHCI port in XLPII processors.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h |  1 +
 arch/mips/netlogic/xlp/nlm_hal.c             |  2 ++
 arch/mips/netlogic/xlp/usb-init-xlp2.c       | 10 +++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index c0b2a80..feb6ed8 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -52,6 +52,7 @@
 #define PIC_2XX_XHCI_2_IRQ		25
 #define PIC_9XX_XHCI_0_IRQ		23
 #define PIC_9XX_XHCI_1_IRQ		24
+#define PIC_9XX_XHCI_2_IRQ		25
 
 #define PIC_MMC_IRQ			29
 #define PIC_I2C_0_IRQ			30
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index c6c31e3..8d743d0 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -75,6 +75,8 @@ static int xlp9xx_irq_to_irt(int irq)
 		return 114;
 	case PIC_9XX_XHCI_1_IRQ:
 		return 115;
+	case PIC_9XX_XHCI_2_IRQ:
+		return 116;
 	case PIC_UART_0_IRQ:
 		return 133;
 	case PIC_UART_1_IRQ:
diff --git a/arch/mips/netlogic/xlp/usb-init-xlp2.c b/arch/mips/netlogic/xlp/usb-init-xlp2.c
index 17ade1c..2524939 100644
--- a/arch/mips/netlogic/xlp/usb-init-xlp2.c
+++ b/arch/mips/netlogic/xlp/usb-init-xlp2.c
@@ -128,6 +128,9 @@ static void xlp9xx_usb_ack(struct irq_data *data)
 	case PIC_9XX_XHCI_1_IRQ:
 		port_addr = nlm_xlpii_get_usb_regbase(node, 2);
 		break;
+	case PIC_9XX_XHCI_2_IRQ:
+		port_addr = nlm_xlpii_get_usb_regbase(node, 3);
+		break;
 	default:
 		pr_err("No matching USB irq %d node  %d!\n", irq, node);
 		return;
@@ -222,14 +225,16 @@ static int __init nlm_platform_xlpii_usb_init(void)
 	}
 
 	/* XLP 9XX, multi-node */
-	pr_info("Initializing 9XX USB Interface\n");
+	pr_info("Initializing 9XX/5XX USB Interface\n");
 	for (node = 0; node < NLM_NR_NODES; node++) {
 		if (!nlm_node_present(node))
 			continue;
 		nlm_xlpii_usb_hw_reset(node, 1);
 		nlm_xlpii_usb_hw_reset(node, 2);
+		nlm_xlpii_usb_hw_reset(node, 3);
 		nlm_set_pic_extra_ack(node, PIC_9XX_XHCI_0_IRQ, xlp9xx_usb_ack);
 		nlm_set_pic_extra_ack(node, PIC_9XX_XHCI_1_IRQ, xlp9xx_usb_ack);
+		nlm_set_pic_extra_ack(node, PIC_9XX_XHCI_2_IRQ, xlp9xx_usb_ack);
 	}
 	return 0;
 }
@@ -253,6 +258,9 @@ static void nlm_xlp9xx_usb_fixup_final(struct pci_dev *dev)
 	case 0x22:
 		dev->irq = nlm_irq_to_xirq(node, PIC_9XX_XHCI_1_IRQ);
 		break;
+	case 0x23:
+		dev->irq = nlm_irq_to_xirq(node, PIC_9XX_XHCI_2_IRQ);
+		break;
 	}
 }
 
-- 
1.9.1
