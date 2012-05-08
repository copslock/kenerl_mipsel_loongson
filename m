Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 14:48:25 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2743 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903698Ab2EHMnI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 14:43:08 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 08 May 2012 05:43:10 -0700
X-Server-Uuid: 72204117-5C29-4314-8910-60DB108979CB
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 8 May 2012 05:42:06 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id BB1359F9F8; Tue, 8
 May 2012 05:42:45 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Tue, 8 May 2012 05:42:44 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 13/14] MIPS: Netlogic: Add IRQ mappings for more devices
Date:   Tue, 8 May 2012 18:12:07 +0530
Message-ID: <1336480928-18887-14-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1336480928-18887-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1336480928-18887-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 63B7CB5444G1245347-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add IRT to IRQ translation for the MMC and I2C IRQs.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h |    3 +++
 arch/mips/netlogic/xlp/nlm_hal.c             |   12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index 3921a31..7e47209 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -47,6 +47,9 @@
 #define PIC_OHCI_1_IRQ			26
 #define PIC_OHCI_2_IRQ			27
 #define PIC_OHCI_3_IRQ			28
+#define PIC_MMC_IRQ			29
+#define PIC_I2C_0_IRQ			30
+#define PIC_I2C_1_IRQ			31
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index fad2cae..6c65ac7 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -89,6 +89,12 @@ int nlm_irq_to_irt(int irq)
 	       return PIC_IRT_OHCI_2_INDEX;
 	case PIC_OHCI_3_IRQ:
 	       return PIC_IRT_OHCI_3_INDEX;
+	case PIC_MMC_IRQ:
+	       return PIC_IRT_MMC_INDEX;
+	case PIC_I2C_0_IRQ:
+		return PIC_IRT_I2C_0_INDEX;
+	case PIC_I2C_1_IRQ:
+		return PIC_IRT_I2C_1_INDEX;
 	default:
 		return -1;
 	}
@@ -121,6 +127,12 @@ int nlm_irt_to_irq(int irt)
 		return PIC_OHCI_2_IRQ;
 	case PIC_IRT_OHCI_3_INDEX:
 		return PIC_OHCI_3_IRQ;
+	case PIC_IRT_MMC_INDEX:
+	       return PIC_MMC_IRQ;
+	case PIC_IRT_I2C_0_INDEX:
+		return PIC_I2C_0_IRQ;
+	case PIC_IRT_I2C_1_INDEX:
+		return PIC_I2C_1_IRQ;
 	default:
 		return -1;
 	}
-- 
1.7.9.5
