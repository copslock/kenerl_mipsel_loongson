Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2003 17:33:54 +0100 (BST)
Received: from p508B6021.dip.t-dialin.net ([IPv6:::ffff:80.139.96.33]:34491
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225365AbTJWQds>; Thu, 23 Oct 2003 17:33:48 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9NGXdNK014277;
	Thu, 23 Oct 2003 18:33:39 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9NGXV1b014276;
	Thu, 23 Oct 2003 18:33:31 +0200
Date: Thu, 23 Oct 2003 18:33:31 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf R?sch <ralf.roesch@rw-gmbh.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Compiler Problems in tlbex-r4k.S
Message-ID: <20031023163331.GA27437@linux-mips.org>
References: <NHBBLBCCGMJFJIKAMKLHOEIJCBAA.ralf.roesch@rw-gmbh.de> <Pine.GSO.4.21.0310231142250.27218-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0310231142250.27218-100000@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 23, 2003 at 11:43:27AM +0200, Geert Uytterhoeven wrote:

> > If I change the line 43 from:
> > #define PTE_PAGE_SIZE	(1L << PTE_PAGE_SHIFT)
> > to
> > #define PTE_PAGE_SIZE	(1 << PTE_PAGE_SHIFT)
> > the compiling is o.k.

The fix for this went into CVS yesterday.

> That's a programming error. The assembler doesn't know 1L, it needs plain 1.
> 
> Yes, it makes life hard, if you want to share your definitions between the
> C compiler and the assembler.

It's a PITA that gas doesn't accept constants in the same syntax as C
does.  It means we have to extract many constants into offset.h before
they can be used in assembler code.  One of the small things on my
wishlist for x-mas ;-)

  Ralf
