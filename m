Received:  by oss.sgi.com id <S554019AbRBOAW6>;
	Wed, 14 Feb 2001 16:22:58 -0800
Received: from ws149.wipro.com ([207.88.89.150]:35541 "EHLO
        santa.mail.wipro.com") by oss.sgi.com with ESMTP id <S554016AbRBOAWv>;
	Wed, 14 Feb 2001 16:22:51 -0800
Received: from webmail ([207.88.89.150]) by santa.mail.wipro.com
          (Netscape Messaging Server 3.6)  with SMTP id AAA7057;
          Wed, 14 Feb 2001 16:27:06 -0800
From:   deepa.suresh@wipro.com (Deepa  Suresh)
To:     linux-mips@oss.sgi.com
Cc:     deepa.suresh@wipro.com
X-Mailer: Netscape Messenger Express 3.5.2 [Mozilla/4.73 [en] (WinNT; I)]
Date:   Wed, 14 Feb 2001 16:27:06 -0800
Message-ID: <77452A3CA92.AAA7057@santa.mail.wipro.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hello,

We have a QED based MIPs processor, running Linux 2.4-test6. 
We use our own graphics card.
We want to get X/display up on this board. WE have a frame buffer driver
written
for the same card running on x86 Linux version and running X using
XFBDev server.

I want to know if we can reuse the same driver for mips also?
In the case of i386 Linux, fbcon.c and fbmem.c do most of the
processing before giving control to the corresponding graphics card.

In mips port can we use the same fbcon.c and fbmem.c functionality 
with our graphics driver. Is this enough for X to come up
without any problems. (i have seen sgi using newport_con , can we use
fb_con itself instead , what are the problems?)

I did see in the mailing list, someone mentioning using ATI graphics
card with the same hardware and running X. How was the frame buffer
driver modified?

Any help on this would be appreciated.

Thanks & Rgds
deepa
