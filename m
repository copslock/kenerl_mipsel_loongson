Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4V3TH928530
	for linux-mips-outgoing; Wed, 30 May 2001 20:29:17 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4V3TBh28518
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 20:29:11 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA05204
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 20:29:08 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA13602;
	Wed, 30 May 2001 15:42:21 +0200 (MET DST)
Date: Wed, 30 May 2001 15:42:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>, Joe deBlaquiere <jadb@redhat.com>,
   "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Surprise! (Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <3B142367.791F28AF@mvista.com>
Message-ID: <Pine.GSO.3.96.1010530141109.9456B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 29 May 2001, Jun Sun wrote:

> >  What about 3) -- a new syscall with a different semantics and no need to
> > care about limitations of current implementations (especially the
> > sysmips() bag).  
> 
> Having a new syscall is fine with me, although seems a little more instrusive
> than adding a subcall to sysmips().

 Actually whole sysmips() looks like a crazy hack, much like ioctl(), but
even worse (passing a pointer in an integer argument, even if it works...
yuck!).  And it is weird, to say at least, to have different
interpretations of the return value -- sometimes it's errno and sometimes 
it's something different.

 A separate syscall has the advantage we can write it cleanly and
optimally, not caring of the calling convention of the incorporating
syscall as in the case of sysmips().  And the overhead is a bit smaller. 

> The patch looks good to me.

 Great!

> BTW, why wouldn't you choose to have three arguments in the syscall, where the
> last one is a pointer to the variable to hold the return value?  Doing that
> would avoid tricky register manipulation on both calling side (fetching return
> value from $v1) and kernel side (setting regs.regs[3]).

 You may treat this as a syscall returning long long. ;-)

 A few other syscalls have non-standard register allocations as well.  I
think it's cleaner to return a value in a register -- no need to handle
passing an invalid pointer.  And the overhead is a bit smaller -- no need
for two memory accesses, which require an auxillary register anyway and
which may cause a TLB fault and/or a cache line reload. 

 This is to be discussed though.  

 I have the glibc patch basically ready.  It's nice -- the target
sys__test_and_set() wrapper is only seven instructions long (of which
three are the gp PIC preamble, sigh).  The v1 to v0 move is free -- it
fits in the delay slot of "jr $ra" nicely. :-)

 Unfortunately, for glibc 2.2.x we should probably fall back to
sysmips(MIPS_ATOMIC_SET) if the sys__test_and_set() fails (with ENOSYS),
for compatibility.  This lengthens the function to 27 instructions.  We
can hopefully remove the crap in glibc 2.3. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
