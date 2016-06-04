Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Jun 2016 23:19:09 +0200 (CEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:35971 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042249AbcFDVS3L5XJ8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Jun 2016 23:18:29 +0200
Received: from localhost.localdomain (85-76-130-131-nat.elisa-mobile.fi [85.76.130.131])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 78D941A2750;
        Sun,  5 Jun 2016 00:18:28 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/3] MIPS: OCTEON: dlink_dsr-1000n.dts: add more leds
Date:   Sun,  5 Jun 2016 00:18:20 +0300
Message-Id: <1465075100-19705-3-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1465075100-19705-1-git-send-email-aaro.koskinen@iki.fi>
References: <1465075100-19705-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Add more leds discovered by reverse engineering. Labels are according
to markings in the mechanics.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts
index a20c5b6..b134798 100644
--- a/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts
+++ b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts
@@ -71,6 +71,21 @@
 			label = "usb2";
 			gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
 		};
+
+		wps {
+			label = "wps";
+			gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		wireless1 {
+			label = "5g";
+			gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+		};
+
+		wireless2 {
+			label = "2.4g";
+			gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
+		};
 	};
 
 	aliases {
-- 
2.7.2
