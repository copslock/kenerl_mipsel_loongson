Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2003 15:45:24 +0100 (BST)
Received: from p508B618D.dip.t-dialin.net ([IPv6:::ffff:80.139.97.141]:37056
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225280AbTHFOpS>; Wed, 6 Aug 2003 15:45:18 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h76EjFpR002639;
	Wed, 6 Aug 2003 16:45:15 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h76EjEAE002638;
	Wed, 6 Aug 2003 16:45:14 +0200
Date: Wed, 6 Aug 2003 16:45:14 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: RM7k cache_flush_sigtramp
Message-ID: <20030806144513.GB12161@linux-mips.org>
References: <9DFF23E1E33391449FDC324526D1F259017DF091@SJC1EXM02> <3F30DFB7.8030304@ict.ac.cn> <20030806115531.GA12161@linux-mips.org> <3F30FA1E.3000002@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F30FA1E.3000002@ict.ac.cn>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 06, 2003 at 08:52:46PM +0800, Fuxin Zhang wrote:

> I am not sure. It is stardard X distribution from debian-woody. Fairly 
> easy to reproduce,just move the mouse
> around and click here and there then it would die. Will check this 
> later,but I think such a giant as Xserver won't fork frequently.

The scenario I was describing was just how we did originally discover the
bug.  Supposedly that was fixed but your register dump and dissassembly
show the exact fingerprint of that old problem, so I though I should
describe it in the hope it's going to help you.

> If the new process touch the cow page first,shouldn't it get a new page 
> and leave the original page for parent?
> If so,the parent should be able to see the trampoline content from 
> icache anyway(either L2 or memory should
> have the value),though the child may not?

RM7000 has a physically indexed cache.  That means if the copy of the
page wasn't explicitly or implicitly written back to L2 the process
whichever ends up with the copy of the page might fetch stale instructions
from memory - boom.

> >  not been flushed proplerly in the previous step, thereby failing to
> >  execute the trampoline - crash.
> >
> RM7000 has 16k 4-way set-associated primary caches,which are supposed to 
> have no cache aliasing problem

The described scenario is not an aliasing problem; it's the case where the
copy of the cow page hasn't properly been flushed at all.  When we
isolated the bug was that neither flush_page_to_ram() nor flush_cache_page()
were flushing the cache.  I suspect your case must be something fairly
similar.

  Ralf
