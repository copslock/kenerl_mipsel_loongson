Received:  by oss.sgi.com id <S553729AbQLSNaG>;
	Tue, 19 Dec 2000 05:30:06 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:30611 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553700AbQLSN3v>;
	Tue, 19 Dec 2000 05:29:51 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA13387;
	Tue, 19 Dec 2000 14:25:34 +0100 (MET)
Date:   Tue, 19 Dec 2000 14:25:33 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@uni-koblenz.de>
cc:     linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET in sys_sysmips()
In-Reply-To: <3A3EC1FF.9B86E2AC@mvista.com>
Message-ID: <Pine.GSO.3.96.1001219140739.10024F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 18 Dec 2000, Jun Sun wrote:

> It looks like sometime after test5 the MIPS_ATOMIC_SET case in sys_sysmips()
> function in the CVS tree is changed.  The new code now uses ll/sc instructions
> and handles syscall trace, etc.. 
> 
> This change does not make sense to me.  The userland typically uses
> MIPS_ATOMIC_SET when ll/sc instructions are not available.  But the new code
> itself uses ll/sc, which pretty much forfeit the purpose.  Or do I miss
> something else?

 There is no problem with using ll/sc in sysmips() itself for machines
that support them. 

> What do we offer to machines without ll/sc?

 I asked Ralf for a clarification of the sysmips(MIPS_ATOMIC_SET, ...) 
call before I write better code.  No response so far.  I'm now really
cosidering implementing the Ultrix atomic_op() syscall -- at least it has
a well-known defined behaviour. 

> BTW, what is the wrong with previous code?  I understand it may be broken in
> SMP case, but I think that is fixable.  Comments?

 The previous code was definitely broken -- depending on the path taken it
would return either the value fetched from memory or an error code.  No
way to distinguish between them. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
