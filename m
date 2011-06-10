Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 23:48:33 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52612 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491135Ab1FJVrj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 23:47:39 +0200
Received: from bobafett.staff.proxad.net (unknown [213.228.1.121])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 0CDA54C8081;
        Fri, 10 Jun 2011 23:47:34 +0200 (CEST)
Received: from sakura.staff.proxad.net (unknown [172.18.3.156])
        by bobafett.staff.proxad.net (Postfix) with ESMTP id 94B52180654;
        Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 7ED8655B091; Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, florian@openwrt.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 01/11] MIPS: BCM63XX: set default pci cache line size.
Date:   Fri, 10 Jun 2011 23:47:11 +0200
Message-Id: <1307742441-28284-2-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 30327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9571

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
