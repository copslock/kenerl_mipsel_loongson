Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Aug 2005 18:17:46 +0100 (BST)
Received: from static-151-204-232-50.bos.east.verizon.net ([IPv6:::ffff:151.204.232.50]:63382
	"EHLO mail2.sicortex.com") by linux-mips.org with ESMTP
	id <S8226023AbVHQRQ6>; Wed, 17 Aug 2005 18:16:58 +0100
Received: from gs104.sicortex.com (gs104.sicortex.com [10.0.1.104])
	by mail2.sicortex.com (Postfix) with ESMTP id 2D6AB1BF33F;
	Wed, 17 Aug 2005 13:21:22 -0400 (EDT)
From:	Joshua Wise <Joshua.Wise@sicortex.com>
Organization: SiCortex
To:	Stephen Hemminger <shemminger@osdl.org>
Subject: Re: NAPI poll routine happens in interrupt context?
Date:	Wed, 17 Aug 2005 13:21:18 -0400
User-Agent: KMail/1.8.1
Cc:	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Aaron Brooks <aaron.brooks@sicortex.com>
References: <200508170932.10441.Joshua.Wise@sicortex.com> <20050817094317.3437607e@dxpl.pdx.osdl.net>
In-Reply-To: <20050817094317.3437607e@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508171321.20094.Joshua.Wise@sicortex.com>
Return-Path: <Joshua.Wise@sicortex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Joshua.Wise@sicortex.com
Precedence: bulk
X-list: linux-mips

On Wednesday 17 August 2005 12:43, Stephen Hemminger wrote:
> You will get more response to network issues on netdev@vger.kernel.org
Okay. Thanks.

> NAPI poll is usually called from softirq context.  This means that
> hardware interrupts are enabled, but it is not in a thread context that
> can sleep.
Okay. I wasn't aware of quite how it was "supposed" to be.

> You shouldn't be calling things that could sleep! If you are it
> is a bug.
I guess I'd better track down this bug, then :)

> Harald Welte is working on a generic virtual Ethernet device, perhaps
> you could collaborate with him.
I assume he is on this mailing list?

> The bug is that ipv6 is doing an operation to handle MIB statistics and
> the MIPS architecture math routines seem to need to sleep.
> Previous versions of SNMP code may have done atomic operations, but
> current 2.6 code uses per-cpu variables.
> Also, there is no might sleep in the current 2.6 MIPS code either
> so the problem is probably fixed if you use current 2.6.12 or later
> kernel.
Hm -- I am using 2.6.13-rc2.
Here is a new trace, showing the same issue with IPv4:

Debug: sleeping function called from invalid context at 
arch/mips/math-emu/dsemul.c:137 
in_atomic():1, irqs_disabled():0
Call Trace:
 [<ffffffff801406e0>] __might_sleep+0x180/0x198 (kernel/sched.c:5223)
 [<ffffffff80101930>] mipsIRQ+0x130/0x1e0 (arch/mips/sc1000/mipsIRQ.S:95)
 [<ffffffff802860fc>] ip_rcv+0x9c/0x7b0 (net/ipv4/ip_input.c:381)
 [<ffffffff80140428>] do_dsemulret+0x68/0x1a0 
(arch/mips/math-emu/dsemul.c:137)
 [<ffffffff8010b3a4>] do_ade+0x24/0x550 (arch/mips/kernel/unaligned.c:506)
 [<ffffffff80102964>] handle_adel_int+0x3c/0x58 (arch/mips/kernel/genex.S:281)
 [<ffffffff80268260>] netif_receive_skb+0x1b0/0x2e0 (net/core/dev.c:1646)
 [<ffffffff80286100>] ip_rcv+0xa0/0x7b0 (net/ipv4/ip_input.c:394)
 [<ffffffff8014da5c>] printk+0x2c/0x38 (kernel/printk.c:515)
 [<ffffffff80268260>] netif_receive_skb+0x1b0/0x2e0 (net/core/dev.c:1646)
 [<ffffffff802573c8>] lanlan_poll+0x3e0/0x440 (drivers/net/lanlan.c:246)
etc, etc.

CC:'ing to linux-mips for obvious reasons. This seems to stem from an 
unaligned access. If this is no longer appropriate for linux-kernel, feel 
free to stop CCing to there, and I will follow.

Thanks,
joshua
