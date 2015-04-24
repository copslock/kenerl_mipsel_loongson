Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 16:20:52 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:13186 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026075AbbDXOUiM22Ch (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Apr 2015 16:20:38 +0200
Received: from localhost.localdomain (unknown [85.177.202.128])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPA id 63BEA82348;
        Fri, 24 Apr 2015 16:18:05 +0200 (CEST)
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
Subject: [PATCH 4/4] spi: spi-ath79: Set the initial state of CS0
Date:   Fri, 24 Apr 2015 16:19:24 +0200
Message-Id: <1429885164-28501-5-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429885164-28501-1-git-send-email-albeu@free.fr>
References: <1429885164-28501-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47076
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

The internal chip select CS0 wasn't initialized properly to work with
CS HIGH chips.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/spi/spi-ath79.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index b37bedd..bf1f9b3 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -115,6 +115,7 @@ static void ath79_spi_disable(struct ath79_spi *sp)
 
 static int ath79_spi_setup_cs(struct spi_device *spi)
 {
+	struct ath79_spi *sp = ath79_spidev_to_sp(spi);
 	int status;
 
 	if (spi->chip_select && !gpio_is_valid(spi->cs_gpio))
@@ -132,6 +133,13 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 
 		status = gpio_request_one(spi->cs_gpio, flags,
 					  dev_name(&spi->dev));
+	} else {
+		if (spi->mode & SPI_CS_HIGH)
+			sp->ioc_base &= ~AR71XX_SPI_IOC_CS0;
+		else
+			sp->ioc_base |= AR71XX_SPI_IOC_CS0;
+
+		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
 	}
 
 	return status;
-- 
2.0.0
