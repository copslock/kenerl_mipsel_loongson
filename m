Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Aug 2003 18:02:58 +0100 (BST)
Received: from p508B60FA.dip.t-dialin.net ([IPv6:::ffff:80.139.96.250]:52918
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225347AbTHBRC4>; Sat, 2 Aug 2003 18:02:56 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h72H2opR005047;
	Sat, 2 Aug 2003 19:02:50 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h72H2kua005046;
	Sat, 2 Aug 2003 19:02:46 +0200
Date: Sat, 2 Aug 2003 19:02:46 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: Dominic Sweetman <dom@mips.com>,
	Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	linux-mips@linux-mips.org
Subject: Re: RM7k cache_flush_sigtramp
Message-ID: <20030802170245.GA19401@linux-mips.org>
References: <9DFF23E1E33391449FDC324526D1F259017DF087@SJC1EXM02> <16170.7179.635988.268987@doms-laptop.algor.co.uk> <20030801092649.GA17624@linux-mips.org> <3F2A76CA.4080904@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2A76CA.4080904@ict.ac.cn>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 01, 2003 at 10:18:50PM +0800, Fuxin Zhang wrote:

> I just run a fresh new 2.4.21 kernel on my board, no luck.  The problem 
> remains.  But I notice that my hardware may have some problems,
> especially with the add-on ide card. Keep headaching...
> 
> As to the discussion of SYNC, I can't help wondering whether the cache 
> management should be totally hidden from programmers. People tends to
> write "safetest" code because of all kinds of brain-damage different
> hardware, which leads to inefficient code. And this will cancel out the
> potential speed benefit of simpler hardware. Also today's hardware seems
> not as expensive as it was before...

Cache managment needs to be somehow hidden from programmers as well as
possible - the average programmer has no clue about how caches work.
We've come up with an API that hides the actual functioning of caches
pretty well for DMA devices, see Documentation/DMA-mapping.txt and in
2.6 also a more generalized version documented in Documentation/DMA-API.txt.

  Ralf
