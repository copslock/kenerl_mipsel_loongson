Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jan 2012 18:14:17 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:60695 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901170Ab2AURN2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jan 2012 18:13:28 +0100
Received: by eaak10 with SMTP id k10so321445eaa.36
        for <multiple recipients>; Sat, 21 Jan 2012 09:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vDqDNqTHj9I3kc3co90X3wTQCwcet0EFeLKAue6yMMA=;
        b=PY9hkLSHniq3yuPLi60IoUsE8jy+3lDyybJU3pV6tCSu+1bGxkAGv1XhMQZV+2xVvi
         Aih1WQyGRSoDhElfhqrNv2HRBrtv++3yzC51iFMrXVuOoX9Ad3LglC9DvBvFRx3XMAOI
         PM2iHT7KIGNYOmomPqUjcVtayGh2fdKOsYaTg=
Received: by 10.213.19.73 with SMTP id z9mr512087eba.41.1327166003239;
        Sat, 21 Jan 2012 09:13:23 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-10-45.adsl.highway.telekom.at. [188.22.10.45])
        by mx.google.com with ESMTPS id x4sm28076665eeb.4.2012.01.21.09.13.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Jan 2012 09:13:22 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/3] MIPS: Alchemy: devboards: kill prom.c
Date:   Sat, 21 Jan 2012 18:13:14 +0100
Message-Id: <1327165995-27425-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1327165995-27425-1-git-send-email-manuel.lauss@googlemail.com>
References: <1327165995-27425-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 32297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

move contents to already existing platform.c file.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/devboards/Makefile   |    2 +-
 arch/mips/alchemy/devboards/platform.c |   30 ++++++++++++++++
 arch/mips/alchemy/devboards/prom.c     |   60 --------------------------------
 3 files changed, 31 insertions(+), 61 deletions(-)
 delete mode 100644 arch/mips/alchemy/devboards/prom.c

diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index 3c37fb3..c9e747d 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -2,7 +2,7 @@
 # Alchemy Develboards
 #
 
-obj-y += prom.o bcsr.o platform.o
+obj-y += bcsr.o platform.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_MIPS_PB1100)	+= pb1100.o
 obj-$(CONFIG_MIPS_PB1500)	+= pb1500.o
diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
index 621f70a..f39042e 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -10,9 +10,39 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 
+#include <asm/bootinfo.h>
 #include <asm/reboot.h>
+#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
 
+#include <prom.h>
+
+void __init prom_init(void)
+{
+	unsigned char *memsize_str;
+	unsigned long memsize;
+
+	prom_argc = (int)fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str || kstrtoul(memsize_str, 0, &memsize))
+		memsize = 64 << 20; /* all devboards have at least 64MB RAM */
+
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
+
+void prom_putchar(unsigned char c)
+{
+#ifdef CONFIG_MIPS_DB1300
+	alchemy_uart_putchar(AU1300_UART2_PHYS_ADDR, c);
+#else
+	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
+#endif
+}
+
 
 static struct platform_device db1x00_rtc_dev = {
 	.name	= "rtc-au1xxx",
diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
deleted file mode 100644
index 57320f2..0000000
--- a/arch/mips/alchemy/devboards/prom.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * Common code used by all Alchemy develboards.
- *
- * Extracted from files which had this to say:
- *
- * Copyright 2000, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <asm/bootinfo.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <prom.h>
-
-void __init prom_init(void)
-{
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = (int)fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
-
-	prom_init_cmdline();
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str || strict_strtoul(memsize_str, 0, &memsize))
-		memsize = 64 << 20; /* all devboards have at least 64MB RAM */
-
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
-
-void prom_putchar(unsigned char c)
-{
-#ifdef CONFIG_MIPS_DB1300
-	alchemy_uart_putchar(AU1300_UART2_PHYS_ADDR, c);
-#else
-	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
-#endif
-}
-- 
1.7.8.4
