Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2012 15:52:21 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:36347 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903599Ab2C2NwN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2012 15:52:13 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1SDFlL-0001n5-19; Thu, 29 Mar 2012 15:51:39 +0200
Date:   Thu, 29 Mar 2012 15:51:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dezhong Diao <dediao@cisco.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCHv2 02/14] X86 & IA64: adapt for dma_map_ops changes
In-Reply-To: <1332855768-32583-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <alpine.LFD.2.02.1203291545520.2542@ionos>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com> <1332855768-32583-3-git-send-email-m.szyprowski@samsung.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-archive-position: 32815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, 27 Mar 2012, Marek Szyprowski wrote:
> From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> -static inline void *dma_alloc_coherent(struct device *dev, size_t size,
> -				       dma_addr_t *daddr, gfp_t gfp)
> +#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)

Please make this an inline function.

>  
> +#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)

Inline please.

> -static inline void dma_free_coherent(struct device *dev, size_t size,
> -				     void *vaddr, dma_addr_t bus)
> +#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)

Ditto

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx
