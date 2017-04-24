Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2017 04:18:12 +0200 (CEST)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:35764
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990519AbdDXCSCnKBKb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2017 04:18:02 +0200
Received: by mail-io0-x241.google.com with SMTP id d203so44619259iof.2;
        Sun, 23 Apr 2017 19:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OTz5cR31+wP9iPzNwlc2CMVeJ6BzJyo3WZnJ4SqMILQ=;
        b=m6yylP/071lJb4bMv+tOueTVdqbauqkk3ZRsl0vrpWiEFx3Wzz3X1iarYwEKEF72Xg
         0XsCjUB1uvaTO8KBb1/n/niSB5VPcxzrjiPYks1scRCQUB9wejh9ddELL6KBZQcCSsLV
         uXB+tGWWUCTajP97j+M3S1cVJ3YwnVY1ph93y5cLCQ317VdVfYXQ/EDirszVd8+i5vw5
         9s/kRNDyhiHD360llcZomw5wgok3QItokZjYZQxD/y/GpfzCBFJ1CCCnTtyHR9c5E8Pk
         3lgcxQ+5UMth572IiAbICrOv0PkMcGwVgBhngcuu5R4Uw+GYklK6sSNvThJ1jWP5lzqn
         PVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OTz5cR31+wP9iPzNwlc2CMVeJ6BzJyo3WZnJ4SqMILQ=;
        b=pK5xMqZgrB0GCudki2Pj6oDmkyTCqTNxEcEiWFb1IAGsq1QrAgySej8BfkLcjB01x8
         piVEfG85G5w2R7Sn7qYlH6eVxuyBuyoyhTFr4YK8/8IdiaZcLuiJbQ5tubpx5tuQ/002
         uijA4WwMgy3U6O1ea36d5JmSp6k/mCPxE67nfPqqKl/6rBnU1joQyWD86EvQPQoQgGqA
         yRweYgSyHNcVVyyGlizRkOOSSBR6ut4mLIi5ZNf6/MAQL1wJROz4SMay954nIbB4TfZg
         c/kmq4RecO9HT03H/ibIG45aeq9XGqYGwwDvpOQL6pVnm1MzwOdC90IcxNmF0RD5eUF8
         7jFg==
X-Gm-Message-State: AN3rC/7GDNXnVDetjQgdQyiO+XT8aNNfRJl/By+9o6RZKQ87ZRRrq3pe
        SgG7APJl7oQCSw==
X-Received: by 10.98.163.75 with SMTP id s72mr22537512pfe.227.1493000276760;
        Sun, 23 Apr 2017 19:17:56 -0700 (PDT)
Received: from localhost ([175.223.33.224])
        by smtp.gmail.com with ESMTPSA id k190sm4474074pge.2.2017.04.23.19.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Apr 2017 19:17:56 -0700 (PDT)
Date:   Mon, 24 Apr 2017 11:17:47 +0900
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
Message-ID: <20170424021747.GA630@jagdpanzerIV.localdomain>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170421015724.GA586@jagdpanzerIV.localdomain>
 <20170421120627.GO3452@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170421120627.GO3452@pathway.suse.cz>
User-Agent: Mutt/1.8.2 (2017-04-18)
Return-Path: <sergey.senozhatsky.work@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57766
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

On (04/21/17 14:06), Petr Mladek wrote:
[..]
> > I agree that this_cpu_read(printk_context) covers slightly more than
> > logbuf_lock scope, so we may get positive this_cpu_read(printk_context)
> > with unlocked logbuf_lock, but I don't tend to think that it's a big
> > problem.
> 
> PRINTK_SAFE_CONTEXT is set also in call_console_drivers().
> It might take rather long and logbuf_lock is availe. So, it is
> noticeable source of false positives.

yes, agree.

probably we need additional printk_safe annotations for
		"logbuf_lock is locked from _this_ CPU"

false positives there can be very painful.

[..]
> 	if (raw_spin_is_locked(&logbuf_lock))
> 		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> 	else
> 		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);

well, if everyone is fine with logbuf_lock access from every CPU from every
NMI then I won't object either. but may be it makes sense to reduce the
possibility of false positives. Steven is loosing critically important logs,
after all.


by the way,
does this `nmi_print_seq' bypass even fix anything for Steven? it sort of
can, in theory, but just in theory. so may be we need direct message flush
from NMI handler (printk->console_unlock), which will be a really big problem.

logbuf might not be big enough for 4890096 messages (Steven's report
mentions "Lost 4890096 message(s)!"). we are counting on the fact that
in case of `nmi_print_seq' bypass some other CPU will call console_unlock()
and print pending logbuf messages, but this is not guaranteed and the
messages can be dropped even from logbuf.

I don't know,
should we try to queue printk_deferred irq_work for all online CPUs from
vprintk_nmi() when it bypasses printk_safe_log_store()? in order to minimize
possibilities of logbuf overflow. printk_deferred() will queue work on
vprintk_nmi() CPU, sure, but we don't know how many messages we are going
to add to logbuf from NMI.


> > @@ -303,7 +303,10 @@ static int vprintk_nmi(const char *fmt, va_list args)
> >  {
> >         struct printk_safe_seq_buf *s = this_cpu_ptr(&nmi_print_seq);
> >  
> > -       return printk_safe_log_store(s, fmt, args);
> > +       if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK)
> > +               return printk_safe_log_store(s, fmt, args);
> > +
> > +       return vprintk_emit(0, LOGLEVEL_SCHED, NULL, 0, fmt, args);
> >  }
> 
> It looks simple but some things are missing. It will be used also
> outside panic/oops, so it should queue the irq_work to flush the console.

you are right. I thought about moving irq_work to vprintk_emit(), but
completely forgot about it. without that missing bit the proposed two-liner
is not complete.

	-ss
