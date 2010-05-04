Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 12:52:37 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:36977 "EHLO
        mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492426Ab0EDKwd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 12:52:33 +0200
Received: by pzk32 with SMTP id 32so868751pzk.21
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=oRoeYF71wZh8ntp2+ehgwYk/hg4my8HXQQ3sgu3zurI=;
        b=TBFHdy/irSJTTgelAu/8m8vXHoVdSTBvokYj1ombuGANryosxw6zeBA8Lq9wrNRA90
         FxyLnS+F/Fifav2Jp8bCkbOr2tUPAnMFY8wBWTaHbLFKOMvGktD9g5RGzGhaI4+n20GV
         1QNJEqY/zxSWAQRwiSYkYq/D7ivraQJ6TjVuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=A6Juu99Ngoi63Maw01RbRpq4nP/NhfZs35t2gOZcpQpJxh0hvuSgwmVP9Uf/JeD0lv
         ojOr6PMKZuL5HhYmZ7sNOc9+TVuhMlrdCrXLscTKmCG1sNaVVxaKvQ8a0DWyMkjjWHUT
         LUB6YL02Q+EQjlKPuTf7JN4iRJSE2J6zAYWbQ=
Received: by 10.114.215.12 with SMTP id n12mr5309785wag.68.1272970345982;
        Tue, 04 May 2010 03:52:25 -0700 (PDT)
Received: from [192.168.2.214] ([202.201.14.140])
        by mx.google.com with ESMTPS id c14sm29055051waa.1.2010.05.04.03.52.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 03:52:24 -0700 (PDT)
Subject: Re: [PATCH 1/12] remove set_irq_trigger_mode to mach_init_irq
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     yajin <yajinzhou@vm-kernel.org>
Cc:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        apatard@mandriva.com
In-Reply-To: <v2w180e2c241005040254h59bd552fv160cee08beaa01ca@mail.gmail.com>
References: <v2w180e2c241005040254h59bd552fv160cee08beaa01ca@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 04 May 2010 18:52:20 +0800
Message-ID: <1272970340.9547.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Yajin

Perhaps we can remove this set_irq_trigger_mode() completely via merging
ti into mach_init_irq().

Then We also need to remove the related declaration in
arch/mips/include/asm/mach-loongson/loongson.h.

Regards,
	Wu Zhangjin

On Tue, 2010-05-04 at 17:54 +0800, yajin wrote:
> The function set_irq_trigger_mode is used to set the interrupt trigger
> level and it should be machine specific. That means we need to remove
> this function from common/irq.c to irq.c of different loongson
> machines.
> 
> 
> Signed-off-by: yajin <yajin@vm-kernel.org>
> ---
>  arch/mips/loongson/common/irq.c     |    3 ---
>  arch/mips/loongson/fuloong-2e/irq.c |    3 +++
>  arch/mips/loongson/lemote-2f/irq.c  |    3 +++
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/loongson/common/irq.c b/arch/mips/loongson/common/irq.c
> index 20e7328..987feeb 100644
> --- a/arch/mips/loongson/common/irq.c
> +++ b/arch/mips/loongson/common/irq.c
> @@ -56,9 +56,6 @@ void __init arch_init_irq(void)
>  	 */
>  	clear_c0_status(ST0_IM | ST0_BEV);
> 
> -	/* setting irq trigger mode */
> -	set_irq_trigger_mode();
> -
>  	/* no steer */
>  	LOONGSON_INTSTEER = 0;
> 
> diff --git a/arch/mips/loongson/fuloong-2e/irq.c
> b/arch/mips/loongson/fuloong-2e/irq.c
> index 320e937..3881bd3 100644
> --- a/arch/mips/loongson/fuloong-2e/irq.c
> +++ b/arch/mips/loongson/fuloong-2e/irq.c
> @@ -59,6 +59,9 @@ void __init mach_init_irq(void)
>  	 *   32-63        ------> bonito irq
>  	 */
> 
> +	/* setting irq trigger mode */
> +	set_irq_trigger_mode();
> +
>  	/* Sets the first-level interrupt dispatcher. */
>  	mips_cpu_irq_init();
>  	init_i8259_irqs();
> diff --git a/arch/mips/loongson/lemote-2f/irq.c
> b/arch/mips/loongson/lemote-2f/irq.c
> index 1d8b4d2..f3eee56 100644
> --- a/arch/mips/loongson/lemote-2f/irq.c
> +++ b/arch/mips/loongson/lemote-2f/irq.c
> @@ -122,6 +122,9 @@ void __init mach_init_irq(void)
>  	 *   32-63        ------> bonito irq
>  	 */
> 
> +	/* setting irq trigger mode */
> +	set_irq_trigger_mode();
> +
>  	/* Sets the first-level interrupt dispatcher. */
>  	mips_cpu_irq_init();
>  	init_i8259_irqs();
