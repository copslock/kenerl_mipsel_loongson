Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:16:36 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:46200
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994824AbeCIPNmmBhzw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:42 +0100
Received: by mail-qk0-x243.google.com with SMTP id d8so1710928qkc.13
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cirn4nRTZ03f2riyhkDoUUy5AwvcZ7qfrWmuySH1ixc=;
        b=kZMcPflEr7mdt5GUbrNGbkyIHJHKWa3LZO5a1+sA5fmlCYZ6Q43iip/lHFqJJ7jg2M
         iEtolhsCO5ZHd1dh+znZV2D2lhqJgD0zMwHhoBgLXpuNpRruaXabyUdgcYSITaPFbDqQ
         H3mYcuPJg4uZpgJIaVKL2P9kl4kmOByDIXNQ4QinmmWNnLFawdI3zPbr3veoE7RS6tpp
         U7XRu9XBoRQsXc/uNp3yodRUvdpKtpRdzKOfHwYriJnM942HiPkdmCEx2BzifQYffAmL
         XFMc1Iy8CvTaAeHlcp8rl//Dh1F2sB+lPnvwr5qKE+PsI3F78PpmWQqzEozBRTFGGem7
         0r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cirn4nRTZ03f2riyhkDoUUy5AwvcZ7qfrWmuySH1ixc=;
        b=fMPJ8Xv3iwFnd2+yzRJxYtF0vPal6b5pgza4xw1NCfE73AuajCRmf9p11WoNT3udxL
         3b1FXUSUI0tjuGWlsD1WPDCeMSsnjEWiONyZL1LJa15EqPgd6tuvC+/MUhKQlyGaS6/j
         t7D9nxvPc6G+3xudqZ1FH+CA+344DwzCJD0/FhJULlVlyQgtSbqr4p6qsA3zjM1FuLWb
         XFVhx7eY/022y++uibtQRUUvmfMvRTrYS03kvwnT9+ZBTahFo4b/E5TGMe8iSR6lRU9V
         GW+32dL1vigrbNIBANTzSfWk259ybbqF0EZGiHc5VTbhUCgGwiWCTfmXnEe+Kr7L/Q5u
         JHVw==
X-Gm-Message-State: AElRT7H4E3yASkJNM2e+b0pC0Zwn43LV70ExkhaBWVe3fd5N9DHDDCOP
        pBlc7ETRTUixzkeqpQ+6p/Pv3g==
X-Google-Smtp-Source: AG47ELtosqMkvvTkhy7fTKPPQY2HnYYAayXjoMllSkNzVC7FzBA/OrDNx5s9GsP/n48RQ2Q/ainw8g==
X-Received: by 10.55.111.66 with SMTP id k63mr45525476qkc.25.1520608416888;
        Fri, 09 Mar 2018 07:13:36 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:36 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 12/14] MIPS: dts: jz4780: Add MMC controller node to the devicetree
Date:   Fri,  9 Mar 2018 12:12:17 -0300
Message-Id: <20180309151219.18723-13-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62889
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

This commit adds the devicetree node to support the MMC
host controller available in JZ480 SoCs.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index fd2ef820fbe3..286c3b80d9af 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -255,6 +255,46 @@
 		status = "disabled";
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
