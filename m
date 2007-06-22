Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2007 15:19:49 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:56811 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022324AbXFVOTq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2007 15:19:46 +0100
Received: from localhost (p1126-ipad201funabasi.chiba.ocn.ne.jp [222.146.64.126])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BEB28B771; Fri, 22 Jun 2007 23:19:42 +0900 (JST)
Date:	Fri, 22 Jun 2007 23:20:23 +0900 (JST)
Message-Id: <20070622.232023.29573321.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Create fallback gpio.h
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Create fallback gpio.h which only contains prototypes for gpio API.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 include/asm-mips/mach-generic/gpio.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/mach-generic/gpio.h b/include/asm-mips/mach-generic/gpio.h
new file mode 100644
index 0000000..6eaf5ef
--- /dev/null
+++ b/include/asm-mips/mach-generic/gpio.h
@@ -0,0 +1,15 @@
+#ifndef __ASM_MACH_GENERIC_GPIO_H
+#define __ASM_MACH_GENERIC_GPIO_H
+
+int gpio_request(unsigned gpio, const char *label);
+void gpio_free(unsigned gpio);
+int gpio_direction_input(unsigned gpio);
+int gpio_direction_output(unsigned gpio, int value);
+int gpio_get_value(unsigned gpio);
+void gpio_set_value(unsigned gpio, int value);
+int gpio_to_irq(unsigned gpio);
+int irq_to_gpio(unsigned irq);
+
+#include <asm-generic/gpio.h>		/* cansleep wrappers */
+
+#endif /* __ASM_MACH_GENERIC_GPIO_H */
