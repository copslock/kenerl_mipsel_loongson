Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Apr 2016 12:58:11 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35479 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026062AbcDIK5zea-Yn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Apr 2016 12:57:55 +0200
Received: by mail-wm0-f65.google.com with SMTP id a140so9827659wma.2;
        Sat, 09 Apr 2016 03:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VeFxT/APz27aCK4V7VD1lhox3EttEHl8kOQP5UMwaH4=;
        b=p9WlC0jAkMCT4DZGNsG9TmSjQ6tlcGe0hC7NahYuuFPY6cztTLWG/Uq5EBagd4bATz
         UEtREXwPCw2PVYNKnbbOejEWiKcfZaUEr5jDvwymhFCXJfQZzB6i0dFgxNnQ2oPivgUV
         pjxjWqTrU1W/LBGNGgO1iM46tePziokesUesEQxDFMe+31w7PdBbjTnOBrjA0lyaIYJy
         SKBnHikD1xZJ0JLPc5SpIk+pgCFJsMNC23l5Xi8cE9JOLyulbsy3kYq8+nGALQTvwBuq
         cFTCxUqS0K4m6pFE4tFcrWnh3+MnBzOjHRrJPUm0ueWV2lw/GXtPRScdfTrIRdzJ0a7d
         biSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeFxT/APz27aCK4V7VD1lhox3EttEHl8kOQP5UMwaH4=;
        b=P67i+rYsC0meGBij6GzF7SX2y4uiUpsy5FwJuvYvZT9Zudyf8lkxNhCH5EFEBsHpIT
         6/BxoG5kKiWbES7JaRVTd6Yz8lWI+zj8/zk1RsKy+B2ZgvY4y/Gulsx+pog0XBqe9jOQ
         eIzOXYudGcUz1Ck8nCzZ+5naOMgfhfl3UUgQ9KsP45mdL4e2D2o+oHH8mdr7oUuNsns+
         K5+/gL870DM3H5cVvMy5OMz7xtXR5wIB+i6oYkKEaQHKAXZHcS+3PTjy1hfYLIg17cM9
         fI0fqbuDWZNzcfzeKN6dZIWjYLYIkAIXrO6LiNYhzqy66S0tpzVxHVqLx9Z1OkezzoAw
         eFUA==
X-Gm-Message-State: AD7BkJK0fItRXDrhbkItZdG9aesLjMkPzQUaDwUtvplj0cKAu1eXYGGmVhIiGF6m+EwxfQ==
X-Received: by 10.194.95.198 with SMTP id dm6mr15112548wjb.136.1460199470287;
        Sat, 09 Apr 2016 03:57:50 -0700 (PDT)
Received: from localhost.localdomain (228.Red-83-55-41.dynamicIP.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id m134sm7233980wmd.14.2016.04.09.03.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 03:57:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/2] MIPS: BMIPS: improve BCM6368 device tree
Date:   Sat,  9 Apr 2016 12:57:49 +0200
Message-Id: <1460199469-18880-2-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1460199469-18880-1-git-send-email-noltari@gmail.com>
References: <1459685585-11747-1-git-send-email-noltari@gmail.com>
 <1460199469-18880-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52943
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
- Use interrupt-controller instead of periph_intc and cpu_intc.
- Add uart1 node.
- Single ohci and ehci nodes.
- Avoid using underscores in node names.
- Rename uart aliases to serial.
- Remove blank line in cpus node.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v2: more device tree improvements
  - There is just ohci/ehci node.
  - Avoid using underscores in node names.
  - Use interrupt-controller for cpu_intc.
  - Rename uart aliases to serial.
  - Remove blank line.

 arch/mips/boot/dts/brcm/bcm6368.dtsi | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm6368.dtsi b/arch/mips/boot/dts/brcm/bcm6368.dtsi
index 1f6b9b5..d0e3a70 100644
--- a/arch/mips/boot/dts/brcm/bcm6368.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6368.dtsi
@@ -20,11 +20,10 @@
 			device_type = "cpu";
 			reg = <1>;
 		};
-
 	};
 
 	clocks {
-		periph_clk: periph_clk {
+		periph_clk: periph-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <50000000>;
@@ -32,11 +31,11 @@
 	};
 
 	aliases {
-		leds0 = &leds0;
-		uart0 = &uart0;
+		serial0 = &uart0;
+		serial1 = &uart1;
 	};
 
-	cpu_intc: cpu_intc {
+	cpu_intc: interrupt-controller {
 		#address-cells = <0>;
 		compatible = "mti,cpu-interrupt-controller";
 
@@ -64,16 +63,16 @@
 			mask = <0x1>;
 		};
 
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
 
 		leds0: led-controller@100000d0 {
@@ -93,7 +92,16 @@
 			status = "disabled";
 		};
 
-		ehci0: usb@10001500 {
+		uart1: serial@10000120 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x10000120 0x18>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <3>;
+			clocks = <&periph_clk>;
+			status = "disabled";
+		};
+
+		ehci: usb@10001500 {
 			compatible = "brcm,bcm6368-ehci", "generic-ehci";
 			reg = <0x10001500 0x100>;
 			big-endian;
@@ -102,7 +110,7 @@
 			status = "disabled";
 		};
 
-		ohci0: usb@10001600 {
+		ohci: usb@10001600 {
 			compatible = "brcm,bcm6368-ohci", "generic-ohci";
 			reg = <0x10001600 0x100>;
 			big-endian;
-- 
2.1.4
