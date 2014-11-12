Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 09:48:51 +0100 (CET)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:59429 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013487AbaKLIrUdsXKm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 09:47:20 +0100
Received: by mail-pa0-f44.google.com with SMTP id bj1so12505216pad.17
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 00:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U6NldCOAZ6FBPKZtLd0lRvYYQZNzc/T057BXaILHlgo=;
        b=c5Dj4W3QeC8ZruP49CNDkyfBby8Og+XidifVJrXY2YMYwilSAeWNp6CezUfrTmbpMY
         RAk9IBf4QayRtAYtzaTJF3GcLJ9mWvCvjkV7VBqLXKIMY0tpHyZ1fA4JT7RBu6mOIdUN
         LaDz9McfVi9Pyay90SG0+HOEs4jW9WFKhM92Pr3J1YOZ9arWslzfLlH4u3C4+m4IhCE0
         gcJLysgyI1MTsuNO4TDq8x3MowcuaoE6RXuFwXoOk4r2DmKaJYQyc1akywAiwRcOuXPa
         KENzxW8hYMEnk2UIdLy5G0aTOxRyTcUhEsNUJgQFDNhiQpyYZHGkg8ZaMVmwJS8Qp8UE
         nsqQ==
X-Received: by 10.69.1.34 with SMTP id bd2mr45697146pbd.67.1415782034921;
        Wed, 12 Nov 2014 00:47:14 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id p10sm18804833pds.63.2014.11.12.00.47.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 00:47:14 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH/RFC 6/8] serial: pxa: Update DT binding documentation
Date:   Wed, 12 Nov 2014 00:46:31 -0800
Message-Id: <1415781993-7755-7-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Add a couple of missing required properties; add the new optional
properties and an example.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../devicetree/bindings/serial/mrvl-serial.txt     | 34 +++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/mrvl-serial.txt b/Documentation/devicetree/bindings/serial/mrvl-serial.txt
index d744340..5bab455 100644
--- a/Documentation/devicetree/bindings/serial/mrvl-serial.txt
+++ b/Documentation/devicetree/bindings/serial/mrvl-serial.txt
@@ -1,4 +1,36 @@
 PXA UART controller
 
 Required properties:
-- compatible : should be "mrvl,mmp-uart" or "mrvl,pxa-uart".
+- compatible : should be "mrvl,mmp-uart", "mrvl,pxa-uart", or
+  "brcm,bcm7401-uart".
+- interrupts : a single interrupt specifier.
+- clocks : phandle to a clock; used to compute the baud divisor.
+
+Optional properties:
+- fifo-size : defaults to 64 bytes.
+- big-endian : always use BE register accesses.
+- native-endian : use BE register accesses if the kernel was built for BE,
+  otherwise use LE register accesses.
+
+Example:
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		uart_clk: uart_clk@0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <81000000>;
+		};
+	};
+
+	uart0: serial@10406900 {
+		compatible = "brcm,bcm7401-upg-uart";
+		reg = <0x10406900 0x20>;
+		native-endian;
+		fifo-size = <32>;
+		interrupt-parent = <&periph_intc>;
+		interrupts = <64>;
+		clocks = <&uart_clk>;
+	};
-- 
2.1.1
