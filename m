Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2005 20:13:49 +0000 (GMT)
Received: from [85.21.88.2] ([85.21.88.2]:45967 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133824AbVKGUNb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2005 20:13:31 +0000
Received: (qmail 6515 invoked from network); 7 Nov 2005 20:14:44 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 7 Nov 2005 20:14:44 -0000
Message-ID: <436FB625.2000302@ru.mvista.com>
Date:	Mon, 07 Nov 2005 23:16:37 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS Development <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>,
	Pete Popov <ppopov@embeddedalley.com>,
	Konstantin Baidarov <kbaidarov@ru.mvista.com>
Subject: [PATCH] arch/mips/au1000/time.c cleanup
Content-Type: multipart/mixed;
 boundary="------------050507000808090606070305"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050507000808090606070305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

       Mark au1xxx_timer_setup() __init, just because it is. Get rid of
unneeded extrns (note that (*do_gettimeoffset)() is already declared by
<asm/time.c>) and an unused variable. Kill some whitespace...

WBR, Sergei


--------------050507000808090606070305
Content-Type: text/plain;
 name="Au1xx0-time-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1xx0-time-cleanup.patch"

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Index: arch/mips/au1000/common/time.c
===================================================================
--- arch/mips/au1000/common/time.c~	19 Jul 2005 07:05:36 -0000
+++ arch/mips/au1000/common/time.c	1 Nov 2005 19:03:51 -0000
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
@@ -387,10 +383,9 @@ static unsigned long do_fast_pm_gettimeo
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



--------------050507000808090606070305--
