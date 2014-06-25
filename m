Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 19:53:02 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:54903 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859932AbaFYRw6aMBxj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jun 2014 19:52:58 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5PHqh46008384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jun 2014 13:52:44 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-125.brq.redhat.com [10.34.1.125])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5PHqd1D027604;
        Wed, 25 Jun 2014 13:52:40 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Wed, 25 Jun 2014 19:51:41 +0200 (CEST)
Date:   Wed, 25 Jun 2014 19:51:36 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v8 5/9] seccomp: split mode set routines
Message-ID: <20140625175136.GA18185@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org> <1403642893-23107-6-git-send-email-keescook@chromium.org> <20140625135121.GB7892@redhat.com> <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com> <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com> <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com> <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com> <20140625173245.GA17695@redhat.com> <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40825
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

On 06/25, Andy Lutomirski wrote:
>
> On Wed, Jun 25, 2014 at 10:32 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> > On 06/25, Andy Lutomirski wrote:
> >>
> >> Write the filter, then smp_mb (or maybe a weaker barrier is okay),
> >> then set the bit.
> >
> > Yes, exactly, this is what I meant. Plas rmb() in __secure_computing().
> >
> > But I still can't understand the rest of your discussion about the
> > ordering we need ;)
>
> Let me try again from scratch.
>
> Currently there are three relevant variables: TIF_SECCOMP,
> seccomp.mode, and seccomp.filter.  __secure_computing needs
> seccomp.mode and seccomp.filter to be in sync, and it wants (but
> doesn't really need) TIF_SECCOMP to be in sync as well.
>
> My suggestion is to rearrange it a bit.  Move mode into seccomp.filter
> (so that filter == NULL implies no seccomp) and don't check
> TIF_SECCOMP in secure_computing.  Then turning on seccomp is entirely
> atomic except for the fact that the seccomp hooks won't be called if
> filter != NULL but !TIF_SECCOMP.  This removes all ordering
> requirements.

Ah, got it, thanks. Perhaps I missed somehing, but to me this looks like
unnecessary complication at first glance.

We alredy have TIF_SECCOMP, we need it anyway, and we should only care
about the case when this bit is actually set, so that we can race with
the 1st call of __secure_computing().

Otherwise we are fine: we can miss the new filter anyway, ->mode can't
be changed it is already nonzero.

> Alternatively, __secure_computing could still BUG_ON(!seccomp.filter).
> In that case, filter needs to be set before TIF_SECCOMP is set, but
> that's straightforward.

Yep. And this is how seccomp_assign_mode() already works? It is called
after we change ->filter chain, it changes ->mode before set(TIF_SECCOMP)
just it lacks a barrier.

Oleg.
