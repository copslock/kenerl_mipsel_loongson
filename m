Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 08:48:47 +0200 (CEST)
Received: from lucky1.263xmail.com ([211.157.147.132]:40550 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011153AbbHFGscvl3pk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 08:48:32 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.130])
        by lucky1.263xmail.com (Postfix) with SMTP id 1BFB85668F;
        Thu,  6 Aug 2015 14:48:29 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id 2D25441D;
        Thu,  6 Aug 2015 14:48:24 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: jh80.chung@samsung.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <103107554a2d8e53b25e21b1cc7bb835>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 9150GDDS0I;
        Thu, 06 Aug 2015 14:48:27 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc:     heiko@sntech.de, dianders@chromium.org, Vineet.Gupta1@synopsys.com,
        Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v4 2/9] Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
Date:   Thu,  6 Aug 2015 14:45:02 +0800
Message-Id: <1438843502-23894-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48653
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
