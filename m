Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 17:46:01 +0100 (BST)
Received: from p508B6C3A.dip.t-dialin.net ([IPv6:::ffff:80.139.108.58]:1359
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225794AbUDWQp7>; Fri, 23 Apr 2004 17:45:59 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3NGjcxT016564;
	Fri, 23 Apr 2004 18:45:38 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3NGjHmc016563;
	Fri, 23 Apr 2004 18:45:17 +0200
Date: Fri, 23 Apr 2004 18:45:17 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: MC Parity Error
Message-ID: <20040423164517.GA16401@linux-mips.org>
References: <20040423080247.GC5814@paradigm.rfc822.org> <Pine.LNX.4.55.0404231509190.14494@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0404231509190.14494@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 23, 2004 at 03:11:19PM +0200, Maciej W. Rozycki wrote:

> > success report for the MC Bus Error handler :)
> > 
> > Apr 19 23:17:32 resume kernel: MC Bus Error
> > Apr 19 23:17:32 resume kernel: CPU error 0x380<RD PAR > @ 0x0f4c6308
> > Apr 19 23:17:32 resume kernel: Instruction bus error, epc == 2accf310, ra == 2accf2c8
> > 
> > I guess i have bad memory. The interesting point is that the machine
> > continued to run for another 2 days. Shouldnt a memory error halt the
> > machine ?
> 
>  As it happened in the user mode, I'd expect only the victim process to be
> killed.

The KSU bits are meaningless.  On Indy like most other MIPS systems a
bus error exception may be delayed.  So the generic solution requires
tracking down the actual user, something which in the current kernel is
relativly easy due to rmap.

  Ralf
