Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 13:50:23 +0200 (CEST)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:59238 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834832Ab3FRLt5lL4xw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 13:49:57 +0200
Received: by mail-lb0-f179.google.com with SMTP id w20so3485996lbh.38
        for <linux-mips@linux-mips.org>; Tue, 18 Jun 2013 04:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=lLUZ9j/YM9IkDTYe7EFguv3eVVZDgSN7iNom6G2+rLA=;
        b=RCNIMxZw3rl119BDnqMmNzL087LTv8Um171ELid1FGFhkSQ+T5OdZ4AAbmXnCjibXD
         dEGJt4Igs3h0FZxAryEQPcEiHj0rosKLEAvq78uVD6kcKKDMTWW1tETOmADAl4Ei3E6Z
         eWz2HZbS8Sw0qeWh6oG0VDd/RLN6qpBwatm497LtJwpAlruWR9OD1035g9Nwe99HPBUw
         cRrS6cstVtwB5Zbw9VbeElk85ZW51GzteIRaa5ss2BuZJE78UrK55XdNVCGsXWTHuRJl
         3eJ4LHcOrmNbMsf1FNHNNR0ypzrHMYdAVvpySzR/FtWRXMInE1a0wO85khHWd6P23cAs
         h/xw==
X-Received: by 10.112.74.47 with SMTP id q15mr909919lbv.75.1371556091681;
        Tue, 18 Jun 2013 04:48:11 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-157-59.pppoe.mtu-net.ru. [91.76.157.59])
        by mx.google.com with ESMTPSA id b8sm6832608lah.0.2013.06.18.04.48.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 04:48:10 -0700 (PDT)
Message-ID: <51C048FB.5050803@cogentembedded.com>
Date:   Tue, 18 Jun 2013 15:48:11 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH V2 1/2] MIPS: BCM63XX: Add SMP support to prom.c
References: <1371548072-6247-1-git-send-email-jogo@openwrt.org> <1371548072-6247-2-git-send-email-jogo@openwrt.org>
In-Reply-To: <1371548072-6247-2-git-send-email-jogo@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmsyhZGP46fQ6g1PBpkPe7wKOI0jnna3kib2dfmVHThTLbIzXDmv/XfnsLjp4HnztwzIGjK
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 18-06-2013 13:34, Jonas Gorski wrote:

> From: Kevin Cernekee <cernekee@gmail.com>

> This involves two changes to the BSP code:

> 1) register_smp_ops() for BMIPS SMP

> 2) The CPU1 boot vector on some of the BCM63xx platforms conflicts with
> the special interrupt vector (IV).  Move it to 0x8000_0380 at boot time,
> to resolve the conflict.

> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> [jogo@openwrt.org: moved SMP ops registration into ifdef guard,
>   changed ifdef guards to if (IS_ENABLED())]
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
> V1 -> V2:
>   * changed ifdef guards to if (IS_ENABLED())

>   arch/mips/bcm63xx/prom.c |   41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)

> diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
> index fd69808..33ddc78 100644
> --- a/arch/mips/bcm63xx/prom.c
> +++ b/arch/mips/bcm63xx/prom.c
[...]
> @@ -52,6 +56,43 @@ void __init prom_init(void)
>
>   	/* do low level board init */
>   	board_prom_init();
> +
> +	if (IS_ENABLED(CONFIG_CPU_BMIPS4350) && IS_ENABLED(CONFIG_SMP)) {
> +		/* set up SMP */
> +		register_smp_ops(&bmips_smp_ops);
> +
> +		/*
> +		 * BCM6328 might not have its second CPU enabled, while BCM6358
> +		 * needs special handling for its shared TLB, so disable SMP
> +		 * for now.
> +		 */
> +		if (BCMCPU_IS_6328()) {
> +			bmips_smp_enabled = 0;
> +		} else if (BCMCPU_IS_6358()) {
> +			bmips_smp_enabled = 0;
> +		}

     Doesn't scripts/checkpatch.pl complain here? You should not use {} 
on the single statement branches.

WBR, Sergei
