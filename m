Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 15:49:37 +0000 (GMT)
Received: from p508B78F8.dip.t-dialin.net ([IPv6:::ffff:80.139.120.248]:27989
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225226AbUBCPtg>; Tue, 3 Feb 2004 15:49:36 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i13FnZex001531;
	Tue, 3 Feb 2004 16:49:35 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i13FnZX8001530;
	Tue, 3 Feb 2004 16:49:35 +0100
Date: Tue, 3 Feb 2004 16:49:35 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20040203154935.GB1018@linux-mips.org>
References: <20040202141939Z8225226-9616+1555@linux-mips.org> <Pine.LNX.4.55.0402021611490.6182@jurand.ds.pg.gda.pl> <20040202152307.GB28673@linux-mips.org> <Pine.LNX.4.55.0402031612100.16076@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0402031612100.16076@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 03, 2004 at 04:30:33PM +0100, Maciej W. Rozycki wrote:

> > >  How do we assure tails of interrupt handlers don't trigger the errata?
> > 
> > The problem can only be triggered if instructions surrounding the
> > cacheop use the dcache; exceptions such as interrupts are not relevant.
> 
>  Why?  How is an "eret" with its preceding instructions different to other 
> instructions?  There may be a data cache miss soon before an "eret" and 
> the response buffer may contain data.  And you may get an exeption right 
> before a CACHE instruction.
>
> > Which I'm really happy about.  Disabling interrupts is a problem in cases
> > were we can't avoid page faults.
> 
>  I worry this is unsafe and given the unlikeliness of getting an interrupt
> just between the dummy load and the CACHE instruction, this change creates
> a completely obscure bug that'll bite unpredictably and possibly
> invisibly, just corrupting data, every once and then.  But the situation
> may be not that bad -- what does exactly happen when the erratum gets 
> triggered?  Missing a Create_Dirty_Excl_D operation should itself be a 
> performance hit only, but given the problems reported I suppose data gets 
> corrupted, either in the cache or in the main memory.  Am I right?

I don't know details but since the person who answered my question was
directly working on the CPU design I have to take that as authoritative
information and after all, the systems seems stable.

Daring a guess, the CPU restarts the pipeline following an eret therefore
instructions preceeding the eret can't cause the problem.

  Ralf
