Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Feb 2015 04:05:00 +0100 (CET)
Received: from pegasus3.altlinux.org ([194.107.17.103]:37129 "EHLO
        pegasus3.altlinux.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012820AbbBGDE7I5QD9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Feb 2015 04:04:59 +0100
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by pegasus3.altlinux.org (Postfix) with ESMTP id C6D4180A7D;
        Sat,  7 Feb 2015 06:04:48 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id DE6C2AC5F8F; Sat,  7 Feb 2015 06:04:47 +0300 (MSK)
Date:   Sat, 7 Feb 2015 06:04:47 +0300
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
        Frederic Weisbecker <fweisbec@gmail.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Subject: Re: a method to distinguish between syscall-enter/exit-stop
Message-ID: <20150207030447.GA4930@altlinux.org>
References: <20150205233945.GA31540@altlinux.org> <CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com> <CALCETrXsCUje+_V=Ud+TB4A2jH2M7yqyoCFMLEyxOD6pd7Di5w@mail.gmail.com> <20150206023249.GB31540@altlinux.org> <CALCETrWTnqKDoatK+5FN=yYDOeENoW5=r5YMToYKhZ8Zfv5wWA@mail.gmail.com> <CAGXu5j+nopAMFukwMu=Cy0GOapziOLTb-ryJhA-aywk_uerg9A@mail.gmail.com> <CALCETrVaF+3ETn5nfcbvyWKUYb71jNXK-zo9V6uOK0cEW4TCNQ@mail.gmail.com> <CAGXu5jJXspS_34KBJ5VxvyKuj4bA+zg267dNiEkqR1LuvjoA1Q@mail.gmail.com> <20150206231720.GB3829@altlinux.org> <CAGXu5jKHkJcnpbiuYY8BVX0-wOEUDFMx7r8_HJJe2ZDT8p3uvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKHkJcnpbiuYY8BVX0-wOEUDFMx7r8_HJJe2ZDT8p3uvQ@mail.gmail.com>
Return-Path: <ldv@altlinux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45762
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

On Fri, Feb 06, 2015 at 05:07:41PM -0800, Kees Cook wrote:
> On Fri, Feb 6, 2015 at 3:17 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> > On Fri, Feb 06, 2015 at 12:07:03PM -0800, Kees Cook wrote:
> >> On Fri, Feb 6, 2015 at 11:32 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> >> > On Fri, Feb 6, 2015 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
> > [...]
> >> >> And an unrelated thought:
> >> >>
> >> >> 3) Can't we find some way to fix the inability of a ptracer to
> >> >> distinguish between syscall-enter-stop and syscall-exit-stop?
> >> >
> >> > Couldn't we add PTRACE_O_TRACESYSENTRY and PTRACE_O_TRACESYSEXIT along
> >> > the lines of PTRACE_O_TRACESYSGOOD?
> >>
> >> That might be a nice idea. I haven't written a test to see, but what
> >> does PTRACE_GETEVENTMSG return on syscall-enter/exit-stop?
> >
> > The value returned by PTRACE_GETEVENTMSG is the value set along with the
> > latest PTRACE_EVENT_*.
> > In case of syscall-enter/exit-stop (which is not a PTRACE_EVENT_*),
> > there is no particular value set for PTRACE_GETEVENTMSG.
> 
> Could we define one to help distinguish?

I suppose we could define one, but performing extra PTRACE_GETEVENTMSG
for every syscall-stop may be too expensive.

For example, strace makes about 4.5 syscalls per syscall-stop.
The minimum is 4 syscalls: wait4, PTRACE_GETREGSET, write, and PTRACE_SYSCALL;
processing some syscall-stops may require additional process_vm_readv calls.

That is, forcing strace to make extra PTRACE_GETEVENTMSG per syscall-stop
would result to about 20% more syscalls per syscall-stop, that is a
noticeable cost.

A better alternative is to define an event that wouldn't require this
extra PTRACE_GETEVENTMSG per syscall-stop.  For example, it could be a
PTRACE_EVENT_SYSCALL_ENTRY and/or PTRACE_EVENT_SYSCALL_EXIT.  In practice,
adding just one of these two events would be enough to distinguish two
kinds of syscall-stops.  Adding two events would look less surprising,
though.

If the decision would be to add both events, I'd recommend adding just one
new option to cover both events - there is a room only for 32 different
PTRACE_O_* options.


-- 
ldv
