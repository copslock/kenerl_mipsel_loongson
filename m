Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Aug 2004 17:34:56 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.130] ([IPv6:::ffff:145.253.187.130]:39689
	"EHLO proxy.baslerweb.com") by linux-mips.org with ESMTP
	id <S8224931AbUHFQew>; Fri, 6 Aug 2004 17:34:52 +0100
Received: from comm1.baslerweb.com (proxy.baslerweb.com [172.16.13.2])
          by proxy.baslerweb.com (Post.Office MTA v3.5.3 release 223
          ID# 0-0U10L2S100V35) with ESMTP id com
          for <linux-mips@linux-mips.org>; Fri, 6 Aug 2004 18:34:04 +0200
Received: from [172.16.13.253] (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id PLG5QZ4Y; Fri, 6 Aug 2004 18:34:50 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: [PATCH] yosemite serial support
Date: Fri, 6 Aug 2004 18:36:24 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408061836.24385.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi,

the patch below adds support for the second serial
port on the PMC-Sierra Yosemite board.

tk

--- linux-mips/arch/mips/pmc-sierra/yosemite/setup.c    2004-07-20 11:43:44.000000000 +0200
+++ linux-mips-work/arch/mips/pmc-sierra/yosemite/setup.c       2004-08-06 18:30:55.518022384 +0200
@@ -156,11 +156,13 @@
 #define TITAN_UART_CLK         3686400
 #define TITAN_SERIAL_BASE_BAUD (TITAN_UART_CLK / 16)
 #define TITAN_SERIAL_IRQ       4
-#define TITAN_SERIAL_BASE      0xfd000008UL
+#define TITAN_SERIAL_BASE      0xfd000000UL
+#define TITAN_SERIAL_REG_SIZE  8

 static void __init py_map_ocd(void)
 {
-        struct uart_port up;
+       struct uart_port up;
+       static const char serr[] = KERN_ERR "Early serial init of port %u failed\n";

        /*
         * Not specifically interrupt stuff but in case of SMP core_send_ipi
@@ -171,20 +173,26 @@
                panic("Mapping OCD failed - game over.  Your score is 0.");

        /*
-        * Register to interrupt zero because we share the interrupt with
-        * the serial driver which we don't properly support yet.
+        * Set up serial port #1. Do not use autodetection; the result is
+        * not what we want.
         */
        memset(&up, 0, sizeof(up));
-       up.membase      = (unsigned char *) ioremap(TITAN_SERIAL_BASE, 8);
+       up.membase      = (unsigned char *) ioremap(TITAN_SERIAL_BASE, TITAN_SERIAL_REG_SIZE * 2);
        up.irq          = TITAN_SERIAL_IRQ;
        up.uartclk      = TITAN_UART_CLK;
        up.regshift     = 0;
        up.iotype       = UPIO_MEM;
-       up.flags        = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
-       up.line         = 0;
+       up.flags        = UPF_SHARE_IRQ;
+       up.line         = 1;
+       up.type         = PORT_16550A;
+       if (!up.membase || early_serial_setup(&up))
+               printk(serr, up.line);

+       /* And now for port #0. */
+       up.membase      += TITAN_SERIAL_REG_SIZE;
+       up.line         = 0;
        if (early_serial_setup(&up))
-               printk(KERN_ERR "Early serial init of port 0 failed\n");
+               printk(serr, up.line);
 }

 static int __init pmc_yosemite_setup(void)

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
