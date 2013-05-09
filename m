Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 May 2013 09:32:18 +0200 (CEST)
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:35134 "EHLO
        grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6816206Ab3EIHcQtyMsq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 May 2013 09:32:16 +0200
Received: from matthijs by grubby.stderr.nl with local (Exim 4.80)
        (envelope-from <matthijs@stdin.nl>)
        id 1UaLKo-0003hH-Da; Thu, 09 May 2013 09:32:14 +0200
From:   Matthijs Kooijman <matthijs@stdin.nl>
To:     blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH] MIPS: ralink: use the dwc2 driver for the rt305x USB controller
Date:   Thu,  9 May 2013 09:32:09 +0200
Message-Id: <1368084729-14183-1-git-send-email-matthijs@stdin.nl>
X-Mailer: git-send-email 1.8.0
Return-Path: <matthijs@stdin.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthijs@stdin.nl
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

This sets up the devicetree file for the rt3050 chip series and rt3052
eval board to use the right compatible string for the dwc2 driver.
---
 arch/mips/ralink/dts/rt3050.dtsi     | 10 ++++++++++
 arch/mips/ralink/dts/rt3052_eval.dts |  4 ++++
 2 files changed, 14 insertions(+)

This is the same patch I sent previously, but now on its own (without
the additional DMA setup patches, which I'm trying to get added to the
dwc2 driver itself).

diff --git a/arch/mips/ralink/dts/rt3050.dtsi b/arch/mips/ralink/dts/rt3050.dtsi
index ef7da1e..e3203d4 100644
--- a/arch/mips/ralink/dts/rt3050.dtsi
+++ b/arch/mips/ralink/dts/rt3050.dtsi
@@ -55,4 +55,14 @@
 			reg-shift = <2>;
 		};
 	};
+
+	usb@101c0000 {
+		compatible = "ralink,rt3050-usb", "snps,dwc2";
+		reg = <0x101c0000 40000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <18>;
+
+		status = "disabled";
+	};
 };
diff --git a/arch/mips/ralink/dts/rt3052_eval.dts b/arch/mips/ralink/dts/rt3052_eval.dts
index df17f5f..77208c1 100644
--- a/arch/mips/ralink/dts/rt3052_eval.dts
+++ b/arch/mips/ralink/dts/rt3052_eval.dts
@@ -43,4 +43,8 @@
 			reg = <0x50000 0x7b0000>;
 		};
 	};
+
+	usb@101c0000 {
+		status = "ok";
+	};
 };
-- 
1.8.0
