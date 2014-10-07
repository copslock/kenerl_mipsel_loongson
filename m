Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 21:22:22 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:49817 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010745AbaJGTWVC-nRA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 21:22:21 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1XbaJn-0002Nh-00; Tue, 07 Oct 2014 19:21:07 +0000
Date:   Tue, 7 Oct 2014 15:21:07 -0400
From:   Rich Felker <dalias@libc.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        David Daney <david.s.daney@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Message-ID: <20141007192107.GN23797@brightrain.aerifal.cx>
References: <54332A64.5020605@caviumnetworks.com>
 <20141007000514.GD23797@brightrain.aerifal.cx>
 <543334CE.8060305@caviumnetworks.com>
 <20141007004915.GF23797@brightrain.aerifal.cx>
 <54337127.40806@gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320F1E173@LEMAIL01.le.imgtec.org>
 <543431DA.4090809@imgtec.com>
 <CALCETrUQEbb=DotSzsneN7Hano_eC-EoTMko6uKcyZXvEcktkw@mail.gmail.com>
 <20141007190943.GM23797@brightrain.aerifal.cx>
 <54343C2B.2080801@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54343C2B.2080801@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43086
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

On Tue, Oct 07, 2014 at 12:16:59PM -0700, Leonid Yegoshin wrote:
> On 10/07/2014 12:09 PM, Rich Felker wrote:
> >I agree completely here. We should not break things (or, as it
> >seems, leave them broken) for common usage cases that affect
> >everyone just to coddle proprietary vendor-specific instructions.
> >The latter just should not be used in delay slots unless the chip
> >vendor also promises to provide fpu branch in hardware. Rich
> And what do you propose - remove a current in-stack emulation and
> you still think it doesn't break a status-quo?

The in-stack trampoline support could be left but used only for
emulating instructions the kernel doesn't know. This would make all
normal binaries immediately usable with non-executable stack, and
would avoid the only potential source of regressions. Ultimately I
think the "xol" stuff should be removed, but that could be a long term
goal.

Rich
