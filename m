Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KF0et13515
	for linux-mips-outgoing; Wed, 20 Feb 2002 07:00:40 -0800
Received: from dea.linux-mips.net (a1as06-p249.stg.tli.de [195.252.187.249])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KF0Z913501
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 07:00:36 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1KD9HY16210;
	Wed, 20 Feb 2002 14:09:17 +0100
Date: Wed, 20 Feb 2002 14:09:17 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020220140917.C15588@dea.linux-mips.net>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020219171238.E25739@mvista.com>; from jsun@mvista.com on Tue, Feb 19, 2002 at 05:12:38PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 19, 2002 at 05:12:38PM -0800, Jun Sun wrote:

> > It's gotta be done.  I mean, the last I heard (which was a long
> > time ago) mips64 Linux was keeping the CPU node number in
> > a watchpoint register (or something equally unwholesome)
> 
> It seems that people are getting smarter by putting cpu id to
> context register.  In fact isn't this part of new MIPS
> standard?

The context register is actually intended to be used for indexing a flat
4mb array of pagetables on a 32-bit processor.  It's a bit ill-defined
on R4000-class processors as it assumes a size of 8 bytes per pte, so
cannot be used in the Linux/MIPS kernel without shifting bits around.
Also in case of Linux it means entering the world of cache aliases ...

  Ralf
