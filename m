Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 21:20:52 +0100 (BST)
Received: from rs25s12.datacenter.cha.cantv.net ([200.44.33.43]:13731 "EHLO
	rs25s12.datacenter.cha.cantv.net") by ftp.linux-mips.org with ESMTP
	id S20027134AbXIYUUm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 21:20:42 +0100
Received: from [192.168.0.2] (dC9D0EE2C.dslam-04-10-6-02-1-01.apr.dsl.cantv.net [201.208.238.44])
	by rs25s12.datacenter.cha.cantv.net (8.13.8/8.13.0/3.0) with ESMTP id l8PKJSL5008158;
	Tue, 25 Sep 2007 16:19:28 -0400
X-Matched-Lists: []
Message-ID: <46F93692.4050801@kanux.com>
Date:	Tue, 25 Sep 2007 12:25:54 -0400
From:	Ricardo Mendoza <ricmm@kanux.com>
User-Agent: Thunderbird 2.0.0.0 (X11/20070601)
MIME-Version: 1.0
To:	Martin Michlmayr <tbm@cyrius.com>
CC:	linux-mips@linux-mips.org
Subject: Re: IP32: serial console broken with current git
References: <20070925182453.GA15749@deprecation.cyrius.com>
In-Reply-To: <20070925182453.GA15749@deprecation.cyrius.com>
Content-Type: multipart/mixed;
 boundary="------------020803070603070808070001"
X-Virus-Scanned: ClamAV version 0.91.2, clamav-milter version 0.91.2 on 10.128.1.89
X-Virus-Status:	Clean
Return-Path: <ricmm@kanux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@kanux.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020803070603070808070001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Martin Michlmayr wrote:
> With current git (and 2.6.23-rc1), nothing shows up on the serial
> console on IP32.  Ricardo Mendoza commented on this on IRC:
> 
>> I think it was that using iobase member in the plat_serial8250_port
>> struct was not working, swapping to membase gave console messages
>> but kind of stopped printing messages at some point (further in than
>> first line of C tho)
> 
> He also sent me a patch to test.  With this patch, I get serial
> console output - but only until:
> 
> | Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> | serial8250.0: ttyS0 at MMIO 0x0 (irq = 53) is a 16550A
> | console [ttyS0] enabled
> 
> Maybe Ricardo can post his patch for comments and someone can look
> into the second issue.


The patch is the following, please ignore the rewrite of the MACE_PORT
specifications, those are not needed (I don't remember why I did that at
all).

As Martin said, the output stops on the 'console [ttyS0] enabled'
message. I don't know much about the serial code internals but I presume
something is getting trashed on the console setup.. or perhaps it's just
something really dumb like a missing call or something. Someone
enlightened in the issue can perhaps shed a light.


     Ricardo



--------------020803070603070808070001
Content-Type: text/x-patch;
 name="plat_dev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="plat_dev.patch"

diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
index ba3697e..6ad2ecc 100644
--- a/arch/mips/sgi-ip32/ip32-platform.c
+++ b/arch/mips/sgi-ip32/ip32-platform.c
@@ -10,25 +10,29 @@
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 
+#include <asm/addrspace.h>
 #include <asm/ip32/mace.h>
 #include <asm/ip32/ip32_ints.h>
 
-/*
- * .iobase isn't a constant (in the sense of C) so we fill it in at runtime.
- */
-#define MACE_PORT(int)							\
-{									\
-	.irq		= int,						\
-	.uartclk	= 1843200,					\
-	.iotype		= UPIO_MEM,					\
-	.flags		= UPF_SKIP_TEST,				\
-	.regshift	= 8,						\
-}
 
 static struct plat_serial8250_port uart8250_data[] = {
-	MACE_PORT(MACEISA_SERIAL1_IRQ),
-	MACE_PORT(MACEISA_SERIAL2_IRQ),
-	{ },
+	[0] = {
+		.irq            = MACEISA_SERIAL1_IRQ,
+	        .uartclk        = 1843200,
+        	.iotype         = UPIO_MEM,
+	        .flags          = UPF_SKIP_TEST,
+        	.regshift       = 8,
+	},
+	[1] = {
+                .irq            = MACEISA_SERIAL2_IRQ,
+                .uartclk        = 1843200,
+                .iotype         = UPIO_MEM,
+                .flags          = UPF_SKIP_TEST,
+                .regshift       = 8,
+	},
+	{
+		0,
+	},
 };
 
 static struct platform_device uart8250_device = {
@@ -41,8 +45,8 @@ static struct platform_device uart8250_device = {
 
 static int __init uart8250_init(void)
 {
-	uart8250_data[0].iobase = (unsigned long) &mace->isa.serial1;
-	uart8250_data[1].iobase = (unsigned long) &mace->isa.serial1;
+	uart8250_data[0].membase = (char *) &mace->isa.serial1;
+	uart8250_data[1].membase = (char *) &mace->isa.serial2;
 
 	return platform_device_register(&uart8250_device);
 }


--------------020803070603070808070001--
