Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 10:38:29 +0100 (BST)
Received: from [IPv6:::ffff:194.217.161.2] ([IPv6:::ffff:194.217.161.2]:48280
	"EHLO wolfsonmicro.com") by linux-mips.org with ESMTP
	id <S8225072AbTGPJiX>; Wed, 16 Jul 2003 10:38:23 +0100
Received: from campbeltown.wolfson.co.uk (campbeltown [192.168.0.166])
	by wolfsonmicro.com (8.11.3/8.11.3) with ESMTP id h6G9c9e23423
	for <linux-mips@linux-mips.org>; Wed, 16 Jul 2003 10:38:10 +0100 (BST)
Received: from caernarfon (unverified) by campbeltown.wolfson.co.uk
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T63771a1cfbc0a800a6414@campbeltown.wolfson.co.uk> for <linux-mips@linux-mips.org>;
 Wed, 16 Jul 2003 10:39:22 +0100
Subject: [PATCH] [2.6.0-test1] Alchemy Pb1500 - Power management
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Message-Id: <1058348289.10765.1527.camel@caernarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Jul 2003 10:38:09 +0100
Content-Transfer-Encoding: 7bit
Return-Path: <liam.girdwood@wolfsonmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liam.girdwood@wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm working my way through building the latest CVS for my Pb1500 and
I've run into a couple of build problems.

This patch fixes some function naming problems and removes duplicate
symbol au1k_wait() (defined in kernel/cpu-probe.c) in the Pb1500 power
management code.

Index: arch/mips/au1000/common/power.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/common/power.c,v
retrieving revision 1.10
diff -r1.10 power.c
36a37
> #include <linux/jiffies.h>
54,55c55,56
< extern void set_au1000_speed(unsigned int new_freq);
< extern unsigned int get_au1000_speed(void);
---
> extern void set_au1x00_speed(unsigned int new_freq);
> extern unsigned int get_au1x00_speed(void);
190,191c191,192
< 		old_baud_base = get_au1000_uart_baud_base();
< 		old_cpu_freq = get_au1000_speed();
---
> 		old_baud_base = get_au1x00_uart_baud_base();
> 		old_cpu_freq = get_au1x00_speed();
195,196c196,197
< 		set_au1000_speed(new_cpu_freq);
< 		set_au1000_uart_baud_base(new_baud_base);
---
> 		set_au1x00_speed(new_cpu_freq);
> 		set_au1x00_uart_baud_base(new_baud_base);
325,329d325
< }
< 
< void au1k_wait(void)
< {
< 	__asm__("nop\n\t" "nop\n\t");


Liam

-- 
Liam Girdwood <liam.girdwood@wolfsonmicro.com>



Wolfson Microelectronics plc
http://www.wolfsonmicro.com
t: +44 131 272-7000
f: +44 131 272-7001
Registered in Scotland 89839

This message may contain confidential or proprietary information. If you receive this message in error, please
immediately delete it, destroy all copies of it and notify the sender. Any views expressed in this message are those of the individual sender,
except where the message states otherwise. We take reasonable precautions to ensure our Emails are virus free.
However, we cannot accept responsibility for any virus transmitted by us
and recommend that you subject any incoming Email to your own virus
checking procedures.
