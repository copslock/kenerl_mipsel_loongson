Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2EHk7e15460
	for linux-mips-outgoing; Thu, 14 Mar 2002 09:46:07 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2EHk3915457
	for <linux-mips@oss.sgi.com>; Thu, 14 Mar 2002 09:46:03 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id g2EHlUp29506;
	Thu, 14 Mar 2002 12:47:30 -0500
Date: Thu, 14 Mar 2002 12:47:30 -0500
From: Jim Paris <jim@jtan.com>
To: Johannes Stezenbach <js@convergence.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: Q: -mcpu= vs. -march= for VR41xx specific instructions
Message-ID: <20020314124730.A29381@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20020314172502.GA5365@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314172502.GA5365@convergence.de>; from js@convergence.de on Thu, Mar 14, 2002 at 06:25:02PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> I am trying to implement power management for an embedded
> device using a NEC VR4120 CPU core, which has the special
> instructions "standby", "suspend" and "hibernate".

> So I think I need either:
> - make gas accept -march=vr4100 along with -mcpu=r4600 (or -mcpu=r4100?)
> - or have a ".set vr4100" directive to enable the vr41xx specific
>   instructions where needed, without changing the flags in the
>   ELF header
> - or make the linker link modules with different (but compatible) e_flags
> - or is "GCCFLAGS += -Wa,-march=vr4100 -mips2 -Wa,--trap" perfect?

For lots of discussion of this, see

   http://sources.redhat.com/ml/binutils/2001-10/threads.html#00504

then

   http://sources.redhat.com/ml/binutils/2001-11/threads.html#00001

I don't remember where things currently stand.

-jim
