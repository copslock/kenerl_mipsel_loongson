Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2014 16:48:30 +0200 (CEST)
Received: from mail-ee0-f50.google.com ([74.125.83.50]:59453 "EHLO
        mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825633AbaDNOs2Uuhmj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Apr 2014 16:48:28 +0200
Received: by mail-ee0-f50.google.com with SMTP id c13so6826847eek.9
        for <multiple recipients>; Mon, 14 Apr 2014 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kY0wusbHLm54RQfEtQlV3/sLEKtqH3fQrh199hvfWgQ=;
        b=j3Ac/hnA407BAVzYsKirtzzv+5sVYiDMp4oa2xVHf7fVXNzfsCAiif30qsnkam2JTV
         o3/5X2Lb2i4Zw4uPaSwe5E88711AaWoQagZXTvetsCIUeRReL8TFCD09HTVsrnxtQxfR
         EpwH9BdP8CV2j7PJ3XLWO+xn1DafRmRWw+fSK9G6tVMrv4MA0y1c5cgJnSxzvKWds0HP
         k4AuixwODzEpjG4VydSIKSlF7zOusYJmzILx5lcOcOjxO5ndkxRO/yk8HCq/KIGRHC3D
         Km/v7iZdgINZqXGhmklFaB/EXzfljseTKztlIu+wykJhN6kEVGz8M2vld1R5Qv7MOiGs
         mpww==
X-Received: by 10.15.36.6 with SMTP id h6mr4530730eev.54.1397486902976;
        Mon, 14 Apr 2014 07:48:22 -0700 (PDT)
Received: from alberich ([2.171.76.237])
        by mx.google.com with ESMTPSA id x45sm41549517eeu.23.2014.04.14.07.48.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Apr 2014 07:48:22 -0700 (PDT)
Date:   Mon, 14 Apr 2014 16:48:18 +0200
From:   Andreas Herrmann <herrmann.der.user@googlemail.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Subject: Re: [PATCH V2 1/8] MIPS: Support hard limit of cpu count (nr_cpu_ids)
Message-ID: <20140414144818.GA10997@alberich>
References: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
 <1397348662-22502-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1397348662-22502-2-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herrmann.der.user@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herrmann.der.user@googlemail.com
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

On Sun, Apr 13, 2014 at 08:24:15AM +0800, Huacai Chen wrote:
> On MIPS currently, only the soft limit of cpu count (maxcpus) has its
> effect, this patch enable the hard limit (nr_cpus) as well. Processor
> cores which greater than maxcpus and less than nr_cpus can be taken up
> via cpu hotplug. The code is borrowed from X86.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Reviewed-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>

W/o this patch nr_cpus had no effect and all CPUs present on a chip
(even if greater than or equal to nr_cpus) could be taken online with
CPU hotplug.  W/o the patch nr_cpus took effect.

Only nitpick: I find the name of the function somehow misleading.
I think it's rather a kind of fixup (to factor in nr_cpus) after
platform smp_setup might have already "prefilled"
cpu_possible_mask. At least in case of cavium-octeon this is the case.


Thanks,
Andreas

> ---
>  arch/mips/kernel/setup.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index a842154..2f01201 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -729,6 +729,25 @@ static void __init resource_init(void)
>  	}
>  }
>  
> +#ifdef CONFIG_SMP
> +static void __init prefill_possible_map(void)
> +{
> +	int i, possible = num_possible_cpus();
> +
> +	if (possible > nr_cpu_ids)
> +		possible = nr_cpu_ids;
> +
> +	for (i = 0; i < possible; i++)
> +		set_cpu_possible(i, true);
> +	for (; i < NR_CPUS; i++)
> +		set_cpu_possible(i, false);
> +
> +	nr_cpu_ids = possible;
> +}
> +#else
> +static inline void prefill_possible_map(void) {}
> +#endif
> +
>  void __init setup_arch(char **cmdline_p)
>  {
>  	cpu_probe();
> @@ -752,6 +771,7 @@ void __init setup_arch(char **cmdline_p)
>  
>  	resource_init();
>  	plat_smp_setup();
> +	prefill_possible_map();
>  
>  	cpu_cache_init();
>  }
> -- 
> 1.7.7.3
> 
> 
