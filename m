Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2004 15:28:48 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:4056 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225326AbUFAO2n>; Tue, 1 Jun 2004 15:28:43 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 6A0F0475C5; Tue,  1 Jun 2004 16:28:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 58970474C5; Tue,  1 Jun 2004 16:28:37 +0200 (CEST)
Date: Tue, 1 Jun 2004 16:28:37 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org,
	debian-toolchain@lists.debian.org
Subject: Re: TLS register
In-Reply-To: <047701c447d6$28aa9d60$10eca8c0@grendel>
Message-ID: <Pine.LNX.4.55.0406011543020.29465@jurand.ds.pg.gda.pl>
References: <20040531230524.GB2785@bogon.ms20.nix> <20040601121520.GB25718@linux-mips.org>
 <047701c447d6$28aa9d60$10eca8c0@grendel>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 1 Jun 2004, Kevin D. Kissell wrote:

> > > Now that gcc 3.4 has incompatible ABI changes (on o32 mostly affecting
> > > mipsel) I've been discussing with Thiemo if I'd be the right point to
> > > take this ABI change as a possibility to additionally reserve a TLS
> > > register. 
> > > He suggested $24 (t8) another discussed possibility would be $27 (k1)
> > > which is already abused by the PS/2 folks for ll/sc emulation.
> > > Another possibility would be to reserve such a register only in the
> > > n32/n64 ABIs and let o32 stay without __thread and TLS forever.

 For Linux the n32/n64 ABIs can be considered being in the initial stage
of deployment, so backwards compatibility is a non-issue.  Whatever is
found to be the best solution may be accepted.  So the problem of defining
a TLS pointer exists for the o32 ABI only and given the existence of
MIPS32 ISA and its implementations ignoring the issue won't only affect
ancient (but still alive) hardware.

> > Sigh, we'e been through this really often enough.  Reserving a register
> > comes at a price so my approach was to implement a fast path in the
> > exception code.  I've benchmarked that long time ago; it had less than
> > half the overhead than normal syscall and such a function would be subject
> > to normal code optimizations so calls should be few only.  Alpha already
> > does something similar using their PAL code.

 It seems a reasonable balance, IMO.

> The overhead realtive to a normal syscall is much less interesting
> to measure than the overhead relative to having the pointer already
> in a register - after all, half of a whole lot of instructions is still a whole
> lot of instructions.

 The interesting factor is how much software really needs threading.  
AFAIK, the majority does not -- I can count threaded software I know of 
(but not necessarily use) using fingers of one hand.  That does not mean 
there are no niches that make use of that approach extensively -- they 
could see a benefit, but why to penalize the rest?

> As some, but perhaps not all of you know, MIPS is working on
> multithreaded extensions to the instruction set architecture and
> the hardware, which include the ability to create and destroy
> parallel threads of executioon without OS intervention in the
> "expected" case (and yes, I have thought about how Linux 
> could support this, but I'm not gonna go into that here).
> In such a framework, it would not be acceptable to do a
> system call to get a TLS value.

 Well, this is exactly a good counter-argument for having a TLS pointer in
a gp register.  I someone needs the fastest threading possible, then let
them use the right hardware (with the threading ASE) or accept the
inefficiency of hardware that predates the concept of threading.

> I don't yet have an opinion as to whether we need to retrofit
> things so that user-level multithreading is compatible with o32,
> but I would comment that if we go for a TLS register, k1 may 
> not be a very good option. The LL/SC emulation trick with k1 
> works by virtue of k1 being *destroyed* by exceptions - it doesn't 
> change its status as a register reserved for kernel use.

 Actually the trick has never found its way into the mainline, and perhaps
it's best to keep it outside as messing with the k registers is inherently
fragile.  Of course, this applies to a possibility to use one of them for
the TLS, too. ;-)

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
