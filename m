Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6OFKOl18695
	for linux-mips-outgoing; Tue, 24 Jul 2001 08:20:24 -0700
Received: from web13903.mail.yahoo.com (web13903.mail.yahoo.com [216.136.175.29])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6OFKNO18690
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 08:20:23 -0700
Message-ID: <20010724152021.81248.qmail@web13903.mail.yahoo.com>
Received: from [61.133.136.12] by web13903.mail.yahoo.com; Tue, 24 Jul 2001 08:20:21 PDT
Date: Tue, 24 Jul 2001 08:20:21 -0700 (PDT)
From: Barry Wu <wqb123@yahoo.com>
Subject: Q: port serial driver from 2.2 to 2.4
To: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi, all,

I am porting serial console driver from kenel
2.2.12 to kernel 2.4.3. I can use printk and
prom_printf to print messages on serial terminal.
But when the kernel call autoconfig() function,
the output on serial terminal is stop. I check
the autoconfig() function, it stop at 
serial_outp(info, UART_LCR, 0xBF); /* set up for
StarTech test */
Why? If someone knows, please help me.
Thanks!

Barry

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
