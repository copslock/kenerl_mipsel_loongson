Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2003 11:58:10 +0100 (BST)
Received: from [IPv6:::ffff:194.217.161.2] ([IPv6:::ffff:194.217.161.2]:12493
	"EHLO wolfsonmicro.com") by linux-mips.org with ESMTP
	id <S8225201AbTGQK6I>; Thu, 17 Jul 2003 11:58:08 +0100
Received: from campbeltown.wolfson.co.uk (campbeltown [192.168.0.166])
	by wolfsonmicro.com (8.11.3/8.11.3) with ESMTP id h6HAw0e22621
	for <linux-mips@linux-mips.org>; Thu, 17 Jul 2003 11:58:00 +0100 (BST)
Received: from caernarfon (unverified) by campbeltown.wolfson.co.uk
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T637c89a5ecc0a800a6414@campbeltown.wolfson.co.uk> for <linux-mips@linux-mips.org>;
 Thu, 17 Jul 2003 11:59:17 +0100
Subject: [PATCH] 2.4 Alchemy Power management.
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Message-Id: <1058439479.10765.1661.camel@caernarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 17 Jul 2003 11:58:00 +0100
Content-Transfer-Encoding: 7bit
Return-Path: <liam.girdwood@wolfsonmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liam.girdwood@wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

Hi,

This patch fixes some link errors with alchemy power management.

Index: arch/mips/au1000/common/power.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/common/power.c,v
retrieving revision 1.2.2.7
diff -r1.2.2.7 power.c
55,58c55,58
< extern void set_au1000_speed(unsigned int new_freq);
< extern unsigned int get_au1000_speed(void);
< extern unsigned long get_au1000_uart_baud_base(void);
< extern void set_au1000_uart_baud_base(unsigned long new_baud_base);
---
> extern void set_au1x00_speed(unsigned int new_freq);
> extern unsigned int get_au1x00_speed(void);
> extern unsigned long get_au1x00_uart_baud_base(void);
> extern void set_au1x00_uart_baud_base(unsigned long new_baud_base);
191,192c191,192
<               old_baud_base = get_au1000_uart_baud_base();
<               old_cpu_freq = get_au1000_speed();
---
>               old_baud_base = get_au1x00_uart_baud_base();
>               old_cpu_freq = get_au1x00_speed();
196,197c196,197
<               set_au1000_speed(new_cpu_freq);
<               set_au1000_uart_baud_base(new_baud_base);
---
>               set_au1x00_speed(new_cpu_freq);
>               set_au1x00_uart_baud_base(new_baud_base);
326,330d325
< }
<
< void au1k_wait(void)
< {
<       __asm__("nop\n\t" "nop\n\t");

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
