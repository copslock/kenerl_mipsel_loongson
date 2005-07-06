Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2005 10:14:21 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:36872 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226322AbVGFJOG>; Wed, 6 Jul 2005 10:14:06 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j669ENtp008163;
	Wed, 6 Jul 2005 10:14:23 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j669EN1x008162;
	Wed, 6 Jul 2005 10:14:23 +0100
Date:	Wed, 6 Jul 2005 10:14:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	djohnson+linuxmips@sw.starentnetworks.com,
	linux-mips@linux-mips.org
Subject: Re: preempt_schedule_irq missing from mfinfo[]?
Message-ID: <20050706091423.GD3226@linux-mips.org>
References: <17093.19241.353160.946039@cortez.sw.starentnetworks.com> <20050703.005921.25910131.anemo@mba.ocn.ne.jp> <20050705200308.GE18772@linux-mips.org> <20050706.122912.71087098.nemoto@toshiba-tops.co.jp> <Pine.LNX.4.61L.0507060952500.9536@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507060952500.9536@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 06, 2005 at 09:58:50AM +0100, Maciej W. Rozycki wrote:

> > Yes, but many sleeping/scheduling (such as schedule_timeout(),
> > __down(), etc.)  are compiled without -fno-omit-frame-pointer, so
> > you can not find the caller of such functions anyway.
> 
>  Of course you can -- __builtin_return_address().  It should be enough for 
> `ps' to fetch useful data from "System.map", shouldn't it?

__builtin_return_address() is what those function could use themselves.
In this case it's about another piece of code unwinding the stackframe
until we hit a caller address that is not a scheduling function.

  Ralf
