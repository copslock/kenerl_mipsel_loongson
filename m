Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:02:43 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:37339
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbeCLV7vdOz9f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:51 +0100
Received: by mail-qt0-x243.google.com with SMTP id a23so9238863qtm.4
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N/vYHgpyAcmfbiYWIad+N8nRx/97zBdHPHIr2FMh0LU=;
        b=zzyLAXEClkL3BwWBekQ/1nJza62ZMPilkCB1bf7Y3Z+giQ3r3LYiEWMIfKDFrKfX8u
         GrzQbG87NYpH6uU5v5nL6daett+UAizWkTHXN6PTIvv7cA4HW0yUlWYklS0jEfHqMf/q
         eLoIB6I2vfCTSt8MUG368Ey47Cnh2Bg9bczGlOHJbaNhuoWvnBPvLZGzYdrIvbh9120o
         +WffxXymlpMpw8ag7UDgDfdqJxYsYrBItE1ho/e6L5n6CGyCYfbhnl0QqC7kN9hSGP8M
         878OtVMTFAg5zngGAMj5sd4oc5lSX0Y3K8OwVrIY3TaC8ZJ3UmL1+dflvZcOoMeXQgX0
         KSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N/vYHgpyAcmfbiYWIad+N8nRx/97zBdHPHIr2FMh0LU=;
        b=SZmHTQus3haOA6GURnNs8i4lc8yU/0fVR6vttj4JjX0bF87rIuRod6DDCU+nGPJGDB
         eqJjyZJjA62uB7Y4Vz+3dIMT3PUjHL9p/NzOnvPgt3XrraMDSno4tX04h4Ie53LBwqlY
         mjz/kVDXAQCMOyZaTaNbOxbmfTQjevmE+ZUqER4/x+LaWCyVXcENlD1bRi3aOBs8ItdC
         E47cQcKVdSME5TIQthuUmTRmEN8cskBFGQYgqsJ8mOEDGYq2haY83MOavVPgNWSivY78
         hGoau7h+T34sV+QaOPQurxCr0+Jyt2/3IaaVx1oey7mWkBTbGkag8eb0gsX0lO6WrYpU
         tQ1A==
X-Gm-Message-State: AElRT7Hyur+/mvuG0cvKqiruDB/BQ14kDGjB/hmu590zwuH4cYUxmvk8
        0aaEzKxMwQH16JDwE2DlxRfBOw==
X-Google-Smtp-Source: AG47ELv/mp0FpTj3CIDNHIyWFbOr5a/BlWtELOExByJbom1l3dr4ABESJ0600mdlVuh50Zq9R2RrDw==
X-Received: by 10.200.45.200 with SMTP id q8mr1427875qta.215.1520891985730;
        Mon, 12 Mar 2018 14:59:45 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:45 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v2 13/14] MIPS: dts: ci20: Enable MMC in the devicetree
Date:   Mon, 12 Mar 2018 18:55:53 -0300
Message-Id: <20180312215554.20770-14-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62944
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

Now that we have support for JZ480 SoCs in the MMC driver,
let's enable it on the devicetree.

Acked-by: James Hogan <jhogan@kernel.org>
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index a4cc52214dbd..0ab5f59a56dc 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -36,6 +36,28 @@
 	clock-frequency = <48000000>;
 };
 
+&mmc0 {
+	status = "okay";
+
+	bus-width = <4>;
+	max-frequency = <50000000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_mmc0>;
+
+	cd-gpios = <&gpf 20 GPIO_ACTIVE_LOW>;
+};
+
+&mmc1 {
+	status = "okay";
+
+	bus-width = <4>;
+	max-frequency = <50000000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_mmc1>;
+};
+
 &uart0 {
 	status = "okay";
 
@@ -203,4 +225,16 @@
 		groups = "nemc-cs6";
 		bias-disable;
 	};
+
+	pins_mmc0: mmc0 {
+		function = "mmc0";
+		groups = "mmc0-1bit-e", "mmc0-4bit-e";
+		bias-disable;
+	};
+
+	pins_mmc1: mmc1 {
+		function = "mmc1";
+		groups = "mmc1-1bit-d", "mmc1-4bit-d";
+		bias-disable;
+	};
 };
-- 
2.16.2
