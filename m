Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 22:37:50 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:23687 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225230AbTGVVhs>; Tue, 22 Jul 2003 22:37:48 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA10512;
	Tue, 22 Jul 2003 23:37:45 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 22 Jul 2003 23:37:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Keith M Wesolowski <wesolows@foobazco.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20030722212117.GB1660@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030722232705.607L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jul 2003, Ralf Baechle wrote:

> And yes, the R6000 is different.  With that in mind R2000 and R4000 look
> like enzygotic twins ...

 ;-)

> > 2. A better visual existence of the 64-bit port; not really a technical
> > advantage, but more a psychological one.  It stops any newcomer wondering
> > whether we support 64-bit systems natively or not. 
> 
> I was thinking about that also.  arch/mips64 and include/asm-mips64 will
> go away but on the other side there will be an option to configure a
> 64-bit kernel in the menus - which will hopefully be more visible than
> just two subdirectories.

 Well, as long as one get that far to run a configuration script (BTW,
what menus are you referring to? -- I haven't seen any).  Right now that's
easily visible straight in the archive which is now even browsable in the
Internet here and there -- Q: "What architectures are supported?" A: "See
the subdirectories of arch/." 

> Btw, an old experience repeats - some of the code was identical except
> inline assembler using addu etc. for 32-bit and daddu etc. for 64-bit.
> I rewrote that stuff to use C for this arithmetic.  The result - less
> inline assembler, more readable code and a file that's identical for
> both 32-bit and 64-bit.

 Well, whatever is plain C code (or should be such) should be identical,
indeed, but macros will differ as will low-level assembly.  Then add
64-bit specific options and you get yet more complication. 

 I hope `uname -m' will continue to report the correct architecture and
that ARCH will be correctly handled (i.e. "mips" selecting a 32-bit build
and "mips64" a 64-bit one) -- have you considered this?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
