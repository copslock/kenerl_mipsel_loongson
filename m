Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2018 23:21:27 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:34354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993937AbeGVVU3gX7YS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2018 23:20:29 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3347FAFCA;
        Sun, 22 Jul 2018 21:20:20 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        James Hartley <james.hartley@sondrel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 05/15] MIPS: dts: img: pistachio_marduk: Enable SPIM0
Date:   Sun, 22 Jul 2018 23:20:00 +0200
Message-Id: <20180722212010.3979-6-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <afaerber@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: afaerber@suse.de
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

SPIM0 supplies SPI pins on the mikroBUS and Raspberry Pi B+ connectors.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/mips/boot/dts/img/pistachio_marduk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts b/arch/mips/boot/dts/img/pistachio_marduk.dts
index 5557a6ad61c3..d723b68084c9 100644
--- a/arch/mips/boot/dts/img/pistachio_marduk.dts
+++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
@@ -123,6 +123,14 @@
 	pins = "mfio17", "mfio18", "mfio19", "mfio20";
 };
 
+&pin_spim0 {
+	drive-strength = <2>;
+};
+
+&pin_spim0_clk {
+	drive-strength = <2>;
+};
+
 &pwm {
 	status = "okay";
 
@@ -137,6 +145,21 @@
 	disable-wp;
 };
 
+&spfi0 {
+	status = "okay";
+
+	pinctrl-0 = <&spim0_pins>,
+		    <&spim0_cs0_alt_pin>,
+		    <&spim0_cs2_alt_pin>,
+		    <&spim0_cs3_alt_pin>,
+		    <&spim0_cs4_alt_pin>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>, <0>,
+		   <&gpio1 12 GPIO_ACTIVE_HIGH>,
+		   <&gpio1 13 GPIO_ACTIVE_HIGH>,
+		   <&gpio1 14 GPIO_ACTIVE_HIGH>;
+};
+
 &spfi1 {
 	status = "okay";
 
-- 
2.16.4
