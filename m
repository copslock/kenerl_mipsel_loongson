Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 16:49:38 +0100 (CET)
Received: from moutng.kundenserver.de ([212.227.126.186]:53695 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903652Ab2BXPte (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 16:49:34 +0100
Received: from klappe2.localnet (deibp9eh1--blueice3n2.emea.ibm.com [195.212.29.180])
        by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
        id 0LwBkQ-1SWCRt0XAE-017RQY; Fri, 24 Feb 2012 16:49:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 00/14] DMA-mapping framework redesign preparation
Date:   Fri, 24 Feb 2012 15:48:59 +0000
User-Agent: KMail/1.12.2 (Linux/3.3.0-rc1; KDE/4.3.2; x86_64; ; )
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
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
In-Reply-To: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202241548.59791.arnd@arndb.de>
X-Provags-ID: V02:K0:T7az3aeAxJJ2biO5z7hE5jD6TBIYwaYasOrCkwG3CUl
 vTSpX2XwMIxuIVDPdgwnGbr6FRW8RxQICDQWSWXyApB3pO4U1Q
 QfBbxFcWfTMxLmF0cS8rtUYp8GDWUNMeNHEJFNLUA2J9ej9uns
 xhueLubFJiBlXL2eVEch3AkSsFkCZm2ZIbFmpjtY3ulrbChUxy
 F9hdbMLvUJm6Ap1t7D9RQepxYPTHA/E3xdcAp47h9BphDn/Vz/
 GObA9B/ql/AkniRF9iYr6C3elm/tPlVwGfOcB6d0EmorDfrZmO
 DDiJBO2oGhz71dxK7ynoB/fIMas0g3e0kDxsB3jjWc1oSWtHus
 kqfQlD5ooX2o7Tw051bI=
X-archive-position: 32546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Friday 23 December 2011, Marek Szyprowski wrote:
> The solution we found is to introduce a new public dma mapping functions
> with additional attributes argument: dma_alloc_attrs and
> dma_free_attrs(). This way all different kinds of architecture specific
> buffer mappings can be hidden behind the attributes without the need of
> creating several versions of dma_alloc_ function.

Since the patches are now in linux-next, we should make sure that they
can actually get merged into 3.4.

I've looked at all the patches again and found them to be straightforward
and helpful, I hope we can get them merged next time. Please add my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
