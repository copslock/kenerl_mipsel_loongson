Received:  by oss.sgi.com id <S553714AbRAEUwe>;
	Fri, 5 Jan 2001 12:52:34 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:38594 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553698AbRAEUwO>;
	Fri, 5 Jan 2001 12:52:14 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA10408;
	Fri, 5 Jan 2001 21:52:29 +0100 (MET)
Date:   Fri, 5 Jan 2001 21:52:29 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Lisa.Hsu@taec.toshiba.com
cc:     linux-mips@oss.sgi.com
Subject: Re: questions on the cross-compiler
In-Reply-To: <OFA30D3318.A1194F94-ON882569CB.006FF5E7@taec.toshiba.com>
Message-ID: <Pine.GSO.3.96.1010105214251.9384G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 5 Jan 2001 Lisa.Hsu@taec.toshiba.com wrote:

> With the help from Kevin Kissell,  I've found out that  the compilation
> directives "set .mips3[4]" were turned on before cpu_probe() and cpu_probe
> () functions in my head.S file.  This is the reason why I've got that wrong
> code generated although I've specified mip1 in the gcc options.
> 
> I 've temporarily used #define to add "set .mips1" in the code to fix the
> problem.   My question now,  is: how can we make the kernel code flexible
> to free from the problem of the one that I've got?

1. Don't use "set .mips*" unless absolutely needed.  The right ISA level
is already set via a compiler option depending on the host CPU selected
upon kernel configuration.

2. If you can't avoid "set .mips*" for some reason, then always restore
the default state after the relevant code, either by ".set mips0" or by
".set push" and ".set pop". 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
