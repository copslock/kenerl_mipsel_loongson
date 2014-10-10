Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 05:41:01 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51248 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010258AbaJJDkchPSkh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 05:40:32 +0200
Received: by mail-pa0-f53.google.com with SMTP id kq14so877687pab.26
        for <multiple recipients>; Thu, 09 Oct 2014 20:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8CtdL4wnT26uhwfDafxPhv/NW7IefqNrctdMwieZNB4=;
        b=PQy4dtfbQ8nGmVxvFqRxNW+5sbc4rEhhcmhDsddgVqud1A8HRcR+yDiRk9zNpzg6/w
         qCt+Bpy+xdHLgn8PQGUe86r1C6KeG46h8GDVNWK8cePixss/Ixzce5ohlu/gkqfhZsh/
         l8S4AR+nkwZ2qQkb4P6jmeUcAx7gCs58QYLn78pWY1NCh+UDaPFi/qxqMHjDOB0ZTOuF
         38fIpmuGIAbOG46klM2Ery4MbD0+z6YMjpyhyd0sgWdibpc1UodbLDOC6DhhODUYlTRt
         1BIZddCxkARMWSazLtRzRyZuEoyYAzH3sHFs2oJZtlqpN8We8oOqYgWAifeQ2p+XL3mM
         LYGw==
X-Received: by 10.67.24.8 with SMTP id ie8mr2206760pad.21.1412912426250;
        Thu, 09 Oct 2014 20:40:26 -0700 (PDT)
Received: from localhost.localdomain ([171.213.62.98])
        by mx.google.com with ESMTPSA id sa6sm1563051pbb.29.2014.10.09.20.40.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Oct 2014 20:40:25 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 2/6] MIPS: Loongson1B: Improve early printk
Date:   Fri, 10 Oct 2014 11:40:00 +0800
Message-Id: <1412912402-6002-3-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412912402-6002-1-git-send-email-keguang.zhang@gmail.com>
References: <1412912402-6002-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

  - Determine serial port for early printk according to kernel command line.
  - Move to 8250/16550 serial early printk driver.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/loongson1/Kconfig       |  1 +
 arch/mips/loongson1/common/prom.c | 30 +++++++++++++-----------------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/mips/loongson1/Kconfig b/arch/mips/loongson1/Kconfig
index e23c25d..4ed9744 100644
--- a/arch/mips/loongson1/Kconfig
+++ b/arch/mips/loongson1/Kconfig
@@ -16,6 +16,7 @@ config LOONGSON1_LS1B
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_MIPS16
 	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
 	select COMMON_CLK
 
 endchoice
diff --git a/arch/mips/loongson1/common/prom.c b/arch/mips/loongson1/common/prom.c
index 2a47af5..6860098 100644
--- a/arch/mips/loongson1/common/prom.c
+++ b/arch/mips/loongson1/common/prom.c
@@ -27,7 +27,7 @@ char *prom_getenv(char *envname)
 	i = strlen(envname);
 
 	while (*env) {
-		if (strncmp(envname, *env, i) == 0 && *(*env+i) == '=')
+		if (strncmp(envname, *env, i) == 0 && *(*env + i) == '=')
 			return *env + i + 1;
 		env++;
 	}
@@ -49,7 +49,7 @@ void __init prom_init_cmdline(void)
 	for (i = 1; i < prom_argc; i++) {
 		strcpy(c, prom_argv[i]);
 		c += strlen(prom_argv[i]);
-		if (i < prom_argc-1)
+		if (i < prom_argc - 1)
 			*c++ = ' ';
 	}
 	*c = 0;
@@ -57,6 +57,7 @@ void __init prom_init_cmdline(void)
 
 void __init prom_init(void)
 {
+	void __iomem *uart_base;
 	prom_argc = fw_arg0;
 	prom_argv = (char **)fw_arg1;
 	prom_envp = (char **)fw_arg2;
@@ -65,23 +66,18 @@ void __init prom_init(void)
 
 	memsize = env_or_default("memsize", DEFAULT_MEMSIZE);
 	highmemsize = env_or_default("highmemsize", 0x0);
-}
 
-void __init prom_free_prom_memory(void)
-{
+	if (strstr(arcs_cmdline, "console=ttyS3"))
+		uart_base = ioremap_nocache(LS1X_UART3_BASE, 0x0f);
+	else if (strstr(arcs_cmdline, "console=ttyS2"))
+		uart_base = ioremap_nocache(LS1X_UART2_BASE, 0x0f);
+	else if (strstr(arcs_cmdline, "console=ttyS1"))
+		uart_base = ioremap_nocache(LS1X_UART1_BASE, 0x0f);
+	else
+		uart_base = ioremap_nocache(LS1X_UART0_BASE, 0x0f);
+	setup_8250_early_printk_port((unsigned long)uart_base, 0, 0);
 }
 
-#define PORT(offset)	(u8 *)(KSEG1ADDR(LS1X_UART0_BASE + offset))
-
-void prom_putchar(char c)
+void __init prom_free_prom_memory(void)
 {
-	int timeout;
-
-	timeout = 1024;
-
-	while (((readb(PORT(UART_LSR)) & UART_LSR_THRE) == 0)
-			&& (timeout-- > 0))
-		;
-
-	writeb(c, PORT(UART_TX));
 }
-- 
1.9.1
