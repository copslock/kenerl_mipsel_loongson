Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 19:02:28 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:4766 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIDRC2>; Wed, 4 Sep 2002 19:02:28 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA17134;
	Wed, 4 Sep 2002 19:02:45 +0200 (MET DST)
Date: Wed, 4 Sep 2002 19:02:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Matthew Dharm <mdharm@momenco.com>
cc: Dominic Sweetman <dom@algor.co.uk>, Jun Sun <jsun@mvista.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Interrupt handling....
In-Reply-To: <20020904094014.B5241@momenco.com>
Message-ID: <Pine.GSO.3.96.1020904185544.10619L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 82
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 4 Sep 2002, Matthew Dharm wrote:

> And this is the heart of the problem.  I set up an ioremap, so I thought
> that the TLB exception handler would fix this for me.  It looks like that
> code won't do anything if the exception was generated from an interrupt...
> Or am I reading it wrong?  I'm not an expert on the TLB code...

 The kernel memory is unswappable so a PTE is always available.  If the
TLB refill handler cannot fetch it for some reason, then there is a bug
somewhere.  It might be helpful if you narrowed it down a bit -- refills
work correctly for modules, including interrupt handlers, and they reside
in KSEG2. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
