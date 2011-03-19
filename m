Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Mar 2011 18:23:18 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46052 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491824Ab1CSRXO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Mar 2011 18:23:14 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p2JHMuDl023859;
        Sat, 19 Mar 2011 18:22:56 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p2JHMsd3023856;
        Sat, 19 Mar 2011 18:22:54 +0100
Date:   Sat, 19 Mar 2011 18:22:54 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Dennis.Yxun" <dennis.yxun@gmail.com>
Cc:     linux-mips@linux-mips.org, "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
Subject: Re: Problem About Vectored interrupt
Message-ID: <20110319172254.GA11550@linux-mips.org>
References: <AANLkTinhM4PUmLbWeAyavf-JPM1Xpu9pJVkXDq4c-f0C@mail.gmail.com>
 <AANLkTinsQrZJsXt0SKRfe3S0cNGT+uuW-t3Jo4Ob4=B4@mail.gmail.com>
 <A7DEA48C84FD0B48AAAE33F328C02014033DADEC@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
 <AANLkTikWUehOmyD6Nk3Abz=u7FEb8NMtX2-N4r5HHuY9@mail.gmail.com>
 <AANLkTimK1xpHwvfE95rEMCikk8-0EkGjn4b5DwYWyN-E@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimK1xpHwvfE95rEMCikk8-0EkGjn4b5DwYWyN-E@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 19, 2011 at 08:42:17AM +0800, Dennis.Yxun wrote:

> HI ALL:
>   Again, found that when come to set vect irq 7, do additional data flush
> fix my problem, here is the patch
> 
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index e971043..850ce58 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1451,6 +1451,9 @@ static void *set_vi_srs_handler(int n, vi_handler_t
> addr, int srs)
>                 *w = (*w & 0xffff0000) | (((u32)handler >> 16) & 0xffff);
>                 w = (u32 *)(b + ori_offset);
>                 *w = (*w & 0xffff0000) | ((u32)handler & 0xffff);
> +               /* FIXME: need flash data cache, for timer irq */
> +               if (n == 7)
> +                       flush_data_cache_page((unsigned int)b);
>                 local_flush_icache_range((unsigned long)b,
>                                          (unsigned long)(b+handler_len));

The call local_flush_icache_range should already flushes the cache and
there should be no reason why a 2nd range makes it any better - or why
it would only be needed for irq 7 - and the timer isn't necessarily
always irq 7.

What is your hardware platform and processor?

  Ralf
