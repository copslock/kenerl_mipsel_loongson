Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2006 23:21:37 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:36804 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133865AbWFBVVW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Jun 2006 23:21:22 +0200
Received: (qmail 23058 invoked from network); 3 Jun 2006 01:30:02 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 3 Jun 2006 01:30:02 -0000
Message-ID: <4480AB90.8020203@ru.mvista.com>
Date:	Sat, 03 Jun 2006 01:20:16 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Jordan Crouse <jordan.crouse@amd.com>
Subject: [PATCH] arch/mips/au1000/common/time.c cleanup (take 2)
References: <436FB625.2000302@ru.mvista.com>
In-Reply-To: <436FB625.2000302@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------080908020005010903040001"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080908020005010903040001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

    Au1xx0 CPU counter ticks at the full CPU clock speed, not at the halved
one -- this is not an issue with the current kernel since Alchemy uses its own
timer handler here which pays no attention to mips_hpt_frequency.
    Additionally, mark au1xxx_timer_setup() __init because it is, get rid of
unneeded externs (note that (*do_gettimeoffset)() is already declared by
<asm/time.c>) and an unused variable, and kill some whitespace...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------080908020005010903040001
Content-Type: text/plain;
 name="Au1xx0-fix-counter-frequency.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1xx0-fix-counter-frequency.patch"

Index: linux-mips/arch/mips/au1000/common/time.c
===================================================================
--- linux-mips.orig/arch/mips/au1000/common/time.c
+++ linux-mips/arch/mips/au1000/common/time.c
@@ -50,10 +50,6 @@
 #include <linux/mc146818rtc.h>
 #include <linux/timex.h>
 
-extern void do_softirq(void);
-extern volatile unsigned long wall_jiffies;
-unsigned long missed_heart_beats = 0;
-
 static unsigned long r4k_offset; /* Amount to increment compare reg each time */
 static unsigned long r4k_cur;    /* What counter should be at next timer irq */
 int	no_au1xxx_32khz;
@@ -287,7 +283,6 @@ unsigned long cal_r4koff(void)
 #else
 		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) *
 			AU1000_SRC_CLK;
-		count = cpu_speed / 2;
 #endif
 	}
 	else {
@@ -296,10 +291,9 @@ unsigned long cal_r4koff(void)
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
@@ -388,10 +382,9 @@ static unsigned long do_fast_pm_gettimeo
 }
 #endif
 
-void au1xxx_timer_setup(struct irqaction *irq)
+void __init au1xxx_timer_setup(struct irqaction *irq)
 {
-        unsigned int est_freq;
-	extern unsigned long (*do_gettimeoffset)(void);
+	unsigned int est_freq;
 
 	printk("calculating r4koff... ");
 	r4k_offset = cal_r4koff();





--------------080908020005010903040001--
