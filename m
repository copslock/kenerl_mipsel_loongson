Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 15:13:32 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:54702 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225519AbUBBPNb>; Mon, 2 Feb 2004 15:13:31 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 3A69146A7E; Mon,  2 Feb 2004 16:13:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 2C13D44C9D; Mon,  2 Feb 2004 16:13:28 +0100 (CET)
Date: Mon, 2 Feb 2004 16:13:28 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20040202141939Z8225226-9616+1555@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0402021611490.6182@jurand.ds.pg.gda.pl>
References: <20040202141939Z8225226-9616+1555@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 2 Feb 2004 ralf@linux-mips.org wrote:

> 	PMC-Sierra says that the workaround for errata #18 of the R4600 V1.7
> 	and a similar erratum in V2.0 don't require disabling of interrupts,
> 	so remove that code.

 How do we assure tails of interrupt handlers don't trigger the errata?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
