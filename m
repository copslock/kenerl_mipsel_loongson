Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2012 05:58:17 +0200 (CEST)
Received: from gate.crashing.org ([63.228.1.57]:40175 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903590Ab2C1D6K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Mar 2012 05:58:10 +0200
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q2S3ueUA015939;
        Tue, 27 Mar 2012 22:56:43 -0500
Message-ID: <1332907000.2882.74.camel@pasglop>
Subject: Re: [PATCHv2 04/14] PowerPC: adapt for dma_map_ops changes
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-mm@kvack.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        Matt Turner <mattst88@gmail.com>,
        Dezhong Diao <dediao@cisco.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        microblaze-uclinux@itee.uq.edu.au, linaro-mm-sig@lists.linaro.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>, discuss@x86-64.org,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Date:   Wed, 28 Mar 2012 14:56:40 +1100
In-Reply-To: <1332855768-32583-5-git-send-email-m.szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
         <1332855768-32583-5-git-send-email-m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.2- 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 32799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, 2012-03-27 at 15:42 +0200, Marek Szyprowski wrote:
> From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> 
> Adapt core PowerPC architecture code for dma_map_ops changes: replace
> alloc/free_coherent with generic alloc/free methods.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> [added missing changes to arch/powerpc/kernel/vio.c]
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---

FYI. David and Arnd reviews are good enough for me ppc-side.

Cheers,
Ben.
