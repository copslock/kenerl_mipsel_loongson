Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 11:38:25 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:52035 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008467AbcDDJiXjRrWa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Apr 2016 11:38:23 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A7C4CAAF1;
        Mon,  4 Apr 2016 09:38:20 +0000 (UTC)
Date:   Mon, 4 Apr 2016 11:38:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCH v4 1/5] printk/nmi: generic solution for safe printk in
 NMI
Message-ID: <20160404093819.GH1023@pathway.suse.cz>
References: <1459353210-20260-1-git-send-email-pmladek@suse.com>
 <1459353210-20260-2-git-send-email-pmladek@suse.com>
 <20160404044928.GD6164@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160404044928.GD6164@swordfish>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52869
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

On Mon 2016-04-04 13:49:28, Sergey Senozhatsky wrote:
> Hello,
> 
> On (03/30/16 17:53), Petr Mladek wrote:
> [..]
> > @@ -67,10 +67,12 @@ extern void irq_exit(void);
> >  		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
> >  		rcu_nmi_enter();				\
> >  		trace_hardirq_enter();				\
> > +		printk_nmi_enter();				\
> >  	} while (0)
> >  
> >  #define nmi_exit()						\
> >  	do {							\
> > +		printk_nmi_exit();				\
> >  		trace_hardirq_exit();				\
> >  		rcu_nmi_exit();					\
> >  		BUG_ON(!in_nmi());				\
> 
> isn't it a bit too early to printk_nmi_exit()? rcu_nmi_exit() can
> WARN_ON_ONCE() in 3 places.
> 
> the same goes for printk_nmi_enter(). rcu_nmi_enter() can WARN_ON_ONCE().
> 
> seems that in both cases we can endup having WARN_ON_ONCE() from nmi,
> but with default printk function.

Great catch! You are right.


> > +/*
> > + * Flush data from the associated per_CPU buffer. The function
> > + * can be called either via IRQ work or independently.
> > + */
> > +static void __printk_nmi_flush(struct irq_work *work)
> > +{
> > +	static raw_spinlock_t read_lock =
> > +		__RAW_SPIN_LOCK_INITIALIZER(read_lock);
> > +	struct nmi_seq_buf *s = container_of(work, struct nmi_seq_buf, work);
> > +	unsigned long flags;
> > +	size_t len, size;
> > +	int i, last_i;
> > +
> > +	/*
> > +	 * The lock has two functions. First, one reader has to flush all
> > +	 * available message to make the lockless synchronization with
> > +	 * writers easier. Second, we do not want to mix messages from
> > +	 * different CPUs. This is especially important when printing
> > +	 * a backtrace.
> > +	 */
> > +	raw_spin_lock_irqsave(&read_lock, flags);
> > +
> 
> hm... so here we have
> 	for (; i < size; i++)
> 		printk()
> 
> under the spinlock. the thing is that one of printk() can end up
> in console_unlock()->call_console_drivers() loop, iterating there
> long enough to spinlock lockup other CPUs that might want to flush
> NMI buffers (if any), assuming that there are enough printk() (or
> may be a slow serial console) happening concurrently on other CPUs
> to keep the current ->read_lock busy. async printk can help here,
> but user can request sync version of printk.

I think that printk() is called on many other locations under
a spinlock and they all are waiting for the async printk.


> how about using deferred printk for nmi flush?
> print_nmi_seq_line()->printk_deferred() ?

But this is great idea. It will help to avoid the ugly macro
deferred_console_in_nmi() as you mentioned in the other mail.

Heh, I remember that I thought about this but I did not want
to override the original log level of the messages. Now, I see
that LOGLEVEL_SCHED is added on top and the original level
is preserved.

Thanks a lot for review. I am going to wait with respin a bit
and give others some time for feedback.


Best Regards,
Petr
