Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 16:20:34 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:12506 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026074AbbDXOUYL084e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Apr 2015 16:20:24 +0200
Received: from localhost.localdomain (unknown [85.177.202.128])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPA id 1634182325;
        Fri, 24 Apr 2015 16:17:50 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-spi@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>, Alban Bedel <albeu@free.fr>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 3/4] spi: spi-ath79: Use clk_prepare_enable and clk_disable_unprepare
Date:   Fri, 24 Apr 2015 16:19:23 +0200
Message-Id: <1429885164-28501-4-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429885164-28501-1-git-send-email-albeu@free.fr>
References: <1429885164-28501-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Clocks should be prepared and unprepared, fix this by using
clk_prepare_enable() and clk_disable_unprepare() instead of
clk_enable() and clk_disable().

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/spi/spi-ath79.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 239bc31..b37bedd 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -249,7 +249,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 		goto err_put_master;
 	}
 
-	ret = clk_enable(sp->clk);
+	ret = clk_prepare_enable(sp->clk);
 	if (ret)
 		goto err_put_master;
 
@@ -273,7 +273,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 err_disable:
 	ath79_spi_disable(sp);
 err_clk_disable:
-	clk_disable(sp->clk);
+	clk_disable_unprepare(sp->clk);
 err_put_master:
 	spi_master_put(sp->bitbang.master);
 
@@ -286,7 +286,7 @@ static int ath79_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&sp->bitbang);
 	ath79_spi_disable(sp);
-	clk_disable(sp->clk);
+	clk_disable_unprepare(sp->clk);
 	spi_master_put(sp->bitbang.master);
 
 	return 0;
-- 
2.0.0
