Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2011 09:49:44 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:46235 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491039Ab1ELHtg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2011 09:49:36 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1QKQdp-0007rv-Fa
        from <mingo@elte.hu>; Thu, 12 May 2011 09:49:12 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 1DF953E2300; Thu, 12 May 2011 09:48:46 +0200 (CEST)
Date:   Thu, 12 May 2011 09:48:50 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Will Drewry <wad@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Eric Paris <eparis@redhat.com>, kees.cook@canonical.com,
        agl@chromium.org, jmorris@namei.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Marek <mmarek@suse.cz>,
        Oleg Nesterov <oleg@redhat.com>,
        Roland McGrath <roland@redhat.com>,
        Jiri Slaby <jslaby@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
 filtering
Message-ID: <20110512074850.GA9937@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
 <1305169376-2363-1-git-send-email-wad@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305169376-2363-1-git-send-email-wad@chromium.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
        -2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
        [score: 0.0000]
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


Ok, i like the direction here, but i think the ABI should be done differently.

In this patch the ftrace event filter mechanism is used:

* Will Drewry <wad@chromium.org> wrote:

> +static struct seccomp_filter *alloc_seccomp_filter(int syscall_nr,
> +						   const char *filter_string)
> +{
> +	int err = -ENOMEM;
> +	struct seccomp_filter *filter = kzalloc(sizeof(struct seccomp_filter),
> +						GFP_KERNEL);
> +	if (!filter)
> +		goto fail;
> +
> +	INIT_HLIST_NODE(&filter->node);
> +	filter->syscall_nr = syscall_nr;
> +	filter->data = syscall_nr_to_meta(syscall_nr);
> +
> +	/* Treat a filter of SECCOMP_WILDCARD_FILTER as a wildcard and skip
> +	 * using a predicate at all.
> +	 */
> +	if (!strcmp(SECCOMP_WILDCARD_FILTER, filter_string))
> +		goto out;
> +
> +	/* Argument-based filtering only works on ftrace-hooked syscalls. */
> +	if (!filter->data) {
> +		err = -ENOSYS;
> +		goto fail;
> +	}
> +
> +#ifdef CONFIG_FTRACE_SYSCALLS
> +	err = ftrace_parse_filter(&filter->event_filter,
> +				  filter->data->enter_event->event.type,
> +				  filter_string);
> +	if (err)
> +		goto fail;
> +#endif
> +
> +out:
> +	return filter;
> +
> +fail:
> +	kfree(filter);
> +	return ERR_PTR(err);
> +}

Via a prctl() ABI:

> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1698,12 +1698,23 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		case PR_SET_ENDIAN:
>  			error = SET_ENDIAN(me, arg2);
>  			break;
> -
>  		case PR_GET_SECCOMP:
>  			error = prctl_get_seccomp();
>  			break;
>  		case PR_SET_SECCOMP:
> -			error = prctl_set_seccomp(arg2);
> +			error = prctl_set_seccomp(arg2, arg3);
> +			break;
> +		case PR_SET_SECCOMP_FILTER:
> +			error = prctl_set_seccomp_filter(arg2,
> +							 (char __user *) arg3);
> +			break;
> +		case PR_CLEAR_SECCOMP_FILTER:
> +			error = prctl_clear_seccomp_filter(arg2);
> +			break;
> +		case PR_GET_SECCOMP_FILTER:
> +			error = prctl_get_seccomp_filter(arg2,
> +							 (char __user *) arg3,
> +							 arg4);

To restrict execution to system calls.

Two observations:

1) We already have a specific ABI for this: you can set filters for events via 
   an event fd.

   Why not extend that mechanism instead and improve *both* your sandboxing
   bits and the events code? This new seccomp code has a lot more
   to do with trace event filters than the minimal old seccomp code ...

   kernel/trace/trace_event_filter.c is 2000 lines of tricky code that
   interprets the ASCII filter expressions. kernel/seccomp.c is 86 lines of
   mostly trivial code.

2) Why should this concept not be made available wider, to allow the 
   restriction of not just system calls but other security relevant components 
   of the kernel as well?

   This too, if you approach the problem via the events code, will be a natural 
   end result, while if you approach it from the seccomp prctl angle it will be
   a limited hack only.

Note, the end result will be the same - just using a different ABI.

So i really think the ABI itself should be closer related to the event code. 
What this "seccomp" code does is that it uses specific syscall events to 
restrict execution of certain event generating codepaths, such as system calls.

Thanks,

	Ingo
