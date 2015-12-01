Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2015 14:04:03 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:53864 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008078AbbLANEAoWA4d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2015 14:04:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=idrgyEkjywdjr+iPhwmfMV/jN9cQEJN6bZa/FwL9VHY=;
        b=MJIa8HxCUF5KMFklsFMRwGLqhovOQm5fMvPGOV7pgCG9hr9eQOYMi4iubpIsqBkAf3sAM/PMdGoc1EGY4/s4GcWN420eufnFxoGNJOn1+IS0FtHS4GQ5hQS4oNVTTKXBkOeDFms04U64HdcCu48jS0jes74Ui1PXkhLTm7g0qJeQrYbKxXOlTBouVbCsT245D/J51YvBVH12pxnrDKSkdxtzW3UUKQ3gG9pIvlr9t9qqP+GdM8YiMigVp6RX7Kcz+ZkLzIJatLyxEIwirhDUXP0IaDkDCKcLlXXUMFHtINaqTAfwbVOCtjzmcGpQeoENrCMtrrfhHQXlrYViAYZoSA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:45580 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a3kay-0007du-8C (Exim); Tue, 01 Dec 2015 13:03:49 +0000
Subject: [PATCH 03/11] watchdog: Add brcm,bcm6345-wdt device tree binding
To:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <565D9A40.60409@simon.arlott.org.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <565D9AB3.2060504@simon.arlott.org.uk>
Date:   Tue, 1 Dec 2015 13:03:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <565D9A40.60409@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

Add device tree binding for the BCM6345 watchdog.

This uses the BCM6345 timer for its warning interrupt.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/watchdog/brcm,bcm6345-wdt.txt         | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm6345-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm6345-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm6345-wdt.txt
new file mode 100644
index 0000000..9d852d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm6345-wdt.txt
@@ -0,0 +1,35 @@
+BCM6345 Watchdog timer
+
+Required properties:
+
+- compatible: should be "brcm,bcm63<soc>-wdt", "brcm,bcm6345-wdt"
+- reg: Specifies base physical address and size of the registers.
+- clocks: Specify the clock used for timing
+
+Optional properties:
+
+- interrupt-parent: phandle to the interrupt controller
+- interrupts: Specify the interrupt used for the watchdog timout warning
+- timeout-sec: Contains the default watchdog timeout in seconds
+
+Example:
+
+watchdog {
+	compatible = "brcm,bcm63168-wdt", "brcm,bcm6345-wdt";
+	reg = <0x1000009c 0x0c>;
+	clocks = <&periph_clk>;
+
+	interrupt-parent = <&timer>;
+	interrupts = <3>;
+	timeout-sec = <30>;
+};
+
+watchdog {
+	compatible = "brcm,bcm6318-wdt", "brcm,bcm6345-wdt";
+	reg = <0x10000068 0x0c>;
+	clocks = <&periph_clk>;
+
+	interrupt-parent = <&timer>;
+	interrupts = <3>;
+	timeout-sec = <30>;
+};
-- 
2.1.4


-- 
Simon Arlott
