Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 23:48:53 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:39400 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491834Ab0E0Vst (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 23:48:49 +0200
Received: by pwi2 with SMTP id 2so283924pwi.36
        for <multiple recipients>; Thu, 27 May 2010 14:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=KICw04MGxQiFERpfSCxA0hV8+0UydEqE9IxuFKM4obw=;
        b=YLEursukEycq0XgpgyBbWfAsXxTuRkJCLHSIX2Bl28YOEYAhLq6OyX9YmewhY6QI5+
         Nk84+XuC8Mm4wLgLYuQ0mJHUZ3eAE9argdr+09ysRs8guWR8IMPXCq3GIVm3sck+POa0
         IfiuBuLPysKXx1bYROKJDvriqFJZl5KQ8OO+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=T2yoTZykCWs39FkdLqEa4MN1jtBIaoLiOwtYpC60m7WbzQnmF/NJkQqNHJl35zlvB9
         NZDe0MoNfm/KVbd2AJaV0SvmRcVlKhK3wRmsybGsAF+QPGqYT1wdQT4HhsrfV01kzL5o
         tHB69H6HyS6YBMsohKN8Aycwdv0JzWDgQ1/7M=
Received: by 10.143.21.24 with SMTP id y24mr7511911wfi.254.1274996922067;
        Thu, 27 May 2010 14:48:42 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id y15sm929567wfd.22.2010.05.27.14.48.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 14:48:40 -0700 (PDT)
Message-ID: <4BFEE8B6.6040605@gmail.com>
Date:   Thu, 27 May 2010 14:48:38 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 01/12] MIPS/Oprofile: extract PMU defines/helper functions
 for sharing
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com> <1274965420-5091-2-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1274965420-5091-2-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 06:03 AM, Deng-Cheng Zhu wrote:
[...]
>
> diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
[...]
> +
> +#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) || \
> +    defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_SB1)
> +

Why predicate the entire contents of the file?

In any event, if you keep it, it shold probably be something like:

     #if defined(CONFIG_CPU_MIPSR1) || defined(CONFIG_CPU_MIPSR2)


> +#define M_CONFIG1_PC	(1<<  4)
> +
> +#define M_PERFCTL_EXL			(1UL<<   0)
> +#define M_PERFCTL_KERNEL		(1UL<<   1)
> +#define M_PERFCTL_SUPERVISOR		(1UL<<   2)
> +#define M_PERFCTL_USER			(1UL<<   3)
> +#define M_PERFCTL_INTERRUPT_ENABLE	(1UL<<   4)
> +#define M_PERFCTL_EVENT(event)		(((event)&  0x3ff)<<  5)
> +#define M_PERFCTL_VPEID(vpe)		((vpe)<<  16)
> +#define M_PERFCTL_MT_EN(filter)		((filter)<<  20)
> +#define    M_TC_EN_ALL			M_PERFCTL_MT_EN(0)
> +#define    M_TC_EN_VPE			M_PERFCTL_MT_EN(1)
> +#define    M_TC_EN_TC			M_PERFCTL_MT_EN(2)
> +#define M_PERFCTL_TCID(tcid)		((tcid)<<  22)
> +#define M_PERFCTL_WIDE			(1UL<<  30)
> +#define M_PERFCTL_MORE			(1UL<<  31)
> +
> +#define M_COUNTER_OVERFLOW		(1UL<<  31)
> +

Some or all of that should probably go in asm/mipsregs.h


[...]
> +
> +#define __define_perf_accessors(r, n, np)				\
> +									\
> +static inline unsigned int r_c0_ ## r ## n(void)			\
> +{									\
> +	unsigned int cpu = vpe_id();					\
> +									\
> +	switch (cpu) {							\
> +	case 0:								\
> +		return read_c0_ ## r ## n();				\
> +	case 1:								\
> +		return read_c0_ ## r ## np();				\
> +	default:							\

Are 0 and 1 really the only conceivable values?


David Daney
