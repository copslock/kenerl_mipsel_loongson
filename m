Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:01:13 +0100 (CET)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:46558
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990427AbeCLV7eiiMjf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:34 +0100
Received: by mail-qk0-x241.google.com with SMTP id o184so8161727qkd.13
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IhjcbqkojenTAvZNASGSZqJQ+CUpKpbQGq5cfUagBLY=;
        b=HoYQPitZPY7GtsL3g/r4UfjBiVbid0SEcqvT/9LoZub/Tjd05R4eGHg8nrGxhwaa//
         b7jPENIVEVFX94vKz1q9m6ozGBlZ5XgEDXAwBNNC7BLS6vJ2qSbfxUX5LGB/PkU1OHoj
         9Xqajo2HX5pSEDqhgA+VvKpTZjrxRWiRQO3rNzsucQtdSe5lMJqs9XcHJZAQtGWMOSVi
         M/3hDdUNoATi1I/izg4zyt5vt73UMn9DPvkr/R/vFwjT5BtTP8qHMFOOa00AZGH8w8Gt
         K7TxYtuVZD7Z3XJ3HnwqyrNq9PL2Wgw5LPTRRjQS58jlD1sZ4sK/nCXW0WlHFlf6Vyqd
         o7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IhjcbqkojenTAvZNASGSZqJQ+CUpKpbQGq5cfUagBLY=;
        b=ajG2eF1LooFtmpdNc6bsLwFkTLwN6Bzs02rBxXnG99PsbvjMNSkM0LWEoAr0sb7YRJ
         zDEhpspit6v2ClzVRifPjib/D7QkyrB8e59yoDmxW8qhloScpR9ge60U3lGCRcMG1Zwf
         Pp01Nx6x7UPfeuZCA2wKnQLemu5kYsDpIeHGfdKWBI+uf0+IVRQ9yhMyC7aecrirK4e+
         PdHic2MlNc1I2v9osaSbevsvMPy5TfENmxeqsy6o8ZGla9YmkvAmbh4tzc9cFv8S0jDs
         YV9LvKE8L8gNoyN0MxCdKO08gem9ovYlALPj6I9oM2ddE4KE3Nxq/OrArz/Yo3OT+Mon
         PYuA==
X-Gm-Message-State: AElRT7GBDFDXoTc1fCZ0xfLfG1BT8ttOwnoIjZ1Gy2iJ5IuRxGGA/MDs
        k1MpRkIE/FAJvgpiT5gs4b8R4Q==
X-Google-Smtp-Source: AG47ELvLrWoN0tqcu06pJVEh7zWhU8fRi8tkGC5LuSK4lPCUtde2PIgs4EkgrUVoZwP0rbBlC2ffug==
X-Received: by 10.55.99.208 with SMTP id x199mr13969176qkb.142.1520891968823;
        Mon, 12 Mar 2018 14:59:28 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:27 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 07/14] mmc: dt-bindings: add MMC support to JZ4740 SoC
Date:   Mon, 12 Mar 2018 18:55:47 -0300
Message-Id: <20180312215554.20770-8-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62938
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

Add the devicetree binding for JZ4740/JZ4780 SoC.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
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
