Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Nov 2017 17:50:50 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:55173 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990754AbdKUQunG0jrk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Nov 2017 17:50:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ndEZtumggrsHtWwgTHse7TqzKoVtC0/IcNPZeSj3kN4=; b=kmYFWJCDC6rPDvRB0u6TC5O2/
        LFjS09KZVKDp+/fmUIiLJoo+293DWJtR2Fx+MHEmWgRwm+kCXOdHqecJH3884CWaXbayq1ubgMSE6
        onY9BZm5lUBAkfWop9FjvjrJPmrwnWkRa29Q5p6v0DG5tvxKe0vS7bkvXJNL0v1xp977l/9UYJvKs
        URf2oeYRQj/2XQ104YFVGiBH3jYfPS+l+nv60jzkTCZYNUHsdBcvSHuQEC/ckHfyFSPknTBO6Z/Hn
        ypup7c9qWLS7R/XWv3dKIfOups2hj5X5qz/V60BW23MQohoSbkeb8S8S0vst6J8fwW1NOiqBFyCIw
        FamNdVXVA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlap)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1eHBkr-0006YY-Dz; Tue, 21 Nov 2017 16:50:37 +0000
Subject: Re: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        James Hogan <james.hogan@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Saeger <tom.saeger@oracle.com>
References: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e0c5b94c-12b2-8250-204f-df5cbe5e4662@infradead.org>
Date:   Tue, 21 Nov 2017 08:50:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <rdunlap@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@infradead.org
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

On 11/21/2017 05:56 AM, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@mips.com>
> 
> Add a new kernel parameter to override the default behavior related
> to the decision whether to set up stack as non-executable in function
> mips_elf_read_implies_exec().
> 
> The new parameter is used to control non executable stack and heap,
> regardless of PT_GNU_STACK entry. This does apply to both stack and
> heap, despite the name.
> 
> Allowed values:
> 
> nonxstack=on	Force non-exec stack & heap
> nonxstack=off	Force executable stack & heap
> 
> If this parameter is omitted, kernel behavior remains the same as it
> was before this patch is applied.
> 
> This functionality is convenient during debugging and is especially
> useful for Android development where non-exec stack is required.
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++
>  arch/mips/kernel/elf.c                          | 39 +++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b74e133..99464ee 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2614,6 +2614,17 @@
>  			noexec32=off: disable non-executable mappings
>  				read implies executable mappings
>  
> +	nonxstack	[MIPS]
> +			Force setting up stack and heap as non-executable or
> +			executable regardless of PT_GNU_STACK entry. Both
> +			stack and heap are affected, despite the name. Valid
> +			arguments: on, off.
> +			nonxstack=on:	Force non-executable stack and heap
> +			nonxstack=off:	Force executable stack and heap
> +			If ommited, stack and heap will or will not be set

			   omitted,

> +			up as non-executable depending on PT_GNU_STACK
> +			entry and possibly other factors.
> +
>  	nofpu		[MIPS,SH] Disable hardware FPU at boot time.
>  
>  	nofxsr		[BUGS=X86-32] Disables x86 floating point extended
> diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
> index 731325a..28ef7f3 100644
> --- a/arch/mips/kernel/elf.c
> +++ b/arch/mips/kernel/elf.c
> @@ -326,8 +326,47 @@ void mips_set_personality_nan(struct arch_elf_state *state)
>  	}
>  }
>  
> +static int nonxstack = EXSTACK_DEFAULT;
> +
> +/*
> + * kernel parameter: nonxstack=on|off
> + *
> + *   Force setting up stack and heap as non-executable or
> + *   executable regardless of PT_GNU_STACK entry. Both
> + *   stack and heap are affected, despite the name. Valid
> + *   arguments: on, off.
> + *
> + *     nonxstack=on:   Force non-executable stack and heap
> + *     nonxstack=off:  Force executable stack and heap
> + *
> + *   If ommited, stack and heap will or will not be set

           omitted

> + *   up as non-executable depending on PT_GNU_STACK
> + *   entry and possibly other factors.
> + */


-- 
~Randy
