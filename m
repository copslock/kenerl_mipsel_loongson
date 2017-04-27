Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2017 17:43:05 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:50144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992111AbdD0Pm4300Li (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Apr 2017 17:42:56 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 20DCB2034A;
        Thu, 27 Apr 2017 15:42:54 +0000 (UTC)
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990BD20373;
        Thu, 27 Apr 2017 15:42:50 +0000 (UTC)
Date:   Thu, 27 Apr 2017 11:42:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20170427114248.1d751efd@gandalf.local.home>
In-Reply-To: <20170427152807.GY3452@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
        <1461239325-22779-2-git-send-email-pmladek@suse.com>
        <20170419131341.76bc7634@gandalf.local.home>
        <20170420033112.GB542@jagdpanzerIV.localdomain>
        <20170420131154.GL3452@pathway.suse.cz>
        <20170421015724.GA586@jagdpanzerIV.localdomain>
        <20170421120627.GO3452@pathway.suse.cz>
        <20170424021747.GA630@jagdpanzerIV.localdomain>
        <20170427133819.GW3452@pathway.suse.cz>
        <20170427103118.56351d30@gandalf.local.home>
        <20170427152807.GY3452@pathway.suse.cz>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <SRS0=kAy7=4D=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

On Thu, 27 Apr 2017 17:28:07 +0200
Petr Mladek <pmladek@suse.com> wrote:


> > When I get a chance, I'll see if I can insert a trigger to crash the
> > kernel from NMI on another box and see if this patch helps.  
> 
> I actually tested it here using this hack:
> 
> diff --cc lib/nmi_backtrace.c
> index d531f85c0c9b,0bc0a3535a8a..000000000000
> --- a/lib/nmi_backtrace.c
> +++ b/lib/nmi_backtrace.c
> @@@ -89,8 -90,7 +90,9 @@@ bool nmi_cpu_backtrace(struct pt_regs *
>         int cpu = smp_processor_id();
>   
>         if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
>  +              if (in_nmi())
>  +                      panic("Simulating panic in NMI\n");
> +               arch_spin_lock(&lock);

I was going to create a ftrace trigger, to crash on demand, but this
may do as well.

>                 if (regs && cpu_in_idle(instruction_pointer(regs))) {
>                         pr_warn("NMI backtrace for cpu %d skipped: idling at pc %#lx\n",
>                                 cpu, instruction_pointer(regs));
> 
> and triggered by:
> 
>    echo  l > /proc/sysrq-trigger
> 
> The patch really helped to see much more (all) messages from the ftrace
> buffers in NMI mode.
> 
> But the test is a bit artifical. The patch might not help when there
> is a big printk() activity on the system when the panic() is
> triggered. We might wrongly use the small per-CPU buffer when
> the logbuf_lock is tested and taken on another CPU at the same time.
> It means that it will not always help.
> 
> I personally think that the patch might be good enough. I am not sure
> if a perfect (more comlpex) solution is worth it.

I wasn't asking for perfect, as the previous solutions never were
either. I just want an optimistic dump if possible.

I'll try to get some time today to test this, and let you know. But it
wont be on the machine that I originally had the issue with.

Thanks,

-- Steve
