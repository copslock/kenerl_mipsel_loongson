Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 10:21:34 +0200 (CEST)
Received: from regular1.263xmail.com ([211.150.99.134]:41968 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011802AbbHEIVdAvfK1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 10:21:33 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.12])
        by regular1.263xmail.com (Postfix) with SMTP id EB42C7076;
        Wed,  5 Aug 2015 16:21:22 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id 8451E414;
        Wed,  5 Aug 2015 16:21:10 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: ulf.hansson@linaro.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <da5c8e938799189e3c0e1e014ec0fade>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 32614PX8KXA;
        Wed, 05 Aug 2015 16:21:20 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Seungwon Jeon <tgih.jun@samsung.com>
Cc:     dianders@chromium.org, linux-mips@linux-mips.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Stefan Agner <stefan@agner.ch>,
        Zhou Wang <wangzhou.bry@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Wang Long <long.wanglong@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jun Nie <jun.nie@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hao <haokexin@gmail.com>,
        Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broadcom.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-samsung-soc@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vineet Gupta <vgupta@synopsys.com>,
        Scott Branden <sbranden@broadcom.com>,
        Anand Moon <linux.amoon@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Tushar Behera <trblinux@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mischa Jonker <mjonker@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Stephen Warren <swarren@nvidia.com>,
        devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>,
        Joachim Eastwood <manabian@gmail.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        addy ke <addy.ke@rock-chips.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Jean Delvare <jdelvare@suse.de>,
        Kevin Hilman <khilman@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Andreas Faerber <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v3 2/5] Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
Date:   Wed,  5 Aug 2015 16:17:52 +0800
Message-Id: <1438762672-22243-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48579
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

synopsys-dw-mshc supports three types of transfer mode. We add bindings
and description for how to use them at runtime. Without idmac and edmac
property, pio is the default transfer mode. Make sure that Idmac and emdac
should not be used simultaneously.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 346c609..30369cb 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -75,6 +75,25 @@ Optional properties:
 * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
   specified we'll defer probe until we can find this regulator.
 
+* supports-idmac: Enables support for internal DMAC block within the Synopsys
+  Designware Mobile Storage IP block. If supports-idmac property is present, then
+  we MUST NOT add supports-edmac property since we'd assume that dw-mshc IP is
+  integrated with only one type of dma master.
+
+* supports-edmac: Enables support for external DMAC block outside the Synopsys
+  Designware Mobile Storage IP block. If supports-edmac property is present, then
+  we MUST NOT add supports-idmac property since we'd assume that dw-mshc IP is
+  integrated with only one type of dma master.
+
+  (Without "supports-idmac" and "supports-edmac", use PIO as default transfer mode)
+
+* dmas: List of DMA specifiers with the controller specific format as described
+  in the generic DMA client binding. This property should be combined with
+  supports-edmac. Refer to dma.txt for details.
+
+* dma-names: DMA request names. Must be "rx-tx". And This property should be
+  combined with supports-edmac. Refer to dma.txt for details.
+
 Aliases:
 
 - All the MSHC controller nodes should be represented in the aliases node using
@@ -95,6 +114,8 @@ board specific portions as listed below.
 		#size-cells = <0>;
 	};
 
+[board specific internal DMA resources]
+
 	dwmmc0@12200000 {
 		clock-frequency = <400000000>;
 		clock-freq-min-max = <400000 200000000>;
@@ -106,4 +127,24 @@ board specific portions as listed below.
 		bus-width = <8>;
 		cap-mmc-highspeed;
 		cap-sd-highspeed;
+		supports-idmac;
 	};
+
+[board specific generic DMA request binding]
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
+		supports-edmac;
+		dmas = <&pdma 12>;
+		dma-names = "rx-tx";
+	};
+
-- 
2.3.7
