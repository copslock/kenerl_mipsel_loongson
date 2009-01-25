Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2009 12:27:20 +0000 (GMT)
Received: from yw-out-1718.google.com ([74.125.46.152]:21412 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S21365855AbZAYM1R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Jan 2009 12:27:17 +0000
Received: by yw-out-1718.google.com with SMTP id 9so2088913ywk.24
        for <multiple recipients>; Sun, 25 Jan 2009 04:27:16 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3yPgh+ysdcwafuomWMITlbHSV9KEeIMsGEOYZFlL3pY=;
        b=mrFRoR9aOuNI4J4xkWJmdvKTVFcQ2Lw+PYTktmV3BZJK/n4LdIF20ntzxZTW0kYCJ2
         Ut8k3yfpPP3I5OtpnHK1c1Hs0vkgGo/8NTll066ItkFesAVspP8IVHjq327/sJB2AzO7
         URIi+RHisDKgmV57nCT2dNRjK3AN3fyt1eivk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nVQXxUhgmqqWhUYRyQoMBz9Hgvuk/w8pb+CGqnlvtO71gjkeGMjR+KVzjzkHmKaAiQ
         1O212p9xBDJdIr418nIRc6XeckyX1Bqi/cjSfzBwtlu7XGim5bk8VWvKqhG9Spuy0Yt8
         cxG178kwZumjDk7kEfpvB+F9M0NxdISq4hSrs=
MIME-Version: 1.0
Received: by 10.90.96.1 with SMTP id t1mr533603agb.73.1232886436246; Sun, 25 
	Jan 2009 04:27:16 -0800 (PST)
In-Reply-To: <20090124191055.GA29966@linux-mips.org>
References: <20090124221542.bcc6c19f.yoichi_yuasa@tripeaks.co.jp>
	 <20090124191055.GA29966@linux-mips.org>
Date:	Sun, 25 Jan 2009 06:27:16 -0600
Message-ID: <b2b2f2320901250427j5349581fr4bc6c807f0b987c8@mail.gmail.com>
Subject: Re: [PATCH][MIPS] fix oops in r4k_dma_cache_inv
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, Jan 24, 2009 at 1:10 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Jan 24, 2009 at 10:15:42PM +0900, Yoichi Yuasa wrote:
>
> Patch looks ok - but I think we also have to assume that the starting
> address of the range might be miss-aligned, so how about this patch?
>
>  Ralf
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 56290a7..c43f4b2 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -619,8 +619,20 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
>                if (size >= scache_size)
>                        r4k_blast_scache();
>                else {
> -                       cache_op(Hit_Writeback_Inv_SD, addr);
> -                       cache_op(Hit_Writeback_Inv_SD, addr + size - 1);
> +                       unsigned long lsize = cpu_scache_line_size();
> +                       unsigned long almask = ~(lsize - 1);
> +
> +                       /*
> +                        * There is no clearly documented alignment requirement
> +                        * for the cache instruction on MIPS processors and
> +                        * some processors, among them the RM5200 and RM7000
> +                        * QED processors will throw an address error for cache
> +                        * hit ops with insufficient alignment.  Solved by
> +                        * aligning the address to cache line size.
> +                        */
> +                       cache_op(Hit_Writeback_Inv_SD, addr & almask);
> +                       cache_op(Hit_Writeback_Inv_SD,
> +                                (addr + size - 1) & almask);
>                        blast_inv_scache_range(addr, addr + size);
>                }
>                return;
> @@ -629,9 +641,12 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
>        if (cpu_has_safe_index_cacheops && size >= dcache_size) {
>                r4k_blast_dcache();
>        } else {
> +               unsigned long lsize = cpu_dcache_line_size();
> +               unsigned long almask = ~(lsize - 1);
> +
>                R4600_HIT_CACHEOP_WAR_IMPL;
> -               cache_op(Hit_Writeback_Inv_D, addr);
> -               cache_op(Hit_Writeback_Inv_D, addr + size - 1);
> +               cache_op(Hit_Writeback_Inv_D, addr & almask);
> +               cache_op(Hit_Writeback_Inv_D, (addr + size - 1)  & almask);
>                blast_inv_dcache_range(addr, addr + size);
>        }
>

This patch resolves the oops on my RM7035C-based board.

Tested-by: Shane McDonald <mcdonald.shane@gmail.com>
