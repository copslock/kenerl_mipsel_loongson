Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IMNY511919
	for linux-mips-outgoing; Fri, 18 Jan 2002 14:23:34 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IMNVP11915
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 14:23:31 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16RgTt-00057P-00; Fri, 18 Jan 2002 16:23:25 -0500
Date: Fri, 18 Jan 2002 16:23:25 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
   GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020118162325.A19122@nevyn.them.org>
References: <m3elkoa5dw.fsf@myware.mynet> <20020118101908.C23887@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020118101908.C23887@lucon.org>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jan 18, 2002 at 10:19:08AM -0800, H . J . Lu wrote:
> > MIPS: Who feels responsible?  Andreas, HJ?
> > 
> 
> I don't see there are any registers we can use without breaking ABI.
> On the other hand, can we change the mips kernel to save k0 or k1 for
> user space?

No, there are no free registers and $k0/$k1 are needed by the kernel
for exceptions.  The only way I can see to do this would be to change
the ABI.

There are none available; the least used that I see is $v1, but $v1 is
used to return half of a double precision return value.  We would have
to steal one of the existing call-saved or call-clobbered registers.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
