Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 07:47:09 +0200 (CEST)
Received: from mail-pg0-x22c.google.com ([IPv6:2607:f8b0:400e:c05::22c]:33193
        "EHLO mail-pg0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbdF3FrBOMsNm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jun 2017 07:47:01 +0200
Received: by mail-pg0-x22c.google.com with SMTP id f127so58488423pgc.0
        for <linux-mips@linux-mips.org>; Thu, 29 Jun 2017 22:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fsLLYHBPsKKb3mLCINlcyWXRGaZKhhkZ1uczRcer8+E=;
        b=D1st9FoLBFC4Za2WgU3p2+GZJedey80aG+b1rVtReiOgENQ3MNNnQiob0qq3S2kOVk
         0AwMEdEaHlfrdYV3Df7eAUxlZlIrVfVYZ2kW6lkO5gBqxRxtx3qeXeN61JTZxvqJbvRr
         0gdTrLq7bSGyrUq7yfPo35SxK2Vf4VPTM1fJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fsLLYHBPsKKb3mLCINlcyWXRGaZKhhkZ1uczRcer8+E=;
        b=ZdlAEKkgiNXEgTVKPSL58uzZPbs6Ed68r4s74Ym1iFzKwuFPbXpXqoIxVIYeI6XEkV
         dN1djfVZJtn2sv/f0WoFVCLKbAGOiS3SX4BAqsI5oNNorsJgpaoIvIYhsEQYuVS8VO7D
         ssFGoXyX8PN2tfnUOjZfBGAnd4nqX9dT7yCTmIMuxsS/LMAfourW+9JOgziQtKGmvhI2
         hmXw6iZEVGsinY85nOoBMXs8Kc0AVuWalSyeIk67H0cDJNJDdH3fO5DomaubnVlMUFSi
         bHnLQY0nToWfUCRnzhZC1rI6h/DyEBpWnmOfBPMAV2d2c9Fy2GkAzK5N/+/SgcVEX8Q4
         C8Yw==
X-Gm-Message-State: AKS2vOzG1DOVSj+IyZHZUPG9LGQeEkBOAJBjt20g1pAVc5vujgrjAwpd
        sjlUSRmvn+wtSBD5
X-Received: by 10.84.212.151 with SMTP id e23mr22617577pli.115.1498801615303;
        Thu, 29 Jun 2017 22:46:55 -0700 (PDT)
Received: from localhost.localdomain ([106.51.129.233])
        by smtp.gmail.com with ESMTPSA id a187sm11405550pgc.37.2017.06.29.22.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 22:46:54 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stable <stable@vger.kernel.org>, Felix Fietkau <nbd@nbd.name>,
        Alban Bedel <albeu@free.fr>,
        sergei.shtylyov@cogentembedded.com, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.4 03/16] MIPS: ath79: fix regression in PCI window initialization
Date:   Fri, 30 Jun 2017 11:16:27 +0530
Message-Id: <1498801600-20896-4-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498801600-20896-1-git-send-email-amit.pundir@linaro.org>
References: <1498801600-20896-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Felix Fietkau <nbd@nbd.name>

commit 9184dc8ffa56844352b3b9860e562ec4ee41176f upstream.

ath79_ddr_pci_win_base has the type void __iomem *, so register offsets
need to be a multiple of 4.

Cc: Alban Bedel <albeu@free.fr>
Fixes: 24b0e3e84fbf ("MIPS: ath79: Improve the DDR controller interface")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Cc: sergei.shtylyov@cogentembedded.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13258/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/ath79/common.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index 3cedd1f95e0f..8ae4067a5eda 100644
--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -76,14 +76,14 @@ void ath79_ddr_set_pci_windows(void)
 {
 	BUG_ON(!ath79_ddr_pci_win_base);
 
-	__raw_writel(AR71XX_PCI_WIN0_OFFS, ath79_ddr_pci_win_base + 0);
-	__raw_writel(AR71XX_PCI_WIN1_OFFS, ath79_ddr_pci_win_base + 1);
-	__raw_writel(AR71XX_PCI_WIN2_OFFS, ath79_ddr_pci_win_base + 2);
-	__raw_writel(AR71XX_PCI_WIN3_OFFS, ath79_ddr_pci_win_base + 3);
-	__raw_writel(AR71XX_PCI_WIN4_OFFS, ath79_ddr_pci_win_base + 4);
-	__raw_writel(AR71XX_PCI_WIN5_OFFS, ath79_ddr_pci_win_base + 5);
-	__raw_writel(AR71XX_PCI_WIN6_OFFS, ath79_ddr_pci_win_base + 6);
-	__raw_writel(AR71XX_PCI_WIN7_OFFS, ath79_ddr_pci_win_base + 7);
+	__raw_writel(AR71XX_PCI_WIN0_OFFS, ath79_ddr_pci_win_base + 0x0);
+	__raw_writel(AR71XX_PCI_WIN1_OFFS, ath79_ddr_pci_win_base + 0x4);
+	__raw_writel(AR71XX_PCI_WIN2_OFFS, ath79_ddr_pci_win_base + 0x8);
+	__raw_writel(AR71XX_PCI_WIN3_OFFS, ath79_ddr_pci_win_base + 0xc);
+	__raw_writel(AR71XX_PCI_WIN4_OFFS, ath79_ddr_pci_win_base + 0x10);
+	__raw_writel(AR71XX_PCI_WIN5_OFFS, ath79_ddr_pci_win_base + 0x14);
+	__raw_writel(AR71XX_PCI_WIN6_OFFS, ath79_ddr_pci_win_base + 0x18);
+	__raw_writel(AR71XX_PCI_WIN7_OFFS, ath79_ddr_pci_win_base + 0x1c);
 }
 EXPORT_SYMBOL_GPL(ath79_ddr_set_pci_windows);
 
-- 
2.7.4
