Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2012 18:51:56 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:36611 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904122Ab2DGQtA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Apr 2012 18:49:00 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SGYoo-0004dH-Ou; Sat, 07 Apr 2012 11:48:54 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Douglas Leung <douglas@mips.com>,
        Chris Dearman <chris@mips.com>
Subject: [PATCH 07/10] MIPS: Add support for early serial debug and LCD device on SEAD-3.
Date:   Sat,  7 Apr 2012 11:48:32 -0500
Message-Id: <1333817315-30091-8-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1333817315-30091-1-git-send-email-sjhill@mips.com>
References: <1333817315-30091-1-git-send-email-sjhill@mips.com>
X-archive-position: 32885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Add SEAD-3 support for early serial printk and the address for the
small LCD display. The actual framebuffer support is contained in
another patch.

Signed-off-by: Douglas Leung <douglas@mips.com>
Signed-off-by: Chris Dearman <chris@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mips-boards/generic.h |    1 +
 arch/mips/kernel/early_printk.c             |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/mips/include/asm/mips-boards/generic.h b/arch/mips/include/asm/mips-boards/generic.h
index 46c0856..a857264 100644
--- a/arch/mips/include/asm/mips-boards/generic.h
+++ b/arch/mips/include/asm/mips-boards/generic.h
@@ -29,6 +29,7 @@
  */
 #define ASCII_DISPLAY_WORD_BASE    0x1f000410
 #define ASCII_DISPLAY_POS_BASE     0x1f000418
+#define LCD_DISPLAY_POS_BASE       0x1f000400   /* SEAD-3 */
 
 
 /*
diff --git a/arch/mips/kernel/early_printk.c b/arch/mips/kernel/early_printk.c
index 9ae813e..e078cae 100644
--- a/arch/mips/kernel/early_printk.c
+++ b/arch/mips/kernel/early_printk.c
@@ -12,6 +12,23 @@
 
 #include <asm/setup.h>
 
+#ifdef CONFIG_MIPS_SEAD3
+#include <linux/string.h>
+#include <asm/mips-boards/prom.h>
+
+extern void prom_putchar(char, char);
+
+static void __init
+early_console_write(struct console *con, const char *s, unsigned n)
+{
+	while (n-- && *s) {
+		if (*s == '\n')
+			prom_putchar('\r', con->index);
+		prom_putchar(*s, con->index);
+		s++;
+	}
+}
+#else
 extern void prom_putchar(char);
 
 static void __init
@@ -24,6 +41,7 @@ early_console_write(struct console *con, const char *s, unsigned n)
 		s++;
 	}
 }
+#endif
 
 static struct console early_console __initdata = {
 	.name	= "early",
@@ -40,5 +58,12 @@ void __init setup_early_printk(void)
 		return;
 	early_console_initialized = 1;
 
+#ifdef CONFIG_MIPS_SEAD3
+	if ((strstr(prom_getcmdline(), "console=ttyS0")) != NULL)
+		early_console.index = 0;
+	else if ((strstr(prom_getcmdline(), "console=ttyS1")) != NULL)
+		early_console.index = 1;
+#endif
+
 	register_console(&early_console);
 }
-- 
1.7.9.6
