Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQM5id25708
	for linux-mips-outgoing; Mon, 26 Nov 2001 14:05:44 -0800
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQM5eo25705
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 14:05:40 -0800
Received: from [192.168.1.233] (192.168.1.233 [192.168.1.233]) by mail.ivivity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2448.0)
	id QMJCN984; Mon, 26 Nov 2001 16:05:33 -0500
Subject: Serial Console on Malta broken?
From: Marc Karasek <marc_karasek@ivivity.com>
To: Linux MIPS <linux-mips@oss.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 26 Nov 2001 16:05:43 -0500
Message-Id: <1006808755.7860.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I just got the latest source from the cvs server (2.4.14).  I am working
on the MALTA eval board from MIPS.  I noticed that the serial console is
very slow once it is initialized,  once it starts to print the "serial
concole detected" it slows down to a crawl.  Prints around 10+ char and
then pauses.  You can do a ls, etc...  but do not expect the output in
your lifetime. 

In debugging I noticed that the mipsIRQ.S file is no longer used for
interrupt handling.  Does anyone know why this was done?  I have
compared it to source from 2.4.3-01.01 (from the MIPS site).  I checked
the mailing list and there was some discussion about a similar bug that
had to do with the serial port and the interrupt not working right. 

Any enlightenment would be greatly appreciated.  We are looking to put a
stake in the ground as far as kernel version to start working with and
we need something that is post 2.4.10.  

-- 
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
