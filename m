Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 21:56:53 +0100 (CET)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:49005 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013571AbaKLUywYYbUG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 21:54:52 +0100
Received: by mail-pd0-f180.google.com with SMTP id ft15so12989738pdb.39
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 12:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U6NldCOAZ6FBPKZtLd0lRvYYQZNzc/T057BXaILHlgo=;
        b=cxzj3vniDD79jk9Ytu1ZVSSJZZxJNzqMfFVu5NC8ZWxJvwdv58T5JGXc1nQ3A/C563
         073CMq52fP1GuCuloVoc8nimCZhQysCpmFwjvn3XD4uokN9wTJm/nesATZQ7pR2PjvMd
         gR10eLfTAsqwzrchwTMfv8jhDpErMLwSG0ZT5Zl1Zpq+mb8/dXloqd46OcO15JmVdGPK
         R1cbOU+mE7+O2eTWLDH4XxCRds9g5KXM34qYFccddqedblq8mrLZZFSDoyVsyLTtEXcW
         7RNat2keifsV9ewgCR0AzdYbJj2RoQCKHO6AyHJML91nR5B8xm7aHTBCV4aBKUGatrYU
         8r0w==
X-Received: by 10.66.180.166 with SMTP id dp6mr50253091pac.101.1415825686785;
        Wed, 12 Nov 2014 12:54:46 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id z15sm23050495pdi.6.2014.11.12.12.54.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 12:54:46 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, grant.likely@linaro.org,
        f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V2 08/10] serial: pxa: Update DT binding documentation
Date:   Wed, 12 Nov 2014 12:54:05 -0800
Message-Id: <1415825647-6024-9-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44083
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
