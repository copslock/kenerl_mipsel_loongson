Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Apr 2004 05:24:08 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:35042
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8224898AbUDQEYH>; Sat, 17 Apr 2004 05:24:07 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3H4O5m16201;
	Sat, 17 Apr 2004 06:24:05 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 17 Apr 2004 06:24:01 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3H4O1N11193;
	Sat, 17 Apr 2004 06:24:01 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 17 Apr 2004 06:24:01 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@linux-mips.org
Subject: Re: IP30 goes relatively far now
In-Reply-To: <Pine.LNX.4.55.0404170000540.24278@jurand.ds.pg.gda.pl>
Message-ID: <Pine.GSO.4.10.10404170612440.10514-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

>  I must have been blind -- there's a matching ".set pop" elsewhere.  Is a 
> "nop" really missing in the output?  I've assembled the file and I can't 
> see any problem:
> 
> 000000000000022c <handle_daddi_ov_int>:
>  22c:	0c000000 	jal	0 <except_vec0_generic>
> 			22c: R_MIPS_26	do_daddi_ov
> 			22c: R_MIPS_NONE	*ABS*
> 			22c: R_MIPS_NONE	*ABS*
>  230:	03a0202d 	move	a0,sp
>  234:	08000000 	j	0 <except_vec0_generic>
> 			234: R_MIPS_26	ret_from_exception
> 			234: R_MIPS_NONE	*ABS*
> 			234: R_MIPS_NONE	*ABS*
>  238:	00000000 	nop
>  23c:	00000000 	nop

Oooh, it's SOOO strange!

For me, it is:

   ...
 228:   03a0202d        move    a0,sp
 22c:   0c000000        jal     0 <except_vec0_generic>
                        22c: R_MIPS_26  do_daddi_ov
                        22c: R_MIPS_NONE        *ABS*
                        22c: R_MIPS_NONE        *ABS*
 230:   08000000        j       0 <except_vec0_generic>
                        230: R_MIPS_26  ret_from_exception
                        230: R_MIPS_NONE        *ABS*
                        230: R_MIPS_NONE        *ABS*

because the last '.set *reorder' before is in 'nmi_handler', and it is a
'.set noreorder'. I will get a newer kernel (I did 2.6.1 because it worked
for me, and 2.6.3 crashed on my PC with astonishing frequency, so I didn't
want to take a chance) and check.

Anyway, the procedure is 'handle_daddi_ov' and not 'handle_daddi_ov_int'
in my genex.S, and it's substantially longer than your code. Do you have
the SAVE_ALL there? I don't see it.

Yours,

Stanislaw Skowronek
