Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 18:53:54 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:55772 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224847AbSLDRxx>; Wed, 4 Dec 2002 18:53:53 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA09228;
	Wed, 4 Dec 2002 18:54:02 +0100 (MET)
Date: Wed, 4 Dec 2002 18:54:02 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
In-Reply-To: <20021204155128.GA18940@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1021204182756.29982G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 4 Dec 2002, Daniel Jacobowitz wrote:

> Sorry, by "not handy" I meant I didn't have the manuals available :)

 'http://www.mips.com/Documentation/R4400_Uman_book_Ed2.pdf' or see under
"Publications"/"R4000...".  There are other sources of the book available,
e.g. somewhere within SGI web pages.  R10k implements a single watchpoint
this way, too. 

> >  What do you think?
> 
> You don't reveal to userland what size watchpoints are available - i.e.
> how large a watchpoint can be.  Does the mask match the hardware
> implementation, and what are the restrictions on it?

 For that you set up a disabled watchpoint with a mask set to all ones (or
the range you are interested in).  Then when you retrieve it, you may see
which bits stayed at ones.  Similarly you may check for hardwired
don't-cares by using a mask with all zeroes.  The mask may differ for each
watchpoint, e.g. for R4650 it's different for IWatch and DWatch, so you
really want to have a per-watchpoint setting.  Also the MIPS32/64 ISA
specification implies a mask need not be contiguous. 

 Similarly you may check for access types permitted, by enabling all of
them (or ones you are interested in) and seeing which ones remained
enabled.  Per-watchpoint, again. 

 I'd prefer not to overdesign the API leaving as much information as
possible passed as is.  This way userland gets more control over what's
available.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
