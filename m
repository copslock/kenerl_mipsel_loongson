Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Feb 2004 13:45:57 +0000 (GMT)
Received: from p508B6DA8.dip.t-dialin.net ([IPv6:::ffff:80.139.109.168]:39975
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225232AbUBRNp4>; Wed, 18 Feb 2004 13:45:56 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i1IDjJex025118;
	Wed, 18 Feb 2004 14:45:19 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i1IDj1Kg025116;
	Wed, 18 Feb 2004 14:45:01 +0100
Date: Wed, 18 Feb 2004 14:45:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Indigodfw <indigodfw@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: question about memory constraint in atomic_add
Message-ID: <20040218134501.GA24330@linux-mips.org>
References: <20040214151152.80368.qmail@web9502.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214151152.80368.qmail@web9502.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 14, 2004 at 07:11:52AM -0800, Indigodfw wrote:

> 2. Result of (C expression) should go into %xyz
> register 
> So v->counter goes into %1, IOW ll from an int!
> 
> Does not make sense to me.
> Why does it work, What am I missing?

> I mean in general what is the expression for a m
> constraint ptr (because I want ptr to be in regiser)
> or *ptr (because I wanna tell compiler that *ptr is
> what gets changed) 

"m" gives you *something* suitable to address a memory object; that isn't
necessarily a memory address.  On MIPS it can't even be just an address
in a register because "m" constraints are used with loads and stores and
those only accept the offset(reg) addressing mode.  If you want an address
use something like "r" (&v->counter), then lw reg,(%xxx).

  Ralf
