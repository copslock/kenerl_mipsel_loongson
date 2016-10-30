Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 00:05:29 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:48692 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992544AbcJ3XDJuBPHa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 00:03:09 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     rtc-linux@googlegroups.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Cc:     Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 6/7] MIPS: qi_lb60: Probe RTC driver from DT and use it as power controller
Date:   Mon, 31 Oct 2016 00:02:46 +0100
Message-Id: <20161030230247.20538-7-paul@crapouillou.net>
In-Reply-To: <20161030230247.20538-1-paul@crapouillou.net>
References: <20161030230247.20538-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1477868589; bh=Z023+pL6M5CvMKbbM+YFyMLu6B2UrFea6C8kayMKGfs=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jlYBomfiS6KMrNgjvkmnXzIq4bci8kjbBaIFRBDqNHf3+b4ICD1JdZK49Ki/gjJF8CXAN9nzYiW/ckiFV95nzyWLxsCIMJk6Nt0PQ6KNhfPx5ffIZSe+n8tP0J46VoWBzqBjCWcKd/0mn/8F2fJFO0hBhPNs4XMZ3SywPfa2uMY=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Since we already have a devicetree node for the jz4740-rtc driver, we
don't have to probe it from platform code.

Besides, using the jz4740-rtc driver as the power controller for the
qi_lb60 platform allows us to remove the jz4740 platform power-off code,
since this is the only jz4740-based board upstream.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Maarten ter Huurne <maarten@treewalker.org>
---
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 4 ++++
 arch/mips/jz4740/board-qi_lb60.c       | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

v2: New patch in this series

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index 2414d63..be1a7d3 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -13,3 +13,7 @@
 &ext {
 	clock-frequency = <12000000>;
 };
+
+&rtc_dev {
+	system-power-controller;
+};
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 258fd03..a5bd94b 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -438,7 +438,6 @@ static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_pcm_device,
 	&jz4740_i2s_device,
 	&jz4740_codec_device,
-	&jz4740_rtc_device,
 	&jz4740_adc_device,
 	&jz4740_pwm_device,
 	&jz4740_dma_device,
-- 
2.9.3
