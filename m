Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2018 23:20:55 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:34154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993885AbeGVVUYXQo2S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2018 23:20:24 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D23ECAFBB;
        Sun, 22 Jul 2018 21:20:18 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        James Hartley <james.hartley@sondrel.com>,
        Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 02/15] MIPS: dts: img: pistachio_marduk: Cleanups
Date:   Sun, 22 Jul 2018 23:19:57 +0200
Message-Id: <20180722212010.3979-3-afaerber@suse.de>
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
X-archive-position: 65034
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

Add and remove some white lines for consistency.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/mips/boot/dts/img/pistachio_marduk.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts b/arch/mips/boot/dts/img/pistachio_marduk.dts
index f03f4114e645..29358d1f7027 100644
--- a/arch/mips/boot/dts/img/pistachio_marduk.dts
+++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
@@ -51,6 +51,7 @@
 
 	leds {
 		compatible = "pwm-leds";
+
 		heartbeat {
 			label = "marduk:red:heartbeat";
 			pwms = <&pwm 3 300000>;
@@ -61,11 +62,13 @@
 
 	keys {
 		compatible = "gpio-keys";
+
 		button@1 {
 			label = "Button 1";
 			linux,code = <0x101>; /* BTN_1 */
 			gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
 		};
+
 		button@2 {
 			label = "Button 2";
 			linux,code = <0x102>; /* BTN_2 */
@@ -92,7 +95,6 @@
 		compatible = "infineon,slb9645tt";
 		reg = <0x20>;
 	};
-
 };
 
 &i2c3 {
-- 
2.16.4
