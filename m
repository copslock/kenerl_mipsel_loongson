Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6N7DCi12111
	for linux-mips-outgoing; Mon, 23 Jul 2001 00:13:12 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6N7DBV12108
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 00:13:11 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id AAA05617
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 00:12:52 -0700 (PDT)
	mail_from (kaos@melbourne.sgi.com)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id RAA28097; Mon, 23 Jul 2001 17:11:38 +1000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@melbourne.sgi.com>
To: Barry Wu <wqb123@yahoo.com>
cc: linux-mips@oss.sgi.com
Subject: Re: about serial console problem 
In-reply-to: Your message of "Sun, 22 Jul 2001 23:51:25 MST."
             <20010723065125.26642.qmail@web13905.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Jul 2001 17:11:38 +1000
Message-ID: <13590.995872298@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 22 Jul 2001 23:51:25 -0700 (PDT), 
Barry Wu <wqb123@yahoo.com> wrote:
>I am porting linux 2.4.3 to our mipsel evaluation
>board. Now I meet a problem. Because I use edown
>to download the linux kernel to evaluation board.
>I update the serial baud rate to 115200.
>I use serial 0 as our console, and I can use
>printk to print debug messages on serial port.
>But after kernel call /sbin/init, I can not
>see "INIT ...  ..." messages on serial port.

Probably you did not code the console boot parameters correctly.  In
LILO, append="console=tty0 console=ttyS0,115200".  printk is written to
all consoles, init messages are only written to the last console
specified.
