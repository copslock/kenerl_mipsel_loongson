Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 14:38:50 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:51659 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991672AbdD1MimQrJ0b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Apr 2017 14:38:42 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89F17AC8A;
        Fri, 28 Apr 2017 12:38:41 +0000 (UTC)
Date:   Fri, 28 Apr 2017 14:38:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20170428123838.GZ3452@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170428012530.GA383@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170428012530.GA383@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57811
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

On Fri 2017-04-28 10:25:30, Sergey Senozhatsky wrote:
> 
> On (04/20/17 15:11), Petr Mladek wrote:
> [..]
> >  void printk_nmi_enter(void)
> >  {
> > -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> > +	/*
> > +	 * The size of the extra per-CPU buffer is limited. Use it
> > +	 * only when really needed.
> > +	 */
> > +	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK ||
> > +	    raw_spin_is_locked(&logbuf_lock)) {
> 
> can we please have && here?

OK, it sounds reasonable after all.

> [..]
> > diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
> > index 4e8a30d1c22f..0bc0a3535a8a 100644
> > --- a/lib/nmi_backtrace.c
> > +++ b/lib/nmi_backtrace.c
> > @@ -86,9 +86,11 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
> >  
> >  bool nmi_cpu_backtrace(struct pt_regs *regs)
> >  {
> > +	static arch_spinlock_t lock = __ARCH_SPIN_LOCK_UNLOCKED;
> >  	int cpu = smp_processor_id();
> >  
> >  	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
> > +		arch_spin_lock(&lock);
> >  		if (regs && cpu_in_idle(instruction_pointer(regs))) {
> >  			pr_warn("NMI backtrace for cpu %d skipped: idling at pc %#lx\n",
> >  				cpu, instruction_pointer(regs));
> > @@ -99,6 +101,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
> >  			else
> >  				dump_stack();
> >  		}
> > +		arch_spin_unlock(&lock);
> >  		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
> >  		return true;
> >  	}
> 
> can the nmi_backtrace part be a patch on its own?

I would prefer to keep it in the same patch. The backtrace from
all CPUs is completely unusable when all CPUs push to the global
log buffer in parallel. Single patch might safe hair of some
poor bisectors.

Best Regards,
Petr
