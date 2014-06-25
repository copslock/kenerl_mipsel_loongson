Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 20:08:55 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:26255 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860039AbaFYSIVwFc-g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jun 2014 20:08:21 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5PI8CeD015416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jun 2014 14:08:12 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-125.brq.redhat.com [10.34.1.125])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5PI888x013681;
        Wed, 25 Jun 2014 14:08:08 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Wed, 25 Jun 2014 20:07:10 +0200 (CEST)
Date:   Wed, 25 Jun 2014 20:07:05 +0200
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
Subject: Re: [PATCH v8 3/9] seccomp: introduce writer locking
Message-ID: <20140625180705.GB18185@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org> <1403642893-23107-4-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403642893-23107-4-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40830
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

On 06/24, Kees Cook wrote:
>
> +static void copy_seccomp(struct task_struct *p)
> +{
> +#ifdef CONFIG_SECCOMP
> +	/*
> +	 * Must be called with sighand->lock held, which is common to
> +	 * all threads in the group. Regardless, nothing special is
> +	 * needed for the child since it is not yet in the tasklist.
> +	 */
> +	BUG_ON(!spin_is_locked(&current->sighand->siglock));
> +
> +	get_seccomp_filter(current);
> +	p->seccomp = current->seccomp;
> +
> +	if (p->seccomp.mode != SECCOMP_MODE_DISABLED)
> +		set_tsk_thread_flag(p, TIF_SECCOMP);
> +#endif
> +}

Wait. But what about no_new_privs? We should copy it as well...

Perhaps this helper should be updated a bit and moved into seccomp.c so
that seccomp_sync_threads() could use it too.

Oleg.
