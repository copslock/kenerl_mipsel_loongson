Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2014 17:25:52 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:2656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860064AbaGJPZt4rLPA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Jul 2014 17:25:49 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6AFPekQ011299
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jul 2014 11:25:41 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-170.brq.redhat.com [10.34.1.170])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s6AFPaNN000925;
        Thu, 10 Jul 2014 11:25:37 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Thu, 10 Jul 2014 17:24:22 +0200 (CEST)
Date:   Thu, 10 Jul 2014 17:24:18 +0200
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
Subject: Re: [PATCH v9 09/11] seccomp: introduce writer locking
Message-ID: <20140710152418.GB20861@redhat.com>
References: <1403911380-27787-1-git-send-email-keescook@chromium.org> <1403911380-27787-10-git-send-email-keescook@chromium.org> <20140709184215.GA4866@redhat.com> <20140709185549.GB4866@redhat.com> <CAGXu5jL6q1d16uA1Yu+QO4eV7zWwcWEWgkZrwmsfymbMvEr6+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jL6q1d16uA1Yu+QO4eV7zWwcWEWgkZrwmsfymbMvEr6+Q@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41115
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
> On Wed, Jul 9, 2014 at 11:55 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> > On 07/09, Oleg Nesterov wrote:
> >>
> >> On 06/27, Kees Cook wrote:
> >> >
> >> >  static u32 seccomp_run_filters(int syscall)
> >> >  {
> >> > -   struct seccomp_filter *f;
> >> > +   struct seccomp_filter *f = ACCESS_ONCE(current->seccomp.filter);
> >>
> >> I am not sure...
> >>
> >> This is fine if this ->filter is the 1st (and only) one, in this case
> >> we can rely on rmb() in the caller.
> >>
> >> But the new filter can be installed at any moment. Say, right after that
> >> rmb() although this doesn't matter. Either we need smp_read_barrier_depends()
> >> after that, or smp_load_acquire() like the previous version did?
> >
> > Wait... and it seems that seccomp_sync_threads() needs smp_store_release()
> > when it sets thread->filter = current->filter by the same reason?
> >
> > OTOH. smp_store_release() in seccomp_attach_filter() can die, "current"
> > doesn't need a barrier to serialize with itself.
>
> I have lost track of what you're suggesting to change. :)

Perhaps I am just trying to confuse you and myself ;)

But,

> Since rmb() happens before run_filters, isn't the ACCESS_ONCE
> sufficient?

Yes. But see above. ACCESS_ONCE is sufficient if we read the first filter
installed by another thread, in this case rmb() pairs with mb_before_atomic()
before set_bit(TIF_SECCOMP).

IOW, if this threads sees TIF_SECCOMP, it should also see all modifications
which were done before set_bit, including the data in ->filter points to.

> We only care that TIF_SECCOMP, mode, and some filter is
> valid. In a tsync thread race, it's okay to use not use the deepest
> filter node in the list,

Yes, it is fine if we miss yet another filter which was just installed by
another thread.

But, unless I missed something, the problem is that we can get this new
filter.

Just to simplify. Suppose TIF_SECCOMP was set a long ago. This thread
has a single filter F1 and it enters seccomp_run_filters().

Right before it does ACCESS_ONCE() to read the pointer, another thread
does seccomp_sync_threads() and sets .filter = F2.

If ACCESS_ONCE() returns F1 - everything is fine. But it can see the new
pointer F2, and in this case we need a barrier to ensure that, say,
LOAD(F2->prog) will see all the preceding changes in this memory.

Oleg.
