Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6N6pQn11239
	for linux-mips-outgoing; Sun, 22 Jul 2001 23:51:26 -0700
Received: from web13905.mail.yahoo.com (web13905.mail.yahoo.com [216.136.175.68])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6N6pPV11236
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 23:51:25 -0700
Message-ID: <20010723065125.26642.qmail@web13905.mail.yahoo.com>
Received: from [61.133.135.16] by web13905.mail.yahoo.com via HTTP; Sun, 22 Jul 2001 23:51:25 PDT
Date: Sun, 22 Jul 2001 23:51:25 -0700 (PDT)
From: Barry Wu <wqb123@yahoo.com>
Subject: about serial console problem
To: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi, all,

I am porting linux 2.4.3 to our mipsel evaluation
board. Now I meet a problem. Because I use edown
to download the linux kernel to evaluation board.
I update the serial baud rate to 115200.
I use serial 0 as our console, and I can use
printk to print debug messages on serial port.
But after kernel call /sbin/init, I can not
see "INIT ...  ..." messages on serial port.
I suppose perhaps I make some mistakes. But when
I use 2.2.12 kernel, it ok.
If someone knows, please help me. Thanks!

Barry

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
