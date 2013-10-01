Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2013 18:27:57 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:51887 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6862035Ab3JAQ1yqpSY0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Oct 2013 18:27:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id DC43F5A6DB2;
        Tue,  1 Oct 2013 19:27:52 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id Jrh6BeaLL9+l; Tue,  1 Oct 2013 19:27:47 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with SMTP id 0C8585BC010;
        Tue,  1 Oct 2013 19:27:47 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Tue, 01 Oct 2013 19:27:44 +0300
Date:   Tue, 1 Oct 2013 19:27:43 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 3.12-rc2 - MIPS regression
Message-ID: <20131001162743.GB14359@blackmetal.musicnaut.iki.fi>
References: <CA+55aFxoF75RJfkp0vnm-b9B0h7PGMitrQiLyTt315tKvG-wTQ@mail.gmail.com>
 <20130927231012.GB4572@blackmetal.musicnaut.iki.fi>
 <20131001142421.6cd0870138caf2fe5600a1ea@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131001142421.6cd0870138caf2fe5600a1ea@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Tue, Oct 01, 2013 at 02:24:21PM +0900, Yoichi Yuasa wrote:
> On Sat, 28 Sep 2013 02:10:12 +0300
> Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > 3.12-rc2 breaks the boot (BUG: scheduling while atomic, see logs below)
> > on Lemote Mini-PC (MIPS). According to git bisect, this is caused by:
> > 
> > ff522058bd717506b2fa066fa564657f2b86477e is the first bad commit
> > commit ff522058bd717506b2fa066fa564657f2b86477e
> > Author: Ralf Baechle <ralf@linux-mips.org>
> > Date:   Tue Sep 17 12:44:31 2013 +0200
> > 
> >     MIPS: Fix accessing to per-cpu data when flushing the cache
> > 
> > Reverting the commit from v3.12-rc2 makes the board boot fine.
> 
> Please try this patch on top of rc2.
> 
> MIPS: Fix forgotten preempt_enable() when CPU has inclusive pcaches

Didn't work but making similar change to also r4k_dma_cache_inv() helps.
So both r4k_dma_cache_wback_inv() and r4k_dma_cache_inv() need to
be fixed.

A.

> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> 
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 627883b..2492e60 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -609,6 +609,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
>  			r4k_blast_scache();
>  		else
>  			blast_scache_range(addr, addr + size);
> +		preempt_enable();
>  		__sync();
>  		return;
>  	}
