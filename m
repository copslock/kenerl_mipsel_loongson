Return-Path: <SRS0=NRRR=QZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10885C43381
	for <linux-mips@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D1221902
	for <linux-mips@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498816;
	bh=6hmZwesDXpNTijRoV6F/KX/PaIU4BqqmN9ToaF8G5cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E7eWnYFBx3zwvxZMlHinwkmGOkyMR/iN5vId6uzSe6xKsQlDQBkxLZ3YbhT5yo+ZX
	 8IOHuNcIFjQDO6+J4oADADAbG1MXNf4oEGebbN/vXAJIKMpkV/p6337FF7o8ZaDAGS
	 uR/4JB7nzN8DJllhQ5aC1Z5cCeazz8z+VN4W5jyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390495AbfBROG4 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:06:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389943AbfBROGz (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 18 Feb 2019 09:06:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB78421901;
        Mon, 18 Feb 2019 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498814;
        bh=6hmZwesDXpNTijRoV6F/KX/PaIU4BqqmN9ToaF8G5cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tb/38sRwJeX3PnFXij9Bs37IYK4+oOmU97Mvs2UkVPo1rhBOwX+bEN2IHBItlw2Nj
         BIpym3YrrYroo0ljBnZ9BHqFDL4TXBuXjhcNau2gh27jqzOxXhIBpuS90ZddeB6U/R
         LMmK1hq3YzquR0kHr/WIQlenZsEkiaExoYftpsBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.4 104/143] MIPS: OCTEON: dont set octeon_dma_bar_type if PCI is disabled
Date:   Mon, 18 Feb 2019 14:43:52 +0100
Message-Id: <20190218133532.835048316@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit dcf300a69ac307053dfb35c2e33972e754a98bce upstream.

Don't set octeon_dma_bar_type if PCI is disabled. This avoids creation
of the MSI irqchip later on, and saves a bit of memory.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: a214720cbf50 ("Disable MSI also when pcie-octeon.pcie_disable on")
Cc: stable@vger.kernel.org # v3.3+
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/pci/pci-octeon.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -571,6 +571,11 @@ static int __init octeon_pci_setup(void)
 	if (octeon_has_feature(OCTEON_FEATURE_PCIE))
 		return 0;
 
+	if (!octeon_is_pci_host()) {
+		pr_notice("Not in host mode, PCI Controller not initialized\n");
+		return 0;
+	}
+
 	/* Point pcibios_map_irq() to the PCI version of it */
 	octeon_pcibios_map_irq = octeon_pci_pcibios_map_irq;
 
@@ -582,11 +587,6 @@ static int __init octeon_pci_setup(void)
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


