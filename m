Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 20:39:14 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:30993 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6854779AbaFXSjM3O1Vt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jun 2014 20:39:12 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5OIcsQH025577
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jun 2014 14:38:55 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-125.brq.redhat.com [10.34.1.125])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5OIcoS3022502;
        Tue, 24 Jun 2014 14:38:51 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Tue, 24 Jun 2014 20:37:53 +0200 (CEST)
Date:   Tue, 24 Jun 2014 20:37:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
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
Subject: Re: [PATCH v7 7/9] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
Message-ID: <20140624183749.GC1258@redhat.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org> <1403560693-21809-8-git-send-email-keescook@chromium.org> <20140624172753.GA31435@redhat.com> <CAGXu5jKoDEXffJqFSjhO+D=5toJOA=KAomi+LQOahPDYKFbEdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKoDEXffJqFSjhO+D=5toJOA=KAomi+LQOahPDYKFbEdg@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40761
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
> On Tue, Jun 24, 2014 at 10:27 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> > On 06/23, Kees Cook wrote:
> >>
> >> +static pid_t seccomp_can_sync_threads(void)
> >> +{
> >> +     struct task_struct *thread, *caller;
> >> +
> >> +     BUG_ON(write_can_lock(&tasklist_lock));
> >> +     BUG_ON(!spin_is_locked(&current->sighand->siglock));
> >> +
> >> +     if (current->seccomp.mode != SECCOMP_MODE_FILTER)
> >> +             return -EACCES;
> >> +
> >> +     /* Validate all threads being eligible for synchronization. */
> >> +     thread = caller = current;
> >> +     for_each_thread(caller, thread) {
> >> +             pid_t failed;
> >> +
> >> +             if (thread->seccomp.mode == SECCOMP_MODE_DISABLED ||
> >> +                 (thread->seccomp.mode == SECCOMP_MODE_FILTER &&
> >> +                  is_ancestor(thread->seccomp.filter,
> >> +                              caller->seccomp.filter)))
> >> +                     continue;
> >> +
> >> +             /* Return the first thread that cannot be synchronized. */
> >> +             failed = task_pid_vnr(thread);
> >> +             /* If the pid cannot be resolved, then return -ESRCH */
> >> +             if (failed == 0)
> >> +                     failed = -ESRCH;
> >
> > forgot to mention, task_pid_vnr() can't fail. sighand->siglock is held,
> > for_each_thread() can't see a thread which has passed unhash_process().
>
> Certainly good to know, but I'd be much more comfortable leaving this
> check as-is. Having "failed" return with "0" would be very very bad
> (userspace would think the filter had been successfully applied, etc).
> I'd rather stay highly defensive here.

OK, agreed. Although in this case I'd suggest

		if (WARN_ON(failed == 0))
			failed = -ESRCH;

but I won't insist.

Oleg.
