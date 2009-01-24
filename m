Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2009 23:20:38 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:37595 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21366305AbZAXXUg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jan 2009 23:20:36 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id 84C1E8F849D;
	Sun, 25 Jan 2009 00:20:30 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uUijuvTGdGZo; Sun, 25 Jan 2009 00:20:29 +0100 (CET)
Received: from [10.1.1.26] (ip-77-25-15-184.web.vodafone.de [77.25.15.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id 82BC78F849C;
	Sun, 25 Jan 2009 00:20:27 +0100 (CET)
Subject: Re: Au1550 with kernel linux-2.6.28.1
From:	Frank Neuber <frank.neuber@kernelport.de>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1232787448.28527.302.camel@t60p>
References: <1232739600.28527.289.camel@t60p>
	 <20090124085734.5b6b5c66@scarran.roarinelk.net>
	 <1232787448.28527.302.camel@t60p>
Content-Type: text/plain
Date:	Sun, 25 Jan 2009 00:20:24 +0100
Message-Id: <1232839224.28527.336.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <frank.neuber@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.neuber@kernelport.de
Precedence: bulk
X-list: linux-mips

Hi Manuel,
after trying the standard early printk without luck I implemented my
own:
 
--- kernel/printk.c.orig        2009-01-24 23:48:08.000000000 +0100
+++ kernel/printk.c     2009-01-24 23:49:42.000000000 +0100
@@ -481,8 +481,30 @@
        _call_console_drivers(start_print, end, msg_level);
 }
 
+#include <linux/serial_8250.h>
+#include <asm/mach-au1x00/au1000.h>
+
+void serial_putc (const char c)
+{
+        volatile u32 *uart_lsr = (volatile u32*)(UART0_ADDR+UART_LSR);
+        volatile u32 *uart_tx = (volatile u32*)(UART0_ADDR+UART_TX);
+
+        if (c == '\n') serial_putc ('\r');
+
+        /* Wait for fifo to shift out some bytes */
+        while((*uart_lsr&UART_LSR_THRE)==0);
+
+        *uart_tx = (u32)c;
+}
+
 static void emit_log_char(char c)
 {
+#if 1
+        if (c == '\n'){
+                serial_putc('\r');
+        }
+        serial_putc(c);
+#endif
        LOG_BUF(log_end) = c;
        log_end++;
        if (log_end - log_start > log_buf_len)

The same result, I see nothing :-(

This means I run into trouble in the very early assembler part of the
kernel. I know the ARM kernel has some debug features implemented (using
the serial port).
Has the mips kernel a comparable debug possebility?

I striped down the defconfig as you sad and start the kernel using
uboot:

tc# bootm 0x80500000
## Booting image at 80500000 ...
   Image Name:   Linux-2.6.28.1
   Created:      2009-01-24  21:39:57 UTC
   Image Type:   MIPS Linux Kernel Image (gzip compressed)
   Data Size:    894213 Bytes = 873.3 kB
   Load Address: 80100000
   Entry Point:  80104690
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

Could the entry point be the problem? He is very close to the load
address. Because I have no JTAG for mips it is not easy to check what is
going on here .... 

Now I have no idea what can I do next ...

Kind Regards,
 Frank
