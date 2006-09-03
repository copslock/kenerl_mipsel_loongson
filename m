Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Sep 2006 19:16:32 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:57676 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039007AbWICSQ1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Sep 2006 19:16:27 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CCD9B3ECE; Sun,  3 Sep 2006 11:16:04 -0700 (PDT)
Message-ID: <44FB1C26.10402@ru.mvista.com>
Date:	Sun, 03 Sep 2006 22:17:10 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manish Lachwani <mlachwani@mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Au1xx0 code sets incorrect mips_hpt_frequency
References: <436FB625.2000302@ru.mvista.com> <4480AB90.8020203@ru.mvista.com>
In-Reply-To: <4480AB90.8020203@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------080102080909070809080704"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080102080909070809080704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alchemy CPU counter ticks at the full CPU clock speed, not at the halved one 
-- this is not an issue with the current kernel since Alchemy uses its own 
timer handler here which pays no attention to mips_hpt_frequency.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
I joined this fix to the arch/mips/au1000/common/time.c cleanup patch 
previously but its earlier verison has been finally committed, so here's the 
recast which fixes the warning about the 'count' variable being unused...


--------------080102080909070809080704
Content-Type: text/plain;
 name="Au1xx0-fix-counter-frequency.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1xx0-fix-counter-frequency.patch"

Index: linux-mips/arch/mips/au1000/common/time.c
===================================================================
--- linux-mips.orig/arch/mips/au1000/common/time.c
+++ linux-mips/arch/mips/au1000/common/time.c
@@ -231,7 +231,6 @@ wakeup_counter0_set(int ticks)
  */
 unsigned long cal_r4koff(void)
 {
-	unsigned long count;
 	unsigned long cpu_speed;
 	unsigned long flags;
 	unsigned long counter;
@@ -258,7 +257,7 @@ unsigned long cal_r4koff(void)
 
 #if defined(CONFIG_AU1000_USE32K)
 		{
-			unsigned long start, end;
+			unsigned long start, end, count;
 
 			start = au_readl(SYS_RTCREAD);
 			start += 2;
@@ -282,7 +281,6 @@ unsigned long cal_r4koff(void)
 #else
 		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) *
 			AU1000_SRC_CLK;
-		count = cpu_speed / 2;
 #endif
 	}
 	else {
@@ -291,10 +289,9 @@ unsigned long cal_r4koff(void)
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


--------------080102080909070809080704--
