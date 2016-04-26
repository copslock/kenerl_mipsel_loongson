Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Apr 2016 16:22:04 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:48207 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008467AbcDZOWCv5Y0O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Apr 2016 16:22:02 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 98E23ACCA;
        Tue, 26 Apr 2016 14:21:58 +0000 (UTC)
Date:   Tue, 26 Apr 2016 16:21:57 +0200
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
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk/nmi: flush NMI messages on the system panic
Message-ID: <20160426142157.GK2749@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-5-git-send-email-pmladek@suse.com>
 <20160423034924.GA535@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160423034924.GA535@swordfish>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53232
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

On Sat 2016-04-23 12:49:24, Sergey Senozhatsky wrote:
> Hello Petr,
> 
> On (04/21/16 13:48), Petr Mladek wrote:
> >  extern void printk_nmi_flush(void);
> > +extern void printk_nmi_flush_on_panic(void);
> >  #else
> >  static inline void printk_nmi_flush(void) { }
> > +static inline void printk_nmi_flush_on_panic(void) { }
> [..]
> > +void printk_nmi_flush_on_panic(void)
> > +{
> > +	/*
> > +	 * Make sure that we could access the main ring buffer.
> > +	 * Do not risk a double release when more CPUs are up.
> > +	 */
> > +	if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) {
> > +		if (num_online_cpus() > 1)
> > +			return;
> > +
> > +		debug_locks_off();
> > +		raw_spin_lock_init(&logbuf_lock);
> > +	}
> > +
> > +	printk_nmi_flush();
> > +}
> [..]
> > -static DEFINE_RAW_SPINLOCK(logbuf_lock);
> > +DEFINE_RAW_SPINLOCK(logbuf_lock);
> 
> just an idea,
> 
> how about doing it a bit differently?
> 
> 
> move printk_nmi_flush_on_panic() to printk.c, and place it next to
> printk_flush_on_panic() (so we will have two printk "flush-on-panic"
> functions sitting together). /* printk_nmi_flush() is in printk.h,
> so it's visible to printk anyway */
> 
> it also will let us keep logbuf_lock static, it's a bit too internal
> to printk to expose it, I think.
> 
> IOW, something like this?

It is rather cosmetic change. I 

> ---
> 
>  kernel/printk/internal.h |  2 --
>  kernel/printk/nmi.c      | 27 ---------------------------
>  kernel/printk/printk.c   | 29 ++++++++++++++++++++++++++++-
>  3 files changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 7fd2838..341bedc 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -22,8 +22,6 @@ int __printf(1, 0) vprintk_default(const char *fmt, va_list args);
>  
>  #ifdef CONFIG_PRINTK_NMI
>  
> -extern raw_spinlock_t logbuf_lock;

Well, it was exposed only in the internal.h header file. I consider
this rather a cosmetic change and do not have strong opinion about it. :-)

Anyway, thanks a lot for review.

Best Regards,
Petr
