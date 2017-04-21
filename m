Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Apr 2017 03:57:46 +0200 (CEST)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:34089
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbdDUB5jXPDbD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Apr 2017 03:57:39 +0200
Received: by mail-io0-x242.google.com with SMTP id h41so23879651ioi.1;
        Thu, 20 Apr 2017 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zXzGkQ468VLkD7+e4+98kA4OPf9sbUvaxTxkSEfpoGg=;
        b=gqK7PxX5puLBS3Qvvn3tDSgwXKAOpZjcOCArprqFnqPjv8JFd3gxKf+kKKjQi5jdxW
         eosT72sJugBNXmDnCrkkeeLzZFg3bMqCPxdT64jYxLFzF2VEd5E2mAUed7oqkxtIvBOQ
         dC5AlZtCVo6B2lvgVgi0zg5y3DwtnW+IoPb7Go6B/tJa+0VqZOIp+71KASbFFvTa/hz4
         zWXi7Mh/cB7vMHd3VrfANHPFzBEedkZcM+SS2B1Yv6zzT+cyu1GOnTknx80SGFoAkkUz
         dR4XTJUvPvDBLd8lZpszdoeHkRwpTUeypooE6W8couzjBBFFxMGCGks9WCCa3Ojfx0lB
         fL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zXzGkQ468VLkD7+e4+98kA4OPf9sbUvaxTxkSEfpoGg=;
        b=N34prLpwYwyY2takV5+rewuCWYp2DS1jhAgIY2DEu9BNOEFIu6DueQUyqVqAzLLSg5
         BxjpB2bIzJ3xSALDJNXMhCZzjP74JGa3LnYYlVcOhi1RcBFGnXhEsCkcZ0Be2cLSqyum
         4JBF3lSYjN1Xjgxb3sPZXYk3ZvzAyONKwdaL+sKbMJH9B+A3WVGxXQlzH5zrg4M+/WJ1
         aEEmyjFAcrntqE9UCLEeg0xn3fs7TlcZIaGuuHHbfv/i+2EyxwyWXH/nPIQDrwIgMnpU
         VUdyGVK5CVRWFUlzCv6cruhblOLh/HFbYnBYTeQBLk3kshUKHGGy/Eql4cSG1OGaahpB
         fPOg==
X-Gm-Message-State: AN3rC/5RpP52CdyTtCWdUf06K6ae6CMYso4t2XrLpdOxYWJ4jbOVf3/h
        A3C0yu/0S588nA==
X-Received: by 10.98.201.209 with SMTP id l78mr10249894pfk.13.1492739848681;
        Thu, 20 Apr 2017 18:57:28 -0700 (PDT)
Received: from localhost ([175.223.39.25])
        by smtp.gmail.com with ESMTPSA id e7sm6053528pgc.17.2017.04.20.18.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Apr 2017 18:57:27 -0700 (PDT)
Date:   Fri, 21 Apr 2017 10:57:25 +0900
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
Message-ID: <20170421015724.GA586@jagdpanzerIV.localdomain>
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
X-archive-position: 57753
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

On (04/20/17 15:11), Petr Mladek wrote:
[..]
> Good analyze. I would summarize it that we need to be careful of:
> 
>   + logbug_lock
>   + PRINTK_SAFE_CONTEXT
>   + locks used by console drivers
> 
> The first two things are easy to check. Except that a check for logbuf_lock
> might produce false negatives. The last check is very hard.
> 
> > so at the moment what I can think of is something like
> > 
> >   -- check this_cpu_read(printk_context) in NMI prink
> > 
> > 	-- if we are NOT in printk_safe on this CPU, then do printk_deferred()
> > 	   and bypass `nmi_print_seq' buffer
> 
> I would add also a check for logbuf_lock.
> > 	-- if we are in printk_safe
> > 	  -- well... bad luck... have a bigger buffer.
> 
> Yup, we do the best effort while still trying to stay on the safe
> side.
> 
> I have cooked up a patch based on this. It uses printk_deferred()
> in NMI when it is safe. Note that console_flush_on_panic() will
> try to get them on the console when a kdump is not generated.
> I believe that it will help Steven.


OK. I need to look more at the patch. It does more than I'd expected/imagined.


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
> +		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> +	} else {
> +		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);
> +	}
>  }

well... the logbuf_lock can temporarily be locked from another CPU. I'd say
that spin_is_locked() has better chances for false positive than
this_cpu_read(printk_context). because this_cpu_read(printk_context) depends
only on this CPU state, while spin_is_locked() depends on all CPUs. and the
idea with this_cpu_read(printk_context) was that we check if the logbuf_lock
was locked from this particular CPU.

I agree that this_cpu_read(printk_context) covers slightly more than
logbuf_lock scope, so we may get positive this_cpu_read(printk_context)
with unlocked logbuf_lock, but I don't tend to think that it's a big
problem.


wouldn't something as simple as below do the trick?
// absolutely and completely untested //


diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 033e50a7d706..c7477654c5b1 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -303,7 +303,10 @@ static int vprintk_nmi(const char *fmt, va_list args)
 {
        struct printk_safe_seq_buf *s = this_cpu_ptr(&nmi_print_seq);
 
-       return printk_safe_log_store(s, fmt, args);
+       if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK)
+               return printk_safe_log_store(s, fmt, args);
+
+       return vprintk_emit(0, LOGLEVEL_SCHED, NULL, 0, fmt, args);
 }

	-ss
