Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 May 2010 03:35:39 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:51081 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492308Ab0EIBfg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 May 2010 03:35:36 +0200
Received: by pwj3 with SMTP id 3so1042732pwj.36
        for <multiple recipients>; Sat, 08 May 2010 18:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=37vauDz7v28zrIZDOUfeJhDjiaePYQ9ZHyA17GriS0I=;
        b=ZaMBCPm+YL2XxDo/k5iydLt/v18ET5aACK8RfvnSfGjBFw1KBAXMczVv2N8+B8+UiK
         ZfdkLC7U/irqwCCZa/wgn48e/1EE4BV9lMH9X0swc2V9SxDI8SYFstlMEX/ynPr/5ter
         HMxTSI9wPGt4QfuB54ZUsYeQOTiOmpEJXTKI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=gCDhYqjWJtUEyskCsTE2XZhyDBPaKXp+OASQskFdBg42Buac96YvUxwvidU1/fam1D
         f8YqIw/x/Ftsns6/LqbO1YJ9ok34tKEul3aI/PIe+LbuIsiqoVpYAFMSSnZFccFhAYia
         zc+6dzMcWvJkTrSDZ+/Z8guJvmdnIMeQ5a/UI=
Received: by 10.114.10.19 with SMTP id 19mr1589919waj.75.1273368927076;
        Sat, 08 May 2010 18:35:27 -0700 (PDT)
Received: from [192.168.2.244] ([202.201.14.140])
        by mx.google.com with ESMTPS id n32sm17480967wae.22.2010.05.08.18.35.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 18:35:24 -0700 (PDT)
Subject: Re: [PATCH] Oprofile: Loongson: Fixup of irq handler
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <1273165186-29153-1-git-send-email-wuzhangjin@gmail.com>
References: <1273165186-29153-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sun, 09 May 2010 09:35:19 +0800
Message-ID: <1273368919.4914.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

This one is urgent, could you please review it, thanks ;)

Regards,
	Wu Zhangjin

On Fri, 2010-05-07 at 00:59 +0800, Wu Zhangjin wrote:
> The interrupt enable bit of performance counters of Loongson is in the
> control register($24), not in the counter register, so, in
> loongson2_perfcount_handler(), we need to use
> 
> 	enabled = read_c0_perfctrl() & LOONGSON2_PERFCNT_INT_EN;
> 
> instead of
> 
> 	enabled = read_c0_perfcnt() & LOONGSON2_PERFCNT_INT_EN;
> 
> Reported-by: Xu Hengyang <hengyang@mail.ustc.edu.cn>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/oprofile/op_model_loongson2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
> index 29e2326..fa3bf66 100644
> --- a/arch/mips/oprofile/op_model_loongson2.c
> +++ b/arch/mips/oprofile/op_model_loongson2.c
> @@ -122,7 +122,7 @@ static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
>  	 */
>  
>  	/* Check whether the irq belongs to me */
> -	enabled = read_c0_perfcnt() & LOONGSON2_PERFCNT_INT_EN;
> +	enabled = read_c0_perfctrl() & LOONGSON2_PERFCNT_INT_EN;
>  	if (!enabled)
>  		return IRQ_NONE;
>  	enabled = reg.cnt1_enabled | reg.cnt2_enabled;
