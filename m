Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 21:57:22 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:26408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860045AbaF0T5TpL4DA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jun 2014 21:57:19 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5RJv9iZ020419
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jun 2014 15:57:09 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-125.brq.redhat.com [10.34.1.125])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5RJv4Vw009567;
        Fri, 27 Jun 2014 15:57:05 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Fri, 27 Jun 2014 21:56:04 +0200 (CEST)
Date:   Fri, 27 Jun 2014 21:55:59 +0200
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
Message-ID: <20140627195559.GA31661@redhat.com>
References: <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com> <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com> <20140625173245.GA17695@redhat.com> <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com> <20140625175136.GA18185@redhat.com> <CAGXu5jL17k6=GXju6x+eLU20FMwBHhnuRiHoQD1Bzj_EmpiKjg@mail.gmail.com> <CALCETrVNwhWSPNiBiZmgP1nD9zLJPTk6cH0yo=85rbxTPTYFRg@mail.gmail.com> <CAGXu5jLavA8FJD8m-1y4wO0uzh3qvvMmajAg0Lrr1Cn_Om3a3w@mail.gmail.com> <20140627192753.GA30752@redhat.com> <CALCETrVbJqfG6oBaZEjj7H3pPa1oVJx6QXAYc5zZ6o-niV=WKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVbJqfG6oBaZEjj7H3pPa1oVJx6QXAYc5zZ6o-niV=WKQ@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40880
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

On 06/27, Andy Lutomirski wrote:
>
> On Fri, Jun 27, 2014 at 12:27 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> > On 06/27, Kees Cook wrote:
> >>
> >> It looks like SMP ARM issues dsb for rmb, which seems a bit expensive.
> >> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0204g/CIHJFGFE.htm
> >>
> >> ...
> >>
> >> I really want to avoid adding anything to the secure_computing()
> >> execution path. :(
> >
> > I must have missed something but I do not understand your concerns.
> >
> > __secure_computing() is not trivial, and we are going to execute the
> > filters. Do you really think rmb() can add the noticeable difference?
> >
> > Not to mention that we can only get here if we take the slow syscall
> > enter path due to TIF_SECCOMP...
> >
>
> On my box, with my fancy multi-phase seccomp patches, the total
> seccomp overhead for a very short filter is about 13ns.  Adding a full
> barrier would add several ns, I think.

I am just curious, does this 13ns overhead include the penalty from the
slow syscall enter path triggered by TIF_SECCOMP ?

> Admittedly, this is x86, not ARM, so comparisons here are completely
> bogus.  And that read memory barrier doesn't even need an instruction
> on x86.  But still, let's try to keep this fast.

Well, I am not going to insist...

But imo it would be better to make it correct in a most simple way, then
we can optimize this code and see if there is a noticeable difference.

Not only we can change the ordering, we can remove the BUG_ON's and just
accept the fact the __secure_computing() can race with sys_seccomp() from
another thread.

If nothing else, it would be much simpler to discuss this patch if it comes
as a separate change.

Oleg.
