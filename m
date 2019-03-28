Return-Path: <SRS0=GXiT=R7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6212AC43381
	for <linux-mips@archiver.kernel.org>; Thu, 28 Mar 2019 07:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E3A2173C
	for <linux-mips@archiver.kernel.org>; Thu, 28 Mar 2019 07:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oAavkeGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfC1HGf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:06:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42321 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1HGf (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 28 Mar 2019 03:06:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so17943151wrx.9
        for <linux-mips@vger.kernel.org>; Thu, 28 Mar 2019 00:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T22U+apjEJp8KKN8ohy9LC/OplKJEtOVR/cRDLcUg9Y=;
        b=oAavkeGXVQAcI0nq1Z6LUurNIAN/67TwbDieDah+uE/ms7uYJxlgnRoKS7Orf03RbC
         P62Qf0EoaZAqWMvrMEVAsCZb4JXpTZ6VZaVZjIN9/ebacuVQXVI41b4GfdhUWlkxKcRp
         Z8KRD76oXAo7ivMoS9g7SgR0Q5ccr5jqF6Aqe0ImWx3o9ZKGpLAHADbbzmPAdKD0+PDj
         byssobBBGfcZyluyKskCUc4kXVDVSj+bA46XQzmaAGj23mPKiBWzjkjO7aX0hLopo1zM
         rV1Gbxkcfh9mb/053fXlm4R8mV8FgBzhBSSfpFA7p8K9dTC+nV9GP7s/8G8Unrq9s9cW
         imkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T22U+apjEJp8KKN8ohy9LC/OplKJEtOVR/cRDLcUg9Y=;
        b=G/Wx4sKQGgKG48vAogxBmAUtWlwOy3zMwL2JCg47B2Otl8TYrrsfctHbaNErXG5hf9
         mfciWTuq7+jeOaWTjcPT/UOASGtcHTxiWPEQ1EqdTVeuEP0hbn0b0GcBFj9ivim7WxUR
         8Bpaz9/93bq2St5nnw1pdbVmf8SqxRBiXZbw2iHzCvIT8yjpqJ49clAtdf754cBxrlnI
         HR49/eE77/hHdqH4H3jqwHqXrz8V1eT1WcDH3yRVcIOXzXpb1yW8dJBLtF5P+2B14npu
         8j8NH9KRSqFhZ4lQosSS+5AW+Ij+5EV6W+ZLnmCvSZC1nHd+6Q/mB6uaqMiQBokQfqJR
         K+EQ==
X-Gm-Message-State: APjAAAUBetLPiyEui73xjcRVgCwObug9WAjLjS0sb+D/j42F7Pk3Pae2
        mrgEJGXUdY18gyUUuoUzuVbsWQ==
X-Google-Smtp-Source: APXvYqzMUttDUzV7VPpup1LC8leqVCSAG90qO4u4AiHyMdEXnrcyGiIu5yficJ/+aA33lbkyzpEKQA==
X-Received: by 2002:adf:ebc8:: with SMTP id v8mr25905058wrn.172.1553756793843;
        Thu, 28 Mar 2019 00:06:33 -0700 (PDT)
Received: from holly.lan ([185.201.60.219])
        by smtp.gmail.com with ESMTPSA id c20sm31217097wre.28.2019.03.28.00.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 00:06:33 -0700 (PDT)
Date:   Thu, 28 Mar 2019 07:06:29 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Chong Qiao <qiaochong@loongson.cn>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: KGDB: fix kgdb support for SMP platforms.
Message-ID: <20190328070629.uw4ybmecz47h7uje@holly.lan>
References: <20190327230801.3650-1-qiaochong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327230801.3650-1-qiaochong@loongson.cn>
User-Agent: NeoMutt/20180716
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, Mar 28, 2019 at 07:08:01AM +0800, Chong Qiao wrote:
> KGDB_call_nmi_hook is called by other cpu through smp call.
> MIPS smp call is processed in ipi irq handler and regs is saved in
>  handle_int.
> So kgdb_call_nmi_hook get regs by get_irq_regs and regs will be passed
>  to kgdb_cpu_enter.
> 
> Signed-off-by: Chong Qiao <qiaochong@loongson.cn>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  arch/mips/kernel/kgdb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index 6e574c02e4c3b..ea781b29f7f17 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -33,6 +33,7 @@
>  #include <asm/processor.h>
>  #include <asm/sigcontext.h>
>  #include <linux/uaccess.h>
> +#include <asm/irq_regs.h>
>  
>  static struct hard_trap_info {
>  	unsigned char tt;	/* Trap type code for MIPS R3xxx and R4xxx */
> @@ -214,7 +215,7 @@ void kgdb_call_nmi_hook(void *ignored)
>  	old_fs = get_fs();
>  	set_fs(KERNEL_DS);
>  
> -	kgdb_nmicallback(raw_smp_processor_id(), NULL);
> +	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  
>  	set_fs(old_fs);
>  }
> -- 
> 2.17.0
> 
> 
