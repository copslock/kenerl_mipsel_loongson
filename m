Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 19:38:16 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:48853 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133819AbWDDSiH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Apr 2006 19:38:07 +0100
Received: (qmail 2243 invoked from network); 4 Apr 2006 22:50:11 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 4 Apr 2006 22:50:11 -0000
Message-ID: <4432BF48.8030403@ru.mvista.com>
Date:	Tue, 04 Apr 2006 22:47:36 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	rmk+serial@arm.linux.org.uk
CC:	linux-mips@linux-mips.org, jordan.crouse@amd.com
Subject: [PATCH] AMD Alchemy: claim UART memory range
Content-Type: multipart/mixed;
 boundary="------------090909080908000800020401"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090909080908000800020401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

      I've noticed that the 8250/Au1x00 driver (drivers/serial/8250_au1x00.c)
doesn't claim UART memory ranges and uses wrong (KSEG1-based) UART addresses
instead of the physical ones.

WBR, Sergei

Sighed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------090909080908000800020401
Content-Type: text/plain;
 name="Au1xx0-claim-UART-range.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1xx0-claim-UART-range.patch"

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 674b15c..d641ac4 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1906,6 +1906,9 @@ static int serial8250_request_std_resour
 	int ret = 0;
 
 	switch (up->port.iotype) {
+	case UPIO_AU:
+		size = 0x100000;
+		/* fall thru */
 	case UPIO_MEM:
 		if (!up->port.mapbase)
 			break;
@@ -1938,6 +1941,9 @@ static void serial8250_release_std_resou
 	unsigned int size = 8 << up->port.regshift;
 
 	switch (up->port.iotype) {
+	case UPIO_AU:
+		size = 0x100000;
+		/* fall thru */
 	case UPIO_MEM:
 		if (!up->port.mapbase)
 			break;
diff --git a/drivers/serial/8250_au1x00.c b/drivers/serial/8250_au1x00.c
index 3d1bfd0..58015fd 100644
--- a/drivers/serial/8250_au1x00.c
+++ b/drivers/serial/8250_au1x00.c
@@ -30,13 +30,12 @@
 	{						\
 		.iobase		= _base,		\
 		.membase	= (void __iomem *)_base,\
-		.mapbase	= _base,		\
+		.mapbase	= CPHYSADDR(_base),	\
 		.irq		= _irq,			\
 		.uartclk	= 0,	/* filled */	\
 		.regshift	= 2,			\
 		.iotype		= UPIO_AU,		\
-		.flags		= UPF_SKIP_TEST | 	\
-				  UPF_IOREMAP,		\
+		.flags		= UPF_SKIP_TEST 	\
 	}
 
 static struct plat_serial8250_port au1x00_data[] = {



--------------090909080908000800020401--
