Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA84NA622142
	for linux-mips-outgoing; Wed, 7 Nov 2001 20:23:10 -0800
Received: from altrade.nijmegen.internl.net (altrade.nijmegen.internl.net [217.149.192.18])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA84N7022138
	for <linux-mips@oss.sgi.com>; Wed, 7 Nov 2001 20:23:07 -0800
Received: from whale.dutch.mountain by altrade.nijmegen.internl.net
	via 1Cust153.tnt10.rtm1.nl.uu.net [213.116.114.153] with ESMTP for <linux-mips@oss.sgi.com>
	id FAA13393 (8.8.8/1.3); Thu, 8 Nov 2001 05:22:59 +0100 (MET)
Received: from localhost(really [127.0.0.1]) by whale.dutch.mountain
	via in.smtpd with smtp
	id <m161V1G-0006DIC@whale.dutch.mountain>
	for <linux-mips@oss.sgi.com>; Wed, 7 Nov 2001 16:53:38 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #2 built 1996-Nov-26)
Date: Wed, 7 Nov 2001 16:53:37 +0100 (MET)
From: Richard van den Berg <R.vandenBerg@inter.NL.net>
X-Sender: ravdberg@whale.dutch.mountain
To: linux-mips@oss.sgi.com
Subject: Re: DECStation framebuffer support
In-Reply-To: <B3007554463@i01sv4107.ids1.intelonline.com>
Message-ID: <Pine.LNX.3.95.1011107163728.7758A-100000@whale.dutch.mountain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 7 Nov 2001, Guo-Rong Koh wrote:

> I have just decided to try getting Linux running on my DECStation
> 5000/25 (currently running NetBSD). I succeeded in cross-compiling a
> 2.4.12 kernel from an i686 Linux box. My main aim is to get the
> framebuffer working.
> 
> To test the kernel I dumped it on the NetBSD root and hit "boot
> 3/rz0/vmlinux".
> 
> This gets me to "This is a Personal DECStation 5000/xx" then stops.
> 
> Any suggestions as to what I should do next?
> Framebuffer support for all the framebuffers has been compiled in. The
> question is: To what extent does the kernel support console on
> framebuffer?

The kernel should support console on framebuffer, it once did. With the
on-board video the kernel needed 'video=maxinefb:on' as a kernel option,
dunno if that's still the case. You only have the on-board video, no
second video controller?

Greetings,
Richard
