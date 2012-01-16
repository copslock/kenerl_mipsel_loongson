Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2012 12:53:28 +0100 (CET)
Received: from ozlabs.org ([203.10.76.45]:36054 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903605Ab2APLwV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jan 2012 12:52:21 +0100
Received: by ozlabs.org (Postfix, from userid 1007)
        id DE6651007D2; Mon, 16 Jan 2012 22:52:17 +1100 (EST)
Date:   Mon, 16 Jan 2012 12:57:10 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Subject: Re: [PATCH 01/14] common: dma-mapping: introduce alloc_attrs and
 free_attrs methods
Message-ID: <20120116015710.GD4512@truffala.fritz.box>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
 <1324643253-3024-2-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1324643253-3024-2-git-send-email-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david@gibson.dropbear.id.au
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Dec 23, 2011 at 01:27:20PM +0100, Marek Szyprowski wrote:
> Introduce new generic alloc and free methods with attributes argument.
> 
> Existing alloc_coherent and free_coherent can be implemented on top of the
> new calls with NULL attributes argument. Later also dma_alloc_non_coherent
> can be implemented using DMA_ATTR_NONCOHERENT attribute as well as
> dma_alloc_writecombine with separate DMA_ATTR_WRITECOMBINE attribute.
> 
> This way the drivers will get more generic, platform independent way of
> allocating dma buffers with specific parameters.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Looks sensible to me.

Reviewed-by: David Gibson <david@gibson.dropbear.ud.au>
-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
