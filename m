Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HIue927780
	for linux-mips-outgoing; Tue, 17 Jul 2001 11:56:40 -0700
Received: from dvmwest.gt.owl.de (postfix@dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HIucV27776
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 11:56:38 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 8EACFC4FE; Tue, 17 Jul 2001 20:56:36 +0200 (CEST)
Date: Tue, 17 Jul 2001 20:56:36 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>
Subject: Re: Oops in serial driver
Message-ID: <20010717205636.A467@lug-owl.de>
Mail-Followup-To: SGI MIPS list <linux-mips@oss.sgi.com>,
	Debian MIPS list <debian-mips@lists.debian.org>
References: <20010717181156.A32024@lug-owl.de> <20010717201114.C5552@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010717201114.C5552@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Jul 17, 2001 at 08:11:14PM +0200
X-Operating-System: Linux mail 2.4.5 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 17, 2001 at 08:11:14PM +0200, Florian Lohoff wrote:
> On Tue, Jul 17, 2001 at 06:11:56PM +0200, Jan-Benedict Glaw wrote:
> > Hi!
> > I'm currently testing with current CVS kernels and facing some bad
> > Oopses in DECstation's serial driver:-( Top fafourites are rs_interrupt
> > and zs_channels. Does anybody already have a fix for this? I fear
> > noting down all the Oops from framebuffer, as it is for obvious reason
> > not written to serial console...
> 
> Loop up the assembly code in the functions and check which register
> they attempt to use. You wont need to write down all registers.

Ok. Will do that tomorrow (Don't have access to that box right now)

> It would be interesting under which occurencies the oops happens - When
> running on fb why do you use the serials ? 

Well... Serial console seems to be *very* handy at all. I'm not
yet that far to use DECstation's own keyboard (which is btw a serial
device-:-) How's that done? "console=tty0 console=ttyS0"?

Another thing is stability. I'm currently using Karsten's glibc2.2
based debian base filesystem which is not that much fun on a R3k
(-> ll/sc and sysmips - any solution at horizon?). Binaries tend to
SIGBUS, Illegal Insn, ... But everything will be good at some
point:-)

Some hints on serial keyboard would be nice! Karsten?

MfG, JBG
