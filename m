Return-Path: <SRS0=SfqM=YX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCAACA9EC5
	for <linux-mips@archiver.kernel.org>; Wed, 30 Oct 2019 13:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4442520874
	for <linux-mips@archiver.kernel.org>; Wed, 30 Oct 2019 13:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="TK4EPcMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfJ3NzA (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:55:00 -0400
Received: from forward105o.mail.yandex.net ([37.140.190.183]:48141 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbfJ3NzA (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Wed, 30 Oct 2019 09:55:00 -0400
Received: from mxback27g.mail.yandex.net (mxback27g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:327])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 502484200ED8;
        Wed, 30 Oct 2019 16:54:56 +0300 (MSK)
Received: from iva8-e1a842234f87.qloud-c.yandex.net (iva8-e1a842234f87.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:e1a8:4223])
        by mxback27g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 7uGwIg3QMS-st8S4JGH;
        Wed, 30 Oct 2019 16:54:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1572443696;
        bh=ARWVQLt1dWTnBId169FvLsAgeDt/XuDlOiFp1rFzjZQ=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=TK4EPcMd+uMyrwR/jJaCbKycYOzuQEY0ykw2BJkgg9+t2DcnYJ8TNZNbyIaRHnNIk
         Rl3SPtnHGHxpUON23jol9EUi4qs0tLyY89XDe3HTbuiyJW8Zc0MA2vSEBG/8WVf3Mh
         zm2t8a7h51ZVfX5351ynrY5gYQa+LZ1qJQy5G8r8=
Authentication-Results: mxback27g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by iva8-e1a842234f87.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id iQ85YfuBaZ-skUufJNa;
        Wed, 30 Oct 2019 16:54:54 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        axboe@kernel.dk, peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, bhelgaas@google.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-pci@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 5/5] libata/ahci: Apply non-standard BAR fix for Loongson
Date:   Wed, 30 Oct 2019 21:53:47 +0800
Message-Id: <20191030135347.3636-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030135347.3636-1-jiaxun.yang@flygoat.com>
References: <20191030135347.3636-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Loongson is using BAR0 as AHCI registers BAR.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/ata/ahci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index dd92faf197d5..db3d7b94ad53 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -42,6 +42,7 @@ enum {
 	AHCI_PCI_BAR_CAVIUM	= 0,
 	AHCI_PCI_BAR_ENMOTUS	= 2,
 	AHCI_PCI_BAR_CAVIUM_GEN5	= 4,
+	AHCI_PCI_BAR_LOONGSON	= 0,
 	AHCI_PCI_BAR_STANDARD	= 5,
 };
 
@@ -575,6 +576,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Enmotus */
 	{ PCI_DEVICE(0x1c44, 0x8000), board_ahci },
 
+	/* Loongson */
+	{ PCI_VDEVICE(LOONGSON, 0x7a08), board_ahci },
+
 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
@@ -1663,6 +1667,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			ahci_pci_bar = AHCI_PCI_BAR_CAVIUM;
 		if (pdev->device == 0xa084)
 			ahci_pci_bar = AHCI_PCI_BAR_CAVIUM_GEN5;
+	} else if (pdev->vendor == PCI_VENDOR_ID_LOONGSON) {
+		if (pdev->device == PCI_DEVICE_ID_LOONGSON_AHCI)
+			ahci_pci_bar = AHCI_PCI_BAR_LOONGSON;
 	}
 
 	/* acquire resources */
-- 
2.23.0

