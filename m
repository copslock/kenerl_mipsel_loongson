Received:  by oss.sgi.com id <S553949AbRBMSvr>;
	Tue, 13 Feb 2001 10:51:47 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:29588 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553948AbRBMSvn>;
	Tue, 13 Feb 2001 10:51:43 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA00039;
	Tue, 13 Feb 2001 19:31:11 +0100 (MET)
Date:   Tue, 13 Feb 2001 19:31:11 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: config option vs. run-time detection (the debate continues ...)
In-Reply-To: <3A8829B9.17B7F691@mvista.com>
Message-ID: <Pine.GSO.3.96.1010213192415.20214H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 12 Feb 2001, Jun Sun wrote:

> >  I don't have an FPU-less system and I can't check such code.  I need to
> > depend on others (I couldn't test all possible configurations anyway).
> 
> However, with CONFIG_HAS_FPU approach I know for sure it will work for any
> MIPS CPU, as long as the programmer specifies it correctly. :-)

 Tha latter being a BIG if.

> > If
> > we have a chance to get an exception we have to catch it, of course
> > (that's trivial to handle in Linux).
> > 
> 
> No effort (as in CONFIG_HAS_FPU approach) is still better than trivial or
> small effort ( as in run-time detection).  :-)

 Regardless of the CONFIG_HAS_FPU option you still need to check if a FPU
is present.

> I am very curious what makes you object to the CONFIG_HAS_FPU approach,
> especially you said earlier it was not about the inability to support both FPU
> and FPU-less CPUs with the same kernel image.

 That's pretty orthogonal -- I do not object the CONFIG_HAS_FPU option (I
even favor it, if it could save us unneeded bits), but whether having it
or not, we still have to properly detect FP hardware.  A silent crash or
an obscure oops is not an option in case of a config error.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
