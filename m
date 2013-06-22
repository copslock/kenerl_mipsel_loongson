Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jun 2013 15:00:30 +0200 (CEST)
Received: from alius.ayous.org ([89.238.89.44]:57148 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816822Ab3FVM75GpSNM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 22 Jun 2013 14:59:57 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@ayous.org>)
        id 1UqNQ3-0000jh-Dq; Sat, 22 Jun 2013 12:59:55 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@ayous.org>)
        id 1UqNPy-00057I-2l; Sat, 22 Jun 2013 14:59:50 +0200
Date:   Sat, 22 Jun 2013 14:59:50 +0200
From:   Andreas Barth <aba@ayous.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V10 05/13] MIPS: Loongson: Add UEFI-like firmware
        interface support
Message-ID: <20130622125950.GB19237@mails.so.argh.org>
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com> <1366030028-5084-6-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1366030028-5084-6-git-send-email-chenhc@lemote.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@ayous.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@ayous.org
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

* Huacai Chen (chenhc@lemote.com) [130415 14:49]:
> The new UEFI-like firmware interface has 3 advantages:
> 
> 1, Firmware export a physical memory map which is similar to X86's
>    E820 map, so prom_init_memory() will be more elegant that #ifdef
>    clauses can be removed.
> 2, Firmware export a pci irq routing table, we no longer need pci
>    irq routing fixup in kernel's code.
> 3, Firmware has a built-in vga bios, and its address is exported,
>    the linux kernel no longer need an embedded blob.
> 
> With the new interface, Loongson-3A/2G and all their successors can use
> a unified kernel. All Loongson-based machines support this new interface
> except 2E/2F series.

Can't we auto-detect whether there is an UEFI-like interface? That
would allow to reduce the number of #ifdefs a bit.


> --- a/arch/mips/loongson/common/env.c
> +++ b/arch/mips/loongson/common/env.c
>  	while (l != 0) {
> -		parse_even_earlier(bus_clock, "busclock", l);
>  		parse_even_earlier(cpu_clock_freq, "cpuclock", l);
>  		parse_even_earlier(memsize, "memsize", l);
>  		parse_even_earlier(highmemsize, "highmemsize", l);
> @@ -57,8 +73,32 @@ void __init prom_init_env(void)
>  	}
>  	if (memsize == 0)
>  		memsize = 256;
> -	if (bus_clock == 0)
> -		bus_clock = 66000000;
> +#else

why are we not interested anymore in busclock in non-UEFI-like
machines (and shouldn't this be documented in the summary)?



Andi
> 
