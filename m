Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Oct 2014 23:59:56 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:49733 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010652AbaJFV7yUrvyl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Oct 2014 23:59:54 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1XbGIH-0008Lv-00; Mon, 06 Oct 2014 21:58:13 +0000
Date:   Mon, 6 Oct 2014 17:58:13 -0400
From:   Rich Felker <dalias@libc.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Message-ID: <20141006215813.GB23797@brightrain.aerifal.cx>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
 <20141006205459.GZ23797@brightrain.aerifal.cx>
 <5433071B.4050606@caviumnetworks.com>
 <20141006213101.GA23797@brightrain.aerifal.cx>
 <54330D79.80102@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54330D79.80102@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42973
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

On Mon, Oct 06, 2014 at 02:45:29PM -0700, David Daney wrote:
> On 10/06/2014 02:31 PM, Rich Felker wrote:
> >On Mon, Oct 06, 2014 at 02:18:19PM -0700, David Daney wrote:
> >>>Userspace should play no part in this; requiring userspace to help
> >>>make special accomodations for fpu emulation largely defeats the
> >>>purpose of fpu emulation.
> >>
> >>That is certainly one way of looking at it.  Really it is opinion,
> >>rather than fact though.
> >
> >It's an opinion, yes, but it has substantial reason behind it.
> >
> >>GLibc is full of code (see ld.so) that in earlier incantations of
> >>Unix/Linux was in kernel space, and was moved to userspace.  Given
> >>that there is a partitioning of code between kernel space and
> >>userspace, I think it not totally unreasonable to consider doing
> >>some of this in userspace.
> >>
> >>Even on systems with hardware FPU, the architecture specification
> >>allows for/requires emulation of certain cases (denormals, etc.)  So
> >>it is already a requirement that userspace cooperate by always
> >>having free space below $SP for use by the kernel.  So the current
> >>situation is that userspace is providing services for the kernel FPU
> >>emulator.
> >>
> >>My suggestion is to change the nature of the way these services are
> >>provided by the userspace program.
> >
> >But this isn't setup by the userspace program. It's setup by the
> >kernel on program entry. Despite that, though, I think it's an
> >unnecessary (and undocumented!) constraint; the fact that it requires
> >the stack to be executable makes it even more harmful and
> >inappropriate.
> >
> 
> The management of the stack is absolutely done by userspace code.
> Any time you do pthread_create(), userspace code does mmap() to
> allocate the stack area, it then sets permissions on the area, and
> then it passes the address of the area to clone().

This is hardly management.

> Furthermore the
> userspace code has to be very careful in its use of the $sp
> register, so that it doesn't store data in places that will be
> used/clobbered by the kernel.

This is not "being careful". The stack pointer can never become
invalid unless you do wacky things in asm or invoke UB.

> All of this is under the control of the userspace program and done
> with userspace code.

For the most part it just happens by default. There is no particular
intentionality needed, and certainly no hideous MIPS-specific hacks
needed.

> I appreciate the fact that libc authors might prefer *not* to write
> more code, but they could, especially if they wanted to add the
> feature of non-executable stacks to their library implementation.

So your position is that:

1. A non-exec-stack system can only run new code produced to do extra
   stuff in userspace.

2. The startup code needs to do special work in userspace on MIPS to
   setup an executable area for fpu emulation.

3. Every call to clone/CLONE_VM needs to be accompanied by a call to
   mmap and this new syscall to set the address, and every call to
   SYS_exit needs to be accompanies by a call to munmap for the
   corresponding mapping.

This is a huge ill-designed mess.

Rich
