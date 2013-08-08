Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 15:39:00 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:59730 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823002Ab3HHNigyFArf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 15:38:36 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH 2/2] serial: MIPS: lantiq: make driver use pinctrl
Date:   Thu,  8 Aug 2013 15:31:27 +0200
Message-Id: <1375968687-8704-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1375968687-8704-1-git-send-email-blogic@openwrt.org>
References: <1375968687-8704-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37475
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

From: Thomas Langer <thomas.langer@lantiq.com>

Add use of devm_pinctrl_get_select_default to active default pinctrl settings.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Acked-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/lantiq.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index ce1ea35..0dcaf3a 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -37,6 +37,8 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/err.h>
 
 #include <lantiq_soc.h>
 
@@ -681,6 +683,7 @@ lqasc_probe(struct platform_device *pdev)
 	struct ltq_uart_port *ltq_port;
 	struct uart_port *port;
 	struct resource *mmres, irqres[3];
+	struct pinctrl *pinctrl;
 	int line = 0;
 	int ret;
 
@@ -719,6 +722,10 @@ lqasc_probe(struct platform_device *pdev)
 	port->irq	= irqres[0].start;
 	port->mapbase	= mmres->start;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev, "pins are not configured from the driver\n");
+
 	ltq_port->fpiclk = clk_get_fpi();
 	if (IS_ERR(ltq_port->fpiclk)) {
 		pr_err("failed to get fpi clk\n");
-- 
1.7.10.4
