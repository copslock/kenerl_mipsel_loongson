Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 19:49:51 +0100 (BST)
Received: from p508B5F50.dip.t-dialin.net ([IPv6:::ffff:80.139.95.80]:46757
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225474AbTI3Stt>; Tue, 30 Sep 2003 19:49:49 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8UIm1NK013678;
	Tue, 30 Sep 2003 20:48:01 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8UIluaY013677;
	Tue, 30 Sep 2003 20:47:56 +0200
Date: Tue, 30 Sep 2003 20:47:55 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Finney, Steve" <Steve.Finney@SpirentCom.COM>,
	linux-mips@linux-mips.org
Subject: Re: 64 bit operations w/32 bit kernel
Message-ID: <20030930184755.GA12599@linux-mips.org>
References: <20030930160023.GB4231@linux-mips.org> <Pine.GSO.3.96.1030930195415.11368C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030930195415.11368C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 30, 2003 at 08:04:42PM +0200, Maciej W. Rozycki wrote:

> > > What would be the downside to enabling 64 bit operations in user space
> > > on a 32 bit kernel (setting the PX bit in the status register?). The
> > > particular issue is that I want to access 64 bit-memory mapped registers,
> > > and I really need to do it as an atomic operation. I tried borrowing
> > > sibyte/64bit.h from the kernel, but I get an illegal instruction on the
> > > double ops.
> > 
> > Common design bug in hardware, imho ...
> 
>  Well, ioremap() can be used to get at these areas (as well as any
> others), whether we call it a bug or not.

What I called a bug is the necessity to access hardware registers with
64-bit loads and stores in some systems as opposed to of 32-bit
instructions - that simply doesn't work from 32-bit universes.

To clarify, it was my understanding of Steve's problem he needs 64-bit
loads and stores, not something in the 64-bit physical address space.
The later problem obviously would get a different answer.

  Ralf
