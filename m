Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 20:21:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37239 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993929AbdFBSUxRV8Ao (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 20:20:53 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E54E7FDDEAC23;
        Fri,  2 Jun 2017 19:20:42 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 19:20:46
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: Document img,boston-clock binding
Date:   Fri, 2 Jun 2017 11:20:00 -0700
Message-ID: <20170602182003.16269-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602182003.16269-1-paul.burton@imgtec.com>
References: <20170602182003.16269-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Add device tree binding documentation for the clocks provided by the
MIPS Boston development board from Imagination Technologies, and a
header file describing the available clocks for use by device trees &
driver.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-mips@linux-mips.org

---

Changes in v4:
- Move img,boston-clock node under platform register syscon node.
- Add MAINTAINERS entry.

Changes in v3: None

Changes in v2:
- Add BOSTON_CLK_INPUT to expose the input clock.

 .../devicetree/bindings/clock/img,boston-clock.txt | 31 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 +++++
 include/dt-bindings/clock/boston-clock.h           | 14 ++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/img,boston-clock.txt
 create mode 100644 include/dt-bindings/clock/boston-clock.h

diff --git a/Documentation/devicetree/bindings/clock/img,boston-clock.txt b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
new file mode 100644
index 000000000000..7bc5e9ffb624
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
@@ -0,0 +1,31 @@
+Binding for Imagination Technologies MIPS Boston clock sources.
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+The device node must be a child node of the syscon node corresponding to the
+Boston system's platform registers.
+
+Required properties:
+- compatible : Should be "img,boston-clock".
+- #clock-cells : Should be set to 1.
+  Values available for clock consumers can be found in the header file:
+    <dt-bindings/clock/boston-clock.h>
+
+Example:
+
+	system-controller@17ffd000 {
+		compatible = "img,boston-platform-regs", "syscon";
+		reg = <0x17ffd000 0x1000>;
+
+		clk_boston: clock {
+			compatible = "img,boston-clock";
+			#clock-cells = <1>;
+		};
+	};
+
+	uart0: uart@17ffe000 {
+		/* ... */
+		clocks = <&clk_boston BOSTON_CLK_SYS>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 053c3bdd1fe5..481fc6d54ca4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8499,6 +8499,13 @@ F:	arch/mips/include/asm/mach-loongson32/
 F:	drivers/*/*loongson1*
 F:	drivers/*/*/*loongson1*
 
+MIPS BOSTON DEVELOPMENT BOARD
+M:	Paul Burton <paul.burton@imgtec.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/img,boston-clock.txt
+F:	include/dt-bindings/clock/boston-clock.h
+
 MIROSOUND PCM20 FM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
diff --git a/include/dt-bindings/clock/boston-clock.h b/include/dt-bindings/clock/boston-clock.h
new file mode 100644
index 000000000000..a6f009821137
--- /dev/null
+++ b/include/dt-bindings/clock/boston-clock.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ *
+ * SPDX-License-Identifier:	GPL-2.0
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_BOSTON_CLOCK_H__
+#define __DT_BINDINGS_CLOCK_BOSTON_CLOCK_H__
+
+#define BOSTON_CLK_INPUT 0
+#define BOSTON_CLK_SYS 1
+#define BOSTON_CLK_CPU 2
+
+#endif /* __DT_BINDINGS_CLOCK_BOSTON_CLOCK_H__ */
-- 
2.13.0
