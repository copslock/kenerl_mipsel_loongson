Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 17:07:52 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:1216 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIEPHv>; Thu, 5 Sep 2002 17:07:51 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA08625;
	Thu, 5 Sep 2002 17:08:06 +0200 (MET DST)
Date: Thu, 5 Sep 2002 17:08:06 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: "Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020905142249.GA15843@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1020905165445.7444D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:

> Well, here's one - while we all know that C code which assumes a
> pointer and int are the same size is buggy, it makes everything
> substantially simpler if long and void* are the same size.  That's true
> for both normal LP64 and ILP32 models.  Since n32 was mostly a
> transitional tool (SGI was primarily interested in n64 as I understand
> it), I imagine they wanted path of least damage...

 I see.  But do we need the SGI's traditional n32 in Linux then?  Having
most experiences in the server world I'd vote for a pure 64-bit setup
(with an optional ability to execute o32 stuff), but I understand there
are people who consider it a waste of resources.

 Therefore, I believe we may choose another way and use an IP32 (if I
encode it right) data model, where we have 32-bit ints and pointers for
these who are short on memory, 64-bit longs for the maximum native
precision (you don't choose long for the type for your favourite "i" loop
counter unless you really need it) and an ability to have double-precision
128-bit long longs in the distant future (if needed). 

 Any opinions?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
