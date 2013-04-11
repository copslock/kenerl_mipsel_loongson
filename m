Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Apr 2013 19:25:19 +0200 (CEST)
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:55576 "EHLO
        grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6823046Ab3DKRY67PgWs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Apr 2013 19:24:58 +0200
Received: from matthijs by grubby.stderr.nl with local (Exim 4.80)
        (envelope-from <matthijs@stdin.nl>)
        id 1UQLEx-0001p8-Lt; Thu, 11 Apr 2013 19:24:51 +0200
From:   Matthijs Kooijman <matthijs@stdin.nl>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH 1/2] MIPS: ralink: use the dwc2 driver for the rt305x USB controller
Date:   Thu, 11 Apr 2013 19:24:49 +0200
Message-Id: <1365701090-6916-1-git-send-email-matthijs@stdin.nl>
X-Mailer: git-send-email 1.8.0
Return-Path: <matthijs@stdin.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36079
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

---
 arch/mips/ralink/dts/rt3050.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

The platform bindings needed for this have been submitted to linux-usb:
http://thread.gmane.org/gmane.linux.usb.general/85088

diff --git a/arch/mips/ralink/dts/rt3050.dtsi b/arch/mips/ralink/dts/rt3050.dtsi
index 5aede8d..2b7ab42 100644
--- a/arch/mips/ralink/dts/rt3050.dtsi
+++ b/arch/mips/ralink/dts/rt3050.dtsi
@@ -161,7 +161,7 @@
 	};
 
 	otg@101c0000 {
-		compatible = "ralink,rt3050-otg";
+		compatible = "ralink,rt3050-otg", "snps,dwc2";
 		reg = <0x101c0000 40000>;
 
 		interrupt-parent = <&intc>;
-- 
1.8.0
