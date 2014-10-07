Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 13:12:52 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:49779 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010703AbaJGLMugWOif (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 13:12:50 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1XbSfW-0001Sp-00; Tue, 07 Oct 2014 11:11:02 +0000
Date:   Tue, 7 Oct 2014 07:11:02 -0400
From:   Rich Felker <dalias@libc.org>
To:     David Daney <david.s.daney@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Daney <ddaney.cavm@gmail.com>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Message-ID: <20141007111102.GH23797@brightrain.aerifal.cx>
References: <5433071B.4050606@caviumnetworks.com>
 <20141006213101.GA23797@brightrain.aerifal.cx>
 <54330D79.80102@caviumnetworks.com>
 <20141006215813.GB23797@brightrain.aerifal.cx>
 <543327E7.4020608@amacapital.net>
 <54332A64.5020605@caviumnetworks.com>
 <20141007000514.GD23797@brightrain.aerifal.cx>
 <543334CE.8060305@caviumnetworks.com>
 <20141007004915.GF23797@brightrain.aerifal.cx>
 <54337127.40806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54337127.40806@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dalias@libc.org
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

On Mon, Oct 06, 2014 at 09:50:47PM -0700, David Daney wrote:
> >>the out-of-line execution trick, but do it somewhere other than in
> >>stack memory.
> >How do you answer Andy Lutomirski's question about what happens when a
> >signal handler interrupts execution while the program counter is
> >pointing at this "out-of-line execution" trampoline? This seems like a
> >show-stopper for using anything other than the stack.
> It would be nice to support, but not doing so would not be a
> regression from current behavior.

It's not just "nice" to support, it's mandatory. Otherwise you will
execute essentially *random instructions* in this case, providing a
very nice attack vector that can almost certainly be elevated to
arbitrary code execution via timing of signals during floating point
code.

The current behavior in regards to this is correct: because you have a
*stack*, each trampoline is pushed onto the stack in its own context,
and popped when it's no longer needed. You can have arbitrarily many
such trampolines up to the stack size. Note that each nested signal
handler already requires sizeof(ucontext_t) in stack space, so these
trampolines are a negligible additional cost without major effects on
the number of signal handlers you can nest without overflowing the
stack.

> >>One way of doing this is to have the kernel magically generate
> >>thread local memory regions.
> >>
> >>Another option is to have userspace manage the out-of-line execution areas.
> >>
> >>As is often the case, each approach has different pluses and minuses.
> >Having the kernel magically do it would be better, but I'm doubtful
> >that solution works anyway due to the above signal handler/nesting
> >issue.
> 
> So the perfect is the enemy of the good?  No non-executable stack
> for you, MIPS.

No, regressions that make the situation worse than executable-stack
are not "good" to begin with, even if it weren't for the other design
issues and dumping everything on userspace for the sake of being lazy
in the kernel.

Rich
