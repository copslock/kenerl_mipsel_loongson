Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Apr 2016 14:13:14 +0200 (CEST)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34947 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006506AbcDCMNLa7xSB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Apr 2016 14:13:11 +0200
Received: by mail-lf0-f67.google.com with SMTP id c62so18253963lfc.2
        for <linux-mips@linux-mips.org>; Sun, 03 Apr 2016 05:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWBYpkrgz20/FrB/XyOe5BlbkCKewiTC9ORdNgVySdg=;
        b=owfJut2PtCzoHI+tKs8zassCCSJv+5rFBpJpotDY0XIiYebeL1aYIZPoifK4gcBe0S
         Kq3aO8oHVcb5sm8z3HvK+/1PsmHIWpS2jkOyvU8O3OWubRx4z+l4F83CQnfBJ94i+YG7
         yWdF1SqLOP/X+CBP4eIBpfq9ugZvYgYDCxPPnhRYpPzWZi5QpFMfcLYNkQFq/GhHCJK6
         CGkJln4JJ7vNIG3KrBzrl3r2PMM7rhidgl+5PWIbofKM+omvORXKv3+ZOoXv32n61sQo
         oNw5MHnDpvqh+LcVZTvmqiN2eJboed17dC/MtaYYBKy7dumUnG1HvrnwEAP4aCI4DR6F
         bv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWBYpkrgz20/FrB/XyOe5BlbkCKewiTC9ORdNgVySdg=;
        b=SsO0oirmQ3QfuJJXGyvVxSUYfrYjZYDiAuMdOTLuxd2PTpgOa9+sfE4/OZnA463/fs
         5JNWUeIaIFDuvK2w/Jj77fjGAyS6JkKWRqd3CGLOFdMLj6ALDpm/XVn/3ni/Ciqn+IfO
         QyQ7t8BwT7fL8DqsBhH10ly2tJ8eZC2/erLws1rZPNxLAU4H6o8kkZ1yCvoV6SrUo2iW
         BInBEpx5RR2frjPLK7njzz7AfQYTVo1B6gV8sAijtTOJBTBVTW8AILs5Pg2nC2VQ5hVC
         AcW6xIvtXYSUbId9IdPaio2V9QvaGL3Qmn0B6SHdDN0N48SL7bEw1BWUE4BGsviLychC
         g+oA==
X-Gm-Message-State: AD7BkJIrXGHui1msr+mAMncsPX3tprxzgQpx6a4gLt+0d31RlRtLmpH6DGoyHbgE7p3JFw==
X-Received: by 10.194.6.234 with SMTP id e10mr2241104wja.118.1459685586081;
        Sun, 03 Apr 2016 05:13:06 -0700 (PDT)
Received: from localhost.localdomain (228.red-83-55-41.dynamicip.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id i2sm23547388wje.22.2016.04.03.05.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Apr 2016 05:13:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        jogo@openwrt.org, cernekee@gmail.com, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/3] MIPS: BMIPS: improve BCM6328 device tree
Date:   Sun,  3 Apr 2016 14:13:03 +0200
Message-Id: <1459685585-11747-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

- Remove unneeded leds0 alias.
- Switch to bcm6345-l1-intc interrupt controller.
- Use interrupt-controller instead of periph_intc.
- Add uart1, ehci0 and ohci0 nodes.
- Refactor syscon and syscon-reboot.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm6328.dtsi | 44 +++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm6328.dtsi b/arch/mips/boot/dts/brcm/bcm6328.dtsi
index 9d19236..8efa420 100644
--- a/arch/mips/boot/dts/brcm/bcm6328.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6328.dtsi
@@ -31,8 +31,8 @@
 	};
 
 	aliases {
-		leds0 = &leds0;
 		uart0 = &uart0;
+		uart1 = &uart1;
 	};
 
 	cpu_intc: cpu_intc {
@@ -50,16 +50,16 @@
 		compatible = "simple-bus";
 		ranges;
 
-		periph_intc: periph_intc@10000020 {
-			compatible = "brcm,bcm3380-l2-intc";
-			reg = <0x10000024 0x4 0x1000002c 0x4>,
-			      <0x10000020 0x4 0x10000028 0x4>;
+		periph_intc: interrupt-controller@10000020 {
+			compatible = "brcm,bcm6345-l1-intc";
+			reg = <0x10000020 0x10>,
+			      <0x10000030 0x10>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
 			interrupt-parent = <&cpu_intc>;
-			interrupts = <2>;
+			interrupts = <2>, <3>;
 		};
 
 		uart0: serial@10000100 {
@@ -71,13 +71,22 @@
 			status = "disabled";
 		};
 
-		timer: timer@10000040 {
+		uart1: serial@10000120 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x10000120 0x18>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <39>;
+			clocks = <&periph_clk>;
+			status = "disabled";
+		};
+
+		timer: syscon@10000040 {
 			compatible = "syscon";
 			reg = <0x10000040 0x2c>;
 			native-endian;
 		};
 
-		reboot {
+		reboot: syscon-reboot@10000068 {
 			compatible = "syscon-reboot";
 			regmap = <&timer>;
 			offset = <0x28>;
@@ -91,5 +100,24 @@
 			reg = <0x10000800 0x24>;
 			status = "disabled";
 		};
+
+		ehci0: usb@10002500 {
+			compatible = "brcm,bcm6328-ehci", "generic-ehci";
+			reg = <0x10002500 0x100>;
+			big-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <42>;
+			status = "disabled";
+		};
+
+		ohci0: usb@10002600 {
+			compatible = "brcm,bcm6328-ohci", "generic-ohci";
+			reg = <0x10002600 0x100>;
+			big-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <41>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.1.4
