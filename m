Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 03:25:49 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:32811
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993879AbdD1BZmY1wOn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 03:25:42 +0200
Received: by mail-pf0-x244.google.com with SMTP id 194so1285256pfv.0;
        Thu, 27 Apr 2017 18:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yXPECBBxQ4GRtweBqNZY/QIPLe6w6JBT46LQAXoSxGc=;
        b=F5Mq/ryf8GXYyQPJUXbcFTA4WDkNYGRPvvQ5vc/YzPLU+OqdQjnbOBva5hl+phneqi
         h2JW+7VXxc13sD20uOe24fa4JOPtEAyu8MZIwy6oikIRMt1kqM8cH1xDuh0ww5SAocD0
         tCH6MUXD04NuUFrIJUPupmkeVnCVx7Ijg++LA4+0ll0SxBfVv8rmqaaBqgXgN4HCBgUG
         7Xgw5kWtvzZIDweEkJDVz1AUVtED9b7sHjGK7v+Xlg9jyM8QOSJ2Iy/taod7f8NPI7Bj
         zDo070VNw17wPZWlrgjT2y41Oame7RLEeIA4uK97+xBm1GW3zESydvE0Yz+zR69ez//G
         5qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yXPECBBxQ4GRtweBqNZY/QIPLe6w6JBT46LQAXoSxGc=;
        b=b317SrTTkFj4M2pmKlPBaDjqpMRn4BWv6SjBM0sicc9V9srLMU8G8rdqCJI+yeGyO4
         P35SU8yuO4Cc7TUq+TRZVISnF7NOwe5Vs/TDXSbAP0tgnMD6GNWWLhImWfdgfve5zBv2
         RW2wfwB3pRHqe1bVN4i8tCuoncWGON9pq7I9PVhY435wL0Exw0Yr1ez+bWhEqFY27Mmi
         gFKxcv00f/C/esdaS9hstrrE0ZJpUy8yiIBIAJKgH4mK+jeFdlRBIFW0DC7Y0y63X5gg
         pQjdYTAf0BpYSf5Z+cLWK4yutZR2kLL0yVPUw357KVVATjrqejDSuhQ1JFi1aIMPNcvE
         6g5A==
X-Gm-Message-State: AN3rC/4kZpohFm+pqkJhAhB39blgLQt/gPDxdSxYBQxi8Z7UmoE5lQBW
        F4x5Qi7PAFsqTA==
X-Received: by 10.99.119.4 with SMTP id s4mr8890437pgc.71.1493342734415;
        Thu, 27 Apr 2017 18:25:34 -0700 (PDT)
Received: from localhost ([110.70.54.84])
        by smtp.gmail.com with ESMTPSA id d3sm9052076pgc.37.2017.04.27.18.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Apr 2017 18:25:33 -0700 (PDT)
Date:   Fri, 28 Apr 2017 10:25:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in
 NMI
Message-ID: <20170428012530.GA383@jagdpanzerIV.localdomain>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420131154.GL3452@pathway.suse.cz>
User-Agent: Mutt/1.8.2 (2017-04-18)
Return-Path: <sergey.senozhatsky.work@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergey.senozhatsky.work@gmail.com
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


On (04/20/17 15:11), Petr Mladek wrote:
[..]
>  void printk_nmi_enter(void)
>  {
> -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> +	/*
> +	 * The size of the extra per-CPU buffer is limited. Use it
> +	 * only when really needed.
> +	 */
> +	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK ||
> +	    raw_spin_is_locked(&logbuf_lock)) {

can we please have && here?


[..]
> diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
> index 4e8a30d1c22f..0bc0a3535a8a 100644
> --- a/lib/nmi_backtrace.c
> +++ b/lib/nmi_backtrace.c
> @@ -86,9 +86,11 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
>  
>  bool nmi_cpu_backtrace(struct pt_regs *regs)
>  {
> +	static arch_spinlock_t lock = __ARCH_SPIN_LOCK_UNLOCKED;
>  	int cpu = smp_processor_id();
>  
>  	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
> +		arch_spin_lock(&lock);
>  		if (regs && cpu_in_idle(instruction_pointer(regs))) {
>  			pr_warn("NMI backtrace for cpu %d skipped: idling at pc %#lx\n",
>  				cpu, instruction_pointer(regs));
> @@ -99,6 +101,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
>  			else
>  				dump_stack();
>  		}
> +		arch_spin_unlock(&lock);
>  		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
>  		return true;
>  	}

can the nmi_backtrace part be a patch on its own?

	-ss
