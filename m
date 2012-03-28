Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2012 06:16:37 +0200 (CEST)
Received: from linux-sh.org ([111.68.239.195]:48155 "EHLO linux-sh.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901346Ab2C1EQd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Mar 2012 06:16:33 +0200
Received: from linux-sh.org (localhost.localdomain [127.0.0.1])
        by linux-sh.org (8.14.5/8.14.4) with ESMTP id q2S4F4lP011886;
        Wed, 28 Mar 2012 13:15:04 +0900
Received: (from pmundt@localhost)
        by linux-sh.org (8.14.5/8.14.4/Submit) id q2S4F3dh011874;
        Wed, 28 Mar 2012 13:15:03 +0900
X-Authentication-Warning: linux-sh.org: pmundt set sender to lethal@linux-sh.org using -f
Date:   Wed, 28 Mar 2012 13:15:03 +0900
From:   Paul Mundt <lethal@linux-sh.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCHv2 07/14] SH: adapt for dma_map_ops changes
Message-ID: <20120328041503.GM26543@linux-sh.org>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com> <1332855768-32583-8-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1332855768-32583-8-git-send-email-m.szyprowski@samsung.com>
User-Agent: Mutt/1.4.1i
X-archive-position: 32800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 27, 2012 at 03:42:41PM +0200, Marek Szyprowski wrote:
> From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> 
> Adapt core SH architecture code for dma_map_ops changes: replace
> alloc/free_coherent with generic alloc/free methods.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Paul Mundt <lethal@linux-sh.org>
