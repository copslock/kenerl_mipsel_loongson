Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jul 2011 19:14:52 +0200 (CEST)
Received: from inx.pm.waw.pl ([195.116.170.130]:58534 "EHLO inx.pm.waw.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491144Ab1GUROr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jul 2011 19:14:47 +0200
Received: by inx.pm.waw.pl (Postfix, from userid 2530)
        id D3AA0B61E; Thu, 21 Jul 2011 19:14:24 +0200 (CEST)
From:   Krzysztof Halasa <khc@pm.waw.pl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jesse Barnes <jbarnes@virtuousgeek.org>,  linux-pci@vger.kernel.org,  Anton Vorontsov <avorontsov@mvista.com>,  Chris Metcalf <cmetcalf@tilera.com>,  Colin Cross <ccross@android.com>,  "David S. Miller" <davem@davemloft.net>,  Eric Miao <eric.y.miao@gmail.com>,  Erik Gilling <konkers@android.com>,  Guan Xuetao <gxt@mprc.pku.edu.cn>,  "H. Peter Anvin" <hpa@zytor.com>,  Imre Kaloz <kaloz@openwrt.org>,  Ingo Molnar <mingo@redhat.com>,  Ivan Kokshaysky <ink@jurassic.park.msu.ru>,  Lennert Buytenhek <kernel@wantstofly.org>,  Matt Turner <mattst88@gmail.com>,  Nicolas Pitre <nico@fluxnic.net>,  Olof Johansson <olof@lixom.net>,  Paul Mundt <lethal@linux-sh.org>,  Richard Henderson <rth@twiddle.net>,  Russell King <linux@arm.linux.org.uk>,  Thomas Gleixner <tglx@linutronix.de>,  Andrew Morton <akpm@linux-foundation.org>,  linux-alpha@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,  linux-mips@linux-mips.org,  linux-sh@vger.kernel.org,  linux
 -tegra@vger.kernel.org,  sparclinux@vger.kernel.org,  x86@kernel.org
Subject: Re: [PATCH] PCI: Make the struct pci_dev * argument of pci_fixup_irqs const.
References: <20110610143021.GA26043@linux-mips.org>
Date:   Thu, 21 Jul 2011 21:14:24 +0200
In-Reply-To: <20110610143021.GA26043@linux-mips.org> (Ralf Baechle's message
        of "Fri, 10 Jun 2011 15:30:21 +0100")
Message-ID: <m3hb6fe99r.fsf@intrepid.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khc@pm.waw.pl
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15275

Ralf Baechle <ralf@linux-mips.org> writes:

> Aside of the usual motivation for constification,  this function has a
> history of being abused a hook for interrupt and other fixups so I turned
> this function const ages ago in the MIPS code but it should be done
> treewide.
>
> Due to function pointer passing in varous places a few other functions
> had to be constified as well.

>  arch/arm/mach-ixp4xx/avila-pci.c               |    2 +-
>  arch/arm/mach-ixp4xx/coyote-pci.c              |    2 +-
>  arch/arm/mach-ixp4xx/dsmg600-pci.c             |    2 +-
>  arch/arm/mach-ixp4xx/fsg-pci.c                 |    2 +-
>  arch/arm/mach-ixp4xx/gateway7001-pci.c         |    3 ++-
>  arch/arm/mach-ixp4xx/goramo_mlr.c              |    2 +-
>  arch/arm/mach-ixp4xx/gtwx5715-pci.c            |    2 +-
>  arch/arm/mach-ixp4xx/ixdp425-pci.c             |    2 +-
>  arch/arm/mach-ixp4xx/ixdpg425-pci.c            |    2 +-
>  arch/arm/mach-ixp4xx/nas100d-pci.c             |    2 +-
>  arch/arm/mach-ixp4xx/nslu2-pci.c               |    2 +-
>  arch/arm/mach-ixp4xx/vulcan-pci.c              |    2 +-
>  arch/arm/mach-ixp4xx/wg302v2-pci.c             |    2 +-

The IXP4xx part looks good to me.

Acked-by: Krzysztof Hałasa <khc@pm.waw.pl>
-- 
Krzysztof Halasa
