Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2013 06:41:22 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:42339 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671Ab3IDElTtIUzv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Sep 2013 06:41:19 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1VH4tw-0000xj-00; Wed, 04 Sep 2013 04:41:08 +0000
Date:   Wed, 4 Sep 2013 00:41:08 -0400
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Denys Vlasenko <vda.linux@googlemail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-mips@linux-mips.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Dave Jones <davej@redhat.com>
Subject: Re: [PATCH v2] MIPS: Reduce _NSIG from 128 to 127 to avoid BUG_ON
Message-ID: <20130904044108.GP20515@brightrain.aerifal.cx>
References: <1371225825-8225-1-git-send-email-james.hogan@imgtec.com>
 <51BEE6A8.2050307@imgtec.com>
 <201306282128.27266.vda.linux@googlemail.com>
 <CAAG0J9-d4BfEhbQovFqUAJ3QoOuXScrpsY1y95PrEPxA5DWedQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAG0J9-d4BfEhbQovFqUAJ3QoOuXScrpsY1y95PrEPxA5DWedQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   Rich Felker <dalias@aerifal.cx>
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dalias@aerifal.cx
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

On Fri, Jun 28, 2013 at 11:03:33PM +0100, James Hogan wrote:
> On 28 June 2013 20:28, Denys Vlasenko <vda.linux@googlemail.com> wrote:
> > On Monday 17 June 2013 12:36, James Hogan wrote:
> >> On 14/06/13 17:03, James Hogan wrote:
> >> > MIPS has 128 signals, the highest of which has the number 128 (they
> >> > start from 1). The following command causes get_signal_to_deliver() to
> >> > pass this signal number straight through to do_group_exit() as the exit
> >> > code:
> >> >
> >> >   strace sleep 10 & sleep 1 && kill -128 `pidof sleep`
> >> >
> >> > However do_group_exit() checks for the core dump bit (0x80) in the exit
> >> > code which matches in this particular case and the kernel panics:
> >> >
> >> >   BUG_ON(exit_code & 0x80); /* core dumps don't get here */
> >> >
> >> > Lets avoid this by changing the ABI by reducing the number of signals to
> >> > 127 (so that the maximum signal number is 127). Glibc incorrectly sets
> >> > [__]SIGRTMAX to 127 already. uClibc sets it to 128 so it's conceivable
> >> > that programs built against uClibc which intentionally uses RT signals
> >> > from the top (SIGRTMAX-n, n>=0) would need an updated uClibc (and a
> >> > rebuild if it's crazy enough to use __SIGRTMAX).
> >>
> >> Hmm, although this works around the BUG_ON, this doesn't actually seem
> >> to be sufficient to behave correctly.
> >>
> >> So it appears the exit status is constructed like this:
> >> bits  purpose
> >> 0x007f        signal number (0-127)
> >> 0x0080        core dump
> >> 0xff00        exit status
> >>
> >> but the macros in waitstatus.h and wait.h in libc
> >> (see also "man 2 wait"):
> >> WIFEXITED:   status & 0x7f == 0
> >> WIFSIGNALED: status & 0x7f in [1..126] (i.e. not 0 or 127)
> >> WIFSTOPPED:  status & 0xff == 127
> >>
> >> So termination due to SIG127 looks like it's been stopped instead of
> >> terminated via a signal, unless a core dump occurs in which case none of
> >> the above match.
> >>
> >> (And termination due to SIG128 hits BUG_ON, otherwise would appear to
> >> have exited normally with core dump).
> >>
> >>
> >> Reducing number of signals to 126 to avoid this will change the glibc
> >> ABI too, in which case we may as well reduce to 64 to match other
> >> arches, which is more likely to break something (I'm not really
> >> comfortable making that change).
> >>
> >> Reducing to 127 (this patch) still leaves incorrect exit status codes
> >> for SIG127 ...
> >>
> >> Any further thoughts/opinions?
> >
> > Strictly speaking, exit status of 0x007f isn't ambiguous.
> >
> > Currently userspace uses the following rules
> > (assuming that status is 16-bit (IOW, dropping PTRACE_EVENT bits)):
> >
> > WIFEXITED(status)    = (status & 0x7f) == 0
> > WIFSIGNALED(status)  = (status & 0x7f) != 0 && (status & 0x7f) < 0x7f
> > WIFSTOPPED(status)   = (status & 0xff) == 0x7f
> > WIFCONTINUED(status) = (status == 0xffff)
> >
> > WEXITSTATUS(status)  = status >> 8
> > WSTOPSIG(status)     = status >> 8
> > WCOREDUMP(status)    = status & 0x80
> > WTERMSIG(status)     = status & 0x7f
> >
> > When process dies from signal 127, status is 0x007f and it is not a valid
> > "stopped by signal" indicator, since WSTOPSIG == 0 is an impossibility.
> >
> > Status 0x007f get misinterpreted by the rules above, namely,
> > WIFSTOPPED is true, WIFSIGNALED is false.
> >
> > But an alternative definition exists which works correctly with
> > all previous status codes, treats 0x007f as "killed by signal 127"
> > and isn't more convoluted.
> > In fact, while WIFSTOPPED needs one additional check,
> > WIFSIGNALED gets simpler (loses one AND'ing operation):
> >
> > WIFSTOPPED(status)   = (status & 0xff) == 0x7f && (status >> 8) != 0
> > WIFSIGNALED(status)  = status != 0 && status <= 0xff
> >
> > All other rules need no change.
> >
> > I think it's feasible to ask {g,uc}libc to change their defines
> > (on MIPS as a minimum), and live with 127 signals.
> 
> Thanks for the explanation. This makes a lot of sense and if I
> understand correctly it already describes the current behaviour of the
> kernel up to SIG127 (I hadn't twigged WIFSTOPPED should imply
> WSTOPSIG!=0 for some reason). I like it.

One other note on this issue: SIG128 also aliases CLONE_VM, and it
would be very bad if a program requesting SIG128 as its exit signal
when calling clone instead ended up with the effects of CLONE_VM...

Also, I have some improved macros for WIFSTOPPED and WIFSIGNALED which
avoid multiple evaluation of their arguments:

#define WIFSTOPPED(s) ((short)((((s)&0xffff)*0x10001)>>8) > 0x7f00)
#define WIFSIGNALED(s) (((s)&0xffff)-1 < 0xffu)

These are what we are using in musl libc now.

Rich
