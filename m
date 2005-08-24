Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2005 16:19:43 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:61212 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225256AbVHXPT1>; Wed, 24 Aug 2005 16:19:27 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7OFOjkg011953;
	Wed, 24 Aug 2005 16:24:45 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7OFOjbo011952;
	Wed, 24 Aug 2005 16:24:45 +0100
Date:	Wed, 24 Aug 2005 16:24:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: custom ide driver causes "Badness in smp_call_function"
Message-ID: <20050824152444.GE2783@linux-mips.org>
References: <20050823140159Z8225393-3678+7283@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050823140159Z8225393-3678+7283@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 23, 2005 at 10:07:02AM -0400, Bryan Althouse wrote:

> I have added a compact flash disk onto the local bus of an rm9224 mips
> processor.  We are using an FPGA as an IDE host adaptor.  Our driver works
> great when the kernel is compiled for a single processor.  But if SMP
> support is enabled, the kernel dies with: 
>             .
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> Ide:  Assuming 50MHz system bus speed for PIO modes; override with
> idebuss=xx
> Badness in smp_call_function at arch/mips/kernel/smp.c:149

That's just a rather drastically looking warning, btw.

> Call Trace:
>  [<ffffffff8010aff8>] smp_call_function+0x1f8/0x200
>  [<ffffffff8032adb0>] schedule+0x950/0xa08
>  [<ffffffff8010b9f8>] local_rm9k_perfcounter_irq_startup+0x0/0x68
>  [<ffffffff8010baa8>] rm9k_perfcounter_irq_startup+0x48/0x68
>  [<ffffffff801658b8>] probe_irq_on+0x2b8/0x2e8
>  [<ffffffff80146c00>] del_singleshot_timer_sync+0x38/0x50
>  [<ffffffff8028e510>] try_to_identify+0x180/0x190
>  [<ffffffff80147d88>] process_timeout+0x0/0x8
>  [<ffffffff8028e66c>] do_probe+0x14c/0x338
>  [<ffffffff8028e57c>] do_probe+0x5c/0x338
>  [<ffffffff8028ec40>] wait_hwif_ready+0x178/0x180
>  [<ffffffff8028f230>] probe_hwif+0x508/0x6e8
>  [<ffffffff8028eec8>] probe_hwif+0x1a0/0x6e8
>  [<ffffffff8028f42c>] probe_hwif_init_with_fixup+0x1c/0xe8
>  [<ffffffff8029435c>] ide_3P_init+0xb4/0x118
>  [<ffffffff80294324>] ide_3P_init+0x7c/0x118
>  [<ffffffff8023d100>] idr_get_new+0x18/0x50
> etc. 
> 
> Does anyone know what sort of bug could cause problems with SMP, but would
> work fine otherwise?  I could supply my driver code if anyone is interested.
> Thanks!

Your driver is probably fine.  The problem is that doing PIO may result in
cache aliases and that requires a cache flush.  Normally that's not
terribly hard to do - but in your case an SMP cacheflush is needed which
in turn requires smp_call_function to be used and that one again may
deadlock if called with interrupts disabled.  See also
include/asm-mips/mach-generic/ide.h.

So until we have a better implementation I suggest try to avoid the use
of ide_inb() etc. with interrupts disabled.

  Ralf
