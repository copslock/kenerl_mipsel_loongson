Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jan 2013 11:53:24 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:49210 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832245Ab3AYKw5Q8cuC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Jan 2013 11:52:57 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Alan Cox <alan@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/2] serial: of: allow au1x00 and rt288x to load from OF
Date:   Fri, 25 Jan 2013 11:50:08 +0100
Message-Id: <1359111008-9998-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359111008-9998-1-git-send-email-blogic@openwrt.org>
References: <1359111008-9998-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

In order to make serial_8250 loadable via OF on Au1x00 and Ralink WiSoC we need
to default the iotype to UPIO_AU.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/of_serial.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index e7cae1c..72e9743 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -97,7 +97,11 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->regshift = prop;
 
 	port->irq = irq_of_parse_and_map(np, 0);
+#if defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_SERIAL_8250_RT288X)
+	port->iotype = UPIO_AU;
+#else
 	port->iotype = UPIO_MEM;
+#endif
 	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
 		switch (prop) {
 		case 1:
-- 
1.7.10.4
