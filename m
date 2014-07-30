Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 18:37:51 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:48374 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860080AbaG3QhtTWIAL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jul 2014 18:37:49 +0200
Received: from watt.rr44.fr ([82.228.202.134] helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1XCWsm-0004oF-8b; Wed, 30 Jul 2014 18:37:40 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1XCWsQ-0001sa-4n; Wed, 30 Jul 2014 18:37:18 +0200
Date:   Wed, 30 Jul 2014 18:37:18 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: tlbex: fix a missing statement for HUGETLB
Message-ID: <20140730163718.GA4848@ohm.rr44.fr>
References: <1406616880-17142-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1406616880-17142-1-git-send-email-chenhc@lemote.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Tue, Jul 29, 2014 at 02:54:40PM +0800, Huacai Chen wrote:
> In commit 2c8c53e28f1 (MIPS: Optimize TLB handlers for Octeon CPUs)
> build_r4000_tlb_refill_handler() is modified. But it doesn't compatible
> with the original code in HUGETLB case. Because there is a copy & paste
> error and one line of code is missing. It is very easy to produce a bug
> with LTP's hugemmap05 test.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
> Cc: <stable@vger.kernel.org>
> ---
>  arch/mips/mm/tlbex.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index e80e10b..343fe0f 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1299,6 +1299,7 @@ static void build_r4000_tlb_refill_handler(void)
>  	}
>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>  	uasm_l_tlb_huge_update(&l, p);
> +	UASM_i_LW(&p, K0, 0, K1);
>  	build_huge_update_entries(&p, htlb_info.huge_pte, K1);
>  	build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
>  				   htlb_info.restore_scratch);

Thanks for this patch. It also fixes TRANSPARENT_HUGEPAGE=y, which we
had to disable on Loongson 3 as it was causing kernel crashes. This
option is quite interesting for most MIPS systems, which are using
a software driven TLB.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
