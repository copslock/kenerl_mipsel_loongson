Received:  by oss.sgi.com id <S553651AbRBJJBx>;
	Sat, 10 Feb 2001 01:01:53 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:14514 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553646AbRBJJBd>;
	Sat, 10 Feb 2001 01:01:33 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id KAA02431;
	Sat, 10 Feb 2001 10:01:50 +0100 (MET)
Date:   Sat, 10 Feb 2001 10:01:50 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: config option vs. run-time detection (the debate continues ...)
In-Reply-To: <3A84619B.94224C30@mvista.com>
Message-ID: <Pine.GSO.3.96.1010210094331.2153A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 9 Feb 2001, Jun Sun wrote:

>   a) an explicit config option, CONFIG_HAS_FPU, (which is not associated with
> PrID), plus "#ifdef CONFIG_HAS_FPU ..." code.  Or
> 
>   b) have run-time detection and many "if .. then .." code.
> 
> I listed some pro's and con's for both of them in my first email.  Right now,
> I found myself not having a strong preference but still biased towards config
> option approach ( - as if that really matters. :-0)

 Well, the number of places a run-time condition exist is small and they
are not performance-critical. 

> I actually don't understand your IDT quote.  It requires one to call mfc1 to
> get FCR0.  On many CPUs without a FPU, this will generate an exception.  Are
> you suggesting that we should catch the exception and from that we conclude
> there is no FPU present?

 I don't have an FPU-less system and I can't check such code.  I need to
depend on others (I couldn't test all possible configurations anyway).  If
we have a chance to get an exception we have to catch it, of course
(that's trivial to handle in Linux). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
