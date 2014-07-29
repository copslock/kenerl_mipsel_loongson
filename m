Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 18:56:13 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:32887 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816676AbaG2Q4G4WyMM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Jul 2014 18:56:06 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6TGtxMJ003465
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jul 2014 12:55:59 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-191.brq.redhat.com [10.34.1.191])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s6TGttLp005889;
        Tue, 29 Jul 2014 12:55:56 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Tue, 29 Jul 2014 18:54:20 +0200 (CEST)
Date:   Tue, 29 Jul 2014 18:54:16 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 6/8] x86: Split syscall_trace_enter into two phases
Message-ID: <20140729165416.GA967@redhat.com>
References: <cover.1405992946.git.luto@amacapital.net> <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net> <20140728173723.GA20993@redhat.com> <CALCETrWUFo_zXcAZja-vdL4_MgJDd=1ed5Vt54eyUuim930xAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWUFo_zXcAZja-vdL4_MgJDd=1ed5Vt54eyUuim930xAw@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41790
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

On 07/28, Andy Lutomirski wrote:
>
> On Mon, Jul 28, 2014 at 10:37 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> > Hi Andy,
> >
> > I am really sorry for delay.
> >
> > This is on top of the recent change from Kees, right? Could me remind me
> > where can I found the tree this series based on? So that I could actually
> > apply these changes...
>
> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>
> The first four patches are already applied there.

Thanks!

> > If I understand correctly, syscall_trace_enter() can avoid _phase2() above.
> > But we should always call user_exit() unconditionally?
>
> Damnit.  I read that every function called by user_exit, and none of
> them give any indication of why they're needed for traced syscalls but
> not for untraced syscalls.  On a second look, it seems that TIF_NOHZ
> controls it.

Yes, just to trigger the slow path, I guess.

> I'll update the code to call user_exit iff TIF_NOHZ is
> set.

Or perhaps it would be better to not add another user of this (strange) flag
and just call user_exit() unconditionally(). But, yes, you need to use
from "work = flags & (_TIF_WORK_SYSCALL_ENTRY & ~TIF_NOHZ)" then.

> > And we should always set X86_EFLAGS_TF if TIF_SINGLESTEP? IIRC, TF can be
> > actually cleared on a 32bit kernel if we step over sysenter insn?
>
> I don't follow.  If TIF_SINGLESTEP, then phase1 will return a nonzero
> value,

Ah yes, thanks, I missed this.

Oleg.
