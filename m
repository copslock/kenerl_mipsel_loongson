Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2003 17:30:06 +0100 (BST)
Received: from p508B7CAD.dip.t-dialin.net ([IPv6:::ffff:80.139.124.173]:49068
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225551AbTJHQaD>; Wed, 8 Oct 2003 17:30:03 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h98GU2NK020258;
	Wed, 8 Oct 2003 18:30:02 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h98GTxxP020250;
	Wed, 8 Oct 2003 18:29:59 +0200
Date: Wed, 8 Oct 2003 18:29:59 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Steve Scott <steve.scott@pioneer-pdt.com>
Cc: jsun@mvista.com, linux-mips@linux-mips.org,
	craig.mautner@pioneer-pdt.com
Subject: Re: schedule() BUG
Message-ID: <20031008162959.GB19102@linux-mips.org>
References: <FJEIIOCBFAIOIDNKLPFJCECODAAA.koji.kawachi@pioneer-pdt.com> <017601c38c77$6d7225a0$2256fea9@janelle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017601c38c77$6d7225a0$2256fea9@janelle>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 06, 2003 at 07:05:06PM -0700, Steve Scott wrote:

> We tried the fault.c patch Jun suggested, but it didn't solve the problem we were
> having with the BUG() in schedule(). The patch at the beginning of
> except_vec3_generic for the Vr5432 bug had previously been installed.
> 
> While chasing the BUG() in schedule(), though, we ran across another BUG() in
> alloc_skb() in ...linux/net/core/skbuff.c. :
> 
>     alloc_skb called nonatomically from interrupt 80117acc
>     kernel BUG at skbuff.c:179!
> 
> We changed the way sock_init_data initializes the 'allocation' field and
> were able to get past this one (see attached sock.c.patch). We're not sure
> if this fix needs to be permanent, or if it's just a temporary workaround.
> 
> For the schedule() BUG(), all evidence that we collected pointed to some
> interrupt causing us to reenter schedule() (i.e., somehow schedule() was
> called during an interrupt handler). We suspected something being run
> from the timer interrupt bottom half, but were never able to prove it. We
> also thought a remote possibility might be a pipeline hazard in the MIPS
> causing the EPC register not to update on a nested exception, but NEC says
> that can't happen on the Vr5432 that we're using...

Can't happen on any MIPS.

> We finally worked around the schedule BUG() by disabling interrupts
> during the context switch in schedule(). This workaround required changes
> in linux/kernel/sched.c and linux/arch/mips/kernel/r4k_switch.S (see attached
> patches).

Ouch.  Forgive but if I'd not already ignore these patches for being
ed-style I'd ignore them for being completly broken - these
patches are harmful for performance and probably not going to achieve
stability by anything other than luck ...

  Ralf
