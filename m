Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2010 07:14:02 +0200 (CEST)
Received: from smtp-out-037.synserver.de ([212.40.180.37]:1047 "HELO
        smtp-out-036.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S1492368Ab0FSFKE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jun 2010 07:10:04 +0200
Received: (qmail 14796 invoked by uid 0); 19 Jun 2010 05:10:04 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 13414
Received: from d024024.adsl.hansenet.de (HELO localhost.localdomain) [80.171.24.24]
  by 217.119.54.77 with SMTP; 19 Jun 2010 05:10:03 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 11/26] MIPS: JZ4740: Add serial support
Date:   Sat, 19 Jun 2010 07:08:16 +0200
Message-Id: <1276924111-11158-12-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1276924111-11158-1-git-send-email-lars@metafoo.de>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
X-archive-position: 27185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13378

This patch adds support for serials on a JZ4740 SoC.

The JZ4740 UART interface is almost 16550 compatible.
The UART module needs to be enabled by setting a bit in the FCR register and it
has support for receive timeout interrupts.
Instead of adding yet another machine specific quirk to the 8250 serial driver
we provide a serial_out implementation which sets the required additional flags.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/serial.c |   33 +++++++++++++++++++++++++++++++++
 arch/mips/jz4740/serial.h |   21 +++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/jz4740/serial.c
 create mode 100644 arch/mips/jz4740/serial.h

diff --git a/arch/mips/jz4740/serial.c b/arch/mips/jz4740/serial.c
new file mode 100644
index 0000000..d23de45
--- /dev/null
+++ b/arch/mips/jz4740/serial.c
@@ -0,0 +1,33 @@
+/*
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 serial support
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+
+void jz4740_serial_out(struct uart_port *p, int offset, int value)
+{
+	switch (offset) {
+	case UART_FCR:
+		value |= 0x10; /* Enable uart module */
+		break;
+	case UART_IER:
+		value |= (value & 0x4) << 2;
+		break;
+	default:
+		break;
+	}
+	writeb(value, p->membase + (offset << p->regshift));
+}
diff --git a/arch/mips/jz4740/serial.h b/arch/mips/jz4740/serial.h
new file mode 100644
index 0000000..247a7d8
--- /dev/null
+++ b/arch/mips/jz4740/serial.h
@@ -0,0 +1,21 @@
+/*
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 serial support
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifndef __MIPS_JZ4740_SERIAL_H__
+
+void jz4740_serial_out(struct uart_port *p, int offset, int value);
+
+#endif
+
-- 
1.5.6.5
