Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:35:39 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:43892
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994767AbeCUT3NMNawZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:29:13 +0100
Received: by mail-qt0-x241.google.com with SMTP id s48so6491039qtb.10
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MsruA1Bj10kSXOkMeJmu7a9+3SjVwU5rGsaIWjpyIfc=;
        b=hwBZYkK0dQflUcUuludI2aBiaSkht12thzeJGeAdyq/l64f+89k9bIT9UjFIL1wDJN
         nseSRLs7E+gomok/q647R02Rq1Dylv/gjHa9NT+yvKBPr9K0kuF3ud3HjRojrPOEJ5ou
         aPmCgRO4BeuPSswmfK2T04ZLTg15NpHUVSPVQXSFMP4TFwXc3YdnsjTdBEzcXh8RW//9
         3plSpX6Ix0GdjHyqSj/+/xy/+insoAU27Ha8bkjEjSpDGiMeW/qIqB96HofrQOSxKr69
         JxxFCq4U8/yWhAGpTI0RimH/JZZ6BwH2MEuI4doHL0A5Kn9c2dkMQAXdYOp1PlNJQyyk
         LD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MsruA1Bj10kSXOkMeJmu7a9+3SjVwU5rGsaIWjpyIfc=;
        b=POEt5pgRxqLSXmgtC0BX4PdLBx2VF6pELdn0BajFNjsHajJB6/Xj9G2aniVGUx88XS
         28mYfv0h10wmU3es781FI0FlcGQ7XqOxC+8n7H6/emfujFMxgYG2QNG/EfMX6k9oTgIK
         eMmA9YFzJWhyrxZlItGTPGp+ZFuUTOnIFJerWzZmnr0b1m5CI0YiOS5+1D8V9zSdxECc
         qvJxTpf8K1dED0ORYAQj7xyGGmwVFlk6k8zjgskq+QQfKNIIAzIo46npURmk4aLjZKCe
         89aQTOgk1bXwOdfeD23ZcC8ZOr+8KJrBcvq1DLcaQIVHQzTHpioLiqNHl7fMlC+KbuTd
         9+TA==
X-Gm-Message-State: AElRT7GUNYh1/R8SJWBPL2HZul7TYs+0/jv10DrC/+DQKhfq3JrwG41G
        m8w3fQFFTSWVFDu6TtVTpTUsyg==
X-Google-Smtp-Source: AG47ELtFHEyH8beoj23TBvCL+TTK0DB5bTP2DfXVhf7WXVwolO+tc/ExEdhlyaaztyS75a0/pcwRnA==
X-Received: by 10.200.48.135 with SMTP id v7mr31329255qta.296.1521660547390;
        Wed, 21 Mar 2018 12:29:07 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:29:06 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH 11/14] MIPS: dts: jz4780: Add DMA controller node to the devicetree
Date:   Wed, 21 Mar 2018 16:27:38 -0300
Message-Id: <20180321192741.25872-12-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63134
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

Add the devicetree node to support the DMA controller found
in JZ480 SoCs.

Tested-by: Mathieu Malaterre <malat@debian.org>
Acked-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 12 +++++++++
 include/dt-bindings/dma/jz4780-dma.h   | 49 ++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 include/dt-bindings/dma/jz4780-dma.h

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 9b5794667aee..15a9801430bd 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/clock/jz4780-cgu.h>
+#include <dt-bindings/dma/jz4780-dma.h>
 
 / {
 	#address-cells = <1>;
@@ -241,6 +242,17 @@
 		status = "disabled";
 	};
 
+	dma: dma@13420000 {
+		compatible = "ingenic,jz4780-dma";
+		reg = <0x13420000 0x10000>;
+		#dma-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <10>;
+
+		clocks = <&cgu JZ4780_CLK_PDMA>;
+	};
+
 	bch: bch@134d0000 {
 		compatible = "ingenic,jz4780-bch";
 		reg = <0x134d0000 0x10000>;
diff --git a/include/dt-bindings/dma/jz4780-dma.h b/include/dt-bindings/dma/jz4780-dma.h
new file mode 100644
index 000000000000..df017fdfb44e
--- /dev/null
+++ b/include/dt-bindings/dma/jz4780-dma.h
@@ -0,0 +1,49 @@
+#ifndef __DT_BINDINGS_DMA_JZ4780_DMA_H__
+#define __DT_BINDINGS_DMA_JZ4780_DMA_H__
+
+/*
+ * Request type numbers for the JZ4780 DMA controller (written to the DRTn
+ * register for the channel).
+ */
+#define JZ4780_DMA_I2S1_TX	0x4
+#define JZ4780_DMA_I2S1_RX	0x5
+#define JZ4780_DMA_I2S0_TX	0x6
+#define JZ4780_DMA_I2S0_RX	0x7
+#define JZ4780_DMA_AUTO		0x8
+#define JZ4780_DMA_SADC_RX	0x9
+#define JZ4780_DMA_UART4_TX	0xc
+#define JZ4780_DMA_UART4_RX	0xd
+#define JZ4780_DMA_UART3_TX	0xe
+#define JZ4780_DMA_UART3_RX	0xf
+#define JZ4780_DMA_UART2_TX	0x10
+#define JZ4780_DMA_UART2_RX	0x11
+#define JZ4780_DMA_UART1_TX	0x12
+#define JZ4780_DMA_UART1_RX	0x13
+#define JZ4780_DMA_UART0_TX	0x14
+#define JZ4780_DMA_UART0_RX	0x15
+#define JZ4780_DMA_SSI0_TX	0x16
+#define JZ4780_DMA_SSI0_RX	0x17
+#define JZ4780_DMA_SSI1_TX	0x18
+#define JZ4780_DMA_SSI1_RX	0x19
+#define JZ4780_DMA_MSC0_TX	0x1a
+#define JZ4780_DMA_MSC0_RX	0x1b
+#define JZ4780_DMA_MSC1_TX	0x1c
+#define JZ4780_DMA_MSC1_RX	0x1d
+#define JZ4780_DMA_MSC2_TX	0x1e
+#define JZ4780_DMA_MSC2_RX	0x1f
+#define JZ4780_DMA_PCM0_TX	0x20
+#define JZ4780_DMA_PCM0_RX	0x21
+#define JZ4780_DMA_SMB0_TX	0x24
+#define JZ4780_DMA_SMB0_RX	0x25
+#define JZ4780_DMA_SMB1_TX	0x26
+#define JZ4780_DMA_SMB1_RX	0x27
+#define JZ4780_DMA_SMB2_TX	0x28
+#define JZ4780_DMA_SMB2_RX	0x29
+#define JZ4780_DMA_SMB3_TX	0x2a
+#define JZ4780_DMA_SMB3_RX	0x2b
+#define JZ4780_DMA_SMB4_TX	0x2c
+#define JZ4780_DMA_SMB4_RX	0x2d
+#define JZ4780_DMA_DES_TX	0x2e
+#define JZ4780_DMA_DES_RX	0x2f
+
+#endif /* __DT_BINDINGS_DMA_JZ4780_DMA_H__ */
-- 
2.16.2
