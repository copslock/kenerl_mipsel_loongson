Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2005 15:43:26 +0100 (BST)
Received: from p549F3E3E.dip.t-dialin.net ([IPv6:::ffff:84.159.62.62]:32435
	"EHLO bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225355AbVFYOnK>; Sat, 25 Jun 2005 15:43:10 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j5PEfuMs019096;
	Sat, 25 Jun 2005 15:41:56 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j5PEfs2i019095;
	Sat, 25 Jun 2005 16:41:54 +0200
Date:	Sat, 25 Jun 2005 16:41:54 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	madprops@gmx.net, linux-mips@linux-mips.org
Subject: Re: tlb magic
Message-ID: <20050625144154.GO6953@linux-mips.org>
References: <17069.62407.584863.185198@mips.com> <18788.1118764826@www21.gmx.net> <17084.61658.662352.432937@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17084.61658.662352.432937@mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jun 25, 2005 at 06:51:22AM +0100, Dominic Sweetman wrote:

> Current Linux systems accept more computation in the TLB miss
> handler in order to use largely portable data structures for keeping
> page tables.  You can always push at that trade-off...

Further tuning is on the Linux agenda.  Right now we've got a rather fancy
implementation of a slow (relativly speaking) but portable algorithm.
The most useful useful trick of all will be increasing the pagesize to
grow beyond the small pagesize of 4k - for expected significant
performance benefits because the the TLB reach will increase but also
virtual aliases will go away on about anything but R4000SC returning us
to the promised lands of simplicity of cache managment :-)

  Ralf
