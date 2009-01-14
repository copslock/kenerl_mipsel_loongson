Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2009 13:55:51 +0000 (GMT)
Received: from yw-out-1718.google.com ([74.125.46.158]:52130 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S21365750AbZANNzo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Jan 2009 13:55:44 +0000
Received: by yw-out-1718.google.com with SMTP id 9so200704ywk.24
        for <linux-mips@linux-mips.org>; Wed, 14 Jan 2009 05:55:41 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=pae7GQIf1G2edhxm2QW2xBMtSItzIXj2ulDnj/vs6es=;
        b=XqZgo7ZWPqK46HyBrXKtTU0uk4qbkG/6X/hYKEraEN5w8cWDc/zkytCf70vmaVkPzc
         k3TbQO8Kz/ni7K9RU5N653pv8uMF2hwxeklB4IPIW16Fs3y6R+4hK6JiEG3m91qE+p5k
         g0dJa6aBtzqjDWMPWvbyrAwVKXwqGveYyEHww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=I+L2NV5fDG5MbbVMhx15gbryBGVus5j2eyhx7liJ8J06+/BhRZgRYf4FNSYDiv3Vnp
         ZiwtPifMBOEt2uaQsL78rAiJO/hhm212+WFEoH14i2B9UtJAP4Lqfpo1fxsF5ORJA7+G
         KozN+QlsrYZmPgW0BUHXTm2eOBH7ZmK8QIrEs=
Received: by 10.100.3.13 with SMTP id 13mr93889anc.26.1231941341082;
        Wed, 14 Jan 2009 05:55:41 -0800 (PST)
Received: from ?10.6.11.31? (cpmsq.epam.com [217.21.56.2])
        by mx.google.com with ESMTPS id d12sm27840221and.2.2009.01.14.05.55.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Jan 2009 05:55:40 -0800 (PST)
Subject: [PATCH] Don't use ttyS* serial device name for board specific
 PNX8XXX UART serial
From:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Wed, 14 Jan 2009 15:55:38 +0200
Message-Id: <1231941338.7186.3.camel@EPBYMINW0568>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.2 
Content-Transfer-Encoding: 7bit
Return-Path: <ihar.hrachyshka@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihar.hrachyshka@gmail.com
Precedence: bulk
X-list: linux-mips

Don't use ttyS* serial device name for board specific PNX8XXX UART
serial. Rather create ttySA* to reflect that the driver uses device with
major:minor numbers for SA1100 serial driver.

Signed-off-by: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
---
 drivers/serial/pnx8xxx_uart.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/pnx8xxx_uart.c b/drivers/serial/pnx8xxx_uart.c
index 22e30d2..6785ee9 100644
--- a/drivers/serial/pnx8xxx_uart.c
+++ b/drivers/serial/pnx8xxx_uart.c
@@ -636,7 +636,7 @@ static struct uart_ops pnx8xxx_pops = {
 /*
  * Setup the PNX8XXX serial ports.
  *
- * Note also that we support "console=ttySx" where "x" is either 0 or 1.
+ * Note also that we support "console=ttySAx" where "x" is either 0 or 1.
  */
 static void __init pnx8xxx_init_ports(void)
 {
@@ -728,7 +728,7 @@ pnx8xxx_console_setup(struct console *co, char *options)
 
 static struct uart_driver pnx8xxx_reg;
 static struct console pnx8xxx_console = {
-	.name		= "ttyS",
+	.name		= "ttySA",
 	.write		= pnx8xxx_console_write,
 	.device		= uart_console_device,
 	.setup		= pnx8xxx_console_setup,
@@ -752,8 +752,8 @@ console_initcall(pnx8xxx_rs_console_init);
 
 static struct uart_driver pnx8xxx_reg = {
 	.owner			= THIS_MODULE,
-	.driver_name		= "ttyS",
-	.dev_name		= "ttyS",
+	.driver_name		= "ttySA",
+	.dev_name		= "ttySA",
 	.major			= SERIAL_PNX8XXX_MAJOR,
 	.minor			= MINOR_START,
 	.nr			= NR_PORTS,
-- 
1.5.6.3
