Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 17:34:58 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:39805 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860069AbaG3PeyajOdW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jul 2014 17:34:54 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6UFYhrI019956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jul 2014 11:34:44 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-191.brq.redhat.com [10.34.1.191])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s6UFYdDY005079;
        Wed, 30 Jul 2014 11:34:40 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Wed, 30 Jul 2014 17:33:03 +0200 (CEST)
Date:   Wed, 30 Jul 2014 17:32:59 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] x86: two-phase syscall tracing and seccomp
        fastpath
Message-ID: <20140730153259.GA25478@redhat.com>
References: <cover.1406604806.git.luto@amacapital.net> <20140729192056.GA6308@redhat.com> <CALCETrX6P7SJQdgc0gTM7FLdwyT_Ld1MWvkLYpTO_2xsvBC9sA@mail.gmail.com> <CALCETrXHF5YzPQDvnJs=mFNm2Ff_FekGu_Y8-JyMaWh2hctR7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXHF5YzPQDvnJs=mFNm2Ff_FekGu_Y8-JyMaWh2hctR7A@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41806
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

On 07/29, Andy Lutomirski wrote:
>
> > SAVE_REST is 6 movq instructions and a subq.  FIXUP_TOP_OF_STACK is 7
> > movqs (and 8 if I ever get my way).  RESTORE_TOP_OF_STACK is 4.
> > RESTORE_REST is 6 movqs and an adsq.  So we're talking about avoiding
> > 21 movqs, and addq, and a subq.  That may be significant.  (And I
> > suspect that the difference is much larger on platforms like arm64,
> > but that's a separate issue.)

OK, thanks. We could probably simplify the logic in phase1 + phase2 if
it was a single function though.

> To put some more options on the table: there's an argument to be made
> that the whole fast-path/slow-path split isn't worth it.  We could
> unconditionally set up a full frame for all syscalls.  This means:

Or, at least, can't we allocate the full frame and avoid "add/sub %rsp"?

> This means:
...
> On the
> other hand, there's zero chance that this would be ready for 3.17.
>
> I'd tend to advocate for keeping the approach in my patches for now.

Yes, sure, I didn't try to convince you to change this code. Thanks.

Oleg.
