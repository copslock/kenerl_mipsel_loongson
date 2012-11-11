Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 13:51:37 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:35486 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826604Ab2KKMums2DQW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 13:50:42 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2053444bkw.36
        for <multiple recipients>; Sun, 11 Nov 2012 04:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ilzpKAQ1ReXtyJCwmpwlHMSak+2qKuTY8Z7a6jgToSA=;
        b=MxSdwS8bEazLvXt3dtdnDwFRMLP1zutEWT5C8EmcOGkp9iNxHTjFhEmZczPqHsRORx
         V+ZyZ/hPxTNouSNBmBbzFVmdA8XdRtLTENNceEnz2Dtu0EoruiJFyeKcNRBPjRZifsKD
         JVrS09PYgAsmCWBWsDbW/FHYEkEPi+aHtLdbKHlbGOOvpqicegW4m4wI4TQ7/M41OLoX
         pW/bMs3H0XjHGvLxgB1VciVKOJfiwTbzxZIpW8mIRY5lQorM+MydzxE5dQujs/b/TkEi
         JcRRXFrNKPcM7kesJnYg0iZ92C0wOSDqZMKuCDTISXqbqR3l0hpVn4bpRaKrVdPzjKg0
         fttQ==
Received: by 10.204.0.74 with SMTP id 10mr6112865bka.83.1352638242570;
        Sun, 11 Nov 2012 04:50:42 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id z22sm1436133bkw.2.2012.11.11.04.50.40
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 04:50:41 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC] SPI: spi-bcm63xx: use clk_{prepare_enable,disable_unprepare}
Date:   Sun, 11 Nov 2012 13:50:39 +0100
Message-Id: <1352638249-29298-6-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Use proper clk_prepare/unprepare calls in preparation for switching
to the generic clock framework.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/spi/spi-bcm63xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index a9f4049..69cb96a 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -431,7 +431,7 @@ static int __devinit bcm63xx_spi_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize hardware */
-	clk_enable(bs->clk);
+	clk_prepare_enable(bs->clk);
 	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
 
 	/* register and we are done */
@@ -447,7 +447,7 @@ static int __devinit bcm63xx_spi_probe(struct platform_device *pdev)
 	return 0;
 
 out_clk_disable:
-	clk_disable(clk);
+	clk_disable_unprepare(clk);
 out_err:
 	platform_set_drvdata(pdev, NULL);
 	spi_master_put(master);
@@ -468,7 +468,7 @@ static int __devexit bcm63xx_spi_remove(struct platform_device *pdev)
 	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
 
 	/* HW shutdown */
-	clk_disable(bs->clk);
+	clk_disable_unprepare(bs->clk);
 	clk_put(bs->clk);
 
 	platform_set_drvdata(pdev, 0);
-- 
1.7.2.5
