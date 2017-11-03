Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Nov 2017 18:23:04 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:55677 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991416AbdKCRWvF3BeQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Nov 2017 18:22:51 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 6470C1A4AF2;
        Fri,  3 Nov 2017 18:22:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id C53E91A4AF5;
        Fri,  3 Nov 2017 18:22:44 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Douglas Leung <douglas.leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@mips.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v8 1/5] Documentation: Add device tree binding for Goldfish PIC driver
Date:   Fri,  3 Nov 2017 18:21:34 +0100
Message-Id: <1509729730-26621-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1509729730-26621-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1509729730-26621-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Miodrag Dinic <miodrag.dinic@mips.com>

Add documentation for DT binding of Goldfish PIC driver. The compatible
string used by OS for binding the driver is "google,goldfish-pic".

Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../interrupt-controller/google,goldfish-pic.txt   | 30 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt b/Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
new file mode 100644
index 0000000..35f7527
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
@@ -0,0 +1,30 @@
+Android Goldfish PIC
+
+Android Goldfish programmable interrupt device used by Android
+emulator.
+
+Required properties:
+
+- compatible : should contain "google,goldfish-pic"
+- reg        : <registers mapping>
+- interrupts : <interrupt mapping>
+
+Example for mips when used in cascade mode:
+
+        cpuintc {
+                #interrupt-cells = <0x1>;
+                #address-cells = <0>;
+                interrupt-controller;
+                compatible = "mti,cpu-interrupt-controller";
+        };
+
+        interrupt-controller@1f000000 {
+                compatible = "google,goldfish-pic";
+                reg = <0x1f000000 0x1000>;
+
+                interrupt-controller;
+                #interrupt-cells = <0x1>;
+
+                interrupt-parent = <&cpuintc>;
+                interrupts = <0x2>;
+        };
diff --git a/MAINTAINERS b/MAINTAINERS
index a4cbb59..47f0b95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -872,6 +872,11 @@ S:	Supported
 F:	drivers/android/
 F:	drivers/staging/android/
 
+ANDROID GOLDFISH PIC DRIVER
+M:	Miodrag Dinic <miodrag.dinic@mips.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
+
 ANDROID GOLDFISH RTC DRIVER
 M:	Miodrag Dinic <miodrag.dinic@mips.com>
 S:	Supported
-- 
2.7.4
