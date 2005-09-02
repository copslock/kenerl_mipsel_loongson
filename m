Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2005 12:55:18 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:34213 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8224772AbVIBLzB>;
	Fri, 2 Sep 2005 12:55:01 +0100
Received: from port-195-158-167-225.dynamic.qsc.de ([195.158.167.225] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1EBAEV-000675-00
	for linux-mips@linux-mips.org; Fri, 02 Sep 2005 14:01:23 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1EBAEX-0007wi-9n
	for linux-mips@linux-mips.org; Fri, 02 Sep 2005 14:01:25 +0200
Date:	Fri, 2 Sep 2005 14:01:25 +0200
To:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050902120125.GC4751@hattusa.textio>
References: <20050902095417Z8224772-3678+8160@linux-mips.org> <Pine.LNX.4.61L.0509021231390.19580@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0509021231390.19580@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.10i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Fri, 2 Sep 2005 ths@linux-mips.org wrote:
> 
> > Modified files:
> > 	arch/mips/mm   : c-r4k.c 
> > 
> > Log message:
> > 	Fix r4600 revision bitmask.
> 
>  This change is broken.  The new masked out value may match a 
> MIPS32/MIPS64 architecture CPU.  What was wrong with the old mask?

Hm, I made it the same as is used in pg-r4k.c without looking up
the meaning of the high bits.


Thiemo
