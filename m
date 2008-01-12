Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2008 23:39:16 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:56299 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20034783AbYALXjH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2008 23:39:07 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JDpwQ-0002N2-00; Sun, 13 Jan 2008 00:39:06 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 4E149C2F36; Sun, 13 Jan 2008 00:39:04 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	linux-input@vger.kernel.org, linux-mips@linux-mips.org
cc:	dmitry.torokhov@gmail.com
Subject: [PATCH] I8042: SNI RM support
Message-Id: <20080112233904.4E149C2F36@solo.franken.de>
Date:	Sun, 13 Jan 2008 00:39:04 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

SNI RM200 don't have the i8042 controller connected to the EISA bus, but
have a second address range for onboard devices. This patch handles
the two possible address ranges for the i8042 on SNI RMs

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Please apply for 2.6.25.

 drivers/input/serio/i8042-snirm.h |   75 +++++++++++++++++++++++++++++++++++++
 drivers/input/serio/i8042.h       |    2 +
 2 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-snirm.h b/drivers/input/serio/i8042-snirm.h
new file mode 100644
index 0000000..57a66a3
--- /dev/null
+++ b/drivers/input/serio/i8042-snirm.h
@@ -0,0 +1,75 @@
+#ifndef _I8042_SNIRM_H
+#define _I8042_SNIRM_H
+
+#include <asm/sni.h>
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+/*
+ * Names.
+ */
+
+#define I8042_KBD_PHYS_DESC "onboard/serio0"
+#define I8042_AUX_PHYS_DESC "onboard/serio1"
+#define I8042_MUX_PHYS_DESC "onboard/serio%d"
+
+/*
+ * IRQs.
+ */
+static int i8042_kbd_irq = -1;
+static int i8042_aux_irq = -1;
+#define I8042_KBD_IRQ i8042_kbd_irq
+#define I8042_AUX_IRQ i8042_aux_irq
+
+static void __iomem *kbd_iobase;
+
+#define I8042_COMMAND_REG	(kbd_iobase + 0x64UL)
+#define I8042_DATA_REG		(kbd_iobase + 0x60UL)
+
+static inline int i8042_read_data(void)
+{
+	return readb(kbd_iobase + 0x60UL);
+}
+
+static inline int i8042_read_status(void)
+{
+	return readb(kbd_iobase + 0x64UL);
+}
+
+static inline void i8042_write_data(int val)
+{
+	writeb(val, kbd_iobase + 0x60UL);
+}
+
+static inline void i8042_write_command(int val)
+{
+	writeb(val, kbd_iobase + 0x64UL);
+}
+static inline int i8042_platform_init(void)
+{
+	/* RM200 is strange ... */
+	if (sni_brd_type == SNI_BRD_RM200) {
+		kbd_iobase = ioremap(0x16000000, 4);
+		i8042_kbd_irq = 33;
+		i8042_aux_irq = 44;
+	} else {
+		kbd_iobase = ioremap(0x14000000, 4);
+		i8042_kbd_irq = 1;
+		i8042_aux_irq = 12;
+	}
+	if (!kbd_iobase)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void i8042_platform_exit(void)
+{
+
+}
+
+#endif /* _I8042_SNIRM_H */
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index dd22d91..b5e9917 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -18,6 +18,8 @@
 #include "i8042-jazzio.h"
 #elif defined(CONFIG_SGI_IP22)
 #include "i8042-ip22io.h"
+#elif defined(CONFIG_SNI_RM)
+#include "i8042-snirm.h"
 #elif defined(CONFIG_PPC)
 #include "i8042-ppcio.h"
 #elif defined(CONFIG_SPARC)
