Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 00:15:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:61162 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023858AbXJBXPt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 00:15:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l92NFmXJ003645;
	Wed, 3 Oct 2007 00:15:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l92NFmre003644;
	Wed, 3 Oct 2007 00:15:48 +0100
Date:	Wed, 3 Oct 2007 00:15:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Fuxin Zhang <fxzhang@ict.ac.cn>, linux-mips@linux-mips.org
Subject: Re: cmpxchg broken in some situation
Message-ID: <20071002231548.GA1240@linux-mips.org>
References: <46FF7BC2.5050905@ict.ac.cn> <20071001025340.GA7091@linux-mips.org> <47010E15.7060109@ict.ac.cn> <20071001152620.GB15820@linux-mips.org> <470210B4.8020902@ict.ac.cn> <20071002103551.GB5152@linux-mips.org> <20071002142210.GD16772@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071002142210.GD16772@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 02, 2007 at 03:22:10PM +0100, Thiemo Seufer wrote:

> > +#define __cmpxchg(ptr,old,new,barrier)					\
> > +({									\
> > +	__typeof__(ptr) __ptr = (ptr);					\
> > +	__typeof__(*(ptr)) __old = (old);				\
> > +	__typeof__(*(ptr)) __new = (new);				\
> > +	__typeof__(*(ptr)) __res = 0;					\
> 
> Maybe we need an acquire barrier here for some systems.

Release you meant.  The acquire lock would be at the end.  Documentation
and actual implmeentations of cmpxchg seem to differ.  It's a relativly
rarely used primitve so I think I err on the side of paranoia for now
and throw in the additional SYNC you suggest.

  Ralf
