Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6NEU5Y02842
	for linux-mips-outgoing; Mon, 23 Jul 2001 07:30:05 -0700
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6NEU3V02824
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 07:30:03 -0700
Received: from [192.168.1.167] (192.168.1.167 [192.168.1.167]) by mail.ivivity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2448.0)
	id PJLG2B7W; Mon, 23 Jul 2001 10:29:56 -0400
Subject: Re: about serial console problem
From: Marc Karasek <marc_karasek@ivivity.com>
To: Barry Wu <wqb123@yahoo.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <20010723065125.26642.qmail@web13905.mail.yahoo.com>
References: <20010723065125.26642.qmail@web13905.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 23 Jul 2001 10:29:20 -0400
Message-Id: <995898583.1139.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This sounds like a problem I ran into on another processor/platform.
What are you using for a ramdisk?  Is it busybox?  There was a bug in
0.51 busybox that would not let it accept input from a console on a
serial port.  It had to do with the init for the serial port.  You can
check the patch file below to see the problem that was in busybox...

--- init.c.orig Sat Apr 21 17:46:57 2001
+++ init.c      Sat Apr 21 17:46:31 2001
@@ -276,7 +276,7 @@

        /* Make it be sane */
        tty.c_cflag &= CBAUD|CBAUDEX|CSIZE|CSTOPB|PARENB|PARODD;
-       tty.c_cflag |= HUPCL|CLOCAL;
+       tty.c_cflag |= CREAD|HUPCL|CLOCAL;

        /* input modes */
        tty.c_iflag = ICRNL | IXON | IXOFF;

On 22 Jul 2001 23:51:25 -0700, Barry Wu wrote:
> 
> Hi, all,
> 
> I am porting linux 2.4.3 to our mipsel evaluation
> board. Now I meet a problem. Because I use edown
> to download the linux kernel to evaluation board.
> I update the serial baud rate to 115200.
> I use serial 0 as our console, and I can use
> printk to print debug messages on serial port.
> But after kernel call /sbin/init, I can not
> see "INIT ...  ..." messages on serial port.
> I suppose perhaps I make some mistakes. But when
> I use 2.2.12 kernel, it ok.
> If someone knows, please help me. Thanks!
> 
> Barry
> 
> __________________________________________________
> Do You Yahoo!?
> Make international calls for as low as $.04/minute with Yahoo! Messenger
> http://phonecard.yahoo.com/
--
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
