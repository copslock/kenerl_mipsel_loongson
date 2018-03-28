Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 23:05:43 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3]:44088
        "EHLO bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994641AbeC1VCnX7mmC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 23:02:43 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 7D2A7275F5A
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v4 13/15] MIPS: dts: ci20: Enable MMC in the devicetree
Date:   Wed, 28 Mar 2018 18:00:55 -0300
Message-Id: <20180328210057.31148-14-ezequiel@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328210057.31148-1-ezequiel@collabora.com>
References: <20180328210057.31148-1-ezequiel@collabora.com>
Return-Path: <ezequiel@collabora.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@collabora.com
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
