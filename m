Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7DBRSRw031260
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 13 Aug 2002 04:27:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7DBRShf031259
	for linux-mips-outgoing; Tue, 13 Aug 2002 04:27:28 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7DBRLRw031247
	for <linux-mips@oss.sgi.com>; Tue, 13 Aug 2002 04:27:21 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g7DBTbY10968;
	Tue, 13 Aug 2002 13:29:37 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g7DBTXfo019918;
	Tue, 13 Aug 2002 13:29:37 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17eZrg-0004jv-00; Tue, 13 Aug 2002 13:29:32 +0200
Date: Tue, 13 Aug 2002 13:29:32 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Simone Caronni <simone.caronni@interhouse.redbus.com>
cc: linux-mips@oss.sgi.com
Subject: Re: framebuffer + ethernet
In-Reply-To: <OIEGJDDMNKKMEPCIMIKPMENOJCAA.simone.caronni@interhouse.redbus.com>
Message-ID: <Pine.LNX.4.21.0208131313250.626-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 13 Aug 2002, Simone Caronni wrote:

> Hello, I have an O2 R5000 I would like to try Linux on. 

Linux on the SGI O2 R5000 is still *very experimental*. You'll need
a 2.5 kernel from the CVS at oss.sgi.com and the patches available there:
http://www.linux-mips.org/~glaurung/

2.5.5 is work in progress, you might have higher chances with 2.5.4.

There are also compiled kernels available if you want to try.

> Can someone please tell me the status and usability of the O2 fb and
> internal ethernet?

The O2 ethernet is working for simple operations, but has a bug when
transmitting a lot of data from the O2. However I've a fix for that I'll
make available in the next few days (needs cleanup).
The framebuffer is also working approximatively, with two known
bugs: the display sometimes (randomly) appears as 'wrapped around' and the
colormap is not working properly in 8 bit mode. I've also tried Xfree86
on framebuffer which displays wrong colors (an X bug this time), but works
well apart from that.
Overall, the O2 is starting to work, but is not stable at all... rather a
hacker's toy currently :)

regards,
Vivien Chappelier.
