Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2011 22:24:56 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.9]:52096 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491000Ab1FNUYv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2011 22:24:51 +0200
Received: from wuerfel.localnet (port-92-200-80-152.dynamic.qsc.de [92.200.80.152])
        by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
        id 0M53tq-1Pbl4227aQ-00zO0W; Tue, 14 Jun 2011 22:22:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date:   Tue, 14 Jun 2011 22:22:43 +0200
User-Agent: KMail/1.13.6 (Linux/3.0.0-rc1nosema+; KDE/4.6.3; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Kyle McMartin <kyle@mcmartin.ca>,
        Lennox Wu <lennox.wu@gmail.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Mikael Starvik <starvik@axis.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@arm.linux.org.uk>,
        sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-sh@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20110614190850.GA13526@linux-mips.org>
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106142222.43553.arnd@arndb.de>
X-Provags-ID: V02:K0:Nw7JuX5Irr6sJRJ8adGr6gZRh5fFvzcsXaKoiGZZRkE
 gtCtOvg3NoIRuAdCPKDL457VlhxTtEblT2auC/jz6zAhpvFNy8
 rBK0aCi5P8c6Yw+jduh31uRgY8K56s9jHhTaBkFgGy3a1XOY9D
 vpizFe5DH2g7f+xBCp2fDNK68IffsjDjtWlDIdoTGcVTY0EleU
 Y8g5hHxoZxBhK0X7GotIg==
X-archive-position: 30384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11867

On Tuesday 14 June 2011 21:08:50 Ralf Baechle wrote:

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9adc278..2968751f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -21,6 +21,7 @@ config ARM
>  	select HAVE_KERNEL_LZO
>  	select HAVE_KERNEL_LZMA
>  	select HAVE_IRQ_WORK
> +	select HAVE_PC_PARPORT
>  	select HAVE_PERF_EVENTS
>  	select PERF_USE_VMALLOC
>  	select HAVE_REGS_AND_STACK_ACCESS_API

On arm that should only be set on a couple of subarchitectures, but
we can fan that out after your patch goes in, just like you do for Mips

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2729c66..b8328df 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -128,6 +128,7 @@ config PPC
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
>  	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
>  	select HAVE_SPARSE_IRQ
>  	select IRQ_PER_CPU
>  	select GENERIC_IRQ_SHOW

Similar to ARM and Mips.

> index e446bab..ceac9b5 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -15,6 +15,7 @@ config MICROBLAZE
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
>  

Highly unlikely, except through PCI.

> diff --git a/arch/score/Kconfig b/arch/score/Kconfig
> index 288add8..ba078d0 100644
> --- a/arch/score/Kconfig
> +++ b/arch/score/Kconfig
> @@ -1,9 +1,10 @@
>  menu "Machine selection"
>  
>  config SCORE
> -       def_bool y
> -       select HAVE_GENERIC_HARDIRQS
> -       select GENERIC_IRQ_SHOW
> +	def_bool y
> +	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
> +	select GENERIC_IRQ_SHOW
>  
>  choice
>  	prompt "System type"

Certainly not, no PIO support

> diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
> index 0249b8b..3e96eff 100644
> --- a/arch/tile/Kconfig
> +++ b/arch/tile/Kconfig
> @@ -8,6 +8,7 @@ config TILE
>  	select USE_GENERIC_SMP_HELPERS
>  	select CC_OPTIMIZE_FOR_SIZE
>  	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_PENDING_IRQ if SMP
>  	select GENERIC_IRQ_SHOW

Only through PCI

> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
> index e57dcce..3832e7e 100644
> --- a/arch/unicore32/Kconfig
> +++ b/arch/unicore32/Kconfig
> @@ -8,6 +8,7 @@ config UNICORE32
>  	select HAVE_KERNEL_BZIP2
>  	select HAVE_KERNEL_LZO
>  	select HAVE_KERNEL_LZMA
> +	select HAVE_PC_PARPORT
>  	select GENERIC_FIND_FIRST_BIT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW

Probably not.

I think you can leave these four out right away, provided you add
the section below:

> --- a/drivers/parport/Kconfig
> +++ b/drivers/parport/Kconfig
> @@ -35,8 +35,7 @@ if PARPORT
> 
>  config PARPORT_PC
>  
>         tristate "PC-style hardware"
> 
> -       depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
> -               (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
> +       depends on HAVE_PC_PARPORT
> 
>         ---help---
>         
>           You should say Y here if you have a PC-style parallel port. All
>           IBM PC compatible computers and some Alphas have PC-style
> 
> @@ -48,6 +47,9 @@ config PARPORT_PC
> 
>           If unsure, say Y.
> 
> +config HAVE_PC_PARPORT
> +       bool
> +

As you write, anything that has PCI can theoretically take parallel ports,
so I would always list PCI here as a way to get it anyway. Probably also
ISA and PCMCIA. How about adding this?

config HAVE_PC_PARPORT
	bool
	default (PCI || ISA || PCMCIA)

	Arnd
