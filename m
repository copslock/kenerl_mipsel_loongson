Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 18:28:40 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:23746 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIEQ2j>; Thu, 5 Sep 2002 18:28:39 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA09797;
	Thu, 5 Sep 2002 18:28:57 +0200 (MET DST)
Date: Thu, 5 Sep 2002 18:28:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: "Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020905151449.GB25023@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1020905181805.7444H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:

> My opinion is that N32 is good enough for people who are short on
> space.  We have too many MIPS ABIs already!

 You meant "there are", I suppose, as we (i.e. Linux) only really have a
single one right now -- o32.  And my opinion is we should carefully choose
additional ABIs for the 64-bit port based on technical superiority and
flexibility and do not blindly follow what others do.  To achieve this, we
do not even need to fiddle with the toolchain -- ELF file formats are
sufficient, binutils don't care and gcc may be set up as needed in a
configuration header.  All that matters is the kernel and libc. 

 That said, I do not assert my address/data model propsal is optimal --
this is subject to a discussion, but please keep non-technical arguments
away. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
