Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:16:23 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:38599
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994820AbeCIPNkYjovw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:40 +0100
Received: by mail-qt0-x243.google.com with SMTP id n12so11030270qtl.5
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wcrjaMlIbEPSNo5xHyhtKYnLi7Uzt/2vPsM/j2Hu928=;
        b=cUPG4xYRegLkHxKrZ3SXlMetRytIFSf8uIqxvEoqavegXKGM/bNaI7x6yAhQtl8FxY
         +Kb1QjNs0a3nidyumitcq0BEIibFeGiwCtfNBgIPnYOW5nWCT56rEU08eUGxZbZntpjz
         JRD0YcQcsO25PZqmwubDncwC79hIbk89/UEfT6zhVYVkhoL+ah4cL5Ak86UG9ByquOhZ
         H34Q9V7Ia3Hif+JAKPeR5cJaQkVW5Zhubxm/s2efzwwXw7IquZtVvL1tOvnZPqkh6wZ9
         FV6oru7jqCHrm0pPcEJgKUi495y7weW9fLME6l4hISZcxP8zE/RvDNrx8ngNJ4Rb2pzQ
         Zm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wcrjaMlIbEPSNo5xHyhtKYnLi7Uzt/2vPsM/j2Hu928=;
        b=JKfEW/FneUfuq6j8DeC58EbsqFI3kUVnNwbc6cTWozqougnvyI4ZN92X4KdmeGj1Tr
         h8S+k6+n3gY/9M0xqJQ0WCIYaCrnaNRkv8tTGdLy1qPqvWIQqgujxtHlf1nNomxS0JRw
         5jnsYkgqzMnMr8jH2umT/Zg5cai+MhaWmEWcaAIDx6jKES4HjIj6yqoAYKdVNTBJUT7T
         KgEY30Eenn19aY+OVe6G7Ga26IdiA5mfqqX531FP/7Uy6qKELeVSPMOBF11TwR21/t1T
         g3GyMxd1YtqnyC9+QLmhZlZhQpzpaeEQFXfjHp4q9HU44CD6hgGbzY0oGHCDulvlCa5F
         Z5nQ==
X-Gm-Message-State: AElRT7EIna/BKv6n+cXuq9t0w01lzmr4MLURRSTaZs76DonyTxff8irx
        yjN0YnlQWYiqcS5hu1Rq52jrFw==
X-Google-Smtp-Source: AG47ELuOKQeEubI3zV4qxeLvk92pFeLCx5mplpgcH/uyB/5/+MjyBx1CjkhOB7AuecxeSo5oHD+gdQ==
X-Received: by 10.237.47.194 with SMTP id m60mr44395978qtd.32.1520608414540;
        Fri, 09 Mar 2018 07:13:34 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:33 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 11/14] MIPS: dts: jz4780: Add DMA controller node to the devicetree
Date:   Fri,  9 Mar 2018 12:12:16 -0300
Message-Id: <20180309151219.18723-12-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62888
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

This commit adds the devicetree node to support the DMA
controller found in JZ480 SoCs.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 14 ++++++++++
 include/dt-bindings/dma/jz4780-dma.h   | 49 ++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 include/dt-bindings/dma/jz4780-dma.h

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 9b5794667aee..fd2ef820fbe3 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/clock/jz4780-cgu.h>
+#include <dt-bindings/dma/jz4780-dma.h>
 
 / {
 	#address-cells = <1>;
@@ -241,6 +242,19 @@
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
+
+		status = "disabled";
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
