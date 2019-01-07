Return-Path: <SRS0=HQ/I=PP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E415C43387
	for <linux-mips@archiver.kernel.org>; Mon,  7 Jan 2019 02:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B8320838
	for <linux-mips@archiver.kernel.org>; Mon,  7 Jan 2019 02:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElOH6rLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfAGCzv (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:55:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36157 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfAGCzu (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 6 Jan 2019 21:55:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so20071614pgm.3
        for <linux-mips@vger.kernel.org>; Sun, 06 Jan 2019 18:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/+MjYxBZ42rf32oo6BKol5gDRXvyjLsHxgRhQQz43E=;
        b=ElOH6rLIZS+jCA24/TslvFQ2Ou/YdslBbTL9rOrjvXCqaroPNqMb0CwAsE//D+5hN3
         Om6AN7vgtHLoU/RayGHFGgyoD3GMhsWoumWPHLTb3MHnB+Ljdv5cIigOyBSxaLr2/WQH
         Orc8t8jLlYmrnsujK8SlyYUNEnQ5+v1MGw+garX3yLuZkemZnwFuRoIsD8p5KFrMtS2W
         /vzpjzdzpjR3q/tMCYChTj1i5VfxhJWwstQaH3Le5ZQ6NeCdIQWX4cF7sTQKfTPDTXP+
         uQt6Yv+UQId0RSFTKXQodJC9SpMAB7NY80lKnnjp6I/ycK8vtzEM4Piv6FSAqQz1eNzW
         UFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=C/+MjYxBZ42rf32oo6BKol5gDRXvyjLsHxgRhQQz43E=;
        b=eSG/WncWV1BmWmFJYAMMgYTl0rSCMYM1EFr9DnSLze/xl8lgRwtSyczcVF1pgBfbMj
         czcGnMQEVYoFaSH8uz5KyccTVlRQ5Kd1eJPMzzbnScOdNWOPbYlCdPpBKq/ggKcHlFhd
         i7yw4DEoeIv2QnW7+xw84kOM9b2TBW/UvkI99w1mgk4R/Q50mHR6+WLWoW5yBQJ+4U28
         UCYsulULuHOCTaBPxuuYueGQJRgFOa2HwAAnt3alGWPgQ9+ph2VlOME4lXkJfKmjqTRx
         fc1cJ3S07ODp1a1loYn46tSes4BN1AaJdzi55A13XFmhEDOEQL6RWIjdq1yT0WNpb8t4
         mOdg==
X-Gm-Message-State: AJcUukcW1GCdbEJ3ed5S5PgnwXXe2ok+oUQDVkdRlmrZ4vt/p2lInqji
        +JzxOyR/Pq4KMKhyYVvUB+8zQnks0qc=
X-Google-Smtp-Source: ALg8bN5ztIJ3oXUKEcXFxBGKOK+GYJQj/E6HuajwDiI3x7jKr07qguNNItGk47kdSh/RCVXFjLFA2g==
X-Received: by 2002:a63:4c04:: with SMTP id z4mr9590402pga.312.1546829749887;
        Sun, 06 Jan 2019 18:55:49 -0800 (PST)
Received: from loongson.users.bfsu.cn ([2001:250:218:3698:d4c:a991:7c4e:a8bf])
        by smtp.gmail.com with ESMTPSA id u126sm133694049pgb.2.2019.01.06.18.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 18:55:49 -0800 (PST)
From:   YunQiang Su <syq@debian.org>
To:     pburton@wavecomp.com, linux-mips@vger.kernel.org
Cc:     YunQiang Su <ysu@wavecomp.com>
Subject: [PATCH] Disable MSI also when pcie-octeon.pcie_disable on
Date:   Mon,  7 Jan 2019 10:55:42 +0800
Message-Id: <20190107025542.2273-1-syq@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: YunQiang Su <ysu@wavecomp.com>

Octeon has an boot-time option to disable pcie.

Since MSI depends on PCI-E, we should also disable MSI also with
this options is on.

Signed-off-by: YunQiang Su <ysu@wavecomp.com>
---
 arch/mips/pci/msi-octeon.c  | 9 +++++++--
 arch/mips/pci/pcie-octeon.c | 5 +++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index 2a5bb849b..ed6b2f93d 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -45,6 +45,11 @@ static DEFINE_SPINLOCK(msi_free_irq_bitmask_lock);
  */
 static int msi_irq_size;
 
+/*
+ * whether pcie is disabled?
+ */
+extern int octeon_pcie_disabled(void);
+
 /**
  * Called when a driver request MSI interrupts instead of the
  * legacy INT A-D. This routine will allocate multiple interrupts
@@ -395,7 +400,7 @@ int __init octeon_msi_initialize(void)
 	for (irq = OCTEON_IRQ_MSI_BIT0; irq <= OCTEON_IRQ_MSI_LAST; irq++)
 		irq_set_chip_and_handler(irq, msi, handle_simple_irq);
 
-	if (octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+	if (octeon_has_feature(OCTEON_FEATURE_PCIE) && !octeon_pcie_disabled()) {
 		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt0,
 				0, "MSI[0:63]", octeon_msi_interrupt0))
 			panic("request_irq(OCTEON_IRQ_PCI_MSI0) failed");
@@ -413,7 +418,7 @@ int __init octeon_msi_initialize(void)
 			panic("request_irq(OCTEON_IRQ_PCI_MSI3) failed");
 
 		msi_irq_size = 256;
-	} else if (octeon_is_pci_host()) {
+	} else if (octeon_is_pci_host() && !octeon_pcie_disabled()) {
 		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt0,
 				0, "MSI[0:15]", octeon_msi_interrupt0))
 			panic("request_irq(OCTEON_IRQ_PCI_MSI0) failed");
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index d919a0d81..16d90290a 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -34,6 +34,11 @@
 static int pcie_disable;
 module_param(pcie_disable, int, S_IRUGO);
 
+int octeon_pcie_disabled(void){
+	return pcie_disable;
+}
+EXPORT_SYMBOL(octeon_pcie_disabled);
+
 static int enable_pcie_14459_war;
 static int enable_pcie_bus_num_war[2];
 
-- 
2.20.1

