Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:02:26 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:38367
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbeCLV7sqwkBf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:48 +0100
Received: by mail-qt0-x241.google.com with SMTP id n12so20618970qtl.5
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lgToQCO/CiugnDBXCRcTKqD4j3HF8lA1U3msvlwVsIE=;
        b=LTEOJA6bLPyh/zA8sg8qc3ivhovhF2aHLOWpEdjSfLHfLBq8ZJbWGbORcT1uyOVcW/
         MlqI5EjYz6Qiot9fcnQvK8+APkdN64vwpEJS1qxH6ZTC/rImnV5bhKYRBZtA5YqQwRg7
         1SrIGg7ZAIaa/K+861UFkzB4MccnCL1otlDFBTTHSg+6RcAvpUimu5p6wM5Yy6roTw/X
         49TjHjgqHkT9VTfCM0U7IUJ9u0EiAoB6molAUt8hDhl1kC6y/xwSCntwC9rbuagGPUYk
         U76NgoijAGRNVVbkzHituhcQuL+jTd8w8FuZmN29NPunIZcBN6lOcxw1EcZ2B2dnVnA0
         9CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lgToQCO/CiugnDBXCRcTKqD4j3HF8lA1U3msvlwVsIE=;
        b=KKzi8R9NhiinmM4Uy1Txitozwi2rc5m2BZFPdppsbiwSVGnk2DFXQI8lBNZbEWziIa
         kAQ1L7KgQ/Um200PCAjb47BncG3YWbokWDL8hweZWf0Z1mcvD4x1a9IS4xUGVRAKOKiN
         XKwDZeTSoXAznrvTVFBBh3c0dRnnBD3Cfab4Vo6h5+2L8hCUtJDsQgSbVpqv2JVSTOi5
         qS4J0TeS3nbvCq6eBNHGuvr32pGnpYJUvxyUExAR6H56r5tTohqVNRazLrrdHH3j5i65
         a7S6GTkqNgThRY2EPdfwfNEZM2hEwgtS3uXQy6eGnIAEl0AYiHhSPeRHKBrtKVf8EWbv
         6grg==
X-Gm-Message-State: AElRT7F7YOfLxcZedUY67YO25LPchrah5TvP2CuefCwDLFntmbseizlD
        rCwUdAqj+x+G+kGskz8sb5DSjw==
X-Google-Smtp-Source: AG47ELtktEbJhOyREVmKlZS85SqRcWRhbMr42/PGV0GZDITyUOXhdAw7Kv5fdyoLb+E+blMrbEoLsg==
X-Received: by 10.237.57.197 with SMTP id m63mr14539795qte.249.1520891982971;
        Mon, 12 Mar 2018 14:59:42 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:42 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v2 12/14] MIPS: dts: jz4780: Add MMC controller node to the devicetree
Date:   Mon, 12 Mar 2018 18:55:52 -0300
Message-Id: <20180312215554.20770-13-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Add the devicetree node to support the MMC host controller
available in JZ480 SoCs.

Acked-by: James Hogan <jhogan@kernel.org>
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 15a9801430bd..b72e53bb7292 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -253,6 +253,46 @@
 		clocks = <&cgu JZ4780_CLK_PDMA>;
 	};
 
+	mmc0: mmc@13450000 {
+		compatible = "ingenic,jz4780-mmc";
+		reg = <0x13450000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <37>;
+
+		clocks = <&cgu JZ4780_CLK_MSC0>;
+		clock-names = "mmc";
+
+		cap-sd-highspeed;
+		cap-mmc-highspeed;
+		cap-sdio-irq;
+		dmas = <&dma JZ4780_DMA_MSC0_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_MSC0_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		status = "disabled";
+	};
+
+	mmc1: mmc@13460000 {
+		compatible = "ingenic,jz4780-mmc";
+		reg = <0x13460000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <36>;
+
+		clocks = <&cgu JZ4780_CLK_MSC1>;
+		clock-names = "mmc";
+
+		cap-sd-highspeed;
+		cap-mmc-highspeed;
+		cap-sdio-irq;
+		dmas = <&dma JZ4780_DMA_MSC1_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_MSC1_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		status = "disabled";
+	};
+
 	bch: bch@134d0000 {
 		compatible = "ingenic,jz4780-bch";
 		reg = <0x134d0000 0x10000>;
-- 
2.16.2
