Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 15:13:22 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:4935 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903696Ab2D1NMv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 15:12:51 +0200
Received: from [10.9.200.131] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 28 Apr 2012 06:12:38 -0700
X-Server-Uuid: B730DE51-FC43-4C83-941F-F1F78A914BDD
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Sat, 28 Apr 2012 06:12:33 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 0E13A9F9F5; Sat, 28
 Apr 2012 06:12:33 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Sat, 28 Apr 2012 06:12:32 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 01/12] MIPS: Netlogic: Fix PCIX irq on XLR chips
Date:   Sat, 28 Apr 2012 18:42:07 +0530
Message-ID: <1335618738-4679-2-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 6385334C3E024591314-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The correct irq is PIC_PCIX_IRQ

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/pci/pci-xlr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 1644805..50ff4dc 100644
--- a/arch/mips/pci/pci-xlr.c
+++ b/arch/mips/pci/pci-xlr.c
@@ -327,7 +327,7 @@ static int __init pcibios_init(void)
 		}
 	} else {
 		/* XLR PCI controller ACK */
-		irq_set_handler_data(PIC_PCIE_XLSB0_LINK3_IRQ, xlr_pci_ack);
+		irq_set_handler_data(PIC_PCIX_IRQ, xlr_pci_ack);
 	}
 
 	return 0;
-- 
1.7.9.5
