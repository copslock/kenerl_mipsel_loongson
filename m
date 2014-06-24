Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 18:53:58 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:64946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816071AbaFXQxu41qoS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jun 2014 18:53:50 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5OGrLlF030185
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jun 2014 12:53:22 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-125.brq.redhat.com [10.34.1.125])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5OGrHv3023630;
        Tue, 24 Jun 2014 12:53:18 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Tue, 24 Jun 2014 18:52:20 +0200 (CEST)
Date:   Tue, 24 Jun 2014 18:52:16 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 3/9] seccomp: introduce writer locking
Message-ID: <20140624165216.GA29272@redhat.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org> <1403560693-21809-4-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403560693-21809-4-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
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

Kees,

I am still trying to force myself to read and try to understand what
this series does ;) Just a minor nit so far.

On 06/23, Kees Cook wrote:
>
> @@ -1142,6 +1168,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>  {
>  	int retval;
>  	struct task_struct *p;
> +	unsigned long irqflags;
>  
>  	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
>  		return ERR_PTR(-EINVAL);
> @@ -1196,7 +1223,6 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>  		goto fork_out;
>  
>  	ftrace_graph_init_task(p);
> -	get_seccomp_filter(p);
>  
>  	rt_mutex_init_task(p);
>  
> @@ -1434,7 +1460,13 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>  		p->parent_exec_id = current->self_exec_id;
>  	}
>  
> -	spin_lock(&current->sighand->siglock);
> +	spin_lock_irqsave(&current->sighand->siglock, irqflags);
> +
> +	/*
> +	 * Copy seccomp details explicitly here, in case they were changed
> +	 * before holding tasklist_lock.
> +	 */
> +	copy_seccomp(p);
>  
>  	/*
>  	 * Process group and session signals need to be delivered to just the
> @@ -1446,7 +1478,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>  	*/
>  	recalc_sigpending();
>  	if (signal_pending(current)) {
> -		spin_unlock(&current->sighand->siglock);
> +		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
>  		write_unlock_irq(&tasklist_lock);
>  		retval = -ERESTARTNOINTR;
>  		goto bad_fork_free_pid;
> @@ -1486,7 +1518,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>  	}
>  
>  	total_forks++;
> -	spin_unlock(&current->sighand->siglock);
> +	spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
>  	write_unlock_irq(&tasklist_lock);
>  	proc_fork_connector(p);
>  	cgroup_post_fork(p);

It seems that the only change copy_process() needs is copy_seccomp() under the locks.
Everythinh else (irqflags games) looks obviously unneeded?

> @@ -524,6 +528,9 @@ static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
>  	}
>  #endif
>
> +	if (unlikely(!lock_task_sighand(current, &irqflags)))
> +		goto out_free;
> +

Unless this task is exiting (namely, it has already called exit_notify()),
lock_task_sighand(current) must not fail. Looks like you can simly do
spin_lock_irq(->siglock).

Oleg.
