Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2011 08:52:08 +0100 (CET)
Received: from smtpgw2.netlogicmicro.com ([12.203.210.54]:60112 "EHLO
        smtpgw2.netlogicmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903760Ab1K3HwB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Nov 2011 08:52:01 +0100
Received: from pps.filterd (smtpgw2 [127.0.0.1])
        by smtpgw2.netlogicmicro.com (8.14.4/8.14.4) with SMTP id pAU7lRsn003242;
        Tue, 29 Nov 2011 23:51:54 -0800
Received: from hqcas02.netlogicmicro.com (hqcas02.netlogicmicro.com [10.65.50.15])
        by smtpgw2.netlogicmicro.com with ESMTP id 11denfg153-1
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 29 Nov 2011 23:51:54 -0800
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Jayachandran C <jayachandranc@netlogicmicro.com>
Subject: [PATCH] MIPS: Netlogic: Fix PCIX irq on XLR chips
Date:   Wed, 30 Nov 2011 13:22:37 +0530
Message-ID: <1322639557-32328-1-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.7.0.77]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.5.7110,1.0.211,0.0.0000
 definitions=2011-11-30_02:2011-11-30,2011-11-30,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=6.0.2-1012030000 definitions=main-1111290392
X-archive-position: 32014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24934

From: Jayachandran C <jayachandranc@netlogicmicro.com>

The correct irq is PIC_PCIX_IRQ

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/pci/pci-xlr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 3d701a9..0148001 100644
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
1.7.5.4
