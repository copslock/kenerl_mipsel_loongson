Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 16:26:11 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:40760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013618AbbLJP0JZ2shv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Dec 2015 16:26:09 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 65913ACED;
        Thu, 10 Dec 2015 15:26:08 +0000 (UTC)
Date:   Thu, 10 Dec 2015 16:26:06 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 1/4] printk/nmi: Generic solution for safe printk in
 NMI
Message-ID: <20151210152606.GD2946@pathway.suse.cz>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-2-git-send-email-pmladek@suse.com>
 <20151209155007.cab2f1afd7e76878a1733033@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151209155007.cab2f1afd7e76878a1733033@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50526
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

On Wed 2015-12-09 15:50:07, Andrew Morton wrote:
> On Wed,  9 Dec 2015 14:21:02 +0100 Petr Mladek <pmladek@suse.com> wrote:
> 
> > printk() takes some locks and could not be used a safe way in NMI
> > context.
> > 
> > The chance of a deadlock is real especially when printing
> > stacks from all CPUs. This particular problem has been addressed
> > on x86 by the commit a9edc8809328 ("x86/nmi: Perform a safe NMI stack
> > trace on all CPUs").
> > 
> > This patch reuses most of the code and makes it generic. It is
> > useful for all messages and architectures that support NMI.
> > 
> > The patch is heavily based on the draft from Peter Zijlstra,
> > see https://lkml.org/lkml/2015/6/10/327
> > 
> 
> I guess this code is useful even on CONFIG_SMP=n: to avoid corruption
> of the printk internal structures whcih the problematic locking
> protects.

Yup and it is used even on CONFIG_SMP=n if I am not missing
something. At least, CONFIG_PRINTK_NMI stays enabled here.


> > +#define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
> > +
> > +struct nmi_seq_buf {
> > +	atomic_t		len;	/* length of written data */
> > +	struct irq_work		work;	/* IRQ work that flushes the buffer */
> > +	unsigned char		buffer[NMI_LOG_BUF_LEN];
> 
> When this buffer overflows, which characters get lost?  Most recent or
> least recent?

The most recent messages are lost when the buffer overflows. The other
way would require to use a ring-buffer instead the seq_buf. We would need
a lock-less synchronization for both, begin and end, pointers. It
would add quite some complications.


> I'm not sure which is best, really.  For an oops trace you probably
> want to preserve the least recent output: the stuff at the start of the
> output.

I agree. Fortunately, this is easier and it works this way.


> > +static void __printk_nmi_flush(struct irq_work *work)
> > +{
> > +	static raw_spinlock_t read_lock =
> > +		__RAW_SPIN_LOCK_INITIALIZER(read_lock);
> > +	struct nmi_seq_buf *s = container_of(work, struct nmi_seq_buf, work);
> > +	int len, size, i, last_i;
> > +
> > +	/*
> > +	 * The lock has two functions. First, one reader has to flush all
> > +	 * available message to make the lockless synchronization with
> > +	 * writers easier. Second, we do not want to mix messages from
> > +	 * different CPUs. This is especially important when printing
> > +	 * a backtrace.
> > +	 */
> > +	raw_spin_lock(&read_lock);
> > +
> > +	i = 0;
> > +more:
> > +	len = atomic_read(&s->len);
> > +
> > +	/*
> > +	 * This is just a paranoid check that nobody has manipulated
> > +	 * the buffer an unexpected way. If we printed something then
> > +	 * @len must only increase.
> > +	 */
> > +	WARN_ON(i && i >= len);
> 
> hm, dumping a big backtrace in this context seems a poor idea.  Oh
> well, shouldn't happen.

I see and the backtrace probably would not help much because "len"
might be manipulated also from NMI context. I am going to change
this to:

	if (i && i >= len)
		pr_err("printk_nmi_flush: internal error: i=%d >=
		len=%d)\n", i, len);



> > +	if (!len)
> > +		goto out; /* Someone else has already flushed the buffer. */
> > +
> > +	/* Make sure that data has been written up to the @len */
> > +	smp_rmb();
> > +
> > +	size = min_t(int, len, sizeof(s->buffer));
> 
> len and size should have type size_t.

OK

> > --- /dev/null
> > +++ b/kernel/printk/printk.h
> 
> I find it a bit irritating to have duplicated filenames.  We could
> follow convention and call this "internal.h".

No problem. I am going to send an updated patchset soon.

Thanks a lot for review,
Petr
