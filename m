Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 06:48:19 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36301 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008573AbcDDEsNAZVCj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 06:48:13 +0200
Received: by mail-pa0-f49.google.com with SMTP id tt10so135619256pab.3;
        Sun, 03 Apr 2016 21:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yLYnnb7iRRBQ7ZyKYCcGhXA+Lhc2bagxcmMqEUjs768=;
        b=BLRlzUOGRvDVJCjNVkoH8WyHclxf4pSn1VURJ5/uSCH08LyXmZLufBg8gojEBEYKWi
         pKGpPkd95guXfElLgPChAznPtnFwXVLGzPgdhTOheb+dZG0L4TjPK1Fq456+IypvrO4K
         EOieYCw6bNcLoKwxOfjdi+wwrE8+P6Rg1FK/T79CjFq66xCMZrohfHK3JhXGw+cvQ2C4
         w8vDvvpi5+xvtqZe5DxyyQEJ+FYjdzDr/zsSibOgLaRr5cwlMWhBotoM3sm3z9W3W/3Q
         NsBX3qpigy8tlTPKeWWEpUkIT1fxOxNSshKokgHGnhbZCSeBxKzdy7BXvJVHw6ubc87O
         08Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yLYnnb7iRRBQ7ZyKYCcGhXA+Lhc2bagxcmMqEUjs768=;
        b=cum2PbGDZCihcd5A/TwtFgfloKLW1oK29ZQ+kd5p9j7uxz+1VLIKWqFjXiEmOWcKE/
         fFV6KMeOYq0uWyxDMwanpJX9EhY/xbnF+wT7xpsLkJEfiMOY+8osvGdp4L1+dTGYa39g
         KzOujcg/vBPCAoqyASBPbCS13Qf9ol2URWeziaTgwgZz2EUGmCwbdpEBpmykqbwQEidi
         yFEpo0irDpbGTsSe3agzzzUwmPJtTNnbLg9K/+Q3kbZoDuzMU2WmNaaau25JZnuaAUHj
         3DSKaJk7+mHM74YpV6jXfFTAqTKOi2i1M5JYvREMP9FTX7iTbw6lIolkio24LtKq4xFZ
         r9bw==
X-Gm-Message-State: AD7BkJJVUGF6rWiI3dn/LAGqQIcK2WJHvtNPlQSgN8Y5Dt7Doj3yyjKZW7ipXgWb6RNhkQ==
X-Received: by 10.66.146.39 with SMTP id sz7mr50736928pab.76.1459745286998;
        Sun, 03 Apr 2016 21:48:06 -0700 (PDT)
Received: from localhost ([39.7.56.6])
        by smtp.gmail.com with ESMTPSA id i9sm35615052pfi.95.2016.04.03.21.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Apr 2016 21:48:05 -0700 (PDT)
Date:   Mon, 4 Apr 2016 13:49:28 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20160404044928.GD6164@swordfish>
References: <1459353210-20260-1-git-send-email-pmladek@suse.com>
 <1459353210-20260-2-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459353210-20260-2-git-send-email-pmladek@suse.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <sergey.senozhatsky.work@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52850
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

Hello,

On (03/30/16 17:53), Petr Mladek wrote:
[..]
> @@ -67,10 +67,12 @@ extern void irq_exit(void);
>  		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
>  		rcu_nmi_enter();				\
>  		trace_hardirq_enter();				\
> +		printk_nmi_enter();				\
>  	} while (0)
>  
>  #define nmi_exit()						\
>  	do {							\
> +		printk_nmi_exit();				\
>  		trace_hardirq_exit();				\
>  		rcu_nmi_exit();					\
>  		BUG_ON(!in_nmi());				\

isn't it a bit too early to printk_nmi_exit()? rcu_nmi_exit() can
WARN_ON_ONCE() in 3 places.

the same goes for printk_nmi_enter(). rcu_nmi_enter() can WARN_ON_ONCE().

seems that in both cases we can endup having WARN_ON_ONCE() from nmi,
but with default printk function.


> +/*
> + * Flush data from the associated per_CPU buffer. The function
> + * can be called either via IRQ work or independently.
> + */
> +static void __printk_nmi_flush(struct irq_work *work)
> +{
> +	static raw_spinlock_t read_lock =
> +		__RAW_SPIN_LOCK_INITIALIZER(read_lock);
> +	struct nmi_seq_buf *s = container_of(work, struct nmi_seq_buf, work);
> +	unsigned long flags;
> +	size_t len, size;
> +	int i, last_i;
> +
> +	/*
> +	 * The lock has two functions. First, one reader has to flush all
> +	 * available message to make the lockless synchronization with
> +	 * writers easier. Second, we do not want to mix messages from
> +	 * different CPUs. This is especially important when printing
> +	 * a backtrace.
> +	 */
> +	raw_spin_lock_irqsave(&read_lock, flags);
> +

hm... so here we have
	for (; i < size; i++)
		printk()

under the spinlock. the thing is that one of printk() can end up
in console_unlock()->call_console_drivers() loop, iterating there
long enough to spinlock lockup other CPUs that might want to flush
NMI buffers (if any), assuming that there are enough printk() (or
may be a slow serial console) happening concurrently on other CPUs
to keep the current ->read_lock busy. async printk can help here,
but user can request sync version of printk.

how about using deferred printk for nmi flush?
print_nmi_seq_line()->printk_deferred() ?

	-ss

> +	i = 0;
> +more:
> +	len = atomic_read(&s->len);
> +
> +	/*
> +	 * This is just a paranoid check that nobody has manipulated
> +	 * the buffer an unexpected way. If we printed something then
> +	 * @len must only increase.
> +	 */
> +	if (i && i >= len)
> +		pr_err("printk_nmi_flush: internal error: i=%d >= len=%zu\n",
> +		       i, len);
> +
> +	if (!len)
> +		goto out; /* Someone else has already flushed the buffer. */
> +
> +	/* Make sure that data has been written up to the @len */
> +	smp_rmb();
> +
> +	size = min(len, sizeof(s->buffer));
> +	last_i = i;
> +
> +	/* Print line by line. */
> +	for (; i < size; i++) {
> +		if (s->buffer[i] == '\n') {
> +			print_nmi_seq_line(s, last_i, i);
> +			last_i = i + 1;
> +		}
> +	}
> +	/* Check if there was a partial line. */
> +	if (last_i < size) {
> +		print_nmi_seq_line(s, last_i, size - 1);
> +		pr_cont("\n");
> +	}
> +
> +	/*
> +	 * Check that nothing has got added in the meantime and truncate
> +	 * the buffer. Note that atomic_cmpxchg() is an implicit memory
> +	 * barrier that makes sure that the data were copied before
> +	 * updating s->len.
> +	 */
> +	if (atomic_cmpxchg(&s->len, len, 0) != len)
> +		goto more;
> +
> +out:
> +	raw_spin_unlock_irqrestore(&read_lock, flags);
> +}
