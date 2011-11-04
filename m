Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 19:12:26 +0100 (CET)
Received: from smtp4-g21.free.fr ([212.27.42.4]:51992 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904134Ab1KDSL7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 19:11:59 +0100
Received: from sakura.staff.proxad.net (unknown [213.36.7.13])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 85E7E4C82C1;
        Fri,  4 Nov 2011 19:11:54 +0100 (CET)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 6E911557C0B; Fri,  4 Nov 2011 19:11:53 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Subject: [PATCH v2 01/11] MIPS: BCM63XX: set default pci cache line size.
Date:   Fri,  4 Nov 2011 19:09:25 +0100
Message-Id: <1320430175-13725-2-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
References: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
To:     ralf@linux-mips.org
X-archive-position: 31391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3867

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/pci/pci-bcm63xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/pci/pci-bcm63xx.c b/arch/mips/pci/pci-bcm63xx.c
index 82e0fde..c7fc92f 100644
--- a/arch/mips/pci/pci-bcm63xx.c
+++ b/arch/mips/pci/pci-bcm63xx.c
@@ -215,6 +215,8 @@ static int __init bcm63xx_pci_init(void)
 	register_pci_controller(&bcm63xx_cb_controller);
 #endif
 
+	pci_cache_line_size = 4;
+
 	/* mark memory space used for IO mapping as reserved */
 	request_mem_region(BCM_PCI_IO_BASE_PA, BCM_PCI_IO_SIZE,
 			   "bcm63xx PCI IO space");
-- 
1.7.1.1
