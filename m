Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2006 16:24:05 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:42642 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133565AbWFXPX4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jun 2006 16:23:56 +0100
Received: (qmail 14170 invoked from network); 24 Jun 2006 19:35:34 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 24 Jun 2006 19:35:34 -0000
Message-ID: <449D58B2.4060802@ru.mvista.com>
Date:	Sat, 24 Jun 2006 19:22:26 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Alchemy counter runs at full CPU speed
References: <436FB625.2000302@ru.mvista.com>
In-Reply-To: <436FB625.2000302@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------010001020504040509060708"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010001020504040509060708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Au1xx0 CPU counter ticks at the full CPU clock speed, not at the halved one. 
This is not an issue with the current kernel since Alchemy uses its own timer 
handler here which pays no attention to mips_hpt_frequency, so this is a 
cleanup type patch (though our kernel had its clock ticking at double speed 
because of this :-).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------010001020504040509060708
Content-Type: text/plain;
 name="Au1xx0-fix-counter-frequency.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1xx0-fix-counter-frequency.patch"

Index: linux-mips/arch/mips/au1000/common/time.c
===================================================================
--- linux-mips.orig/arch/mips/au1000/common/time.c
+++ linux-mips/arch/mips/au1000/common/time.c
@@ -287,7 +287,6 @@ unsigned long cal_r4koff(void)
 #else
 		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) *
 			AU1000_SRC_CLK;
-		count = cpu_speed / 2;
 #endif
 	}
 	else {
@@ -296,10 +295,9 @@ unsigned long cal_r4koff(void)
 		 * NOTE: some old silicon doesn't allow reading the PLL.
 		 */
 		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) * AU1000_SRC_CLK;
-		count = cpu_speed / 2;
 		no_au1xxx_32khz = 1;
 	}
-	mips_hpt_frequency = count;
+	mips_hpt_frequency = cpu_speed;
 	// Equation: Baudrate = CPU / (SD * 2 * CLKDIV * 16)
 	set_au1x00_uart_baud_base(cpu_speed / (2 * ((int)(au_readl(SYS_POWERCTRL)&0x03) + 2) * 16));
 	spin_unlock_irqrestore(&time_lock, flags);


--------------010001020504040509060708--
