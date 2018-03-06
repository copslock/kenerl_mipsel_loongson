Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2018 13:18:06 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:44912 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994688AbeCFMRMtwR8r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2018 13:17:12 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D2F4C207A3; Tue,  6 Mar 2018 13:17:00 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6E54D209F6;
        Tue,  6 Mar 2018 13:16:20 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v5 3/5] MIPS: mscc: add ocelot PCB123 device tree
Date:   Tue,  6 Mar 2018 13:16:05 +0100
Message-Id: <20180306121607.1567-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
References: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Add a device tree for the Microsemi Ocelot PCB123 evaluation board.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/Makefile          |  2 ++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb123.dts

diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
index dd08e63a10ba..c51164537c02 100644
--- a/arch/mips/boot/dts/mscc/Makefile
+++ b/arch/mips/boot/dts/mscc/Makefile
@@ -1 +1,3 @@
+dtb-$(CONFIG_LEGACY_BOARD_OCELOT)	+= ocelot_pcb123.dtb
+
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
new file mode 100644
index 000000000000..b4e3860c6cf4
--- /dev/null
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
@@ -0,0 +1,27 @@
+//SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2017 Microsemi Corporation */
+
+/dts-v1/;
+
+#include "ocelot.dtsi"
+
+/ {
+	compatible = "mscc,ocelot-pcb123", "mscc,ocelot";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0e000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
-- 
2.16.2
