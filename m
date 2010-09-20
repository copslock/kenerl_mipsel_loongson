Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Sep 2010 15:34:39 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1491000Ab0ITNef (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Sep 2010 15:34:35 +0200
Date:   Mon, 20 Sep 2010 14:34:35 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc:     akpm@linux-foundation.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH -mm 4/8] mips: enable ARCH_DMA_ADDR_T_64BIT with (HIGHMEM
 && 64BIT_PHYS_ADDR) || 64BIT
Message-ID: <20100920133434.GB15938@linux-mips.org>
References: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
 <1283474956-14710-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1283474956-14710-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15308

On Fri, Sep 03, 2010 at 09:49:12AM +0900, FUJITA Tomonori wrote:

> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Cc: linux-mips@linux-mips.org

Looks good:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

As this patch by itself doesn't make any sense in the MIPS tree and would
only cry for a janitor to remove it again I suggest you merge this with
the rest of the series.

Thanks,

  Ralf
