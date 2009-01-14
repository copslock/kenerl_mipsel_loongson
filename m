Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2009 14:35:49 +0000 (GMT)
Received: from rn-out-0910.google.com ([64.233.170.190]:34614 "EHLO
	rn-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S21365069AbZANOfr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Jan 2009 14:35:47 +0000
Received: by rn-out-0910.google.com with SMTP id j66so535587rne.9
        for <linux-mips@linux-mips.org>; Wed, 14 Jan 2009 06:35:45 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=UojVWJGzYgmKKUnEMHR9vIk4l2ZrjmXP5MnljWHatKs=;
        b=r75e23UZJGALZgZDlVRSNfJtH/TNCLZx3MOmBUn9geDbco9miAK9WTnDSDgLrDm2QM
         7m/Ujq2aYN8LmLIBmAhZBogd/o7ZJiWzHUoLn3kBEN/FOaWKA5P8cM5O90u6/uUAkjnd
         O5cmGV2sIJbRWvbHBGASugoiHqr3UOXch0svs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=CZzb+fwcPwfnGdKIY+MCvV376KcAJSFVEl45tm2lF7Jumd8iSnODj1eFUp/msCA41H
         1Zf61kucMKNqGyM0AZEgPn0CK+i27XP9fUTWs4TEpVg9BlWYN0dM5vRl0xnADIuAJTci
         TZi0SGFOCBi8dHSqQY7summgrgHbCYQGycp8c=
Received: by 10.100.164.20 with SMTP id m20mr105936ane.121.1231943745524;
        Wed, 14 Jan 2009 06:35:45 -0800 (PST)
Received: from ?10.6.11.31? (cpmsq.epam.com [217.21.56.2])
        by mx.google.com with ESMTPS id c40sm9040412anc.16.2009.01.14.06.35.44
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Jan 2009 06:35:44 -0800 (PST)
Subject: [PATCH] Don't use ttyS* serial device name for board specific
 PNX8XXX UART serial
From:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Wed, 14 Jan 2009 16:35:42 +0200
Message-Id: <1231943742.8457.6.camel@EPBYMINW0568>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.2 
Content-Transfer-Encoding: 7bit
Return-Path: <ihar.hrachyshka@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihar.hrachyshka@gmail.com
Precedence: bulk
X-list: linux-mips

I think that's a better solution for the problem I said so please commit
this patch rather previous one...

---

Don't use ttyS[0-1] serial device name for board specific PNX8XXX UART
serial. Rather create ttyPNX[0-1]. Also changed minor number to be
different with sa1100 serial driver one.

Signed-off-by: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
---
 drivers/serial/pnx8xxx_uart.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/serial/pnx8xxx_uart.c b/drivers/serial/pnx8xxx_uart.c
index 22e30d2..96870f1 100644
--- a/drivers/serial/pnx8xxx_uart.c
+++ b/drivers/serial/pnx8xxx_uart.c
@@ -34,9 +34,8 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-/* We'll be using StrongARM sa1100 serial port major/minor */
 #define SERIAL_PNX8XXX_MAJOR	204
-#define MINOR_START		5
+#define MINOR_START		96
 
 #define NR_PORTS		2
 
@@ -636,7 +635,7 @@ static struct uart_ops pnx8xxx_pops = {
 /*
  * Setup the PNX8XXX serial ports.
  *
- * Note also that we support "console=ttySx" where "x" is either 0 or 1.
+ * Note also that we support "console=ttyPNXx" where "x" is either 0 or 1.
  */
 static void __init pnx8xxx_init_ports(void)
 {
@@ -728,7 +727,7 @@ pnx8xxx_console_setup(struct console *co, char *options)
 
 static struct uart_driver pnx8xxx_reg;
 static struct console pnx8xxx_console = {
-	.name		= "ttyS",
+	.name		= "ttyPNX",
 	.write		= pnx8xxx_console_write,
 	.device		= uart_console_device,
 	.setup		= pnx8xxx_console_setup,
@@ -752,8 +751,8 @@ console_initcall(pnx8xxx_rs_console_init);
 
 static struct uart_driver pnx8xxx_reg = {
 	.owner			= THIS_MODULE,
-	.driver_name		= "ttyS",
-	.dev_name		= "ttyS",
+	.driver_name		= "ttyPNX",
+	.dev_name		= "ttyPNX",
 	.major			= SERIAL_PNX8XXX_MAJOR,
 	.minor			= MINOR_START,
 	.nr			= NR_PORTS,
-- 
1.5.6.3
