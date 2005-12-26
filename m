Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Dec 2005 22:21:11 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:27322 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133530AbVLZWUx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Dec 2005 22:20:53 +0000
Received: (qmail 10330 invoked from network); 26 Dec 2005 22:22:29 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 26 Dec 2005 22:22:29 -0000
Message-ID: <43B06DB4.409@ru.mvista.com>
Date:	Tue, 27 Dec 2005 01:24:52 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	rmk+serial@arm.linux.org.uk
CC:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp
Subject: [PATCH] serial_txx9: forcibly init the spinlock for PCI UART used
 as a console
Content-Type: multipart/mixed;
 boundary="------------060002020409050600060303"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060002020409050600060303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

        When a system console gets assigned to the UART located on the Toshiba
GOKU-S PCI card, the port spinlock is not initialized at all --
uart_add_one_port() thinks it's been initialized by the console setup code
which is called too early for being able to do that, before the PCI card is
even detected by the driver, and therefore fails. That unitialized spinlock
causes 3 BUG messages in the boot log with Ingo Molnar's RT preemption patch
as uart_add_one_port() called to register PCI UART with the serial core calls
uart_configure_port() which makes use of the port spinlock.

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------060002020409050600060303
Content-Type: text/plain;
 name="GOKU-console-spinlock-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="GOKU-console-spinlock-fix.patch"

diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
index f10c86d..3f8dc41 100644
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -1065,6 +1065,14 @@ static int __devinit serial_txx9_registe
 		uart->port.mapbase  = port->mapbase;
 		if (port->dev)
 			uart->port.dev = port->dev;
+
+		/*
+		 * If this port is a console, its spinlock couldn't have been
+		 * initialized by serial_txx9_console_setup() and it won't be
+		 * initialized by uart_add_one_port(), so have to do it here...
+		 */
+		spin_lock_init(&uart->port.lock);
+
 		ret = uart_add_one_port(&serial_txx9_reg, &uart->port);
 		if (ret == 0)
 			ret = uart->port.line;





--------------060002020409050600060303--
