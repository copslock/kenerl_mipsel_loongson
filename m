Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jun 2013 22:11:30 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44433 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819546Ab3FUUL2sPfGE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jun 2013 22:11:28 +0200
Received: from unknown (dslb-088-073-012-093.pools.arcor-ip.net [88.73.12.93])
        by mail.nanl.de (Postfix) with ESMTPSA id 8EEEF40154;
        Fri, 21 Jun 2013 20:11:22 +0000 (UTC)
Date:   Fri, 21 Jun 2013 22:11:29 +0200
From:   Jonas Gorski <jogo@openwrt.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Jayachandran C <jchandra@broadcom.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH V3] MIPS: flush TLB handlers directly after writing them
Message-ID: <20130621221129.00006552@unknown>
In-Reply-To: <51C4A5A5.9050201@gmail.com>
References: <1371840528-5207-1-git-send-email-jogo@openwrt.org>
        <51C4A5A5.9050201@gmail.com>
Organization: OpenWrt
X-Mailer: Claws Mail 3.9.0cvs12 (GTK+ 2.16.6; i586-pc-mingw32msvc)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, 21 Jun 2013 12:12:37 -0700
David Daney <ddaney.cavm@gmail.com> wrote:

> A couple of thoughts about this...
> 
> On 06/21/2013 11:48 AM, Jonas Gorski wrote:
> > When having enabled MIPS_PGD_C0_CONTEXT, trap_init() might call the
> > generated tlbmiss_handler_setup_pgd before it was committed to memory,
> > causing boot failures:
> >
> >    trap_init()
> >     |- per_cpu_trap_init()
> >     |   |- TLBMISS_HANDLER_SETUP()
> >     |       |- tlbmiss_handler_setup_pgd()
> >     |- flush_tlb_handlers()
> >
> > To avoid this, move flush_tlb_handlers() into build_tlb_refill_handler()
> > right after they were generated. We can do this as the cache handling is
> > initialized just before creating the tlb handlers.
> >
> > This issue was introduced in 3d8bfdd0307223de678962f1c1907a7cec549136
> > ("MIPS: Use C0_KScratch (if present) to hold PGD pointer.").
> >
> > Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> > ---
> > @Ralf, this is a direct replacement for V2.
> >
> > V2 -> V3:
> >   * Move flush_tlb_handlers() call into build_tlb_refill_handler() as
> >     suggested by Jayachandran C.
> >   * Make it static as now doesn't need to be called from external anymore.
> >   * Move it on top of build_tlb_refill_handler() to avoid having to add a
> >     prototype for it.
> >
> > V1 -> V2:
> >   * Move flush_tlb_handlers into per_cpu_trap_init() to also fix it for
> >     !boot_cpu.
> >
> >   arch/mips/kernel/traps.c |    2 --
> >   arch/mips/mm/tlbex.c     |   30 ++++++++++++++++--------------
> >   2 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> > index 142d2be..f44366d 100644
> > --- a/arch/mips/kernel/traps.c
> > +++ b/arch/mips/kernel/traps.c
> > @@ -1668,7 +1668,6 @@ void *set_vi_handler(int n, vi_handler_t addr)
> >   }
> >
> >   extern void tlb_init(void);
> > -extern void flush_tlb_handlers(void);
> >
> >   /*
> >    * Timer interrupt
> > @@ -1997,7 +1996,6 @@ void __init trap_init(void)
> >   		set_handler(0x080, &except_vec3_generic, 0x80);
> >
> >   	local_flush_icache_range(ebase, ebase + 0x400);
> > -	flush_tlb_handlers();
> >
> >   	sort_extable(__start___dbe_table, __stop___dbe_table);
> >
> > diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> > index f1eabe7..02b1b22 100644
> > --- a/arch/mips/mm/tlbex.c
> > +++ b/arch/mips/mm/tlbex.c
> > @@ -2192,6 +2192,20 @@ static void __cpuinit build_r4000_tlb_modify_handler(void)
> >   	dump_handler("r4000_tlb_modify", handle_tlbm, ARRAY_SIZE(handle_tlbm));
> >   }
> >
> > +static void __cpuinit flush_tlb_handlers(void)
> > +{
> > +	local_flush_icache_range((unsigned long)handle_tlbl,
> > +			   (unsigned long)handle_tlbl + sizeof(handle_tlbl));
> > +	local_flush_icache_range((unsigned long)handle_tlbs,
> > +			   (unsigned long)handle_tlbs + sizeof(handle_tlbs));
> > +	local_flush_icache_range((unsigned long)handle_tlbm,
> > +			   (unsigned long)handle_tlbm + sizeof(handle_tlbm));
> > +#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
> > +	local_flush_icache_range((unsigned long)tlbmiss_handler_setup_pgd_array,
> > +			   (unsigned long)tlbmiss_handler_setup_pgd_array + sizeof(handle_tlbm));
> > +#endif
> > +}
> > +
> 
> 1) Why not move the local_flush_icache_range() into the build_*
>     function right after the point where the instructions are written
>     to their final location?
> 
>     Having this out-of-line flusher seems like it is patching up
>     something we forgot to do when we generated the code.

This was done this way for historical reasons, at least I was told so.
but whatever was resonsible for that isn't true anymore.

This sounds like a good clean up, but I think this is rather something
for a follow up patch (just like fixing the end argument for the last
cache flush that uses the wrong array for sizeof).


> 2) Also what happens on the other CPUs?  Don't they need their icache
>     invalidated as well?  How is that handled?

The cache_init() called directly before flush_tlb_handlers() flushes
all caches, except on the boot cpu, where the flush was done before the
handlers are build.

> 3) Why is is called local_flush_icache_range?  It seems like
>     local_invalidate... would be better

local_flush_icache_range() also flushes the dcache if necessary. So perhaps it
should be called
local_invalidate_icache_and_maybe_flush_dcache_range ;-).

It seems all icache invalidate functions are named "flush". Not sure if
it's worth "fixing" the naming.



Jonas
