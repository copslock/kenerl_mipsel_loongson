Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Aug 2013 12:27:39 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:41586 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822995Ab3HBK1g02E6w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Aug 2013 12:27:36 +0200
Received: by mail-pd0-f182.google.com with SMTP id r10so513655pdi.13
        for <multiple recipients>; Fri, 02 Aug 2013 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pAlZ1eGBVriRyX3L9I+SuxkCFN7MqrwNHlUm7EvKqHg=;
        b=0/XYWb0KzCZ8BICYPIvxo3UvECZZ6zw4R8cOrUSBECKYpxEzyJ71m9HIXCloK/07QC
         RgU6tQmCzfdfmuk4YNic2W6nY+RGH52Gihq2CbzcvGUsKoNk6uDhBQJ5As34xP1EVHo6
         7J4YdYt6oZ/t4FovRROV2HPsBsWsNMOZJNDuQOzt8dcpgLjT4WASRV9sUwMnr9dR64Q1
         SVu59Y7+VF3xjC+Ky6ySENozQ/I0biOV6A+Yhc4ds8Vi+J35Q+HQKgWINd73D/Jggf3H
         DjtTew1YLMtUoykMBwEgd469JxJ7gJa1tn55CNDpEXZm1SZ6rVuV+fWgNc0Wt9Iat3SO
         WllQ==
X-Received: by 10.68.209.196 with SMTP id mo4mr6939517pbc.114.1375439249946;
        Fri, 02 Aug 2013 03:27:29 -0700 (PDT)
Received: from gmail.com ([115.111.18.195])
        by mx.google.com with ESMTPSA id om2sm9470012pbc.30.2013.08.02.03.27.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 03:27:28 -0700 (PDT)
Date:   Fri, 2 Aug 2013 15:57:14 +0530
From:   Jerin Jacob <jerinjacobk@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, mbhat@netlogicmicro.com,
        jchandra@broadcom.com
Subject: Re: [PATCH] MIPS: oprofile: Fix for BUG: using smp_processor_id() in
 preemptible [00000000] code: oprofiled/1362
Message-ID: <20130802102712.GA5135@gmail.com>
References: <1375369841-16427-1-git-send-email-jerinjacobk@gmail.com>
 <20130801163105.GC23583@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130801163105.GC23583@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jerinjacobk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerinjacobk@gmail.com
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

On Thu, Aug 01, 2013 at 06:31:05PM +0200, Ralf Baechle wrote:
> On Thu, Aug 01, 2013 at 08:40:41PM +0530, Jerin Jacob wrote:
> 
> > current_cpu_type() is not preemption-safe.
> > If CONFIG_PREEMPT is enabled then mipsxx_reg_setup() can be called from preemptible state.
> > Added get_cpu()/put_cpu() pair to make it preemption-safe.
> > 
> > This was found while testing oprofile with CONFIG_DEBUG_PREEMPT enable.
> [...]
> 
> Interesting.  I wonder how many more of this kind of bug we got lurking
> around.
> 
> In case of oprofile, we silently assume that all processors have the same
> number of counters, the same style and number of counters.  So it'd be
> ok to just look at the boot CPU which is even simpler than your fix.
> 
> What do you think about below fix?
yes, it make sense to compare the cpu_type against boot cpu.
Acked-by: Jerin Jacob <jerinjacobk@gmail.com>
> 
> Thanks,
> 
>   Ralf
> 
>  arch/mips/include/asm/cpu-features.h | 2 ++
>  arch/mips/oprofile/op_model_mipsxx.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index 1dc0860..fa44f3e 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -17,6 +17,8 @@
>  #define current_cpu_type()	current_cpu_data.cputype
>  #endif
>  
> +#define boot_cpu_type()		cpu_data[0].cputype
> +
>  /*
>   * SMP assumption: Options of CPU 0 are a superset of all processors.
>   * This is true for all known MIPS systems.
> diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
> index e4b1140..3a2b6e9 100644
> --- a/arch/mips/oprofile/op_model_mipsxx.c
> +++ b/arch/mips/oprofile/op_model_mipsxx.c
> @@ -166,7 +166,7 @@ static void mipsxx_reg_setup(struct op_counter_config *ctr)
>  			reg.control[i] |= M_PERFCTL_USER;
>  		if (ctr[i].exl)
>  			reg.control[i] |= M_PERFCTL_EXL;
> -		if (current_cpu_type() == CPU_XLR)
> +		if (boot_cpu_type() == CPU_XLR)
>  			reg.control[i] |= M_PERFCTL_COUNT_ALL_THREADS;
>  		reg.counter[i] = 0x80000000 - ctr[i].count;
>  	}
