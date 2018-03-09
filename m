Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:15:02 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:39092
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994806AbeCIPN3yXO0w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:29 +0100
Received: by mail-qt0-x244.google.com with SMTP id n9so11011010qtk.6
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gOyZTLYBUN29sc/NXSomkiVqT7iPyYD2eKGMKo30/xw=;
        b=GUqiHpyPE34SuuPip0kAkbHLiE24b04PLR/IaDadO3/Pcys/VH+26b/wbAQucGDbHe
         aVsTp3DZU46/af/Zvqv5gTikoNT437DBv5lugDDaX+i4xXaDDK5TRkCnE2oZxAqFFLvx
         p/wtNc9Gwr5gfPKFfqaLddUWdaM/oc71bVrZqq1hIEOD9TzFKqjUig0E6AExGnslt3o+
         SOxT1WuW8+biqMeUAoXCmbBOsrNbpdBoLhcplW2d31vSxEhAElGtk1VceAWaf9hgLCVt
         whgbBgb+BNW7DLA+dlZ5JjOJac79COoHnsmlNqCjZt3dWtB/KnSR+nVvmuomaxqC7Jgn
         pxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gOyZTLYBUN29sc/NXSomkiVqT7iPyYD2eKGMKo30/xw=;
        b=cLlmFi8yXUxdpNFYO9j1k3pf6LcY5szp6ORIdgnfeSPXahU4I0ZIiFSNsveohS9S3h
         SIfXJu2kkfBToraChx/ZWbnJAiAiuUVG/Ld0yddYRy7U83KO+Alrw/f1Z+dEM2LdgeSM
         ga395bIRvxO7wNuR3dCNsSZQMH8/tJY0ex3NiWgPPz5GAVgyVvw8yYoiGa6tZplSrw3d
         JpPlFMz68W0eIoTD9CrLVDhuEawVnb6EX1vKEjkZyOLLj4LTScnHR+coi8cQfWzyAcvs
         /qisLGBaA/CXtdNkAILVfIkHFHSdiQzjkcX2uLP3H65MH2g1UpMypcmWgiBrZgcnImLy
         3FIQ==
X-Gm-Message-State: AElRT7EHRKKVDURIbW45xE9lLGT04sHWiDybGdgtxN+s+BIFNfwEKmxd
        G6+KjHCxEHBZENiPefT95f1jAw==
X-Google-Smtp-Source: AG47ELt0CAehitwlpcwN7su2Ie4QiFzxCGj9oBtBnm+F0Mzo2JTPUz16ziwjuXuKZzTaptCGMtMcXw==
X-Received: by 10.200.7.11 with SMTP id g11mr14020966qth.264.1520608402609;
        Fri, 09 Mar 2018 07:13:22 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:21 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 06/14] mmc: dt-bindings: add MMC support to JZ4740 SoC
Date:   Fri,  9 Mar 2018 12:12:11 -0300
Message-Id: <20180309151219.18723-7-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62883
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

Add the devicetree binding for JZ4740/JZ4780 SoC.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
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
