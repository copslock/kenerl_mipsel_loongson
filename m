Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Apr 2016 14:13:51 +0200 (CEST)
Received: from mail-lb0-f193.google.com ([209.85.217.193]:36196 "EHLO
        mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014434AbcDCMNNmyt0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Apr 2016 14:13:13 +0200
Received: by mail-lb0-f193.google.com with SMTP id q4so16799885lbq.3
        for <linux-mips@linux-mips.org>; Sun, 03 Apr 2016 05:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcDrx3C91VqhCuEgnc+DnIX6jQ0KnKQVa2L88JpWQ+Y=;
        b=BvGYjpZ2TtaurMjJEa68m1+DF51vF+Bvqz1Fyf9Ih0ipXqL/2+MLcQiPWJtSIZ86WA
         sWrj8AHYsf+PxmpcCGTj8BDnv/MC8ohjg7ipJdF96rXYcwwhL7j2a48tGqiFAOfKzDLw
         RcU68rgZ3Wtcx98zA4NuuVyMkKDOUHLHSXyr69Vec5bUK6bzsjf4tWhEuBsdaB9OB7ht
         BZAgy2LwHtAtubHqPPzVPq/S48TnAouniz+M9m1cYLUT6h8wo/X3mmdQR5VYCTb4L1NX
         zjaEDvR9uKotian9C+Q6y3r5JGi9wkA+AiEPnsfqYmX/PK6TTaKPNn6T+dCf/7JwH+vn
         RbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcDrx3C91VqhCuEgnc+DnIX6jQ0KnKQVa2L88JpWQ+Y=;
        b=OPX0IIdb1Oos+doh7UADbc0oXuQfds4RJYTWmBXabGEVBvLlHLm7W9aoL8u34YXEv7
         P7+Eyc6zIws2xaLR1fZKBHZEWN6CY3qtihwoueURXdBLtBk98/LKHMKABOzPrCm6g0eQ
         uBWC39/umQdzb3wS1PPjAfrbRX9+mvaKzsTWgKLuhnUB5uGuqiH2/Vb+fZmD72fsn3ju
         r9xcasl/LWfB3zsx9cNBNXYmG0RoeMFBwilyk7XzCgdfDAak5v0WveJnCX0WA/cuF9/l
         I063uTHZQ/tmn6lohbSkodqCrpuzLKO/yVIr33bzrzjkO5gxeM3CenOj3fh0MX/TwK2C
         8Xhw==
X-Gm-Message-State: AD7BkJKmukvNMTN4RWVmw9XkdzeH05CXqGPPhi76ARNRDh9+UYJvOgzQCwha3/2MMtNlhw==
X-Received: by 10.28.107.9 with SMTP id g9mr7307324wmc.34.1459685588378;
        Sun, 03 Apr 2016 05:13:08 -0700 (PDT)
Received: from localhost.localdomain (228.red-83-55-41.dynamicip.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id i2sm23547388wje.22.2016.04.03.05.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Apr 2016 05:13:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        jogo@openwrt.org, cernekee@gmail.com, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 3/3] MIPS: BMIPS: improve BCM6368 device tree
Date:   Sun,  3 Apr 2016 14:13:05 +0200
Message-Id: <1459685585-11747-3-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459685585-11747-1-git-send-email-noltari@gmail.com>
References: <1459685585-11747-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52844
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
- Add uart1 node.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm6368.dtsi | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm6368.dtsi b/arch/mips/boot/dts/brcm/bcm6368.dtsi
index 1f6b9b5..75aba97 100644
--- a/arch/mips/boot/dts/brcm/bcm6368.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6368.dtsi
@@ -32,8 +32,8 @@
 	};
 
 	aliases {
-		leds0 = &leds0;
 		uart0 = &uart0;
+		uart1 = &uart1;
 	};
 
 	cpu_intc: cpu_intc {
@@ -64,16 +64,16 @@
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
@@ -93,6 +93,15 @@
 			status = "disabled";
 		};
 
+		uart1: serial@10000120 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x10000120 0x18>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <3>;
+			clocks = <&periph_clk>;
+			status = "disabled";
+		};
+
 		ehci0: usb@10001500 {
 			compatible = "brcm,bcm6368-ehci", "generic-ehci";
 			reg = <0x10001500 0x100>;
-- 
2.1.4
