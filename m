Received:  by oss.sgi.com id <S553822AbQLSSIQ>;
	Tue, 19 Dec 2000 10:08:16 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:30615 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553814AbQLSSIH>;
	Tue, 19 Dec 2000 10:08:07 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA25861;
	Tue, 19 Dec 2000 19:03:01 +0100 (MET)
Date:   Tue, 19 Dec 2000 19:03:00 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
cc:     linux-mips@oss.sgi.com, Ralf Baechle <ralf@uni-koblenz.de>,
        Jun Sun <jsun@mvista.com>
Subject: Re: MIPS_ATOMIC_SET in sys_sysmips()
In-Reply-To: <XFMail.001219180301.Harald.Koerfgen@home.ivm.de>
Message-ID: <Pine.GSO.3.96.1001219184849.18507D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 19 Dec 2000, Harald Koerfgen wrote:

> Another possibility would be to rely on the userland ll/sc emulation in the
> kernel. The one in the linux-vr tree seems to be working well and can easily be
> backported to Linux/MIPS.

 This should work but it looks ugly to me and the performance would suck
horribly. 

> Advantage: userland binary compatibility.
> Disadvantage: possibility for a lot of context switches for userland atomic
> operations.

 We may implement the emulation anyway, just like we emulate unaligned
accesses. 

> Having a sysmips(MIPS_ATOMIC_SET, ...) or atomic_op() solution would probably a
> lot faster.
> 
> Maybe we should implement both :)

 If we could afford another syscall number then I would prefer atomic_op() 
at the moment as it is well-documented and it does not overload one
function for various purposes, i.e. it's a bit faster. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
