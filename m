Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2004 09:39:04 +0100 (BST)
Received: from p508B7001.dip.t-dialin.net ([IPv6:::ffff:80.139.112.1]:3686
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225248AbUDBIjC>; Fri, 2 Apr 2004 09:39:02 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i328d1oM019720;
	Fri, 2 Apr 2004 10:39:01 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i328d0P0019719;
	Fri, 2 Apr 2004 10:39:00 +0200
Date: Fri, 2 Apr 2004 10:39:00 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Brian Murphy <brian@murphy.dk>
Cc: linux-mips@linux-mips.org
Subject: Re: BUG in pcnet32.c?
Message-ID: <20040402083900.GB19375@linux-mips.org>
References: <4068809F.8070103@murphy.dk> <4068864D.1020209@realitydiluted.com> <406B2E90.5060307@murphy.dk> <20040401173154.GA30634@linux-mips.org> <406D240C.8020208@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406D240C.8020208@murphy.dk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 02, 2004 at 10:27:56AM +0200, Brian Murphy wrote:

> >The more information BUG or BUG_ON provide the bigger the kernel gets.
> >Using a simple break instruction was simply the smallest thing.  The
> >previous, just slightly more verbose BUG() implementation did result
> >in ~ 87k of bloat ...
> > 
> >
> Perhaps you could mention this usage of break explicitly in the message 
> in do_bp.

That's easy, BUG() and BUG_ON() if the condition was met use a break
instruction.

  Ralf
