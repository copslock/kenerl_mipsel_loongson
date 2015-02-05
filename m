Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2015 00:39:52 +0100 (CET)
Received: from pegasus3.altlinux.org ([194.107.17.103]:32887 "EHLO
        pegasus3.altlinux.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012696AbbBEXjvSf1wC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Feb 2015 00:39:51 +0100
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by pegasus3.altlinux.org (Postfix) with ESMTP id D515C80A7D;
        Fri,  6 Feb 2015 02:39:45 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id C5206AC5F8A; Fri,  6 Feb 2015 02:39:45 +0300 (MSK)
Date:   Fri, 6 Feb 2015 02:39:45 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v5 3/5] x86: Split syscall_trace_enter into two phases
Message-ID: <20150205233945.GA31540@altlinux.org>
References: <cover.1409954077.git.luto@amacapital.net> <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net> <20150205211916.GA31367@altlinux.org> <CAGXu5j+aXxt55LsxxbNkfGGF719ubXBZ2JAFwUPNARwKMVFgng@mail.gmail.com> <20150205214027.GB31367@altlinux.org> <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com> <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
Return-Path: <ldv@altlinux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ldv@altlinux.org
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

On Thu, Feb 05, 2015 at 03:12:39PM -0800, Kees Cook wrote:
> On Thu, Feb 5, 2015 at 1:52 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > On Thu, Feb 5, 2015 at 1:40 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> >> On Thu, Feb 05, 2015 at 01:27:16PM -0800, Kees Cook wrote:
> >>> On Thu, Feb 5, 2015 at 1:19 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> >>> > Hi,
> >>> >
> >>> > On Fri, Sep 05, 2014 at 03:13:54PM -0700, Andy Lutomirski wrote:
> >>> >> This splits syscall_trace_enter into syscall_trace_enter_phase1 and
> >>> >> syscall_trace_enter_phase2.  Only phase 2 has full pt_regs, and only
> >>> >> phase 2 is permitted to modify any of pt_regs except for orig_ax.
> >>> >
> >>> > This breaks ptrace, see below.
> >>> >
[...]
> >>> >> +             ret = seccomp_phase1(&sd);
> >>> >> +             if (ret == SECCOMP_PHASE1_SKIP) {
> >>> >> +                     regs->orig_ax = -1;
> >>> >
> >>> > How the tracer is expected to get the correct syscall number after that?
> >>>
> >>> There shouldn't be a tracer if a skip is encountered. (A seccomp skip
> >>> would skip ptrace.) This behavior hasn't changed, but maybe I don't
> >>> see what you mean? (I haven't encountered any problems with syscall
> >>> tracing as a result of these changes.)
> >>
> >> SECCOMP_RET_ERRNO leads to SECCOMP_PHASE1_SKIP, and if there is a tracer,
> >> it will get -1 as a syscall number.
> >>
> >> I've found this while testing a strace parser for
> >> SECCOMP_MODE_FILTER/SECCOMP_SET_MODE_FILTER, so the problem is quite real.
> >
> > Hasn't it always been this way?
> 
> As far as I know, yes, it's always been this way. The point is to the
> skip the syscall, which is what the -1 signals. Userspace then reads
> back the errno.

There is a clear difference: before these changes, SECCOMP_RET_ERRNO used
to keep the syscall number unchanged and suppress syscall-exit-stop event,
which was awful because userspace cannot distinguish syscall-enter-stop
from syscall-exit-stop and therefore relies on the kernel that
syscall-enter-stop is followed by syscall-exit-stop (or tracee's death, etc.).

After these changes, SECCOMP_RET_ERRNO no longer causes syscall-exit-stop
events to be suppressed, but now the syscall number is lost.


-- 
ldv
