Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 13:39:49 +0100 (BST)
Received: from [IPv6:::ffff:194.217.161.2] ([IPv6:::ffff:194.217.161.2]:33723
	"EHLO wolfsonmicro.com") by linux-mips.org with ESMTP
	id <S8225072AbTGPMjr>; Wed, 16 Jul 2003 13:39:47 +0100
Received: from campbeltown.wolfson.co.uk (campbeltown [192.168.0.166])
	by wolfsonmicro.com (8.11.3/8.11.3) with ESMTP id h6GCdae07651
	for <linux-mips@linux-mips.org>; Wed, 16 Jul 2003 13:39:36 +0100 (BST)
Received: from caernarfon (unverified) by campbeltown.wolfson.co.uk
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T6377c04222c0a800a6414@campbeltown.wolfson.co.uk> for <linux-mips@linux-mips.org>;
 Wed, 16 Jul 2003 13:40:50 +0100
Subject: [PATCH] [2.60-test1] Alchemy UART build problems
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Message-Id: <1058359177.10765.1568.camel@caernarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Jul 2003 13:39:37 +0100
Content-Transfer-Encoding: 7bit
Return-Path: <liam.girdwood@wolfsonmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liam.girdwood@wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

Hi,

I've found some function/type naming errors within the Alchemy serial
driver. Patch below.


Index: drivers/serial/au1x00_uart.c
===================================================================
RCS file: /home/cvs/linux/drivers/serial/au1x00_uart.c,v
retrieving revision 1.1
diff -r1.1 au1x00_uart.c
1079c1079
< 		up->port.irq      = irq_cannonicalize(old_serial_port[i].irq);
---
> 		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
1307c1307
< int __init early_serial_setup(struct serial_struct *req)
---
> int __init early_serial_setup(struct uart_port *req)


There is also a reference to a non existant member called change_speed
of struct uart_ops on line 1055 i.e. 

	.change_speed	= serial_au1x00_change_speed,

This builds if it is commented out, however serial_au1x00_change_speed()
is not called anywhere in the driver and the change_speed member is not
used anywhere else in the kernel!

It looks like this file is still in transition between 2.4 and 2.6 as
the 2.4 driver works fine. Does anyone have a working 2.5/2.6 Alchemy
uart driver ?

Thanks

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
