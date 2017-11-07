Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 12:26:06 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:40070 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991526AbdKGLZ4TCRo7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 12:25:56 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 07 Nov 2017 11:25:40 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 7 Nov 2017 03:24:39 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Rob Herring <robh@kernel.org>, <linux-mips@linux-mips.org>,
        <devicetree@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [RFC PATCH] earlycon: Search for uartclk provided by DT
Date:   Tue, 7 Nov 2017 11:24:31 +0000
Message-ID: <1510053871-29295-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1510053940-637138-27155-819626-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186669
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

During set up of the early console, the earlycon driver will attempt to
configure a baud rate if one is set in the earlycon structure.
Previously, of_setup_earlycon left this field as 0, ignoring any baud
rate selected by the DT. Commit 31cb9a8575ca ("earlycon: initialise baud
field of earlycon device structure") changed this behaviour such that
any selected baud rate is now set. The earlycon driver must deduce the
divisor from the configured uartclk, which of_setup_earlycon sets to the
constant BASE_BAUD. One of the boards supported by the MIPS generic
kernel is the Boston FPGA board. On that board clock rates provided to
the UART depend on the FPGA bitfile. Coupled with this being a generic
kernel binary which can run across several hardware platforms, a generic
BASE_BAUD cannot be known at kernel compile time. Since MIPS generic
kernels cannot set BASE_BAUD, an incorrect divisor is now calculated for
the selected baud rate. This results in garbage being printed to the
console during boot. This was a regression in v4.14 since previously
of_setup_earlycon did not specify a baud rate and the bootloaders
configured baud rate persisted though earlycon setup.

In order to fix this, introduce a mechanism such that earlycon can find
the uartclk from the device tree. This allows the bootloader to specify
the clock frequency in the DT before the kernel is started.

There are a few different ways specified in clock-bindings.txt that the
clock frequency of a UART may be provided in DT, and this mechanism
attempts to cope with them.

1. UART node contains the <clock-frequency> property. If the UART is
clocked by a fixed clock, then it's freqeuncy may be provided directly
in the UART node.

2. UART node contains <assigned-clock-rates>. If the UART is the only
consumer of a clock, then it is allowed to specify it's rate via the
<assigned-clock-rates> property on the UART.

3. UART node contains phandle to clock provider. The clock provider node
may specify a frequency through either the <clock-frequency> property or
the <assigned-clock-rates> property.

With this change in place, the board bootloader can fill the required
information in the DT to allow earlycon to correctly configure the
uartclk and hence drivers can calculate the right divisor, restoring
console output.

Fixes: 31cb9a8575ca ("earlycon: initialise baud field of earlycon device structure")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---


I haven't handled the <assigned-clock-parents> property yet, the
documentation isn't especially clear about this, but I guess that this
should be handled as a phandle to a clock node in the same way as the
<clocks> property? With parent clocks, potentially the code would have
to walk up the clock tree following phandles until it finds one with a
clock rate specified?

I'm not quite clear what it means to have assigned-clocks which are
different to the consumed clocks specified in the clocks node, as in the
example?

This is quite a large change so I would not expect it to be a 4.14 fix.

Thanks,
Matt

---
 drivers/tty/serial/earlycon.c | 112 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 98928f082d87..c2e676e9b0a8 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/libfdt.h>
 #include <linux/serial_core.h>
 #include <linux/sizes.h>
 #include <linux/of.h>
@@ -234,6 +235,115 @@ early_param("earlycon", param_setup_earlycon);
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
+static unsigned long clk_node __initdata;
+
+/* Scan flat DT looking for node matching a phandle */
+static int __init of_setup_earlycon_clk_scan(unsigned long node,
+					     const char *uname, int depth,
+					     void *data)
+{
+	u32 phandle = *(u32 *)data;
+
+	if (phandle == of_get_flat_dt_phandle(node)) {
+		clk_node = node;
+		/* break now */
+		return 1;
+	}
+	return 0;
+}
+
+
+/* Determine the frequency of a clock from it's DT node
+ * @node: DT node
+ * @clk_phandle: phandle of clock consumed by UART
+ * @clk_output: which clock output - 0 for clocks with a single output
+ *
+ * Properties read are:
+ * - clock-frequency - for fixed clocks
+ * - assigned-clock-rates - for initial clock speeds
+ * - assigned clocks - determines entry in the assigned-clock-rates node
+ *
+ * returns the clock frequency or 0
+ */
+static int __init of_setup_earlycon_clk_get_rate(unsigned long node,
+						 u32 clk_phandle,
+						 int clk_output)
+{
+	const __be32 *val;
+	int size, i;
+
+	val = of_get_flat_dt_prop(node, "clock-frequency", NULL);
+	if (val)
+		return be32_to_cpu(*val);
+
+	val = of_get_flat_dt_prop(node,  "assigned-clocks", &size);
+	if (!val) {
+		/* No assigned-clocks property */
+		return 0;
+	}
+
+	/* Find the assigned-clocks property matching the phandle & output */
+	for (i = 0; i < (size / sizeof(u32)); i += 2) {
+		if ((be32_to_cpu(*(val + i)) == clk_phandle) &&
+		    (be32_to_cpu(*(val + i + 1)) == clk_output)) {
+			int output = i / 2;
+
+			/*
+			 * If the assigned-clock-rates property has enough
+			 * entries, read the frequency from there.
+			 */
+			val = of_get_flat_dt_prop(node,
+						  "assigned-clock-rates",
+						  &size);
+			if (val && size >= (sizeof(u32) * (output)))
+				return be32_to_cpu(*(val + output));
+		}
+	}
+	return 0;
+}
+
+static int __init of_setup_earlycon_clk(unsigned long node)
+{
+	u32 clk_phandle = 0, clk_output = 0;
+	int size, err, uartclk = 0;
+	const __be32 *val;
+
+	/* First try the UART's clock phandle */
+	val = of_get_flat_dt_prop(node, "clocks", &size);
+	if (val) {
+		clk_phandle = be32_to_cpu(*val);
+
+		/* Clock index optionally follows phandle */
+		if (size > sizeof(u32))
+			clk_output = be32_to_cpu(*(val + 1));
+
+		/* Find the clock's node from it's phandle */
+		err = of_scan_flat_dt(of_setup_earlycon_clk_scan, &clk_phandle);
+
+		/* If we found the clock node, check for a frequency */
+		if (err)
+			uartclk = of_setup_earlycon_clk_get_rate(clk_node,
+								 clk_phandle,
+								 clk_output);
+	}
+
+	/*
+	 * If frequency couldn't be determined from the clock node, try the
+	 * UART. The phandle / output of the clock set by assigned-clocks must
+	 * match the one consumed by the UART (clk_phandle / clk_output).
+	 */
+	if (!uartclk)
+		uartclk = of_setup_earlycon_clk_get_rate(node,
+							 clk_phandle,
+							 clk_output);
+
+	/* If frequency could't be determined from DT fall back to BASE_BAUD */
+	if (!uartclk)
+		uartclk = BASE_BAUD * 16;
+
+	return uartclk;
+}
+
 int __init of_setup_earlycon(const struct earlycon_id *match,
 			     unsigned long node,
 			     const char *options)
@@ -252,7 +362,7 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 		return -ENXIO;
 	}
 	port->mapbase = addr;
-	port->uartclk = BASE_BAUD * 16;
+	port->uartclk = of_setup_earlycon_clk(node);
 	port->membase = earlycon_map(port->mapbase, SZ_4K);
 
 	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
-- 
2.7.4
