Return-Path: <SRS0=LPLt=QD=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9AC282CA
	for <linux-mips@archiver.kernel.org>; Sun, 27 Jan 2019 21:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB0C2133D
	for <linux-mips@archiver.kernel.org>; Sun, 27 Jan 2019 21:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfA0V2o (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:28:44 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:46906 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfA0V2o (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 27 Jan 2019 16:28:44 -0500
Received: from localhost.localdomain (85-76-101-7-nat.elisa-mobile.fi [85.76.101.7])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id DE04530059;
        Sun, 27 Jan 2019 23:28:42 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled
Date:   Sun, 27 Jan 2019 23:28:33 +0200
Message-Id: <20190127212833.16520-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Don't set octeon_dma_bar_type if PCI is disabled. This avoids creation
of the MSI irqchip later on, and saves a bit of memory.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/pci/pci-octeon.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 5017d5843c5a..fc29b85cfa92 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -568,6 +568,11 @@ static int __init octeon_pci_setup(void)
 	if (octeon_has_feature(OCTEON_FEATURE_PCIE))
 		return 0;
 
+	if (!octeon_is_pci_host()) {
+		pr_notice("Not in host mode, PCI Controller not initialized\n");
+		return 0;
+	}
+
 	/* Point pcibios_map_irq() to the PCI version of it */
 	octeon_pcibios_map_irq = octeon_pci_pcibios_map_irq;
 
@@ -579,11 +584,6 @@ static int __init octeon_pci_setup(void)
 	else
 		octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_BIG;
 
-	if (!octeon_is_pci_host()) {
-		pr_notice("Not in host mode, PCI Controller not initialized\n");
-		return 0;
-	}
-
 	/* PCI I/O and PCI MEM values */
 	set_io_port_base(OCTEON_PCI_IOSPACE_BASE);
 	ioport_resource.start = 0;
-- 
2.17.0

