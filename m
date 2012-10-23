Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:49:53 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:65033 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825704Ab2JWRsDeL71w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:48:03 +0200
Received: by mail-la0-f49.google.com with SMTP id z14so2431934lag.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kqesxoV2E8UXutKpWTqOsmlH1jIINiDsgVrxkhmkt38=;
        b=ufrMwIowf/gHdJFHPfES5VdK7mfwLfQTYEQONVI+7TmYjIAsY3VbR/gNVw2iZgKW0L
         SRR/yUEsMisGPwbbMpmGOPDqELT96orUKhY8l9ZBMQa11gWW3T6iY5Vg4QQYwbCFziL6
         /bGaird/8CLuL8VGg2pZkw/wFIYr23HDzsWDI3zO1rSEeWBQuJ6/fXwS9Mzm/y95o5dr
         uAaC4hxIj8+9zbkavGsVz3+mXWKFqJczZlvgg3awxMqbG92BeGbjxlO9LlidEKiIp9DU
         72fz4Pk6i1IDqxSMcHHnsz9xTEJWypAtlAM/5fv3LbzuehAPHKx00+EV/xn7HOi2mmbp
         zP7g==
Received: by 10.152.148.169 with SMTP id tt9mr12093417lab.15.1351014483025;
        Tue, 23 Oct 2012 10:48:03 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.48.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:48:02 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 08/13] MIPS: JZ4750D: Add serial support
Date:   Tue, 23 Oct 2012 21:43:56 +0400
Message-Id: <1351014241-3207-9-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

The JZ4750D UART interface is almost 16550 compatible.
The UART module needs to be enabled by setting a bit in the FCR register
and it has support for receive timeout interrupts. Instead of adding yet
another machine specific quirk to the 8250 serial driver we provide a
serial_out implementation which sets the required additional flags.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/jz4750d/serial.c |   32 ++++++++++++++++++++++++++++++++
 arch/mips/jz4750d/serial.h |   22 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/mips/jz4750d/serial.c
 create mode 100644 arch/mips/jz4750d/serial.h

diff --git a/arch/mips/jz4750d/serial.c b/arch/mips/jz4750d/serial.c
new file mode 100644
index 0000000..e152e64
--- /dev/null
+++ b/arch/mips/jz4750d/serial.c
@@ -0,0 +1,32 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D serial support
+ *
+ *  based on JZ4740 serial support
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+
+void jz4750d_serial_out(struct uart_port *p, int offset, int value)
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
diff --git a/arch/mips/jz4750d/serial.h b/arch/mips/jz4750d/serial.h
new file mode 100644
index 0000000..d381572
--- /dev/null
+++ b/arch/mips/jz4750d/serial.h
@@ -0,0 +1,22 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D serial support
+ *
+ *  based on JZ4740 serial support
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __MIPS_JZ4750D_SERIAL_H__
+#define __MIPS_JZ4750D_SERIAL_H__
+
+struct uart_port;
+
+void jz4750d_serial_out(struct uart_port *p, int offset, int value);
+
+#endif
-- 
1.7.10.4
