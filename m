Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA8Bw5K00309
	for linux-mips-outgoing; Thu, 8 Nov 2001 03:58:05 -0800
Received: from altrade.nijmegen.internl.net (altrade.nijmegen.internl.net [217.149.192.18])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA8Bw2000306
	for <linux-mips@oss.sgi.com>; Thu, 8 Nov 2001 03:58:03 -0800
Received: from whale.dutch.mountain by altrade.nijmegen.internl.net
	via 1Cust60.tnt56.rtm1.nl.uu.net [213.117.30.60] with ESMTP for <linux-mips@oss.sgi.com>
	id MAA15179 (8.8.8/1.3); Thu, 8 Nov 2001 12:57:56 +0100 (MET)
Received: from localhost(really [127.0.0.1]) by whale.dutch.mountain
	via in.smtpd with smtp
	id <m161nnu-0006DUC@whale.dutch.mountain>
	for <linux-mips@oss.sgi.com>; Thu, 8 Nov 2001 12:57:06 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #2 built 1996-Nov-26)
Date: Thu, 8 Nov 2001 12:57:06 +0100 (MET)
From: Richard van den Berg <R.vandenBerg@inter.NL.net>
X-Sender: ravdberg@whale.dutch.mountain
To: linux-mips@oss.sgi.com
Subject: Re: DECStation framebuffer support
In-Reply-To: <B3007593198@i01sv4107.ids1.intelonline.com>
Message-ID: <Pine.LNX.3.95.1011108125624.9651A-100000@whale.dutch.mountain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 8 Nov 2001, Guo-Rong Koh wrote:

> I've also got a PMAGB-B installed in the system. Since system detects
> and uses that as default, I'm guessing the kernel option will be
> 'video=pmagb-b-fb:on' right?

I didn't succeed in getting that to work, my advise would to try it first
with the on-board video.

> BTW, thanks for responding, none of this documented anywhere.

Oh yes it is, do a grep maxinefb on the 1999 mail archive available from
http://home.zonnet.berg56/ and you see it was discussed in june... 

Greetings,
Richard
