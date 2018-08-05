Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2018 01:27:14 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:40480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994562AbeHEX1KfKhJz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Aug 2018 01:27:10 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37D09AE62;
        Sun,  5 Aug 2018 23:27:03 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc:     linux-mips@linux-mips.org, jringle@gridpoint.com,
        allsey87@gmail.com, Jakub Kicinski <kubakici@wp.pl>,
        Xue Liu <liuxuenetmail@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [RFC] serial: sc16is7xx: Use DT sub-nodes for UART ports
Date:   Mon,  6 Aug 2018 01:26:51 +0200
Message-Id: <20180805232651.10605-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <CAL_JsqKNnfgESG6ON95D7nD8VNrcVy7-x6cGGnae_GbbGKAuPQ@mail.gmail.com>
References: <CAL_JsqKNnfgESG6ON95D7nD8VNrcVy7-x6cGGnae_GbbGKAuPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <afaerber@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: afaerber@suse.de
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

This is to allow using serdev.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/tty/serial/sc16is7xx.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 243c96025053..ad7267274f65 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1213,9 +1213,31 @@ static int sc16is7xx_probe(struct device *dev,
 			SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
+#ifdef CONFIG_OF
+		struct device_node *np;
+		struct platform_device *pdev;
+		char name[6] = "uartx";
+#endif
+
 		s->p[i].line		= i;
 		/* Initialize port data */
+#ifdef CONFIG_OF
+		name[4] = '0' + i;
+		np = of_get_child_by_name(dev->of_node, name);
+		if (IS_ERR(np)) {
+			ret = PTR_ERR(np);
+			goto out_ports;
+		}
+		pdev = of_platform_device_create(np, NULL, dev);
+		if (IS_ERR(pdev)) {
+			ret = PTR_ERR(pdev);
+			goto out_ports;
+		}
+		platform_set_drvdata(pdev, dev_get_drvdata(dev));
+		s->p[i].port.dev	= &pdev->dev;
+#else
 		s->p[i].port.dev	= dev;
+#endif
 		s->p[i].port.irq	= irq;
 		s->p[i].port.type	= PORT_SC16IS7XX;
 		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
@@ -1271,6 +1293,9 @@ static int sc16is7xx_probe(struct device *dev,
 	for (i--; i >= 0; i--) {
 		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 		clear_bit(s->p[i].port.line, &sc16is7xx_lines);
+#ifdef CONFIG_OF
+		of_platform_device_destroy(s->p[i].port.dev, NULL);
+#endif
 	}
 
 #ifdef CONFIG_GPIOLIB
-- 
2.16.4
