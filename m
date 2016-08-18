Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 16:13:42 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:56665 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993411AbcHROMrlplkI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Aug 2016 16:12:47 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D3DDABEF;
        Thu, 18 Aug 2016 14:12:43 +0000 (UTC)
Date:   Thu, 18 Aug 2016 16:12:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Metcalf <cmetcalf@mellanox.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aaron Tomlin <atomlin@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Ralf Baechle ralf @ linux-mips . org David S. Miller" 
        <davem@davemloft.net>, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
Message-ID: <20160818141242.GK26194@pathway.suse.cz>
References: <1471377024-2244-1-git-send-email-cmetcalf@mellanox.com>
 <1471377024-2244-2-git-send-email-cmetcalf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471377024-2244-2-git-send-email-cmetcalf@mellanox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmladek@suse.com
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

On Tue 2016-08-16 15:50:21, Chris Metcalf wrote:
> Currently you can only request a backtrace of either all cpus, or
> all cpus but yourself.  It can also be helpful to request a remote
> backtrace of a single cpu, and since we want that, the logical
> extension is to support a cpumask as the underlying primitive.
> 
> This change modifies the existing lib/nmi_backtrace.c code to take
> a cpumask as its basic primitive, and modifies the linux/nmi.h code
> to use the new "cpumask" method instead.
> 
> The mips code ignored the "include_self" boolean but with this change
> it will now also dump a local backtrace if requested.
> 
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 7429ad09fbe3..fea1fa7726e3 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -569,9 +569,16 @@ static void arch_dump_stack(void *info)
>  	dump_stack();
>  }
>  
> -void arch_trigger_all_cpu_backtrace(bool include_self)
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>  {
> -	smp_call_function(arch_dump_stack, NULL, 1);
> +	long this_cpu = get_cpu();
> +
> +	if (cpumask_test_cpu(this_cpu, mask) && !exclude_self)
> +		dump_stack();

The bit is not cleared in the mask. Therefore arch_dump_stack
will get called for this CPU as well.

We could either use similar tricks as in lib/nmi_backtrace().
I mean to copy the mask into a global variable and prevent
parallel call with a backtrace_flag.

Or we could ignore the exclude_self flag as it was done
before. It is a separate problem after all and it need
not be solved in this patch(set).

> +
> +	smp_call_function_many(mask, arch_dump_stack, NULL, 1);
> +
> +	put_cpu();
>  }

Otherwise the patch patch looks good to me.

Best Regards,
Petr
