Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:35:58 +0100 (CET)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:46833
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994702AbeCUT3QCq83Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:29:16 +0100
Received: by mail-qt0-x242.google.com with SMTP id h4so6491577qtn.13
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lgToQCO/CiugnDBXCRcTKqD4j3HF8lA1U3msvlwVsIE=;
        b=lAUtERt94QM7uQYGhsebHJF/6l0XA9eE1X1yFNr/wFkTZ2IOux93oXk6r2Rs1bpbOj
         LxVi3CL4FMy1pIhw2StLjZ5ZeraCXjjB+hhgtRGvSonR/7j9ogeypwwycVVjMJNuXUzl
         w4f+6/fLT8CBcxBCovYxa+/PA7lxn3CzMyvxRRFikXa5EGDg7HtLr4mPmm5BgaVKLjCY
         JclyFqP0zrP6w+fdabTOU3FHmrwh8RJyh2s/yTzdbpQn1ps5VZjNT8wVUZw1RkAdmi6u
         ojVMqQ2w227ByGRqN/NUqDcaMkhu+w7eKitRpwHnpW5MLdcZPFYvSNdgnrx7npf2gZNv
         Aoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lgToQCO/CiugnDBXCRcTKqD4j3HF8lA1U3msvlwVsIE=;
        b=ZdzoVsqCIzJrKKxpCA/7d9nUUdfjUvhqHiILIEKX6jqojTX46bfcZhSFuZUEJzjJjH
         0s8zJC5XO+8gv06PHi30O2OC1gGcbSZNhoLxkmr9chJw/RrAm42eg9HsSSolNeXhgu+A
         ILSgoDgvXgWe6mZkOQYhuG2P9nfHAB70i8sQlEA4yU4RQj3O/AaMOiVmJdHqnh9KHnoe
         kDDTO+JDSXSXP9+S6wZtav59Rb7wnQ4tY9t1KFYZRtSQSd7QAHhWfodlEA9dnn8qqZR1
         QjX6plVf7iN13qarGZIHz5pV/KQ2puHSpyJFjim8ba/AsgJVweE52ZjCMqhaz7NhbFED
         836g==
X-Gm-Message-State: AElRT7FWzxItsftCdFX8in8oPlFuGB6z2FuP0hIHJm+gylHOEPmZwCT7
        odrp9j6iLD4ytmU/3TPCTCAvlA==
X-Google-Smtp-Source: AG47ELslmOoSoaGXwR//PmJl6i8Jl/tCxo5ufz7c4SpaH4jGKSPGNx0/yLtef9NNwz6fJ+Rp63cvHg==
X-Received: by 10.237.35.76 with SMTP id i12mr31145506qtc.134.1521660550119;
        Wed, 21 Mar 2018 12:29:10 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:29:09 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH 12/14] MIPS: dts: jz4780: Add MMC controller node to the devicetree
Date:   Wed, 21 Mar 2018 16:27:39 -0300
Message-Id: <20180321192741.25872-13-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63135
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
