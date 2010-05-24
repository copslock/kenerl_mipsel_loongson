Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2010 01:01:57 +0200 (CEST)
Received: from hull.simtec.co.uk ([78.105.113.97]:40200 "EHLO
        preston.local.simtec.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491989Ab0EXXBt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 May 2010 01:01:49 +0200
Received: from [192.168.101.34]
        by preston.local.simtec.co.uk with esmtp (Exim 4.69)
        (envelope-from <ben@simtec.co.uk>)
        id 1OGgeV-0003v1-Ha; Tue, 25 May 2010 00:01:43 +0100
Message-ID: <4BFB0547.4070607@simtec.co.uk>
Date:   Tue, 25 May 2010 08:01:27 +0900
From:   Ben Dooks <ben@simtec.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
MIME-Version: 1.0
To:     yajin <yajinzhou@vm-kernel.org>
CC:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com, vince@simtec.co.uk
Subject: Re: [PATCH 8/12] gdium uses different freq of mclk&m1xclk of sm501
References: <q2u180e2c241005040255n628614a0p828116a04f65a894@mail.gmail.com>
In-Reply-To: <q2u180e2c241005040255n628614a0p828116a04f65a894@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <ben@simtec.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@simtec.co.uk
Precedence: bulk
X-list: linux-mips

On 04/05/10 18:55, yajin wrote:
> Gdium uses different freq of mclk&m1xclk of sm501. This seems a dirty
> hack. Maybe we need a configuration option for changing the freq of
> these clocks.
> 
> Signed-off-by: yajin <yajin@vm-kernel.org>
> ---
>  drivers/mfd/sm501.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> index ce5dfce..5e55cbd 100644
> --- a/drivers/mfd/sm501.c
> +++ b/drivers/mfd/sm501.c
> @@ -1606,10 +1606,15 @@ static struct sm501_initdata sm501_pci_initdata = {
>  	.devices	= SM501_USE_ALL,
> 
>  	/* Errata AB-3 says that 72MHz is the fastest available
> -	 * for 33MHZ PCI with proper bus-mastering operation */
> -
> +	 * for 33MHZ PCI with proper bus-mastering operation
> +	 * For gdium, it works under 84&112M clock freq.*/
> +#ifdef CONFIG_DEXXON_GDIUM
> +	.mclk		= 84 * MHZ,
> +	.m1xclk		= 112 * MHZ,
> +#else

I think these frequencies are out of spec for the SM501,
Plus, it is a hack.
Does it not work at 72/144?

>  	.mclk		= 72 * MHZ,
>  	.m1xclk		= 144 * MHZ,
> +#endif
>  };
> 
>  static struct sm501_platdata_fbsub sm501_pdata_fbsub = {
