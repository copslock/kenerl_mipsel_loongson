Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 14:15:33 +0100 (BST)
Received: from p508B6C3A.dip.t-dialin.net ([IPv6:::ffff:80.139.108.58]:63052
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225737AbUDWNPc>; Fri, 23 Apr 2004 14:15:32 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3NDF6xT016654;
	Fri, 23 Apr 2004 15:15:06 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3NDEjKJ016651;
	Fri, 23 Apr 2004 15:14:45 +0200
Date: Fri, 23 Apr 2004 15:14:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Bradley D. LaRonde" <brad@laronde.org>, linux-mips@linux-mips.org
Subject: Re: inconsistent operand constraints in 'asm' in unaligned.h:66 using gcc 3.4
Message-ID: <20040423131445.GA16274@linux-mips.org>
References: <06d601c428e2$3ba1dcc0$8d01010a@prefect> <Pine.LNX.4.55.0404231454120.14494@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0404231454120.14494@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 23, 2004 at 03:07:43PM +0200, Maciej W. Rozycki wrote:

> I'm pretty sure it works fine with gcc 2.95.x as well -- for Alpha it used
> to, even with such antiques as egcs 1.1.2.
> 
>  Ralf, I can see 2.6 already does the right thing -- I suppose you won't
> mind me backporting (copying?) it?

I certainly won't.  I think the 2.4 implementation was originally written
necessary upto egcs 1.0 which were generating correct but very inefficient
code for __attribute((packed)).

  Ralf
