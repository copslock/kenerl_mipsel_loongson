Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5SHIXnC012506
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 28 Jun 2002 10:18:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5SHIX7s012505
	for linux-mips-outgoing; Fri, 28 Jun 2002 10:18:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-123.ka.dial.de.ignite.net [62.180.196.123])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5SHINnC012494
	for <linux-mips@oss.sgi.com>; Fri, 28 Jun 2002 10:18:25 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5SHLiI25373;
	Fri, 28 Jun 2002 19:21:44 +0200
Date: Fri, 28 Jun 2002 19:21:44 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Marco C. Mason" <mason@ntr.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: Need contact info for Origin 200
Message-ID: <20020628192144.A25357@dea.linux-mips.net>
References: <3D1C9464.91CD9F71@ntr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D1C9464.91CD9F71@ntr.net>; from mason@ntr.net on Fri, Jun 28, 2002 at 12:52:52PM -0400
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jun 28, 2002 at 12:52:52PM -0400, Marco C. Mason wrote:

> The only difficulty is that these things are LOUD!  I'd like to find out
> if there are any temperature monitors inside the thing, and if I can run
> the fans at a reduced speed, or remove some of the fans to make them
> reasonable in a home environment.  They don't do a lot (as I just do
> some CPU-intensive stuff on them every once in a while, and very little
> disk-I/O).

Via the system controller you can set the fan speed.  Only the fan speeds
n like normal and h like high are supported.  If the machine feels like
it is hot or one of the fans has failed it'll automatically switch the
fan speed to h.  If more than one fan fails it'll power off ...

> Thus, I'd like to find a contact for simple (but technical) hardware
> questions like these on the Origin 200.  If you guys could send me a
> friendly contact or two, I'd be very grateful.

Well, try this list.

> (I'm also interested in making the thing dual-boot Irix & Linux, if the
> Linux port is close to operating...  I've also got a pair of Indys that
> I'm planning on sacrificing to the Linux gods...)

The Indy port is in reasonable shape; the O200 port has decayed a bit
over the past months but as far as time permits I'm working on getting
it to run again.

  Ralf
