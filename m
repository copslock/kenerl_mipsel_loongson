Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 21:19:35 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:46791 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6855641AbaFXTTdfwyLU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jun 2014 21:19:33 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5OJJLrS009809
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jun 2014 15:19:21 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-125.brq.redhat.com [10.34.1.125])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5OJJHZr012112;
        Tue, 24 Jun 2014 15:19:17 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Tue, 24 Jun 2014 21:18:19 +0200 (CEST)
Date:   Tue, 24 Jun 2014 21:18:15 +0200
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
Subject: Re: [PATCH v7 4/9] seccomp: move no_new_privs into seccomp
Message-ID: <20140624191815.GA3623@redhat.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org> <1403560693-21809-5-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403560693-21809-5-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40764
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

On 06/23, Kees Cook wrote:
>
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -3,6 +3,8 @@
>
>  #include <uapi/linux/seccomp.h>
>
> +#define SECCOMP_FLAG_NO_NEW_PRIVS	0	/* task may not gain privs */
> +
>  #ifdef CONFIG_SECCOMP
>
>  #include <linux/thread_info.h>
> @@ -16,6 +18,7 @@ struct seccomp_filter;
>   *         system calls available to a process.
>   * @filter: must always point to a valid seccomp-filter or NULL as it is
>   *          accessed without locking during system call entry.
> + * @flags: flags under task->sighand->siglock lock
>   *
>   *          @filter must only be accessed from the context of current as there
>   *          is no read locking.
> @@ -23,6 +26,7 @@ struct seccomp_filter;
>  struct seccomp {
>  	int mode;
>  	struct seccomp_filter *filter;
> +	unsigned long flags;
>  };
>
>  extern int __secure_computing(int);
> @@ -51,7 +55,9 @@ static inline int seccomp_mode(struct seccomp *s)
>
>  #include <linux/errno.h>
>
> -struct seccomp { };
> +struct seccomp {
> +	unsigned long flags;
> +};

A bit messy ;)

I am wondering if we can simply do

	static inline bool current_no_new_privs(void)
	{
		if (current->no_new_privs)
			return true;

	#ifdef CONFIG_SECCOMP
		if (test_thread_flag(TIF_SECCOMP))
			return true;
	#endif

		return false;

	     return test_bit(SECCOMP_FLAG_NO_NEW_PRIVS, &p->seccomp.flags);
	}

instead ?

Oleg.
