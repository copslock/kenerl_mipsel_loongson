Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 17:38:40 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:27592 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225241AbSLKRij>; Wed, 11 Dec 2002 17:38:39 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA27775;
	Wed, 11 Dec 2002 18:38:51 +0100 (MET)
Date: Wed, 11 Dec 2002 18:38:51 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
In-Reply-To: <20021211165854.GA12223@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1021211182901.22157N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 11 Dec 2002, Daniel Jacobowitz wrote:

> That way we expose more of the hardware to userland; and the thing
> that's most important to me is that GDB not have to know if it's on a
> MIPS32 or an R4650 when determining how watchpoints work. 
> IWatch/DWatch are two particular watchpoints or distinguished by access
> type?  I.E. what would GDB need to know to know which it is setting?

 The watchpoints would always be interfaced the same way, regardless of
the underlying implementation, of course.  For the IWatch/DWatch, I'd
assign their numbers somehow (e.g. IWatch is watchpoint #0 and DWatch is
#1, following the sequence used for their CP0 register numbers).  A user
such as GDB would have to determine the capabilities of all watchpoints as
I described and would discover that watchpoint #0 only accepts instruction
fetch events and watchpoint #1 only accepts data read/write ones.

 This way we can accept an arbitrary underlying implementation.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
