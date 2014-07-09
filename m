Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2014 20:07:10 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:15697 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859949AbaGISHEqQxtM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Jul 2014 20:07:04 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s69I6hHZ012207
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jul 2014 14:06:43 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-170.brq.redhat.com [10.34.1.170])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s69I6cva017265;
        Wed, 9 Jul 2014 14:06:39 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Wed,  9 Jul 2014 20:05:25 +0200 (CEST)
Date:   Wed, 9 Jul 2014 20:05:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 11/11] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
Message-ID: <20140709180520.GA2560@redhat.com>
References: <1403911380-27787-1-git-send-email-keescook@chromium.org> <1403911380-27787-12-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403911380-27787-12-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41103
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

First of all, sorry for delay ;)

So far I quickly glanced at this series and everything look fine, but
I am confused by the signal_group_exit() check,

On 06/27, Kees Cook wrote:
>
> To make sure that de_thread() is actually able
> to kill other threads during an exec, any sighand holders need to check
> if they've been scheduled to be killed, and to give up on their work.

Probably this connects to that check below? I can't understand this...

> +	/*
> +	 * Make sure we cannot change seccomp or nnp state via TSYNC
> +	 * while another thread is in the middle of calling exec.
> +	 */
> +	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
> +	    mutex_lock_killable(&current->signal->cred_guard_mutex))
> +		goto out_free;

-EINVAL looks a bit confusing in this case, but this is cosemtic because
userspace won't see this error-code anyway.

>  	spin_lock_irq(&current->sighand->siglock);
> +	if (unlikely(signal_group_exit(current->signal))) {
> +		/* If thread is dying, return to process the signal. */

OK, this doesn't hurt, but why?

You could check __fatal_signal_pending() with the same effect. And since
we hold this mutex, exec (de_thread) can be the source of that SIGKILL.
We take this mutex specially to avoid the race with exec.

So why do we need to abort if we race with kill() or exit_grouo() ?

Oleg.
