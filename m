Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 20:09:53 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:46307 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493403AbZJ1TJX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 20:09:23 +0100
Received: by ewy12 with SMTP id 12so1125846ewy.0
        for <multiple recipients>; Wed, 28 Oct 2009 12:09:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=93fnFT9Y+YFm0MxTEIB8ov9uIJLAz3J9TFKVCWJ07lk=;
        b=gEU/G4MTbN1QURvuu2upS4OGDPNpmU7vSwrZQJXz/eJXEjLKg6n4pqcBuXtZK2J3a+
         C7gLBbEvp4Lxjjd10ClI/hFpickQKDLQeeiEYeW/l//o4Eju/EinWEBmUfdqHarpyOQj
         3JnosTrFH9F1tm7J7W7sBT+NbinxUuXAzQc28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S12JosVq5v0SjmTMM8O1FPgLdka4SfuVs0duxbJRqhpzpjbfdARWkEU7nzoHnH8BZ6
         jR67YYKrqSWphYhCb6u1ySNUExY9wQaT3GtwCSPwXr9t+Y2ECg9ixfdKeZTtzWDVrLsf
         Z/I/0uv/cPxHYqH5R86tftjWGGMXB1yFB1Zww=
Received: by 10.216.86.129 with SMTP id w1mr1089145wee.145.1256756958077;
        Wed, 28 Oct 2009 12:09:18 -0700 (PDT)
Received: from localhost.localdomain (p5496FE70.dip.t-dialin.net [84.150.254.112])
        by mx.google.com with ESMTPS id x6sm4428359gvf.1.2009.10.28.12.09.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 12:09:17 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/2] MIPS: Alchemy: UARTs are 16550A
Date:	Wed, 28 Oct 2009 20:09:14 +0100
Message-Id: <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com>
References: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

UART autodetection breaks on the Au1300 but the IP blocks are
identical, at least in the datasheets.

Pass uart type on to the 8250 driver via platform data, and move
the MSR quirk to another place sind autoconf() is now no longer
called on init.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Tested on DB1200 and DB1300.
The mips parts apply on top of Ralf's mips-queue tree.

 arch/mips/alchemy/common/platform.c |    4 +++-
 drivers/serial/8250.c               |   13 +++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 195e5b3..3be14b0 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -26,7 +26,9 @@
 		.irq		= _irq,				\
 		.regshift	= 2,				\
 		.iotype		= UPIO_AU,			\
-		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
+		.flags		= UPF_SKIP_TEST | UPF_IOREMAP |	\
+				  UPF_FIXED_TYPE,		\
+		.type		= PORT_16550A,			\
 	}
 
 static struct plat_serial8250_port au1x00_uart_data[] = {
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 2ff81eb..9538e5b 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1214,12 +1214,6 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	}
 #endif
 
-#ifdef CONFIG_SERIAL_8250_AU1X00
-	/* if access method is AU, it is a 16550 with a quirk */
-	if (up->port.type == PORT_16550A && up->port.iotype == UPIO_AU)
-		up->bugs |= UART_BUG_NOMSR;
-#endif
-
 	serial_outp(up, UART_LCR, save_lcr);
 
 	if (up->capabilities != uart_config[up->port.type].flags) {
@@ -2586,6 +2580,13 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 
 	if (flags & UART_CONFIG_TYPE)
 		autoconfig(up, probeflags);
+
+#ifdef CONFIG_SERIAL_8250_AU1X00
+	/* if access method is AU, it is a 16550 with a quirk */
+	if (up->port.type == PORT_16550A && up->port.iotype == UPIO_AU)
+		up->bugs |= UART_BUG_NOMSR;
+#endif
+
 	if (up->port.type != PORT_UNKNOWN && flags & UART_CONFIG_IRQ)
 		autoconfig_irq(up);
 
-- 
1.6.5
