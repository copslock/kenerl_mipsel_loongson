Return-Path: <SRS0=z0u9=PQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975C9C43387
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 05:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6512173C
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 05:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdrDvplv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfAHFpS (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:45:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38110 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfAHFpS (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 8 Jan 2019 00:45:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so1363384pfi.5
        for <linux-mips@vger.kernel.org>; Mon, 07 Jan 2019 21:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HeQGH1WZ87iLFewg02MGkqpTqd7ZY7DycL/i0yWMLas=;
        b=cdrDvplvjb0e+aGMg/iDKAsd7dvu6kSbN6G4s2Tm4QLk3RFWuymJOhxPdBVWW8VDIX
         MznqIxAaCwlogNnjbO3Zo6tx81kYJQ+hEaLotZMjUJ1dfBDn0YDdHfoULe2gt6ZMyZ9f
         qgAaZgwA17bpfqPir2nGy4upr3m5vZVGEuRikF2WcSps5VeXp9f0SPGxjX9H2Q8fQKB1
         rUaO5J6DEA1gfkVwdG1cprnQeDKyidy3dK/xfNN7LFSjRn0WlASNvTNqNfTtq/pAcJL9
         tcuf3TjHpunMGks1TmVyh6XkUijVNeCJKLA4YpTA8n2s8NgiUvITlIJUjtxmYC/TNIfN
         SMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HeQGH1WZ87iLFewg02MGkqpTqd7ZY7DycL/i0yWMLas=;
        b=dbY4JWA7PgnO5aVWBEOZsNPkIhns8fLt46armp6kPRs96eJ4A00Xpg1A6iOCjpNeXR
         Yy3OINzyPA8CNraso0erq3HzgrP3fEYy1tGSzJ8iCYxSuzUjUcJYtnrAue1Ma4tlMFFw
         +eyPWgeQNSW2jj9UYFFQXJuottmgG7F6CmPyiMqErDQzsz71RwsypE0HZal3JNM0PteJ
         mLSOT04lmi9YD72NXBdyjRffsCzPFdibVBdv12ZQXAzLT8iAVO4UcMrkmKJxJwuU290c
         O9uH7+y3e6pQQxNWbEa/vnWfz7kb92v0w6lP1PQ6vt/tIajx3ka0rkVbMz3BnvO9+eOO
         lCkA==
X-Gm-Message-State: AJcUukc9lvzPDcCw0PRuPSwZ4bLHG6wgAggjZNygwTMAl70zrDP/kcDG
        CDiTfAeADw27wmOSC5vt7/M=
X-Google-Smtp-Source: ALg8bN7i5ygmUfDcIGQkK001x7iyGUmZA7axHdAsp9kzy46kdxLlJ39ibc6TYqCloyhBWMFWccHUfA==
X-Received: by 2002:a62:3141:: with SMTP id x62mr446952pfx.12.1546926318034;
        Mon, 07 Jan 2019 21:45:18 -0800 (PST)
Received: from loongson.vpn2.bfsu.edu.cn ([47.74.12.188])
        by smtp.gmail.com with ESMTPSA id u123sm89876144pfb.1.2019.01.07.21.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 21:45:17 -0800 (PST)
From:   YunQiang Su <syq@debian.org>
To:     pburton@wavecomp.com, linux-mips@vger.kernel.org,
        aaro.koskinen@iki.fi
Cc:     YunQiang Su <ysu@wavecomp.com>
Subject: [PATCH v2] Disable MSI also when pcie-octeon.pcie_disable on
Date:   Tue,  8 Jan 2019 13:45:10 +0800
Message-Id: <20190108054510.7393-1-syq@debian.org>
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
 arch/mips/pci/msi-octeon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index 2a5bb849b..288b58b00 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -369,7 +369,9 @@ int __init octeon_msi_initialize(void)
 	int irq;
 	struct irq_chip *msi;
 
-	if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_PCIE) {
+	if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_INVALID) {
+		return 0;
+	} else if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_PCIE) {
 		msi_rcv_reg[0] = CVMX_PEXP_NPEI_MSI_RCV0;
 		msi_rcv_reg[1] = CVMX_PEXP_NPEI_MSI_RCV1;
 		msi_rcv_reg[2] = CVMX_PEXP_NPEI_MSI_RCV2;
-- 
2.20.1

