Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g03LaDs28134
	for linux-mips-outgoing; Thu, 3 Jan 2002 13:36:13 -0800
Received: from gw-nl5.philips.com (gw-nl5.philips.com [212.153.235.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g03La9g28131
	for <linux-mips@oss.sgi.com>; Thu, 3 Jan 2002 13:36:09 -0800
Received: from smtpscan-nl4.philips.com (localhost.philips.com [127.0.0.1])
          by gw-nl5.philips.com with ESMTP id VAA21287
          for <linux-mips@oss.sgi.com>; Thu, 3 Jan 2002 21:36:05 +0100 (MET)
          (envelope-from balaji.ramalingam@philips.com)
From: balaji.ramalingam@philips.com
Received: from smtpscan-nl4.philips.com(130.139.36.24) by gw-nl5.philips.com via mwrap (4.0a)
	id xma021285; Thu, 3 Jan 02 21:36:05 +0100
Received: from smtprelay-us1.philips.com (localhost [127.0.0.1]) 
	by smtpscan-nl4.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id VAA26138
	for <linux-mips@oss.sgi.com>; Thu, 3 Jan 2002 21:36:04 +0100 (MET)
Received: from arj001soh.diamond.philips.com (amsoh01.diamond.philips.com [161.88.79.212]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id OAA21440
	for <linux-mips@oss.sgi.com>; Thu, 3 Jan 2002 14:36:03 -0600 (CST)
Subject: can't access tty
To: linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF4E0B0951.73B94A95-ON88256B36.0070ACD7@diamond.philips.com>
Date: Thu, 3 Jan 2002 12:36:54 -0800
X-MIMETrack: Serialize by Router on arj001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 03/01/2002 14:39:50
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hello,

I had been trying to get the linux kernel 2.4.3 on our
latest mips core which is mips32 ISA complient.

Finally I was able to boot the kernel. Also /bin/sh executes
but gives the following message and a prompt. Everything
freezes thereafter.

sh: can't access tty; Job control turned off
#


I dont know if its a problem with the serial driver or the keyboard
driver. I'm using the ttyS0 as the console and I think its working
fine. I dont know how to check that the keyboard is working fine.

Any tips ??

Thanks in advance.

regards,
Balaji
