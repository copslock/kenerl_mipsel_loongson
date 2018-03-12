Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:02:11 +0100 (CET)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:46433
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeCLV7rNvSHf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:47 +0100
Received: by mail-qt0-x242.google.com with SMTP id m13so20590959qtg.13
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jQCX9UlB4I6JZI6O5mTJEo3CwL3AGCcV/QQhIg/E2Rw=;
        b=eeUf2zeJZmGE5xCvxiS3SYOrrs88XtVqf5suc1jla8s+YvmFc0UIlYcgYUoWSOGD4s
         /32iuiylP03Jkoiy3jShcbLBfLlSLsHCC3ja2HiWFSY8PxQCxPYCjCq4a6uqiDSly+NW
         6F/KLxDAu2+ayArhY8NCEcLwcJhipBmtbHtPCFb6JJMQuz05wDjT3tMjI8KAz1Y2JAUK
         4KWlW4uuj5Sl1lvajIlbbr6C+17q51omrZsLUOjEw/s+d6jYnxU8B2eu1xweEmWlHYnR
         erQ5LhySCbwjvC984eW1F8PKYS9Q9mMFIOnbce9yTgbZpG8AAfz7fkeqSimgiSK+o54P
         ZEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jQCX9UlB4I6JZI6O5mTJEo3CwL3AGCcV/QQhIg/E2Rw=;
        b=Irq6gC7Fv+bbjI9aywAJmF4ryqC302BiHqqw7SxZ/xYXRZ6buLZBtl9MYkdx8F38HT
         9sToVDTO3GzLuSE3OLzjrnGDBni4My2+FSzt3hj7cC9zhN9OSmTrfB5Qh4Ahim7/7Fcu
         LuPy+NwH6Wx6tti5/J8r+B1T/22bGY59SsAI+JW1WdjzzC4cbX23nI5aE0+plW7j8Qjg
         LuFBHiyz7VXrLpBgRFeAL/W9e3F26hAgsOv+wWBgKnInFFMD/w3KYHIgjxfsy7X3FWXj
         gYITZVayDCsNxkP/YwR7ByrJQRJWTVe4Pyp/F9ZBMvnHojL5hdYDa4ASoa1bnyF/5wqe
         nWUA==
X-Gm-Message-State: AElRT7Ga4HCUniTYq/P1NeAi/5yUX/I7R2MoL4Gjj+BBlYqbz1UbdaDX
        w9lLNykygBAh/iX4dtSvpZmgBsbB
X-Google-Smtp-Source: AG47ELsGmsnTV83rviBf9I9vPaicNuIFKsZWWE0mgWIfji8LDzfetC3Bx5kT3ECroT2I5rbRPr3GyQ==
X-Received: by 10.200.49.8 with SMTP id g8mr9304527qtb.279.1520891980204;
        Mon, 12 Mar 2018 14:59:40 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:39 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v2 11/14] MIPS: dts: jz4780: Add DMA controller node to the devicetree
Date:   Mon, 12 Mar 2018 18:55:51 -0300
Message-Id: <20180312215554.20770-12-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62942
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
