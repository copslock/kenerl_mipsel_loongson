Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 00:24:55 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36397 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012094AbaJUWXhBCNbn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 00:23:37 +0200
Received: by mail-pa0-f50.google.com with SMTP id kx10so2354517pab.9
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dLYfOmKMzHgnhZ8mQ4gE5MKGS9z/XR5dHp3eZ8TrwL0=;
        b=jkYIVZYqSy91eH3vuYZMIMdqGKK9dd6k7aBdft/kyxev1pXJFE48S7/KOlEszGfWdG
         B8qHI+G3/e7YCfqGAmbuGwDVekkB4s5gi4TnsDjhdjyq1aTSJLdtT3vVN+qjDC6UCMFi
         nCfkWdyourOcEii8LVPAtRfEShqDyzd8tYOlkmEGWSNKW8BiHxMXVC/OlLFjeB7Z/9AB
         uZbvb5ZRQnCybN2Itko6OYm2hkr+6V0fzo5HdF7zSwrFR43YSRkMsmH606Sm/IipNPaL
         3Aa5im00ziaFfsJyQsU3R9kE9sGDEXG+K+iVZtuom8IkpvESWVyrBoPW5nFPW2ERofH1
         MGgA==
X-Received: by 10.68.130.134 with SMTP id oe6mr37615087pbb.3.1413930211070;
        Tue, 21 Oct 2014 15:23:31 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id al4sm12702816pbc.19.2014.10.21.15.23.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 15:23:30 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz
Cc:     robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de,
        geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V3 05/10] Documentation: DT: Add entries for bcm63xx UART
Date:   Tue, 21 Oct 2014 15:23:01 -0700
Message-Id: <1413930186-23168-6-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43441
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

This squashes a checkpatch warning on my new bcm3384 dts submission.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../devicetree/bindings/serial/bcm63xx-uart.txt    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
new file mode 100644
index 0000000..5c52e5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
@@ -0,0 +1,30 @@
+* BCM63xx UART
+
+Required properties:
+
+- compatible: "brcm,bcm6345-uart"
+
+- reg: The base address of the UART register bank.
+
+- interrupts: A single interrupt specifier.
+
+- clocks: Clock driving the hardware; used to figure out the baud rate
+  divisor.
+
+Example:
+
+	uart0: serial@14e00520 {
+		compatible = "brcm,bcm6345-uart";
+		reg = <0x14e00520 0x18>;
+		interrupt-parent = <&periph_intc>;
+		interrupts = <2>;
+		clocks = <&periph_clk>;
+	};
+
+	clocks {
+		periph_clk: periph_clk@0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <54000000>;
+		};
+	};
-- 
2.1.1
