Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 19:25:35 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:14508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859932AbaFYRZbsESO0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jun 2014 19:25:31 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5PHPHYo002436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jun 2014 13:25:17 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-125.brq.redhat.com [10.34.1.125])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5PHPDEZ018540;
        Wed, 25 Jun 2014 13:25:14 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Wed, 25 Jun 2014 19:24:15 +0200 (CEST)
Date:   Wed, 25 Jun 2014 19:24:10 +0200
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
Subject: Re: [PATCH v8 9/9] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
Message-ID: <20140625172410.GA17133@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org> <1403642893-23107-10-git-send-email-keescook@chromium.org> <20140625142121.GD7892@redhat.com> <CAGXu5jJtLrjbobZC1FD4WV-Jm2p7cRGa1aSPK-d_isnfCZAHdA@mail.gmail.com> <20140625165209.GA14720@redhat.com> <CAGXu5jLHDew1fifGY_mWgwcH7evm0T8rqSnBrw4XpoAXGK+t-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLHDew1fifGY_mWgwcH7evm0T8rqSnBrw4XpoAXGK+t-Q@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40821
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

On 06/25, Kees Cook wrote:
>
> On Wed, Jun 25, 2014 at 9:52 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Yes, at least this should close the race with suid-exec. And there are no
> > other users. Except apparmor, and I hope you will check it because I simply
> > do not know what it does ;)
> >
> >> I wonder if changes to nnp need to "flushed" during syscall entry
> >> instead of getting updated externally/asynchronously? That way it
> >> won't be out of sync with the seccomp mode/filters.
> >>
> >> Perhaps secure computing needs to check some (maybe seccomp-only)
> >> atomic flags and flip on the "real" nnp if found?
> >
> > Not sure I understand you, could you clarify?
>
> Instead of having TSYNC change the nnp bit, it can set a new flag, say:
>
>     task->seccomp.flags |= SECCOMP_NEEDS_NNP;
>
> This would be set along with seccomp.mode, seccomp.filter, and
> TIF_SECCOMP. Then, during the next secure_computing() call that thread
> makes, it would check the flag:
>
>     if (task->seccomp.flags & SECCOMP_NEEDS_NNP)
>         task->nnp = 1;
>
> This means that nnp couldn't change in the middle of a running syscall.

Aha, so you were worried about the same thing. Not sure we need this,
but at least I understand you and...

> Hmmm. Perhaps this doesn't solve anything, though? Perhaps my proposal
> above would actually make things worse, since now we'd have a thread
> with seccomp set up, and no nnp. If it was in the middle of exec,
> we're still causing a problem.

Yes ;)

> I think we'd also need a way to either delay the seccomp changes, or
> to notice this condition during exec. Bleh.

Hmm. confused again,

> What actually happens with a multi-threaded process calls exec? I
> assume all the other threads are destroyed?

Yes. But this is the point-of-no-return, de_thread() is called after the execing
thared has already passed (say) check_unsafe_exec().

However, do_execve() takes cred_guard_mutex at the start in prepare_bprm_creds()
and drops it in install_exec_creds(), so it should solve the problem?

Oleg.
