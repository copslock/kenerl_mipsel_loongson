Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2018 19:42:12 +0100 (CET)
Received: from mail-wr1-x442.google.com ([IPv6:2a00:1450:4864:20::442]:35581
        "EHLO mail-wr1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991065AbeJaSkz1WR1A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2018 19:40:55 +0100
Received: by mail-wr1-x442.google.com with SMTP id w5-v6so17643687wrt.2
        for <linux-mips@linux-mips.org>; Wed, 31 Oct 2018 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WtYS++Eq2aKwebxiYSlbkwQV34nMjfy4iBCJpS0awSw=;
        b=hdQ/nyXbfRzLkuTjrCs+yt4AzN38RVEgQhSi/O8VUC5RcMchuISzBsyZJL1VYH2Frd
         EEOj3uIby+3hOsmcYzl+uFlpUahxCiq5zKOrtPNCdr3QyOddDFKIJ4zqQT+lvmodn2nu
         ORdFQfg5/C1Cx0QHT5BZWjF6cV+MJh4h6LW6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtYS++Eq2aKwebxiYSlbkwQV34nMjfy4iBCJpS0awSw=;
        b=QxcgkszndsjUAON6+EWd7chv5dogf4huPLN7Ica3dt37XTw2Gqhvc2howaSD7HGUpM
         6j9Zgws/jTeXIgAJpcvh/VIN//3Fe3sSvCX1Jr+gaXnq8VPMKf+ygkgkRhiG7JTc5Slj
         aDUqhb6DDnRroKEchp5Mm5lVarjGSd+djcwi+eNYzkQ49bV2Mxr69IL5/QhG+0+h0VCZ
         VkkM69Uj/998glgSRpGJEkjC7sviKSvQ5BzIFNcgXEUQq3qwo5gtd4Sjab395Fq1++9y
         U0/eWdta+g29kuvw6D/h6ZFI1Y9SkBVUgJC3eWGDS4Z3ZSBUK62BQhgxW3gaTp+knwOY
         rPig==
X-Gm-Message-State: AGRZ1gKogyf/erCJXyJ1hthgh5rEpihJgorpzmwY2a9codQYlmMmozYM
        YHBI7TYWJfsQd9rdY/RyxnFTlg==
X-Google-Smtp-Source: AJdET5cW1DPUxxa9WGN3IWebi0IepbzWy8AHnIeVuGeUiXFAb/j4Sh57UviFzEx5cdIbZsHCTGri7g==
X-Received: by 2002:adf:8909:: with SMTP id s9-v6mr3821947wrs.309.1541011254757;
        Wed, 31 Oct 2018 11:40:54 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 191-v6sm18863435wmk.30.2018.10.31.11.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 11:40:53 -0700 (PDT)
Date:   Wed, 31 Oct 2018 18:40:50 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Rich Felker <dalias@libc.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Message-ID: <20181031184050.sd5opni3mznaapkv@holly.lan>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030221843.121254-3-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Return-Path: <daniel.thompson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.thompson@linaro.org
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

On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index f3cadda45f07..9a3f952de6ed 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -55,6 +55,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmacache.h>
>  #include <linux/rcupdate.h>
> +#include <linux/irq.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/byteorder.h>
> @@ -220,6 +221,39 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +/*
> + * Default (weak) implementation for kgdb_roundup_cpus
> + */
> +
> +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> +
> +void __weak kgdb_call_nmi_hook(void *ignored)
> +{
> +	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> +}
> +
> +void __weak kgdb_roundup_cpus(void)
> +{
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		smp_call_function_single_async(cpu, csd);
> +	}

smp_call_function() automatically skips the calling CPU but this code does
not. It isn't a hard bug since kgdb_nmicallback() does a re-entrancy
check but I'd still prefer to skip the calling CPU.

As mentioned in another part of the thread we can also add robustness
by skipping a cpu where csd->flags != 0 (and adding an appropriately
large comment regarding why). Doing the check directly is abusing
internal knowledge that smp.c normally keeps to itself so an accessor
of some kind would be needed.


> +}
> +
> +static void kgdb_generic_roundup_init(void)
> +{
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		csd->func = kgdb_call_nmi_hook;
> +	}
> +}

I can't help noticing this code is very similar to kgdb_roundup_cpus. Do
we really gain much from ahead-of-time initializing csd->func?


Daniel.
