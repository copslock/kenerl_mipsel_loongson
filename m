Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 14:11:26 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:16341 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225739AbUDWNLZ>; Fri, 23 Apr 2004 14:11:25 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 97EF14C064; Fri, 23 Apr 2004 15:11:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 8C30C4C055; Fri, 23 Apr 2004 15:11:19 +0200 (CEST)
Date: Fri, 23 Apr 2004 15:11:19 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@linux-mips.org
Subject: Re: MC Parity Error
In-Reply-To: <20040423080247.GC5814@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.55.0404231509190.14494@jurand.ds.pg.gda.pl>
References: <20040423080247.GC5814@paradigm.rfc822.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 23 Apr 2004, Florian Lohoff wrote:

> success report for the MC Bus Error handler :)
> 
> Apr 19 23:17:32 resume kernel: MC Bus Error
> Apr 19 23:17:32 resume kernel: CPU error 0x380<RD PAR > @ 0x0f4c6308
> Apr 19 23:17:32 resume kernel: Instruction bus error, epc == 2accf310, ra == 2accf2c8
> 
> I guess i have bad memory. The interesting point is that the machine
> continued to run for another 2 days. Shouldnt a memory error halt the
> machine ?

 As it happened in the user mode, I'd expect only the victim process to be
killed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
