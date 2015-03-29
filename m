Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2015 23:05:11 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:38529 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009986AbbC2VFKAuM6G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Mar 2015 23:05:10 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 23AE319BDB2;
        Mon, 30 Mar 2015 00:05:10 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id 4nST23lmLkuA; Mon, 30 Mar 2015 00:05:05 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 30B165BC004;
        Mon, 30 Mar 2015 00:05:05 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: OCTEON: add GPIO LED support for DSR-1000N
Date:   Mon, 30 Mar 2015 00:04:56 +0300
Message-Id: <1427663096-29592-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46592
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

DSR-1000N board has two GPIO LEDs next to USB ports. Add support for them.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/boot/dts/octeon_3xxx.dts        | 12 ++++++++++++
 arch/mips/cavium-octeon/octeon-platform.c |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/mips/boot/dts/octeon_3xxx.dts b/arch/mips/boot/dts/octeon_3xxx.dts
index fa33115..9c48e05 100644
--- a/arch/mips/boot/dts/octeon_3xxx.dts
+++ b/arch/mips/boot/dts/octeon_3xxx.dts
@@ -587,4 +587,16 @@
 		usbn = &usbn;
 		led0 = &led0;
 	};
+
+	dsr1000n-leds {
+		compatible = "gpio-leds";
+		usb1 {
+			label = "usb1";
+			gpios = <&gpio 9 1>; /* Active low */
+		};
+		usb2 {
+			label = "usb2";
+			gpios = <&gpio 10 1>; /* Active low */
+		};
+	};
  };
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 12410a2..e1d56f3 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -958,6 +958,13 @@ end_led:
 		}
 	}
 
+	if (octeon_bootinfo->board_type != CVMX_BOARD_TYPE_CUST_DSR1000N) {
+		int dsr1000n_leds = fdt_path_offset(initial_boot_params,
+						    "/dsr1000n-leds");
+		if (dsr1000n_leds >= 0)
+			fdt_nop_node(initial_boot_params, dsr1000n_leds);
+	}
+
 	return 0;
 }
 
-- 
2.2.0
