Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2002 13:42:26 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:61890 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123899AbSIXLmZ>; Tue, 24 Sep 2002 13:42:25 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA29466;
	Tue, 24 Sep 2002 13:42:47 +0200 (MET DST)
Date: Tue, 24 Sep 2002 13:42:47 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: linux-mips@linux-mips.org
Subject: Re: FCSR Management
In-Reply-To: <008801c2639f$385b1b80$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1020924133932.29072A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 24 Sep 2002, Kevin D. Kissell wrote:

> dump core, so the user never executes again.  But *if*
> the user has registered a handler for SIGFPE, and one
> of the IEEE exceptions occurs, I don't see where the
> associated Cause bit is being cleared, and I would think
> that the consequence would be that the process would
> get into an endless loop of trapping, posting the signal,
> restoring the FCSR from the context with the bits set,
> and trapping again, whether or not the PC is modified
> to avoid re-executing the faulting instruction.

 Obviously user code is responsible to clear the bit it acted upon in the
saved context. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
