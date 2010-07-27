Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jul 2010 22:14:39 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:35862 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492715Ab0G0UNI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jul 2010 22:13:08 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 4A50E7E2C;
        Tue, 27 Jul 2010 22:13:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YNe9VHRjM10g; Tue, 27 Jul 2010 22:12:58 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-249-197.ewe-ip-backbone.de [91.97.249.197])
        by hauke-m.de (Postfix) with ESMTPSA id CC28285E2;
        Tue, 27 Jul 2010 22:12:55 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] MIPS: BCM47xx: Setup and register serial early
Date:   Tue, 27 Jul 2010 22:12:46 +0200
Message-Id: <1280261566-8247-5-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280261566-8247-1-git-send-email-hauke@hauke-m.de>
References: <1280261566-8247-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

Swap the first and second serial if console=ttyS1 was set.
Set it up and register it for early serial support.

This patch has been in OpenWRT for a long time.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c |   37 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 516ac89..a40d88e 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -28,6 +28,8 @@
 #include <linux/types.h>
 #include <linux/ssb/ssb.h>
 #include <linux/ssb/ssb_embedded.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
@@ -190,12 +192,45 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 
 void __init plat_mem_setup(void)
 {
-	int err;
+	int i, err;
+	char buf[100];
+	struct ssb_mipscore *mcore;
 
 	err = ssb_bus_ssbbus_register(&ssb_bcm47xx, SSB_ENUM_BASE,
 				      bcm47xx_get_invariants);
 	if (err)
 		panic("Failed to initialize SSB bus (err %d)\n", err);
+	mcore = &ssb_bcm47xx.mipscore;
+
+	nvram_getenv("kernel_args", buf, sizeof(buf));
+	if (!strncmp(buf, "console=ttyS1", 13)) {
+		struct ssb_serial_port port;
+
+		printk(KERN_DEBUG "Swapping serial ports!\n");
+		/* swap serial ports */
+		memcpy(&port, &mcore->serial_ports[0], sizeof(port));
+		memcpy(&mcore->serial_ports[0], &mcore->serial_ports[1],
+		       sizeof(port));
+		memcpy(&mcore->serial_ports[1], &port, sizeof(port));
+	}
+
+	for (i = 0; i < mcore->nr_serial_ports; i++) {
+		struct ssb_serial_port *port = &(mcore->serial_ports[i]);
+		struct uart_port s;
+
+		memset(&s, 0, sizeof(s));
+		s.line = i;
+		s.mapbase = (unsigned int) port->regs;
+		s.membase = port->regs;
+		s.irq = port->irq + 2;
+		s.uartclk = port->baud_base;
+		s.flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+		s.iotype = SERIAL_IO_MEM;
+		s.regshift = port->reg_shift;
+
+		early_serial_setup(&s);
+	}
+	printk(KERN_DEBUG "Serial init done.\n");
 
 	_machine_restart = bcm47xx_machine_restart;
 	_machine_halt = bcm47xx_machine_halt;
-- 
1.7.0.4
