Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0AEUSR11238
	for linux-mips-outgoing; Thu, 10 Jan 2002 06:30:28 -0800
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0AEUMg11235
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 06:30:22 -0800
Received: by ATLOPS with Internet Mail Service (5.5.2653.19)
	id <ZA0NHR4H>; Thu, 10 Jan 2002 08:30:13 -0500
Message-ID: <25369470B6F0D41194820002B328BDD2195B0E@ATLOPS>
From: Marc Karasek <marc_karasek@ivivity.com>
To: "'balaji.ramalingam@philips.com'" <balaji.ramalingam@philips.com>,
   linux-mips@oss.sgi.com
Subject: RE: linux on keyboardless system
Date: Thu, 10 Jan 2002 08:30:12 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

What are you using for init?  Is it busybox by chance.  If so there was a
bug in a past version that would cause this.  It had to do with not setting
CREAD properly I believe.

-----Original Message-----
From: balaji.ramalingam@philips.com
[mailto:balaji.ramalingam@philips.com]
Sent: Wednesday, January 09, 2002 8:17 PM
To: linux-mips@oss.sgi.com
Subject: linux on keyboardless system


Hello,

I'm tried booting linux 2.4.3 on my prototype system which does not have
a keyboard and a monitor. I used the uart as my serial device and passed on
the console=ttyS0(com1 in my pc) to the kernel. I can see the shell prompt
after the kernel
bootup but not able to enter anything after that.

So how can I use my pc keyboard to send characters to my uart?
I think I'm missing something here.
Can anyone give me some hint?
Thankyou in advance...


regards,
Balaji
