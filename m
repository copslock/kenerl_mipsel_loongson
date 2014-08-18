Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2014 17:10:58 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:53573 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855222AbaHRPKw63Jml (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Aug 2014 17:10:52 +0200
Received: by mail-lb0-f177.google.com with SMTP id s7so4148639lbd.8
        for <linux-mips@linux-mips.org>; Mon, 18 Aug 2014 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=O95rpZvVpFkqNgqHvjigxuqgVjuXXZFS+iBsa3xdMMY=;
        b=Jxg2WtHN98mJM2fSkbetFy+M2u/hnWXUSb5S5BjE9HLLp/fEPITzx20JAThUIB+7qd
         pAUbqLbs3aAnCRcCdRhKbzDq1Mb4ij5S9Qj1jXju6xYWfMdEFbLrdPMQYVrz497TKqMD
         A0A0W8s7t4uhymrkLX8MDDanhnpMMdrPbp7AKnzCHgvrUqt2kAKG2keNtE1eHm+mHmG8
         +qFRJMHFDglmAg6Re8eJKikEPbuubbE18vIFgo9R3LyZcs/BSP5bqfW3E0UyWbnQa5dQ
         Xv6AMlvul5vh3DWkQjNB0SM16zNd/nITsQ8Bqy/IhfsP2i/hcSm9QsqhMIhyivmSOOmd
         Dd4w==
X-Received: by 10.152.26.38 with SMTP id i6mr9184256lag.86.1408374646271;
        Mon, 18 Aug 2014 08:10:46 -0700 (PDT)
Received: from localhost.localdomain (p4FD8DAC0.dip0.t-ipconnect.de. [79.216.218.192])
        by mx.google.com with ESMTPSA id ap2sm6307018lac.22.2014.08.18.08.10.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 08:10:44 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: fix db1200 PSC clock enablement
Date:   Mon, 18 Aug 2014 17:10:32 +0200
Message-Id: <1408374632-130791-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.4
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Enable PSC0 (I2C/SPI) clock and leave PSC1 (Audio) alone.  This patch
restores functionality to both Audio and I2C/SPI.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1200.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 7761889..8c13675 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -847,6 +847,7 @@ int __init db1200_dev_setup(void)
 			pr_warn("DB1200: cant get I2C close to 50MHz\n");
 		else
 			clk_set_rate(c, pfc);
+		clk_prepare_enable(c);
 		clk_put(c);
 	}
 
@@ -922,11 +923,6 @@ int __init db1200_dev_setup(void)
 	}
 
 	/* Audio PSC clock is supplied externally. (FIXME: platdata!!) */
-	c = clk_get(NULL, "psc1_intclk");
-	if (!IS_ERR(c)) {
-		clk_prepare_enable(c);
-		clk_put(c);
-	}
 	__raw_writel(PSC_SEL_CLK_SERCLK,
 	    (void __iomem *)KSEG1ADDR(AU1550_PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
 	wmb();
-- 
2.0.4
