Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 22:00:34 +0200 (CEST)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:59420 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025192AbaHVUAdUGD2U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 22:00:33 +0200
Received: by mail-wg0-f45.google.com with SMTP id x12so11084558wgg.16
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QLTB3Pl2k9Jc5TWrpS9xqtY81UHGi8I4LZ3gOpCFYkI=;
        b=WayGmhXd9JpZLvQt+buKFh77Y7oG0IazvFQ5MhahJSWFdai3uJzYBzaeTg3EFHahfH
         /4CgDZWlo/Sq1MSparijGL77xqBPrMipkVr8O7f0QZTQRLALAm5pi38Zadqe+6KwRrKj
         SN2V9ORO+IgoVMtdRDPNV6Iv7wSntvBASodnd2bw6k8Gv6sdsIMdh3xFH3kEvnEcpV6t
         JnnS6Anf4F5EkepyrGqqEV+B21meucubhoWWdrr5Uq6KvNXJcPsfAQ56zeIoMVYysVfr
         o4VgPbCfGGY4uUBGypZsfdnc4JiRySYIyj9ktuMhF6lg2c4gvrIu3bdgg2c/dqV82LxE
         4o+A==
X-Received: by 10.180.208.81 with SMTP id mc17mr17755052wic.7.1408563413280;
        Wed, 20 Aug 2014 12:36:53 -0700 (PDT)
Received: from localhost.localdomain (p4FD8DBDE.dip0.t-ipconnect.de. [79.216.219.222])
        by mx.google.com with ESMTPSA id vn10sm60779177wjc.28.2014.08.20.12.36.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Aug 2014 12:36:52 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 3/4] MIPS: Alchemy: db1xxx: explicitly set 50MHz clock for I2C/SPI units.
Date:   Wed, 20 Aug 2014 21:36:32 +0200
Message-Id: <1408563393-132515-4-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1408563393-132515-1-git-send-email-manuel.lauss@gmail.com>
References: <1408563393-132515-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42168
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

Add an explicit call to set the desired rate to get the correct
clock routing for the PSC clocks.  It wasn't broken before, but
now it's less affected by bootloader changes.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1300.c | 3 ++-
 arch/mips/alchemy/devboards/db1550.c | 9 ++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index ef93ee3..e476ae9 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -762,9 +762,10 @@ int __init db1300_dev_setup(void)
 	__raw_writel(PSC_SEL_CLK_SERCLK,
 	    (void __iomem *)KSEG1ADDR(AU1300_PSC2_PHYS_ADDR) + PSC_SEL_OFFSET);
 	wmb();
-	/* I2C uses internal 48MHz EXTCLK1 */
+	/* I2C driver wants 50MHz, get as close as possible */
 	c = clk_get(NULL, "psc3_intclk");
 	if (!IS_ERR(c)) {
+		clk_set_rate(c, 50000000);
 		clk_prepare_enable(c);
 		clk_put(c);
 	}
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index 7e89936..0fd5177 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -34,12 +34,9 @@ static void __init db1550_hw_setup(void)
 	void __iomem *base;
 	unsigned long v;
 
-	/* complete SPI setup: link psc0_intclk to a 48MHz source,
-	 * and assign GPIO16 to PSC0_SYNC1 (SPI cs# line) as well as PSC1_SYNC
-	 * for AC97 on PB1550.
+	/* complete pin setup: assign GPIO16 to PSC0_SYNC1 (SPI cs# line)
+	 * as well as PSC1_SYNC for AC97 on PB1550.
 	 */
-	v = alchemy_rdsys(AU1000_SYS_CLKSRC);
-	alchemy_wrsys(v | 0x000001e0, AU1000_SYS_CLKSRC);
 	v = alchemy_rdsys(AU1000_SYS_PINFUNC);
 	alchemy_wrsys(v | 1 | SYS_PF_PSC1_S1, AU1000_SYS_PINFUNC);
 
@@ -586,11 +583,13 @@ int __init db1550_dev_setup(void)
 
 	c = clk_get(NULL, "psc0_intclk");
 	if (!IS_ERR(c)) {
+		clk_set_rate(c, 50000000);
 		clk_prepare_enable(c);
 		clk_put(c);
 	}
 	c = clk_get(NULL, "psc2_intclk");
 	if (!IS_ERR(c)) {
+		clk_set_rate(c, db1550_spi_platdata.mainclk_hz);
 		clk_prepare_enable(c);
 		clk_put(c);
 	}
-- 
2.0.4
