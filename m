Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KEhJEC028434
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 07:43:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KEhJ65028433
	for linux-mips-outgoing; Tue, 20 Aug 2002 07:43:19 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KEh7EC028422
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 07:43:09 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA13559;
	Tue, 20 Aug 2002 16:46:34 +0200 (MET DST)
Date: Tue, 20 Aug 2002 16:46:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: [PATCH] Bring back R4600 V1.7 support
In-Reply-To: <20020820141013.GC10730@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1020820163727.8700J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 20 Aug 2002, Jan-Benedict Glaw wrote:

> Actually, I had written all that using separate functions before, but
> neither I nor Ralf liked this approach (because it adds hundreds LOC to
> .../c-r4k.c). Ralf then suggested writing it using macros, so I did.

 Obviously you'd put all the R4600 stuff in a separate file (the second
and the third being the regular R4k stuff and the template macros sourced
by the first and the second one).  That would aid diffing as well. 

> -*- Proposal -*-
> There are IMHO two goals, one for near future, one for following day
> (after first goal has reached):
> 
> 	1. There are many (equally looking) functions in c-r4k.c . It
> 	   would be nice to not have the (more-or-less) function body 10
> 	   times there.
> 	2. it would be nice to not have like 50 functions around, but to
> 	   better have a flexible way to do what needs to be done.
> 	   Something like an (initdata) array containing PRId and
> 	   function pointers (or other info) on "what needs to be
> 	   done".
> 
> The first one seems quite easy. Looking eg. at Alphas, they have a macro
> defining a whole function (which inserts a correct function name by
> supplied arguments etc.). This way, 
[...]

 Definitely.  The other one is done by Alphas as well since RTH wrote
generic kernel support.  I consider such a feature one of goals for MIPS
as well, so such a rewrite would be a necessary part of the design sooner
or later anyway. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
