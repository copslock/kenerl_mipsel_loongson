Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 20:37:08 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:21734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6854779AbaFXShGXA0UI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jun 2014 20:37:06 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5OIauh9021294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jun 2014 14:36:56 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-125.brq.redhat.com [10.34.1.125])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5OIaqaE032064;
        Tue, 24 Jun 2014 14:36:52 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Tue, 24 Jun 2014 20:35:54 +0200 (CEST)
Date:   Tue, 24 Jun 2014 20:35:50 +0200
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
Subject: Re: [PATCH v7 3/9] seccomp: introduce writer locking
Message-ID: <20140624183550.GB1258@redhat.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org> <1403560693-21809-4-git-send-email-keescook@chromium.org> <20140624165216.GA29272@redhat.com> <CAGXu5j+G8qAkGD7H=3R2iw2ZTqZSrMPa2f=czoEjwSW5wKqUWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+G8qAkGD7H=3R2iw2ZTqZSrMPa2f=czoEjwSW5wKqUWQ@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40760
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
> On Tue, Jun 24, 2014 at 9:52 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> > Kees,
> >
> > I am still trying to force myself to read and try to understand what
> > this series does ;) Just a minor nit so far.
>
> The use-case this solves is when a userspace process does not control
> (or know) when a thread is spawned (e.g. via shared library init, or
> LD_PRELOAD) but wants to make sure seccomp filters have been applied
> to it.

Yes, thanks, I understand this. But the details are not clear to me so
far, I'll try to re-read this series later.

> >> @@ -1142,6 +1168,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
> >>  {
> >>       int retval;
> >>       struct task_struct *p;
> >> +     unsigned long irqflags;
> >>
> >>       if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
> >>               return ERR_PTR(-EINVAL);
> >> @@ -1196,7 +1223,6 @@ static struct task_struct *copy_process(unsigned long clone_flags,
> >>               goto fork_out;
> >>
> >>       ftrace_graph_init_task(p);
> >> -     get_seccomp_filter(p);
> >>
> >>       rt_mutex_init_task(p);
> >>
> >> @@ -1434,7 +1460,13 @@ static struct task_struct *copy_process(unsigned long clone_flags,
> >>               p->parent_exec_id = current->self_exec_id;
> >>       }
> >>
> >> -     spin_lock(&current->sighand->siglock);
> >> +     spin_lock_irqsave(&current->sighand->siglock, irqflags);
> >> +
> >> +     /*
> >> +      * Copy seccomp details explicitly here, in case they were changed
> >> +      * before holding tasklist_lock.
> >> +      */
> >> +     copy_seccomp(p);
> >>
> >>       /*
> >>        * Process group and session signals need to be delivered to just the
> >> @@ -1446,7 +1478,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
> >>       */
> >>       recalc_sigpending();
> >>       if (signal_pending(current)) {
> >> -             spin_unlock(&current->sighand->siglock);
> >> +             spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
> >>               write_unlock_irq(&tasklist_lock);
> >>               retval = -ERESTARTNOINTR;
> >>               goto bad_fork_free_pid;
> >> @@ -1486,7 +1518,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
> >>       }
> >>
> >>       total_forks++;
> >> -     spin_unlock(&current->sighand->siglock);
> >> +     spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
> >>       write_unlock_irq(&tasklist_lock);
> >>       proc_fork_connector(p);
> >>       cgroup_post_fork(p);
> >
> > It seems that the only change copy_process() needs is copy_seccomp() under the locks.
> > Everythinh else (irqflags games) looks obviously unneeded?
>
> I got irq lock dep warnings without these changes.

With or without your patches? Could you show the waring?

> If they're
> unneeded, that's totally fine by me, but some change (either this or
> markings to keep lockdep happy) is needed.

Yes, we need to understand what what happens...

Oleg.
