Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2012 18:41:52 +0200 (CEST)
Received: from wolverine02.qualcomm.com ([199.106.114.251]:9532 "EHLO
        wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903562Ab2C0Qlq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2012 18:41:46 +0200
X-IronPort-AV: E=McAfee;i="5400,1158,6661"; a="173932808"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 27 Mar 2012 09:41:43 -0700
Received: from codeaurora.org (pdmz-snip-v218.qualcomm.com [192.168.218.1])
        by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 7203710004C1;
        Tue, 27 Mar 2012 09:41:42 -0700 (PDT)
Date:   Tue, 27 Mar 2012 11:41:40 -0500
From:   Richard Kuo <rkuo@codeaurora.org>
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
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCHv2 10/14] Hexagon: adapt for dma_map_ops changes
Message-ID: <20120327164140.GA3916@codeaurora.org>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-11-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1332855768-32583-11-git-send-email-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 32791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkuo@codeaurora.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 27, 2012 at 03:42:44PM +0200, Marek Szyprowski wrote:
> Adapt core Hexagon architecture code for dma_map_ops changes: replace
> alloc/free_coherent with generic alloc/free methods.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/hexagon/include/asm/dma-mapping.h |   18 ++++++++++++------
>  arch/hexagon/kernel/dma.c              |    9 +++++----
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org> 

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
