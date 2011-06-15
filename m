Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 06:32:05 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:54453 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491043Ab1FOEb5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 06:31:57 +0200
Received: from tazenda.hos.anvin.org ([IPv6:2001:470:861f:0:e269:95ff:fe35:9f3c])
        (authenticated bits=0)
        by mail.zytor.com (8.14.4/8.14.4) with ESMTP id p5F4VWO0019301
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Tue, 14 Jun 2011 21:31:32 -0700
Message-ID: <4DF8359F.10809@zytor.com>
Date:   Tue, 14 Jun 2011 21:31:27 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Thunderbird/3.1.10
MIME-Version: 1.0
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
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
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "microblaze-uclinux@itee.uq.edu.au" 
        <microblaze-uclinux@itee.uq.edu.au>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
References: <20110614190850.GA13526@linux-mips.org> <987664A83D2D224EAE907B061CE93D5301E7281306@orsmsx505.amr.corp.intel.com>
In-Reply-To: <987664A83D2D224EAE907B061CE93D5301E7281306@orsmsx505.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 30393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12088

On 06/14/2011 03:08 PM, Luck, Tony wrote:
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 38280ef..849805a 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -23,6 +23,7 @@ config IA64
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_DMA_API_DEBUG
>  	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_PENDING_IRQ if SMP
>  	select IRQ_PER_CPU
> 
> I took a look at the back of all my ia64 systems - none of them
> have a parallel port.  It seems unlikely that new systems will
> start adding parallel ports :-)
> 
> So even if I had a printer (or other device) that used a parallel
> port, I have no way to test it.
> 

If it has PCI slots, it can have a parallel port.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
