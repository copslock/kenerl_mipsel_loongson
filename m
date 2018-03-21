Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:34:38 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:34633
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994763AbeCUT3CGMMjZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:29:02 +0100
Received: by mail-qk0-x244.google.com with SMTP id z184so6722048qkc.1
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c33eXkoTAqjBPjksdgnedmVe3xN0ZA6ftlENmZCV71k=;
        b=eZP8y1rFEc+RNxZzEBiURCoY9kqTlkrNQc4WIey/nP2towwESV3Dmf/k3tA7AroW+/
         wg7NebTkFvduleBs24cypeGnAQnhwQy1xrNS0rZlAMTFN+qgrfy47YFWqlI5C9zE4Of8
         AeoybHC7P1twIomtKwkZqKtcae5St+I5ZTH439Gaek8p9DVew4KS8ynp7W8oGAD/fwlq
         xOW1UEB9E4RTyxtVLlU67rbtvtDux6WP5UiGAlQZ6BjdF/NvpuQw3VEhd+HaThrGALux
         e2VuoEO1y4fI0sq64vuE/rCxPuTF7EjMgbZjGW0/BRt8LAVRdYpUlqlWgCB+cb0h+POC
         kEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c33eXkoTAqjBPjksdgnedmVe3xN0ZA6ftlENmZCV71k=;
        b=PSBJa796NqS2R8FHeUn4cJ1UvCFQZu56TlPdOKcSF+MJ+lNuxAN+B5ubLAjvr6h3JZ
         pLK6AViGBgLqm0hpC3Cgjb9sXOAyMVc/vBXC78XAdc0oJClwiCplSFhAeHPF9tD4yBsO
         xI08jBoH5EwPnt6oVXikG/Xr8nayRTwSL+X2lI2BFtKZp/VuJ8IlhqJcT8NP0ruVom8W
         HpIjDivKUYoz5Z7kPwLZ4QlgbLC3TsadK/D6i5w8xSU6MdXMEDktq1dCpp4E3tvOoxAZ
         UyHbqH1zJnyoGGV+gZgtesmlSdxnbktdUrU3r29XV7OEqF++DoIXzOVF++O+Dhh+zUw4
         q/Iw==
X-Gm-Message-State: AElRT7FlUGdrBgOGAVdTuyva+86oq7clKegxzSbAeRwd7Tt+zKfHc+Z0
        4VBYW8DqSDFeMKZ67typZJqZOg==
X-Google-Smtp-Source: AG47ELtIPk+5mFpfnt/pQ1umRZTGW6rbrkyIxTIsUrXZ1DWOIc/Hp4tJUjS475PC+3cDT+r7r9Gd2g==
X-Received: by 10.55.159.204 with SMTP id i195mr7212781qke.188.1521660536291;
        Wed, 21 Mar 2018 12:28:56 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:28:55 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 07/14] mmc: dt-bindings: add MMC support to JZ4740 SoC
Date:   Wed, 21 Mar 2018 16:27:34 -0300
Message-Id: <20180321192741.25872-8-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63130
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

Add the devicetree binding for JZ4740/JZ4780 SoC MMC/SD controller.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 Documentation/devicetree/bindings/mmc/jz4740.txt | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/jz4740.txt

diff --git a/Documentation/devicetree/bindings/mmc/jz4740.txt b/Documentation/devicetree/bindings/mmc/jz4740.txt
new file mode 100644
index 000000000000..7cd8c432d7c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/jz4740.txt
@@ -0,0 +1,38 @@
+* Ingenic JZ47xx MMC controllers
+
+This file documents the device tree properties used for the MMC controller in
+Ingenic JZ4740/JZ4780 SoCs. These are in addition to the core MMC properties
+described in mmc.txt.
+
+Required properties:
+- compatible: Should be one of the following:
+  - "ingenic,jz4740-mmc" for the JZ4740
+  - "ingenic,jz4780-mmc" for the JZ4780
+- reg: Should contain the MMC controller registers location and length.
+- interrupts: Should contain the interrupt specifier of the MMC controller.
+- clocks: Clock for the MMC controller.
+
+Optional properties:
+- dmas: List of DMA specifiers with the controller specific format
+        as described in the generic DMA client binding. A tx and rx
+        specifier is required.
+- dma-names: RX and TX  DMA request names.
+        Should be "rx" and "tx", in that order.
+
+For additional details on DMA client bindings see ../dma/dma.txt.
+
+Example:
+
+mmc0: mmc@13450000 {
+	compatible = "ingenic,jz4780-mmc";
+	reg = <0x13450000 0x1000>;
+
+	interrupt-parent = <&intc>;
+	interrupts = <37>;
+
+	clocks = <&cgu JZ4780_CLK_MSC0>;
+	clock-names = "mmc";
+
+	dmas = <&dma JZ4780_DMA_MSC0_RX 0xffffffff>, <&dma JZ4780_DMA_MSC0_TX 0xffffffff>;
+	dma-names = "rx", "tx";
+};
-- 
2.16.2
