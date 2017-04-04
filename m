Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2017 22:10:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7651 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993009AbdDDUKDOP6JP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2017 22:10:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7BF903025F132;
        Tue,  4 Apr 2017 21:09:17 +0100 (IST)
Received: from [10.20.78.40] (10.20.78.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 4 Apr 2017
 21:09:20 +0100
Date:   Tue, 4 Apr 2017 21:09:05 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3] MIPS: Avoid warnings from use of dla in 32 bit
 kernels
In-Reply-To: <9459713.IbS6oA1Njj@np-p-burton>
Message-ID: <alpine.DEB.2.00.1704042009530.25796@tp.orcam.me.uk>
References: <20170330214838.5828-1-paul.burton@imgtec.com> <alpine.DEB.2.00.1703310441420.5644@tp.orcam.me.uk> <9459713.IbS6oA1Njj@np-p-burton>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.20.78.40]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Tue, 4 Apr 2017, Paul Burton wrote:

> >  This is however exactly what we do in several places, and I would
> > recommend here as well.  Can you point me at the earlier review of your
> > proposal?
> 
> The first 2 revisions of the patch, which did include asm/asm.h & use PTR_LA, 
> can be found in patchwork:

 Thanks for the pointers!

>   https://patchwork.linux-mips.org/patch/12436/

 NB contrary to what Ralf says this `.set' can go as this definition is 
conditional on (defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)), 
so we must have the ISA level already set here to one supporting JR.HB.

> > > Instead fix this by adding a ".set gp=64" directive to inform the
> > > assembler that general purpose registers are 64 bit for the dla
> > > instruction. This is a lie, but no more so than using the dla
> > > instruction to begin with.
> > 
> >  I agree using DLA unconditionally is wrong, so if using <asm/asm.h> and
> > its PTR_LA turns out infeasible indeed, then please define a local macro
> > that expands to LA or DLA as appropriate and does not cause a namespace
> > issue, and use it in `instruction_hazard' (all instances) rather than this
> > horrible hack.
> 
> Horrible though the use of dla may be at first glance, I do wonder if it 
> actually makes sense to just keep it. Presumably Ralf thought it made sense 
> when he added it in 7043ad4f4c81 ("MIPS: R2: Try to bulletproof 
> instruction_hazard against miss-compilation."). The presumption is simply that 
> the dla pseudo-instruction won't result in any MIPS64 instructions being 
> emitted when used on a 32 bit canonical address, which might not be "nice" but 
> then neither is the #ifdef solution.

 These days it qualifies for `asm goto' (and Ralf was correct with his 
commit in that regular `asm' does not support such constructs), however we 
surely still want to support GCC versions that do not have it.

 Your proposed change actually reveals a bug in GAS in that LA and DLA are 
supposed to warn on the address size mismatch.  And the address size is 
set by the ABI selected.  That means DLA is supposed to warn (effectively) 
with `-mabi=32' and `-mabi=n32' and likewise LA with `-mabi=64' (there are 
some complications around `-mabi=64 -msym32' I do not want to dive into 
here).  Using `.set gp=64' should not make a difference, because it does 
not affect the ABI selected and consequently the address size (of course 
some `.set gp=' settings will be invalid depending on other settings).

 So as soon as this corner case has been fixed in GAS, you'll get assembly 
warnings again -- which is why I advise against your hack.

 And whether you like the #ifdef solution or not it has the advantage of 
letting you do this correctly rather than by chance.

> I had lost track of what the build failures were when including asm/asm.h, but 
> reverting to v2 of my patch & building all defconfigs shows a number of 
> issues.
> 
> For example, from mtx1_defconfig:
> 
>   CC [M]  drivers/net/ethernet/fealnx.o
> In file included from ./arch/mips/include/asm/hazards.h:15:0,
>                  from ./arch/mips/include/asm/mipsregs.h:18,
>                  from ./arch/mips/include/asm/mach-generic/spaces.h:15,
>                  from ./arch/mips/include/asm/addrspace.h:13,
>                  from ./arch/mips/include/asm/barrier.h:11,
>                  from ./arch/mips/include/asm/bitops.h:18,
>                  from ./include/linux/bitops.h:36,
>                  from ./include/linux/kernel.h:10,
>                  from ./include/linux/list.h:8,
>                  from ./include/linux/module.h:9,
>                  from drivers/net/ethernet/fealnx.c:71:
> ./arch/mips/include/asm/asm.h:318:15: error: expected identifier before ‘.’ 
> token
>  #define LONG  .word
>                ^
> drivers/net/ethernet/fealnx.c:261:2: note: in expansion of macro ‘LONG’
>   LONG = 0x20,  /* long packet received */
>   ^
> 
> Or from rm200_defconfig:
> 
>   CC      arch/mips/sni/setup.o
> In file included from ./arch/mips/include/asm/hazards.h:15:0,
>                  from ./arch/mips/include/asm/mipsregs.h:18,
>                  from ./arch/mips/include/asm/mach-generic/spaces.h:15,
>                  from ./arch/mips/include/asm/addrspace.h:13,
>                  from ./arch/mips/include/asm/barrier.h:11,
>                  from ./arch/mips/include/asm/bitops.h:18,
>                  from ./include/linux/bitops.h:36,
>                  from ./include/linux/kernel.h:10,
>                  from ./include/linux/list.h:8,
>                  from ./include/linux/kobject.h:20,
>                  from ./include/linux/device.h:17,
>                  from ./include/linux/eisa.h:5,
>                  from arch/mips/sni/setup.c:11:
> ./arch/mips/include/asm/asm.h:318:15: error: expected identifier or ‘(’ before 
> ‘.’ token
>  #define LONG  .word
>                ^
> ./arch/mips/include/asm/fw/arc/types.h:18:15: note: in expansion of macro 
> ‘LONG’
>  typedef long  LONG __attribute__ ((__mode__ (__SI__)));
> 
> Other builds that include asm/fw/arc/types.h of course fail similarly, for 
> example ip22_defconfig, ip27_defconfig, ip28_defconfig, ip32_defconfig & 
> jazz_defconfig all fail to build when asm/hazards.h includes asm/asm.h.

 Thanks for these results.  Arguably it's drivers/net/ethernet/fealnx.c 
and asm/fw/arc/types.h that chose a name that is too generic, which should 
be reserved for core (which asm/asm.h certainly is close to) rather than 
driver or platform support.  IOW I'd expect names like FEALNX_LONG and 
ARC_LONG or suchlike.

 However for the sake of namespace collision avoidance I think we may well 
poke at asm/asm.h instead; after all it's not core support either -- it's 
architecture support.  I think this is about the only macro that can cause 
issues, and we can deal with it by excluding it (and maybe PTR as well, 
for consistency) if !__ASSEMBLY__, and then defining say LONGDATA and 
PTRDATA aliases, e.g:

#define LONGDATA	.word
#define LONGSIZE	4
#define LONGMASK	3
#define LONGLOG		2
#endif

[...]

#ifdef __ASSEMBLY__
#define LONG		LONGDATA
#define PTR		PTRDATA
#endif

/*
 * Some cp0 registers were extended to 64bit for MIPS III.
 */

so that C code has a way to handle this in inline assembly (which it 
already does).  Of course C sources already using STR(PTR) will have to be 
updated accordingly; there are no STR(LONG) cases AFAICT.

> Your point above that we already include asm/asm.h in various C files is a 
> good one, though given how generic some of the names of its preprocessor 
> definitions are it wouldn't surprise me to see that cause other build breakage 
> in the future.

 Let's handle it on a case by case basis if this actually ever triggers.

  Maciej
