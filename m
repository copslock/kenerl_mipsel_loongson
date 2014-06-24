Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 20:32:04 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:45856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822968AbaFXScCH6Vwe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jun 2014 20:32:02 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5OIVU6O001192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jun 2014 14:31:30 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-125.brq.redhat.com [10.34.1.125])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5OIVQot028951;
        Tue, 24 Jun 2014 14:31:27 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Tue, 24 Jun 2014 20:30:29 +0200 (CEST)
Date:   Tue, 24 Jun 2014 20:30:24 +0200
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
Message-ID: <20140624183024.GA1258@redhat.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org> <1403560693-21809-4-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403560693-21809-4-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40759
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

I am puzzled by the usage of smp_load_acquire(),

On 06/23, Kees Cook wrote:
>
>  static u32 seccomp_run_filters(int syscall)
>  {
> -	struct seccomp_filter *f;
> +	struct seccomp_filter *f = smp_load_acquire(&current->seccomp.filter);
>  	struct seccomp_data sd;
>  	u32 ret = SECCOMP_RET_ALLOW;
>  
>  	/* Ensure unexpected behavior doesn't result in failing open. */
> -	if (WARN_ON(current->seccomp.filter == NULL))
> +	if (WARN_ON(f == NULL))
>  		return SECCOMP_RET_KILL;
>  
>  	populate_seccomp_data(&sd);
> @@ -186,9 +186,8 @@ static u32 seccomp_run_filters(int syscall)
>  	 * All filters in the list are evaluated and the lowest BPF return
>  	 * value always takes priority (ignoring the DATA).
>  	 */
> -	for (f = current->seccomp.filter; f; f = f->prev) {
> +	for (; f; f = smp_load_acquire(&f->prev)) {
>  		u32 cur_ret = SK_RUN_FILTER(f->prog, (void *)&sd);
> -
>  		if ((cur_ret & SECCOMP_RET_ACTION) < (ret & SECCOMP_RET_ACTION))
>  			ret = cur_ret;

OK, in this case the 1st one is probably fine, altgough it is not
clear to me why it is better than read_barrier_depends().

But why do we need a 2nd one inside the loop? And if we actually need
it (I don't think so) then why it is safe to use f->prog without
load_acquire ?

>  void get_seccomp_filter(struct task_struct *tsk)
>  {
> -	struct seccomp_filter *orig = tsk->seccomp.filter;
> +	struct seccomp_filter *orig = smp_load_acquire(&tsk->seccomp.filter);
>  	if (!orig)
>  		return;

This one looks unneeded.

First of all, afaics atomic_inc() should work correctly without any barriers,
otherwise it is buggy. But even this doesn't matter.

With this changes get_seccomp_filter() must be called under ->siglock, it can't
race with add-filter and thus tsk->seccomp.filter should be stable.

>  	/* Reference count is bounded by the number of total processes. */
> @@ -361,7 +364,7 @@ void put_seccomp_filter(struct task_struct *tsk)
>  	/* Clean up single-reference branches iteratively. */
>  	while (orig && atomic_dec_and_test(&orig->usage)) {
>  		struct seccomp_filter *freeme = orig;
> -		orig = orig->prev;
> +		orig = smp_load_acquire(&orig->prev);
>  		seccomp_filter_free(freeme);
>  	}

This one looks unneeded too. And note that this patch does not add
smp_load_acquire() to read tsk->seccomp.filter.

atomic_dec_and_test() adds mb(), we do not need more barriers to access
->prev ?

Oleg.
