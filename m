Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2010 05:52:08 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:50123 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491119Ab0EYDwF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 May 2010 05:52:05 +0200
Received: by gwj19 with SMTP id 19so1071776gwj.36
        for <multiple recipients>; Mon, 24 May 2010 20:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=wSIM3QeOYeuFC2nQcIUAdAl5PiVobB3hc+aks++eRxg=;
        b=CfCR8odzlJGwgZHGhP7GDfG0sVelgGUNqRe4Pu5jGxieRbxkbKwOegS//B6xp6ZCSn
         UmZNsihg0E1AKozAXeXe6SyIlEJYjTP1CopHAOec7hUDRleRAOBHWsZK+W6bWoKwSK1q
         /JvbQ6uoCY+YerqgW63o7m+ndfGPMDojf9P3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=PQ5y4GH2XtMerZvzlASXgGfwk15fckhRfGJfyttuWej/CSB4GiBMC7+wgrWxSdB2vs
         fCZD5zOaDOw30wXLr89K0WgwuQvlXCroTy5fJE97b3u5b4pMn/DMCiH2ihO90m1+NbJ2
         ZSLeNNvnQKVGIGIyQFekUeAfBVLn/2zaJYkK0=
Received: by 10.150.160.18 with SMTP id i18mr7255602ybe.100.1274759518292;
        Mon, 24 May 2010 20:51:58 -0700 (PDT)
Received: from [192.168.2.218] ([202.201.14.140])
        by mx.google.com with ESMTPS id v2sm310165ybh.4.2010.05.24.20.51.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 20:51:56 -0700 (PDT)
Subject: Re: [PATCH] Oprofile: Loongson: Fixup of loongson2_exit()
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <1273165429-29766-1-git-send-email-wuzhangjin@gmail.com>
References: <1273165429-29766-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 25 May 2010 11:51:50 +0800
Message-ID: <1274759510.10746.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

Seems you have accepted this patch but forgot to apply it, could you
please apply it, thanks ;)

Best Regards,
	Wu Zhangjin

On Fri, 2010-05-07 at 01:03 +0800, Wu Zhangjin wrote:
> When exiting from loongson2_exit(), we need to reset the counter
> register too, this patch adds a function reset_counters() to do it, by
> the way, this function will be shared by Perf.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/oprofile/op_model_loongson2.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
> index fa3bf66..01f91a3 100644
> --- a/arch/mips/oprofile/op_model_loongson2.c
> +++ b/arch/mips/oprofile/op_model_loongson2.c
> @@ -51,6 +51,12 @@ static char *oprofid = "LoongsonPerf";
>  static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id);
>  /* Compute all of the registers in preparation for enabling profiling.  */
>  
> +static void reset_counters(void *arg)
> +{
> +	write_c0_perfctrl(0);
> +	write_c0_perfcnt(0);
> +}
> +
>  static void loongson2_reg_setup(struct op_counter_config *cfg)
>  {
>  	unsigned int ctrl = 0;
> @@ -157,7 +163,7 @@ static int __init loongson2_init(void)
>  
>  static void loongson2_exit(void)
>  {
> -	write_c0_perfctrl(0);
> +	reset_counters(NULL);
>  	free_irq(LOONGSON2_PERFCNT_IRQ, oprofid);
>  }
>  
