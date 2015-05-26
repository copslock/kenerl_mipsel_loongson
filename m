Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 20:45:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31216 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007270AbbEZSpt0jFy8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2015 20:45:49 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A9FC9137E3E55;
        Tue, 26 May 2015 19:45:42 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 26 May
 2015 19:44:42 +0100
Received: from laptop.hh.imgtec.org (10.100.200.175) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 26 May
 2015 19:44:41 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        <Govindraj.Raja@imgtec.com>, <Damien.Horsley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v2 5/7] clocksource: Add Pistachio SoC general purpose timer binding document
Date:   Tue, 26 May 2015 15:41:11 -0300
Message-ID: <1432665671-16102-1-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1432665548-16024-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432665548-16024-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.175]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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

Add a device-tree binding document for the clocksource driver provided
by Pistachio SoC general purpose timers.

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 .../bindings/timer/img,pistachio-gptimer.txt       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt

diff --git a/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt b/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt
new file mode 100644
index 0000000..418379f
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt
@@ -0,0 +1,28 @@
+* Pistachio general-purpose timer based clocksource
+
+Required properties:
+ - compatible: "img,pistachio-gptimer".
+ - reg: Address range of the timer registers.
+ - interrupts: An interrupt for each of the four timers
+ - clocks : Should contain a clock specifier for each entry in clock-names
+ - clock-names : Should contain the following entries:
+                "sys", interface clock
+                "slow", slow counter clock
+                "fast", fast counter clock
+ - img,cr-periph: Must contain a phandle to the peripheral control
+		  syscon node.
+
+Example:
+	timer: timer@18102000 {
+		compatible = "img,pistachio-gptimer";
+		reg = <0x18102000 0x100>;
+		interrupts = <GIC_SHARED 60 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SHARED 61 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SHARED 62 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SHARED 63 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk_periph PERIPH_CLK_COUNTER_FAST>,
+		         <&clk_periph PERIPH_CLK_COUNTER_SLOW>,
+			 <&cr_periph SYS_CLK_TIMER>;
+		clock-names = "fast", "slow", "sys";
+		img,cr-periph = <&cr_periph>;
+	};
-- 
2.3.3
