Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 01:29:10 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:31623 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133530AbWAZB2v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 01:28:51 +0000
Received: (qmail 26675 invoked from network); 26 Jan 2006 01:33:14 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 26 Jan 2006 01:33:14 -0000
Message-ID: <43D82799.9000203@ru.mvista.com>
Date:	Thu, 26 Jan 2006 04:36:25 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Jordan Crouse <jordan.crouse@amd.com>, ralf@linux-mips.org
Subject: [PATCH] Make KGDB compile for AMD Au1200
Content-Type: multipart/mixed;
 boundary="------------090202040109050403050807"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090202040109050403050807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     Reposting the patch with sign-off...

     AMD Au1200 SOC just doesn't have UART3, so KGDB won't even compile for it
as is, here's the fix to make KGDB use UART1. Note that I haven't really
tested KGDB itself...

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------090202040109050403050807
Content-Type: text/plain;
 name="DBAu1200-fix-KGDB-UART.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DBAu1200-fix-KGDB-UART.patch"

diff --git a/include/asm-mips/mach-au1x00/au1000.h b/include/asm-mips/mach-au1x00/au1000.h
index 8e1d7ed..4686e17 100644
--- a/include/asm-mips/mach-au1x00/au1000.h
+++ b/include/asm-mips/mach-au1x00/au1000.h
@@ -1198,7 +1198,11 @@ extern au1xxx_irq_map_t au1xxx_irq_map[]
 
 /* UARTS 0-3 */
 #define UART_BASE                 UART0_ADDR
+#ifdef	CONFIG_SOC_AU1200
+#define UART_DEBUG_BASE           UART1_ADDR
+#else
 #define UART_DEBUG_BASE           UART3_ADDR
+#endif
 
 #define UART_RX		0	/* Receive buffer */
 #define UART_TX		4	/* Transmit buffer */




--------------090202040109050403050807--
