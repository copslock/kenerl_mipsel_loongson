Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 11:15:55 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:60512 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994633AbeAPKNJnbYqs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 11:13:09 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id C49B2208CB; Tue, 16 Jan 2018 11:12:59 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 95B0C208C4;
        Tue, 16 Jan 2018 11:12:49 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3 6/8] MIPS: mscc: add ocelot PCB123 device tree
Date:   Tue, 16 Jan 2018 11:12:38 +0100
Message-Id: <20180116101240.5393-7-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/mips/boot/dts/mscc/Makefile          |  2 ++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb123.dts

diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
index f0a155a74e02..09a1c4b97de2 100644
--- a/arch/mips/boot/dts/mscc/Makefile
+++ b/arch/mips/boot/dts/mscc/Makefile
@@ -1,3 +1,5 @@
+dtb-$(CONFIG_MSCC_OCELOT)	+= ocelot_pcb123.dtb
+
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
new file mode 100644
index 000000000000..42bd404471f6
--- /dev/null
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
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
+	memory {
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
2.15.1
