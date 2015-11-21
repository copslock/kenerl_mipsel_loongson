Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 20:04:53 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:57180 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012171AbbKUTEr4MJQI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Nov 2015 20:04:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=RPituaI2h5Xv5Cp9ccvSyAnlDuNYQP4CnKftaNEvbDs=;
        b=GfDIib0KOrrcyOe3SUehYDFwRgMNeI1stSTBmybNFZcd9/6URdytYxyl51WTBhKjk//TX57cy0csLNIV8Ve2gMMUrP5C0FJ0kb8olYFR+fpy4z/6pxnmWb+vraPCyhTTqOX9ZM5nL2QsOGr7FVQ2ao0vzkbb+TuDjWpp18FjAoyR7UpVpdSHv6qme2cutoNesxbAmXcDs+2WV1/0xeTXPOZlXppPxHx2qmZq3nPz5004i61N3sVWwAO2RpZrWvxe3O+TBAlD/FuNaKK1K+SZQhQInXbteASqy+AEQRT9sRXoHnffNOnjcZ2fXoIToa9vzmbuPmqwKqoiNG5UFPlIZg==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:58019 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a0DSi-0006JB-7c (Exim); Sat, 21 Nov 2015 19:04:41 +0000
Subject: [PATCH 3/4] watchdog: Add brcm,bcm6345-wdt device tree binding
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Miguel Gaio <miguel.gaio@efixo.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5650C047.6040303@simon.arlott.org.uk>
Date:   Sat, 21 Nov 2015 19:04:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5650BFD6.5030700@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50029
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
