Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2004 18:35:06 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:48009 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225234AbUBMSfG>; Fri, 13 Feb 2004 18:35:06 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 664FB4AD51; Fri, 13 Feb 2004 19:35:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 57FD34787C; Fri, 13 Feb 2004 19:35:01 +0100 (CET)
Date: Fri, 13 Feb 2004 19:35:01 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
In-Reply-To: <20040213175141.GB16718@mvista.com>
Message-ID: <Pine.LNX.4.55.0402131908370.15042@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl>
 <20040213145316.GA23810@linux-mips.org> <20040213175141.GB16718@mvista.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 13 Feb 2004, Jun Sun wrote:

> > > 2. It changes inline-assembly function prologues to be embedded within the
> > > functions, which makes them a bit safer as they can now explicitly refer
> > > to the "regs" struct and assures the code won't be removed or reordered.
> > 
> > It is possible that gcc changes one of the registers before save_static

 I think it is possible, too, but it doesn't happen now as gcc tries not
to change static callee-saved registers if possible as that's expensive.  
Only changes to "s8" seem inevitable if the frame pointer is used, but for
MIPS the kernel is always built with "-fomit-frame-pointer", so the
restriction doesn't apply.

> > and I can't imagine there's a reliable way to fix this in the inline
> > version.
> 
> Yes.  I still remember this bug vividly.  It took me quite a few days
> to track it down.

 The patch makes the code safer than what we have now, but it would still 
need to be verified periodically.

> I really wish there is a more reliable and systematic way to do this, 
> even at some expense of a few more instructions ...

 If we want to tolerate performance loss, then it's easily doable.  That 
can be done with the current setup, with a jump instruction to the 
referred function added at the end and "__attribute__((used))" or perhaps 
"asm("foo")" added to the function declaration.

 I can choose this path if we agree on it.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
