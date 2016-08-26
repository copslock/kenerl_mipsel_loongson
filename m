Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:48:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18877 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992705AbcHZPoPoC0-I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:44:15 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id ED2F4C4F03F8D;
        Fri, 26 Aug 2016 16:43:55 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:43:58 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH 24/26] dt-bindings: Document img,boston-clock binding
Date:   Fri, 26 Aug 2016 16:37:23 +0100
Message-ID: <20160826153725.11629-25-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54808
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
---

 .../devicetree/bindings/clock/img,boston-clock.txt | 27 ++++++++++++++++++++++
 include/dt-bindings/clock/boston-clock.h           | 13 +++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/img,boston-clock.txt
 create mode 100644 include/dt-bindings/clock/boston-clock.h

diff --git a/Documentation/devicetree/bindings/clock/img,boston-clock.txt b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
new file mode 100644
index 0000000..c01ea60
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
@@ -0,0 +1,27 @@
+Binding for Imagination Technologies MIPS Boston clock sources.
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : Should be "img,boston-clock".
+- #clock-cells : Should be set to 1.
+  Values available for clock consumers can be found in the header file:
+    <dt-bindings/clock/boston-clock.h>
+- regmap : Phandle to the Boston platform register system controller.
+  This should contain a phandle to the system controller node covering the
+  platform registers provided by the Boston board.
+
+Example:
+
+	clk_boston: clock {
+		compatible = "img,boston-clock";
+		#clock-cells = <1>;
+		regmap = <&plat_regs>;
+	};
+
+	uart0: uart@17ffe000 {
+		/* ... */
+		clocks = <&clk_boston BOSTON_CLK_SYS>;
+	};
diff --git a/include/dt-bindings/clock/boston-clock.h b/include/dt-bindings/clock/boston-clock.h
new file mode 100644
index 0000000..25f9cd2
--- /dev/null
+++ b/include/dt-bindings/clock/boston-clock.h
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ *
+ * SPDX-License-Identifier:	GPL-2.0
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_BOSTON_CLOCK_H__
+#define __DT_BINDINGS_CLOCK_BOSTON_CLOCK_H__
+
+#define BOSTON_CLK_SYS 0
+#define BOSTON_CLK_CPU 1
+
+#endif /* __DT_BINDINGS_CLOCK_BOSTON_CLOCK_H__ */
-- 
2.9.3
