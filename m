Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Sep 2010 11:19:10 +0200 (CEST)
Received: from sh.osrg.net ([192.16.179.4]:57348 "EHLO sh.osrg.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491112Ab0IVJTH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Sep 2010 11:19:07 +0200
Received: from localhost (rose.osrg.net [10.76.0.1])
        by sh.osrg.net (8.14.3/8.14.3/OSRG-NET) with ESMTP id o8M9IQoc012248;
        Wed, 22 Sep 2010 18:18:27 +0900
Date:   Wed, 22 Sep 2010 18:18:26 +0900
To:     ralf@linux-mips.org
Cc:     fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH -mm 4/8] mips: enable ARCH_DMA_ADDR_T_64BIT with
 (HIGHMEM && 64BIT_PHYS_ADDR) || 64BIT
From:   FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100920133434.GB15938@linux-mips.org>
References: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
        <1283474956-14710-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
        <20100920133434.GB15938@linux-mips.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20100922181454N.fujita.tomonori@lab.ntt.co.jp>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (sh.osrg.net [192.16.179.4]); Wed, 22 Sep 2010 18:18:27 +0900 (JST)
X-Virus-Scanned: clamav-milter 0.96.1 at sh
X-Virus-Status: Clean
X-archive-position: 27787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fujita.tomonori@lab.ntt.co.jp
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17051

On Mon, 20 Sep 2010 14:34:35 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Sep 03, 2010 at 09:49:12AM +0900, FUJITA Tomonori wrote:
> 
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > Cc: linux-mips@linux-mips.org
> 
> Looks good:
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks,


> As this patch by itself doesn't make any sense in the MIPS tree and would
> only cry for a janitor to remove it again I suggest you merge this with
> the rest of the series.

I expect akpm to merge all the patches.
