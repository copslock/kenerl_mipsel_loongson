Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5SKMKnC015367
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 28 Jun 2002 13:22:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5SKMKtV015366
	for linux-mips-outgoing; Fri, 28 Jun 2002 13:22:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ntr.net (genoa.broadwing.net [65.90.208.154])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5SKMBnC015357;
	Fri, 28 Jun 2002 13:22:12 -0700
Received: from ntr.net (12-220-164-56.client.insightBB.com [12.220.164.56])
	by mail.ntr.net (8.12.2/8.12.2) with ESMTP id g5SKPnq0021629;
	Fri, 28 Jun 2002 16:25:50 -0400
Message-ID: <3D1CC755.5C3D4C45@ntr.net>
Date: Fri, 28 Jun 2002 16:30:13 -0400
From: "Marco C. Mason" <mason@ntr.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-26mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Need contact info for Origin 200
References: <3D1C9464.91CD9F71@ntr.net> <20020628192144.A25357@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf--

Thanks for your reply!

--marco

Ralf Baechle wrote:

> On Fri, Jun 28, 2002 at 12:52:52PM -0400, Marco C. Mason wrote:
>
> > The only difficulty is that these things are LOUD!  I'd like to find out
> > if there are any temperature monitors inside the thing, and if I can run
> > the fans at a reduced speed, or remove some of the fans to make them
> > reasonable in a home environment.  They don't do a lot (as I just do
> > some CPU-intensive stuff on them every once in a while, and very little
> > disk-I/O).
>
> Via the system controller you can set the fan speed.  Only the fan speeds
> n like normal and h like high are supported.  If the machine feels like
> it is hot or one of the fans has failed it'll automatically switch the
> fan speed to h.  If more than one fan fails it'll power off ...
>
> > Thus, I'd like to find a contact for simple (but technical) hardware
> > questions like these on the Origin 200.  If you guys could send me a
> > friendly contact or two, I'd be very grateful.
>
> Well, try this list.
>
> > (I'm also interested in making the thing dual-boot Irix & Linux, if the
> > Linux port is close to operating...  I've also got a pair of Indys that
> > I'm planning on sacrificing to the Linux gods...)
>
> The Indy port is in reasonable shape; the O200 port has decayed a bit
> over the past months but as far as time permits I'm working on getting
> it to run again.
>
>   Ralf
