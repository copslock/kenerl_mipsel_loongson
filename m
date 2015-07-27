Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 16:02:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12852 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011309AbbG0OC228Nhd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 16:02:28 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A2561E959F9B2;
        Mon, 27 Jul 2015 15:02:19 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 27 Jul
 2015 15:02:22 +0100
Received: from imgworks-VB.kl.imgtec.org (192.168.167.141) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 27 Jul 2015 15:02:22 +0100
From:   Govindraj Raja <govindraj.raja@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        "Govindraj Raja" <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v4 5/7] clocksource: Add Pistachio SoC general purpose timer binding document
Date:   Mon, 27 Jul 2015 15:02:33 +0100
Message-ID: <1438005755-27051-1-git-send-email-govindraj.raja@imgtec.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.141]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: govindraj.raja@imgtec.com
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

From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

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
index 0000000..7afce80
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt
@@ -0,0 +1,28 @@
+* Pistachio general-purpose timer based clocksource
+
+Required properties:
+ - compatible: "img,pistachio-gptimer".
+ - reg: Address range of the timer registers.
+ - interrupts: An interrupt for each of the four timers
+ - clocks: Should contain a clock specifier for each entry in clock-names
+ - clock-names: Should contain the following entries:
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
1.9.1
