Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2007 13:06:46 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:8111 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022380AbXLCNGo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Dec 2007 13:06:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB3D5DtN006431;
	Mon, 3 Dec 2007 13:05:38 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB3D5DC5006430;
	Mon, 3 Dec 2007 13:05:13 GMT
Date:	Mon, 3 Dec 2007 13:05:13 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org, linux-serial@linux-mips.org
Subject: Rename Sibyte duart devices?
Message-ID: <20071203130512.GA6320@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Devices created by udev have been named duart? instead of the common
ttyS?.  This is a nuisance because it requires changes to all sorts of
config files such as /etc/inittab, /etc/securetty etc. to work.  I
suggest to kill the problem by the root by something like the below
patch.  Comments?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/serial/sb1250-duart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/sb1250-duart.c b/drivers/serial/sb1250-duart.c
index 2d6c08b..0defbd6 100644
--- a/drivers/serial/sb1250-duart.c
+++ b/drivers/serial/sb1250-duart.c
@@ -897,7 +897,7 @@ static int __init sbd_console_setup(struct console *co, char *options)
 
 static struct uart_driver sbd_reg;
 static struct console sbd_console = {
-	.name	= "duart",
+	.name	= "ttyS",
 	.write	= sbd_console_write,
 	.device	= uart_console_device,
 	.setup	= sbd_console_setup,
@@ -925,7 +925,7 @@ console_initcall(sbd_serial_console_init);
 static struct uart_driver sbd_reg = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "serial",
-	.dev_name	= "duart",
+	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= SB1250_DUART_MINOR_BASE,
 	.nr		= DUART_MAX_CHIP * DUART_MAX_SIDE,
