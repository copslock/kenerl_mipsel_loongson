Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:16:58 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:44786
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994808AbeCIPNo5sm-w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:44 +0100
Received: by mail-qt0-x244.google.com with SMTP id g60so10993690qtd.11
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mVFAFmH6u8dRtgpBk1cYCiyosx4m3TzFUUY36eO0oeY=;
        b=M+3a8cIhVtRCkzCKGxYvuZ4m+Ev3426N+tglpAmLA17iwwICP80WE2rKzddQI7ia4b
         yn/ZJ1qYBvXtqb8aqo7uiQs0IYT5iTu36t2/Ont/SKS5U10fxnOgDashojgDSBo1b4Vd
         L6HlPRwpAwCbBjN8oWU0rg3gHsJB6onsX3KZJPwJ/0yzei6y05CdZnRcv5AH+XFTdMa5
         xkiY0IIUk8siFI4CKHsYMaGckjwKSOE/6GxLpoxXnPEe6HkwSKt9gT5pcy8NeXMiJREh
         WEgSeXwPJdAAU4Zg455u7toeVOLieqdBw6MGLYXR4yKqK+uDvOBSWfDDDqmiB8a/TpOx
         u2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mVFAFmH6u8dRtgpBk1cYCiyosx4m3TzFUUY36eO0oeY=;
        b=geG/X0nwLyPfNauoprTlbGRfmOW5I0E3bfcpnmgrjLUYUqjAo6Q5HVWcmnnYJ1eMNN
         9FhF2pAqyw28s+gTOndzn/IePQCYl7DrYrddVJ7Rb56Vwg9U2ryitXzbSv5caWhmqtCb
         3SVDL735KgfqvHihUkCExAPHbgeCtkyQyNVHIVYdJGsCteQmdEWYBY3PbWr5PmUBRXlM
         ZzBhEM+l2vV67s5LTCYXXFETWUcQJeGgHCEozMm+P7bv4EVVp7n4ur0loQPr6whS9YwF
         W+zelaRZT+jGjm6vhvJGwhOZCEuJAKOp8nkpJyidWzdzQhH2rH5K4YLEJQHoujDUX0Jf
         vOcA==
X-Gm-Message-State: AElRT7EbPofiuS6OkNh2jeFBNQl4SvBzXRjJssqfp+4hFS1kNP9g4s3m
        ug5qURhIkl2qNgoGBF9UVfWSKA==
X-Google-Smtp-Source: AG47ELttI6b/HlMjtBIpDHOtIRgWlPOPRNG+aVr2nAUFoB2Rgp7RU9/KC9hUnaUccbIBEqnOIMA6Ag==
X-Received: by 10.200.23.91 with SMTP id u27mr47319843qtk.209.1520608419139;
        Fri, 09 Mar 2018 07:13:39 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:38 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 13/14] MIPS: dts: ci20: Enable DMA and MMC in the devicetree
Date:   Fri,  9 Mar 2018 12:12:18 -0300
Message-Id: <20180309151219.18723-14-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62890
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

Now that we have support for JZ480 SoCs in the MMC driver,
let's enable it on the devicetree.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index a4cc52214dbd..9c5261dbcc4e 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -36,6 +36,32 @@
 	clock-frequency = <48000000>;
 };
 
+&dma {
+	status = "okay";
+};
+
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
 
@@ -203,4 +229,16 @@
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
