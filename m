Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Apr 2004 07:30:56 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:48837 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224898AbUDQGax>; Sat, 17 Apr 2004 07:30:53 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id E0E4247A40; Sat, 17 Apr 2004 08:30:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id CA45E47745; Sat, 17 Apr 2004 08:30:44 +0200 (CEST)
Date: Sat, 17 Apr 2004 08:30:44 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: IP30 goes relatively far now
In-Reply-To: <Pine.GSO.4.10.10404170612440.10514-100000@helios.et.put.poznan.pl>
Message-ID: <Pine.LNX.4.55.0404170817260.24278@jurand.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10404170612440.10514-100000@helios.et.put.poznan.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 17 Apr 2004, Stanislaw Skowronek wrote:

> because the last '.set *reorder' before is in 'nmi_handler', and it is a
> '.set noreorder'. I will get a newer kernel (I did 2.6.1 because it worked

 Ouch -- there used to be such a bug in the past, but it was fixed on Aug
6th, 2003.  Please update indeed -- your snapshot is severly old and there
have been plenty updates since then, so chances are you may struggle with
problems that have been dealt with elsewhere, too.  Please use the CVS, of
course.

> for me, and 2.6.3 crashed on my PC with astonishing frequency, so I didn't
> want to take a chance) and check.

 Well, the stability of the i386 and the MIPS port for a given version is
sometimes unrelated. ;-)

> Anyway, the procedure is 'handle_daddi_ov' and not 'handle_daddi_ov_int'
> in my genex.S, and it's substantially longer than your code. Do you have
> the SAVE_ALL there? I don't see it.

 I've stripped the preceding unrelated entry code.  The "_int" alternate
entry points to exception handlers were merged from 2.4 on Jan 3th (only
handle_fpe_int is actually needed, for R3k-class CPUs, as they handle the
FP error as an ordinary interrupt).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
