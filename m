Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 18:22:08 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:44661 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492472Ab0EFQWE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 18:22:04 +0200
Received: by pvg16 with SMTP id 16so58698pvg.36
        for <multiple recipients>; Thu, 06 May 2010 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=dfGiwAWOqR0JTkj38atc6a/e0X28YbVhk1erfMtZcvc=;
        b=eK6Vhov3iCaupFMLFcEnvg1Mz2lrIGRI11QJ3/fDe4o/KnA1jzHYekq6eQeLKj34aD
         rLpsgL90GMcyMRY024gsrYu93OMI6zeUVBYqC9Rz6eq4YALFO1qx99WpAj10tJyjy1M/
         TkRxtWqF09Lpb/S71J4FK/QQ25Q93LzN27P4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=BFyoU7143AugJsH/mqlydLc9ZuXKItMhRd7fFPSjOn+QwDSW59iIb44hc5Jkv5D6as
         c2AkGbf5N1RpvsT9k3qK1FEGumPJ9fPIJvhSu/LER/T2JW7QG4pmKBw7B/IUCVw/eS1d
         W2xNzi76ONL5HogC2Lo3mGDw3Us0Fgl8p9HKc=
Received: by 10.114.237.21 with SMTP id k21mr2695376wah.141.1273162915785;
        Thu, 06 May 2010 09:21:55 -0700 (PDT)
Received: from [192.168.2.201] ([202.201.14.140])
        by mx.google.com with ESMTPS id c1sm5026854wam.7.2010.05.06.09.21.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 09:21:54 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] MIPS/Oprofile: extract PMU defines/helper
 functions for sharing
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
In-Reply-To: <1273067734-4758-2-git-send-email-dengcheng.zhu@gmail.com>
References: <1273067734-4758-1-git-send-email-dengcheng.zhu@gmail.com>
         <1273067734-4758-2-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 07 May 2010 00:21:49 +0800
Message-ID: <1273162909.23734.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 2010-05-05 at 21:55 +0800, Deng-Cheng Zhu wrote:
> Moving performance counter/control defines/helper functions into a single
> header file, so that software using the MIPS PMU can share the code.
> 
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
> ---
>  arch/mips/include/asm/pmu.h             |  244 +++++++++++++++++++++++++++++++
>  arch/mips/oprofile/op_model_loongson2.c |   23 +---
>  arch/mips/oprofile/op_model_mipsxx.c    |  164 +---------------------
>  arch/mips/oprofile/op_model_rm9000.c    |   16 +--
>  4 files changed, 247 insertions(+), 200 deletions(-)
>  create mode 100644 arch/mips/include/asm/pmu.h
> 
> diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
[...]
> +
> +#ifndef __MIPS_PMU_H__
> +#define __MIPS_PMU_H__
> +
> +#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) || \
> +    defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_SB1)
[...]
> +static int (*save_perf_irq)(void);

For we will use the save_perf_irq in the common function:
mipspmu_get_irq() of the next patch, so, we need to move the definition
of it out of the #if ... and put it before the #if:

...
+static int (*save_perf_irq)(void);

#if defined(CONFIG_CPU_MIPS32)
...

Regards,
	Wu Zhangjin
