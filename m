Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3MHfxqf006298
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Apr 2002 10:41:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3MHfrPO006297
	for linux-mips-outgoing; Mon, 22 Apr 2002 10:41:53 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3MHfoqf006294
	for <linux-mips@oss.sgi.com>; Mon, 22 Apr 2002 10:41:50 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g3MHgL410213;
	Mon, 22 Apr 2002 10:42:21 -0700
Date: Mon, 22 Apr 2002 10:42:21 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Hartvig Ekner <hartvige@mips.com>
Cc: user alias <linux-mips@oss.sgi.com>
Subject: Re: Problems with H.J's latest RPM 4.0.4 binary packages
Message-ID: <20020422104221.A10146@dea.linux-mips.net>
References: <200204221446.QAA23835@copsun17.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200204221446.QAA23835@copsun17.mips.com>; from hartvige@mips.com on Mon, Apr 22, 2002 at 04:46:45PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 22, 2002 at 04:46:45PM +0200, Hartvig Ekner wrote:

> [hartvige@copmalt13 /bin]$ rpm --version
> error: Macro %__id_u has empty body
> RPM version 4.0.4
> [hartvige@copmalt13 /bin]$
> 
> Before I start digging any deeper, has anybody else seen this and found the
> explanation?
> 
> (Note that I have not yet finished compiling the glibc RPM natively as
> required - this is currently ongoing).

Rpm has this nasty property of inherting much of it's configuration from
one generation into the next generation.  To get around this you will have
to hack the configuration of your current rpm in /usr/lib/rpm/ rsp.
/etc/rpm and rebuild.  I've seen even more funny things when crossbuilding
rpm.

  Ralf
