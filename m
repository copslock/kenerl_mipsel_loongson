Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7DCRjRw002889
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 13 Aug 2002 05:27:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7DCRjD4002888
	for linux-mips-outgoing; Tue, 13 Aug 2002 05:27:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from relay-1.interhouse.redbus.com (mail.interhouse.redbus.com [80.85.66.51])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7DCRSRw002879
	for <linux-mips@oss.sgi.com>; Tue, 13 Aug 2002 05:27:37 -0700
Received: from [192.168.11.27] (account simone.caronni@interhouse.redbus.com HELO control2)
  by relay-1.interhouse.redbus.com (CommuniGate Pro SMTP 4.0b4)
  with ESMTP id 437210 for linux-mips@oss.sgi.com; Tue, 13 Aug 2002 13:29:03 +0100
From: "Simone Caronni" <simone.caronni@interhouse.redbus.com>
To: "Linux-Mips" <linux-mips@oss.sgi.com>
Subject: RE: framebuffer + ethernet
Date: Tue, 13 Aug 2002 14:34:37 +0200
Message-ID: <OIEGJDDMNKKMEPCIMIKPOEOAJCAA.simone.caronni@interhouse.redbus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.21.0208131313250.626-100000@melkor>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Spam-Status: No, hits=-3.8 required=5.0 tests=IN_REP_TO,TO_LOCALPART_EQ_REAL version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Many thanks, I will definitely give it a try.

Simone

-----Original Message-----
From: Vivien Chappelier [mailto:vivien.chappelier@enst-bretagne.fr]
Sent: martedi 13 agosto 2002 13.30
To: Simone Caronni
Cc: linux-mips@oss.sgi.com
Subject: Re: framebuffer + ethernet


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
