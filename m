Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 03:30:04 +0200 (CEST)
Received: from mprc.pku.edu.cn ([162.105.203.9]:38629 "EHLO mprc.pku.edu.cn"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491064Ab1FOB3s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 03:29:48 +0200
Received: from [192.168.0.106] ([162.105.80.111])
        (authenticated bits=0)
        by mprc.pku.edu.cn (8.13.8/8.13.8) with ESMTP id p5F1Wm6I014980;
        Wed, 15 Jun 2011 09:32:50 +0800
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
From:   Guan Xuetao <gxt@mprc.pku.edu.cn>
Reply-To: gxt@mprc.pku.edu.cn
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
        microblaze-uclinux@itee.uq.edu.au, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
References: <20110614190850.GA13526@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: MPRC, PKU
Date:   Wed, 15 Jun 2011 09:24:06 +0800
Message-ID: <1308101046.4727.10.camel@epip-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 30390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gxt@mprc.pku.edu.cn
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12027

On Tue, 2011-06-14 at 20:08 +0100, Ralf Baechle wrote:
> The PC parallel port Kconfig as acquired one of those messy terms to
> describe it's architecture dependencies:
> 
>        depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
>                (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
> 
> This isn't just ugly - it also almost certainly describes the dependencies
> too coarse grainedly.  This is an attempt at cleaing the mess up.
> 
> I tried to faithfully aproximate the old behaviour but the existing
> behaviour seems inacurate if not wrong for some architectures or platforms.
> To improve on this I rely on comments from other arch and platforms
> maintainers.  Any system that can take PCI multi-IO card or has a PC-style
> parallel port on the mainboard should probably should now do a
> select HAVE_PC_PARPORT.  And some arch Kconfig files should further
> restrict the use of HAVE_PC_PARPORT to only those platforms that actually
> need it.
> 
> Thanks,
> 
>   Ralf

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
In UniCore32, only some debug-boards need to support parport.
So I'd like to add HAVE_PC_PARPORT and related configs to certian
*_defconfig, but not in Kconfig.

Thanks Ralf.

Guan Xuetao
