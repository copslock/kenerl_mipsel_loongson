Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2003 05:26:09 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:31702 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225200AbTJAE0H>; Wed, 1 Oct 2003 05:26:07 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id GAA21337;
	Wed, 1 Oct 2003 06:26:03 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 1 Oct 2003 06:26:02 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Michael Uhler <uhler@mips.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	"Finney, Steve" <Steve.Finney@spirentcom.com>,
	linux-mips@linux-mips.org
Subject: Re: 64 bit operations w/32 bit kernel
In-Reply-To: <1064950055.12992.99.camel@uhler-linux.mips.com>
Message-ID: <Pine.GSO.3.96.1031001055849.20371C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 30 Sep 2003, Michael Uhler wrote:

> >  Well, I think this is OK -- 64-bit opcodes are generally useless for
> > software built for the o32 ABI, so they should not normally happen in
> > regular code.  Perhaps some fancy hand-coded assembly might try to use
> > them to get unusual results, including an invalid opcode trap handler for
> > the processors that do not support them at all.  But I don't think we
> > should try to work hard to prevent broken software from shooting into its
> > foot.
> 
> I'm not a real fan of architecting software to dismiss broken (or rogue)
> programs since it tends to open up a whole lot of holes that cause
> O/S crashes.  For instance, an o32 program should never be able to pass
> a non-sign-extended value thru a GPR to the O/S in a system call.  How
> many places in the O/S implicitly assume this is true?  The architecture

 That actually we get right -- the arguments at the stack are obviously
32-bit and the ones in argument registers are explicitly sign-extended
from their 32 LSBs in our syscall prologue for o32 syscalls.

> was never intended to run real 32-bit programs with 64-bit ops enabled,
> and I would strongly urge you not to do this now.

 After a bit of thinking, I consider this not to be a real problem.  Apart
from the kernel interface, which sanitizes values passed, the rest is pure
userland, where allowing undefined operation with 64-bit opcodes cannot
really hurt.  Of course running a buggy or malicious program may lead to
bad results or loss of data, but it'll be limited to the user responsible
for running such software and the root user by definition has to know what
he is doing and specifically he is responsible for not running untrusted
software on critical systems.

 That said, I don't really have a strong preference either way -- it just
doesn't seem to be worth the hassle for me to explicitly defend against
such a marginal case.  Although it may be good to try validating this
assumption with `crashme'. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
