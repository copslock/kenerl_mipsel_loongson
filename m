Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Oct 2014 23:32:14 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:49726 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010651AbaJFVcMdPQdl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Oct 2014 23:32:12 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1XbFrx-0008JS-00; Mon, 06 Oct 2014 21:31:01 +0000
Date:   Mon, 6 Oct 2014 17:31:01 -0400
From:   Rich Felker <dalias@libc.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Message-ID: <20141006213101.GA23797@brightrain.aerifal.cx>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
 <20141006205459.GZ23797@brightrain.aerifal.cx>
 <5433071B.4050606@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5433071B.4050606@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42971
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

On Mon, Oct 06, 2014 at 02:18:19PM -0700, David Daney wrote:
> >Userspace should play no part in this; requiring userspace to help
> >make special accomodations for fpu emulation largely defeats the
> >purpose of fpu emulation.
> 
> That is certainly one way of looking at it.  Really it is opinion,
> rather than fact though.

It's an opinion, yes, but it has substantial reason behind it.

> GLibc is full of code (see ld.so) that in earlier incantations of
> Unix/Linux was in kernel space, and was moved to userspace.  Given
> that there is a partitioning of code between kernel space and
> userspace, I think it not totally unreasonable to consider doing
> some of this in userspace.
> 
> Even on systems with hardware FPU, the architecture specification
> allows for/requires emulation of certain cases (denormals, etc.)  So
> it is already a requirement that userspace cooperate by always
> having free space below $SP for use by the kernel.  So the current
> situation is that userspace is providing services for the kernel FPU
> emulator.
> 
> My suggestion is to change the nature of the way these services are
> provided by the userspace program.

But this isn't setup by the userspace program. It's setup by the
kernel on program entry. Despite that, though, I think it's an
unnecessary (and undocumented!) constraint; the fact that it requires
the stack to be executable makes it even more harmful and
inappropriate.

> >The kernel is perfectly capable of mapping
> >an appropriate page. The mapping should happen at exec time,  and at
> >clone time with CLONE_VM
> 
> Why?  This adds overhead for threads that don't use the FPU.  So
> this suggestion adds at least one page of memory overhead for each
> thread in the system (unless I misunderstand what you are saying).

Yes, that's why I think the mutual-exclusion approach might be
preferred. But if you're going to use per-thread areas for this, they
MUST be allocated at thread-creation time, since that's the only time
you can handle error (by failing pthread_create). If you do it lazily,
it might fail and there's no way to recover. And there's no way to
know in advance whether a thread will invoke floating point code, so
you have to set it up for every thread.

> >unless the kernel is going to handle mutual
> >exclusion so that only one thread can be using the page at a time.
> >(Using one page for the whole process, and excluding simultaneous
> >execution of fpu emulation in multiple threads, may be the more
> >practical approach.)
> >
> >As an alternative, if the space of possible instruction with a delay
> >slot is sufficiently small, all such instructions could be mapped as
> >immutable code in a shared mapping, each at a fixed offset in the
> >mapping. I suspect this would be borderline-impractical (multiple
> >megabytes?), but it is the cleanest solution otherwise.
> >
> 
> Yes, there are 2^32 possible instructions.  Each one is 4 bytes,
> plus you need a way to exit after the instruction has executed,
> which would require another instruction.  So you would need 32GB of
> memory to hold all those instructions, larger than the 32-bit
> virtual address space.

There are not 2^32 instructions that have delay slots after them. Only
branch instructions have delay slots. The space of such instruction is
much smaller, probably on the order of 64-256 MB, not 32GB, but I
haven't looked at the instruction encoding tables to confirm this.

Rich
