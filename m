Received:  by oss.sgi.com id <S553872AbRBIUjh>;
	Fri, 9 Feb 2001 12:39:37 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:20142 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553864AbRBIUjV>;
	Fri, 9 Feb 2001 12:39:21 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA20117;
	Fri, 9 Feb 2001 21:39:29 +0100 (MET)
Date:   Fri, 9 Feb 2001 21:39:29 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: config option vs. run-time detection (the debate continues ...)
In-Reply-To: <3A844C16.DD53E7E0@mvista.com>
Message-ID: <Pine.GSO.3.96.1010209212607.13007B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 9 Feb 2001, Jun Sun wrote:

> Do you like run-time detection better because it allows a kernel to run on
> CPUs both with a FPU and without a FPU?  Or there is something else to it?

 Nope.  There are certain explicit actions that are to be performed by the
kernel if a real FPU is present, such as saving and restoring its
registers or setting the control register.  Therefore the kernel has to
know if a real part is present and act accordingly.  Maintaining a table
of all CPU ids ever manufactured and manually setting the FPU presence bit
is unreliable, especially as there are chips which cannot be classified
this way, e.g. knowing your CPU is an R3000A you don't know if an R3010A
FPU is soldered as well or not. 

> Another question.  I know with mips32 and mips64 we can do run-time detection
> reliably.  What about other existing processors?

 I've sent a quote from an IDT manual recently.  It recommended to use the
FPU implementation ID to check if an FP hw is present.  I believe it
should work for any sane implementation of a MIPS CPU.  See the mail for
details. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
