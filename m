Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2003 04:23:56 +0100 (BST)
Received: from p508B60E0.dip.t-dialin.net ([IPv6:::ffff:80.139.96.224]:39643
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224802AbTG3DXy>; Wed, 30 Jul 2003 04:23:54 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6U3GWx6015647;
	Wed, 30 Jul 2003 05:16:32 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6U3GWgM015646;
	Wed, 30 Jul 2003 05:16:32 +0200
Date: Wed, 30 Jul 2003 05:16:31 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Keith M Wesolowski <wesolows@foobazco.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030730031631.GD7366@linux-mips.org>
References: <20030722212117.GB1660@linux-mips.org> <Pine.GSO.3.96.1030722232705.607L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030722232705.607L-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 22, 2003 at 11:37:44PM +0200, Maciej W. Rozycki wrote:

> > Btw, an old experience repeats - some of the code was identical except
> > inline assembler using addu etc. for 32-bit and daddu etc. for 64-bit.
> > I rewrote that stuff to use C for this arithmetic.  The result - less
> > inline assembler, more readable code and a file that's identical for
> > both 32-bit and 64-bit.
> 
>  Well, whatever is plain C code (or should be such) should be identical,
> indeed, but macros will differ as will low-level assembly.  Then add
> 64-bit specific options and you get yet more complication. 

You're right, we've got a good bit of assembler code that should just be
C.  So I rewrote some of the code to C.

>  I hope `uname -m' will continue to report the correct architecture and
> that ARCH will be correctly handled (i.e. "mips" selecting a 32-bit build
> and "mips64" a 64-bit one) -- have you considered this?

Not intend to change the behaviour of uname.  It actually changed in CVS,
for now consider that a bug ...

We should consider changing the behaviour though.  A machine type of
mips64 broke lots of software.  Of course that was all 32-bit softare but
it raises the question if returning mips64 is really a good idea?

As for choosing a 32-bit vs. 64-bit kernel, that's now a menu point and can
be choosen like every other config option.

  Ralf
