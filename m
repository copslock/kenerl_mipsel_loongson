Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2002 16:17:43 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:20691 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123897AbSJBORn>; Wed, 2 Oct 2002 16:17:43 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA12135;
	Wed, 2 Oct 2002 16:18:08 +0200 (MET DST)
Date: Wed, 2 Oct 2002 16:18:08 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: [resend] 2.4: Support R4000 as a distinct CPU type
In-Reply-To: <20021002154753.F17373@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021002160212.8947B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 2 Oct 2002, Ralf Baechle wrote:

> >  Here is a new version that takes your recent mips64 cache code rearrange
> > into account.  OK to apply?
> 
> I'm not sure if that's really a good idea.  Technically it's ok but I expect
> users of the R4000 to missconfigure their kernels.  So I wonder if it might

 I plan to write some code to detect various processor bugs, including
this one.  A nice kernel panic will instruct users how to configure the
kernel properly, so this is not an issue.  If you want me to defer the
patch until it's done, I see no problem.  Others may apply the patch as
needed for now.

> be more appropriate to have just automatically enabled this workaround for
> systems that are affected?  If we keep it user-selectable then we at least

 The workaround affects gcc's code generation -- there is no way to change
it at the run time.

> want a safety check somewhere in the startup code telling users to rebuild
> their code with the workaround enabled.

 Of course, as I've written above.

> Having this workaround enabled by default would also ensure Linux
> distributions ship working code - you don't want users having to recompile
> their whole distribution ...

 But the generated code is worse -- it interlocks on a multiplication
flushing the whole benefit of the separate multiply unit down the drain. 
There is room for an improvement here, though. 

 As to compiling userland -- the workaround is the gcc's default for R4000
which is what is selected by "-mips3" among others.  It should probably be
enabled by default for "-mips1" and "-mips2" configurations as well if no
explicit CPU selection options are passed.

 Ultimately we'll want to have a separate setting for the R4400 in the
kernel as well, due to a smaller set of bugs.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
