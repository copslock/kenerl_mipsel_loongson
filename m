Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 13:37:52 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:6820 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039159AbWLGNhu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Dec 2006 13:37:50 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB7Dbjqu003401;
	Thu, 7 Dec 2006 13:37:46 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB7Dbhbq003400;
	Thu, 7 Dec 2006 13:37:43 GMT
Date:	Thu, 7 Dec 2006 13:37:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
Message-ID: <20061207133743.GA3373@linux-mips.org>
References: <20061205194907.GA1088@linux-mips.org> <20061205195702.GA2097@linux-mips.org> <cda58cb80612060040o17ec40f3x4c2f7d0037d3cd1@mail.gmail.com> <20061207.121702.108739943.nemoto@toshiba-tops.co.jp> <20061207115035.GA15386@linux-mips.org> <Pine.LNX.4.64N.0612071329530.22220@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0612071329530.22220@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 07, 2006 at 01:32:25PM +0000, Maciej W. Rozycki wrote:

> From:	"Maciej W. Rozycki" <macro@linux-mips.org>
> > > Also I think most codes in vr41xx/nec-cmbvr4133/irq.c can be removed
> > > if we made I8259A_IRQ_BASE customizable, but that would be another
> > > story...
> > 
> > This number is fixed to zero because that's what all the old ISA drivers
> > expect, the ISA boards have printed on etc...
> 
>  Well, it's probably that nobody has been brave enough to tackle it yet. 
> ;-)

I just think this problem should better be unsolved ;-)

  Ralf
