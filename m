Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 12:11:38 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:43946 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225201AbTBUMLh>; Fri, 21 Feb 2003 12:11:37 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA14075;
	Fri, 21 Feb 2003 13:11:59 +0100 (MET)
Date: Fri, 21 Feb 2003 13:11:58 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: [patch] Cobalt IRQ handler CP0 interlock?
In-Reply-To: <20030220195314.C30853@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030221125800.13836I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 20 Feb 2003, Ralf Baechle wrote:

> >  Does Cobalt have a processor that implements its pipeline differently or
> > interlocks on CP0 loads?  If not, I'll apply the following fix. 
> 
> Mfc0 doesn't need a nops on any R4000 class CPU I know of.

 Well, my MIPS R4k manual is vague on this matter and my IDT software
manual for R3k, R4k, R5k is even explicit on the load delay slot of mfc0. 
But a run-time test proves otherwise. 

 I stand corrected then unless someone finds a counter-example.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
