Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2003 15:23:38 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:42650 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225482AbTJOOX1>; Wed, 15 Oct 2003 15:23:27 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA10659;
	Wed, 15 Oct 2003 16:23:06 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 15 Oct 2003 16:23:06 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20031014132850.GA12938@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1031015161040.9299D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 14 Oct 2003, Ralf Baechle wrote:

> Still want more?  A 3 level tree would then cover 128TB of virtual
> address space already exceedin the hardware limits of all processors but
> the R8000.

 Well, the MIPS64 ISA spec allows up to 8EB of user memory to be supported
by an implementation, IIRC; probably nothing supports that much yet,
though. ;-)  BTW, is an R8000 spec available online anywhere?

> 64k pagesize stretches the limits even further.   Here a two level
> pagetable tree would cover 4TB, 3-level could cover 32PB exceeding
> the capacity of every MIPS processor ever made - and probably sufficient
> for the coming decade :-)

 Further increasing of the page size should result in better performance
due to fewer TLB misses and reduce the memory footprint of page tables,
but the drawback is more memory is wasted for maps.  Whether the end
result is a gain or a loss depends on the actual application of a system,
so I guess we should either leave the size configurable (with a sane
default for those who might have troubles judging what would suit them
best) or only decide on a given size after lots of benchmarking.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
