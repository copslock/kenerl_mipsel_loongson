Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2010 21:45:49 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:62513 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492453Ab0GOTpT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jul 2010 21:45:19 +0200
Received: by mail-bw0-f49.google.com with SMTP id 15so902171bwz.36
        for <linux-mips@linux-mips.org>; Thu, 15 Jul 2010 12:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UV1FdQ33aRnkv7ALXE9J02z4HysguoxJeQ9B2zZbyNM=;
        b=d9s36WNlnb++p5cSG1Cia8kuDjQPGXiJNWwZ0VBnq5cD10hTfmHrkcZ9AzL59BOr7G
         0lg1a7n/tQOfF2HogxWht+0H556eDZ7pjqXgbEJCsgB13MUSU6fM+i43r1ClorrJs5cs
         eE1tn/dMtsRVgcJTaLUEVrr1X5qfc3AtMOx2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TvuutXuJNfgRCk/nGB/d7DEgpkS9DkX13r1tpV9/XtXeU7anEG+ecBMXU0B4YocZtR
         K+GK9xjAzE28wf/qQ3AD81YX3TgM+81BpGlVPZLku3DxK3WGu16Ph1QdSWUevjenjBOq
         RD1rmVYadiYQY6VLVMhtln+C8f73kaqLk86BM=
Received: by 10.204.142.205 with SMTP id r13mr76302bku.207.1279223119501;
        Thu, 15 Jul 2010 12:45:19 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id s17sm7274438bkx.18.2010.07.15.12.45.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 12:45:18 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        Linux-serial <linux-serial@vger.kernel.org>
Subject: [PATCH 2/2] serial: 8250: remove SERIAL_8250_AU1X00
Date:   Thu, 15 Jul 2010 21:45:05 +0200
Message-Id: <1279223105-23816-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279223105-23816-1-git-send-email-manuel.lauss@googlemail.com>
References: <1279223105-23816-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Remove the SERIAL_8250_AU1X00 config symbol.  Instead, use the MIPS_ALCHEMY
one which is always defined when building an Au1x00-based platform.

Cc: Linux-serial <linux-serial@vger.kernel.org>
Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
This one depends on a previous patch (which removes SOC_AU1X00 and changes
MACH_ALCHEMY) to apply cleanly (and then actually work), so I'd love for
this to go in via the mips tree.

 arch/mips/alchemy/common/platform.c |    2 --
 drivers/serial/8250.c               |   13 +++----------
 drivers/serial/Kconfig              |    8 --------
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 70f4abd..7186a02 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -50,7 +50,6 @@ static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 	}
 
 static struct plat_serial8250_port au1x00_uart_data[] = {
-#if defined(CONFIG_SERIAL_8250_AU1X00)
 #if defined(CONFIG_SOC_AU1000)
 	PORT(UART0_PHYS_ADDR, AU1000_UART0_INT),
 	PORT(UART1_PHYS_ADDR, AU1000_UART1_INT),
@@ -71,7 +70,6 @@ static struct plat_serial8250_port au1x00_uart_data[] = {
 	PORT(UART0_PHYS_ADDR, AU1200_UART0_INT),
 	PORT(UART1_PHYS_ADDR, AU1200_UART1_INT),
 #endif
-#endif	/* CONFIG_SERIAL_8250_AU1X00 */
 	{ },
 };
 
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 2420bec..92f34b3 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -302,7 +302,7 @@ static const struct serial8250_config uart_config[] = {
 	},
 };
 
-#if defined (CONFIG_SERIAL_8250_AU1X00)
+#if defined(CONFIG_MIPS_ALCHEMY)
 
 /* Au1x00 UART hardware has a weird register layout */
 static const u8 au_io_in_map[] = {
@@ -422,7 +422,6 @@ static unsigned int mem32_serial_in(struct uart_port *p, int offset)
 	return readl(p->membase + offset);
 }
 
-#ifdef CONFIG_SERIAL_8250_AU1X00
 static unsigned int au_serial_in(struct uart_port *p, int offset)
 {
 	offset = map_8250_in_reg(p, offset) << p->regshift;
@@ -434,7 +433,6 @@ static void au_serial_out(struct uart_port *p, int offset, int value)
 	offset = map_8250_out_reg(p, offset) << p->regshift;
 	__raw_writel(value, p->membase + offset);
 }
-#endif
 
 static unsigned int tsi_serial_in(struct uart_port *p, int offset)
 {
@@ -503,12 +501,11 @@ static void set_io_from_upio(struct uart_port *p)
 		p->serial_out = mem32_serial_out;
 		break;
 
-#ifdef CONFIG_SERIAL_8250_AU1X00
 	case UPIO_AU:
 		p->serial_in = au_serial_in;
 		p->serial_out = au_serial_out;
 		break;
-#endif
+
 	case UPIO_TSI:
 		p->serial_in = tsi_serial_in;
 		p->serial_out = tsi_serial_out;
@@ -535,9 +532,7 @@ serial_out_sync(struct uart_8250_port *up, int offset, int value)
 	switch (p->iotype) {
 	case UPIO_MEM:
 	case UPIO_MEM32:
-#ifdef CONFIG_SERIAL_8250_AU1X00
 	case UPIO_AU:
-#endif
 	case UPIO_DWAPB:
 		p->serial_out(p, offset, value);
 		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
@@ -573,7 +568,7 @@ static inline void _serial_dl_write(struct uart_8250_port *up, int value)
 	serial_outp(up, UART_DLM, value >> 8 & 0xff);
 }
 
-#if defined(CONFIG_SERIAL_8250_AU1X00)
+#if defined(CONFIG_MIPS_ALCHEMY)
 /* Au1x00 haven't got a standard divisor latch */
 static int serial_dl_read(struct uart_8250_port *up)
 {
@@ -2596,11 +2591,9 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 	if (flags & UART_CONFIG_TYPE)
 		autoconfig(up, probeflags);
 
-#ifdef CONFIG_SERIAL_8250_AU1X00
 	/* if access method is AU, it is a 16550 with a quirk */
 	if (up->port.type == PORT_16550A && up->port.iotype == UPIO_AU)
 		up->bugs |= UART_BUG_NOMSR;
-#endif
 
 	if (up->port.type != PORT_UNKNOWN && flags & UART_CONFIG_IRQ)
 		autoconfig_irq(up);
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 1acc7b3..e437ce8 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -258,14 +258,6 @@ config SERIAL_8250_ACORN
 	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
 	  cards.  If unsure, say N.
 
-config SERIAL_8250_AU1X00
-	bool "Au1x00 serial port support"
-	depends on SERIAL_8250 != n && MIPS_ALCHEMY
-	help
-	  If you have an Au1x00 SOC based board and want to use the serial port,
-	  say Y to this option. The driver can handle up to 4 serial ports,
-	  depending on the SOC. If unsure, say N.
-
 config SERIAL_8250_RM9K
 	bool "Support for MIPS RM9xxx integrated serial port"
 	depends on SERIAL_8250 != n && SERIAL_RM9000
-- 
1.7.1.1
