Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2004 20:50:45 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:47829 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225937AbUFKTul>; Fri, 11 Jun 2004 20:50:41 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 40FD3475C5; Fri, 11 Jun 2004 21:50:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 2943745837; Fri, 11 Jun 2004 21:50:35 +0200 (CEST)
Date: Fri, 11 Jun 2004 21:50:35 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: cgd@broadcom.com
Cc: David Daney <ddaney@avtrex.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
In-Reply-To: <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com>
Message-ID: <Pine.LNX.4.55.0406112133380.13062@jurand.ds.pg.gda.pl>
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com>
 <40C9F7F0.50501@avtrex.com> <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl>
 <mailpost.1086981251.16853@news-sj1-1> <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 11 Jun 2004 cgd@broadcom.com wrote:

> > 2. Gas should definitely use the codes consistently.  And it's a pity the
> > ABI got broken -- I think another mnemonic should have been chosen for the
> > correct implementation of "break", available to any ISA.
> 
> in retrospect, the 'B' variation probably wasn't the greatest idea.

 I guess it may be useful for something to have 20-bit codes available.  
Though except these few special cases, breaks tend to be inserted at the
run time, so it's the interested software that decides how to interpret
them, not gas.

> It may be very confusing to people who expect that the break code will
> translate into the instruction in an obvious way, and obviously it
> would mess up use of 20-bit codes, but i don't know how prevalent that
> is.

 I was surprised at first, too.

> Unfortunately, at this point, Linux should probably accept the
> divide-by-zero code in both locations.

 I think that's not a big trouble for Linux -- the path is rare and not
critical for performance.

> (Really, from day one, assemblers probably should have accepted a
> 20-bit code.  I just checked my copy of the Kane r2000/r3000 book, and
> it was 20-bit all the way back then.  If i had to guess, i'd guess
> that gas was copying a non-gnu assembler's behaviour.  In any case,
> water under the bridge.)

 Definitely they should have.  It's bug-compatibility with the original
MIPS assembler, I'm told.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
