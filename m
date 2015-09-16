Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Sep 2015 08:44:48 +0200 (CEST)
Received: from lucky1.263xmail.com ([211.157.147.133]:40211 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007621AbbIPGo3tnifJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Sep 2015 08:44:29 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.129])
        by lucky1.263xmail.com (Postfix) with SMTP id 417E24C246;
        Wed, 16 Sep 2015 14:44:26 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id 6BE3212899;
        Wed, 16 Sep 2015 14:44:20 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: jh80.chung@samsung.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <b84b5ec0995f58c433b1eee526805c39>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 2629250NK4F;
        Wed, 16 Sep 2015 14:44:24 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc:     Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de,
        dianders@chromium.org, linux-samsung-soc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v8 03/10] Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
Date:   Wed, 16 Sep 2015 14:41:50 +0800
Message-Id: <1442385710-29778-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shawn.lin@rock-chips.com
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

synopsys-dw-mshc supports three types of transfer mode. We add
bindings and description for how to use them at runtime.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 346c609..8636f5a 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -75,6 +75,12 @@ Optional properties:
 * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
   specified we'll defer probe until we can find this regulator.
 
+* dmas: List of DMA specifiers with the controller specific format as described
+  in the generic DMA client binding. Refer to dma.txt for details.
+
+* dma-names: request names for generic DMA client binding. Must be "rx-tx".
+  Refer to dma.txt for details.
+
 Aliases:
 
 - All the MSHC controller nodes should be represented in the aliases node using
@@ -95,6 +101,23 @@ board specific portions as listed below.
 		#size-cells = <0>;
 	};
 
+[board specific internal DMA resources]
+
+	dwmmc0@12200000 {
+		clock-frequency = <400000000>;
+		clock-freq-min-max = <400000 200000000>;
+		num-slots = <1>;
+		broken-cd;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		vmmc-supply = <&buck8>;
+		bus-width = <8>;
+		cap-mmc-highspeed;
+		cap-sd-highspeed;
+	};
+
+[board specific generic DMA request binding]
+
 	dwmmc0@12200000 {
 		clock-frequency = <400000000>;
 		clock-freq-min-max = <400000 200000000>;
@@ -106,4 +129,6 @@ board specific portions as listed below.
 		bus-width = <8>;
 		cap-mmc-highspeed;
 		cap-sd-highspeed;
+		dmas = <&pdma 12>;
+		dma-names = "rx-tx";
 	};
-- 
2.3.7
