Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 14:13:27 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:47761 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225255AbUCZON0>; Fri, 26 Mar 2004 14:13:26 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 10FF247781; Fri, 26 Mar 2004 15:13:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 0038B316; Fri, 26 Mar 2004 15:13:18 +0100 (CET)
Date: Fri, 26 Mar 2004 15:13:18 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: linker script problem
In-Reply-To: <200403261455.38960.thomas.koeller@baslerweb.com>
Message-ID: <Pine.LNX.4.55.0403261506440.3736@jurand.ds.pg.gda.pl>
References: <200403261349.41783.thomas.koeller@baslerweb.com>
 <20040326125704.GF9524@rembrandt.csv.ica.uni-stuttgart.de>
 <200403261455.38960.thomas.koeller@baslerweb.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 26 Mar 2004, Thomas Koeller wrote:

> Thanks for the hint. My target is the PMC-Sierra Yosemite evaluation
> board. I found that this board has no entry in arch/mips/Makefile,
> which explains why LOADADDR is unset. Can you point me at some useful
> information about how to choose a sensible load address? Will the RAM
> base address do?

 A KSEG0 address of the beginning of RAM is a reasonable choice unless 
your firmware reserves some space for own needs.

> Btw. if I get this right and want to contribute a patch, what are the
> rules for doing so? Would I need to provide some legal stuff (copyright
> assignment) first?

 Just send patches here, cc-ing ones you consider ready for inclusion to
Ralf Baechle.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
