Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2014 17:10:15 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:19948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860064AbaGJPKF5vroB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Jul 2014 17:10:05 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6AF9tOJ006679
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jul 2014 11:09:55 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-170.brq.redhat.com [10.34.1.170])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s6AF9pP8023573;
        Thu, 10 Jul 2014 11:09:51 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Thu, 10 Jul 2014 17:08:36 +0200 (CEST)
Date:   Thu, 10 Jul 2014 17:08:32 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v9 11/11] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
Message-ID: <20140710150832.GA20861@redhat.com>
References: <1403911380-27787-1-git-send-email-keescook@chromium.org> <1403911380-27787-12-git-send-email-keescook@chromium.org> <20140709180520.GA2560@redhat.com> <CAGXu5jLUqz-T1tRBCpPLkzWijyAF-Vjw_7PnQ1EvUh4urwyaUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLUqz-T1tRBCpPLkzWijyAF-Vjw_7PnQ1EvUh4urwyaUg@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41114
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

On 07/10, Kees Cook wrote:
>
> On Wed, Jul 9, 2014 at 11:05 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> >> +     /*
> >> +      * Make sure we cannot change seccomp or nnp state via TSYNC
> >> +      * while another thread is in the middle of calling exec.
> >> +      */
> >> +     if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
> >> +         mutex_lock_killable(&current->signal->cred_guard_mutex))
> >> +             goto out_free;
> >
> > -EINVAL looks a bit confusing in this case, but this is cosemtic because
> > userspace won't see this error-code anyway.
>
> Happy to use whatever since, as you say, it's cosmetic. Perhaps -EAGAIN?

Or -EINTR. I do not really mind, I only mentioned this because I had another
nit.

> >>       spin_lock_irq(&current->sighand->siglock);
> >> +     if (unlikely(signal_group_exit(current->signal))) {
> >> +             /* If thread is dying, return to process the signal. */
> >
> > OK, this doesn't hurt, but why?
> >
> > You could check __fatal_signal_pending() with the same effect. And since
> > we hold this mutex, exec (de_thread) can be the source of that SIGKILL.
> > We take this mutex specially to avoid the race with exec.
> >
> > So why do we need to abort if we race with kill() or exit_grouo() ?
>
> In my initial code inspection that we could block waiting for the
> cred_guard mutex, with exec holding it, exec would schedule death in
> de_thread, and then once it released, the tsync thread would try to
> keep running.
>
> However, in looking at this again, now I'm concerned this produces a
> dead-lock in de_thread, since it waits for all threads to actually
> die, but tsync will be waiting with the killable mutex.

That is why you should always use _killable (or _interruptible) if you
want to take ->cred_guard_mutex.

If this thread races with de_thread() which holds this mutex, it will
be killed and mutex_lock_killable() will fail.

(to clarify; this deadlock is not "fatal", de_thread() can be killed too,
 but this doesn't really matter).

> So I think I got too defensive when I read the top of de_thread where
> it checks for pending signals itself.
>
> It seems like I can just safely remove the singal_group_exit checks?
> The other paths (non-tsync seccomp_set_mode_filter, and
> seccomp_set_mode_strict)

Yes, I missed another signal_group_exit() in seccomp_set_mode_strict().
It looks equally unneeded.

> I can't decide which feels cleaner: just letting stuff
> clean up naturally on death or to short-circuit after taking
> sighand->siglock.

I'd prefer to simply remove the singal_group_exit checks.

I won't argue if you prefer to keep them, but then please add a comment
to explain that this is not needed for correctness.

Because otherwise the code looks confusing, as if there is a subtle reason
why we must not do this if killed.

Oleg.
