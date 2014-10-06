Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Oct 2014 22:55:11 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:49717 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010651AbaJFUzJv7UGv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Oct 2014 22:55:09 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1XbFJ5-0006tI-00; Mon, 06 Oct 2014 20:54:59 +0000
Date:   Mon, 6 Oct 2014 16:54:59 -0400
From:   Rich Felker <dalias@libc.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     libc-alpha@sourceware.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Message-ID: <20141006205459.GZ23797@brightrain.aerifal.cx>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42969
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

On Mon, Oct 06, 2014 at 01:23:30PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> In order for MIPS to be able to support a non-executable stack, we
> need to supply a method to specify a userspace area that can be used
> for executing emulated branch delay slot instructions.
> 
> We add a new system call, sys_set_fpuemul_xol_area so that userspace
> threads that are using the FPU can specify the location of the FPU
> emulation out of line execution area.
> 
> Background:
> 
> MIPS floating point support requires that any instruction that cannot
> be directly executed by the FPU, be emulated by the kernel.  Part of
> this emulation involves executing non-FPU instructions that fall in
> the delay slots of FP branch instructions.  Since the beginning of
> MIPS/Linux time, this has been done by placing the instructions on the
> userspace thread stack, and executing them there, as the instructions
> must be executed in the MM context of the thread receiving the
> emulation.
> 
> Because of this, the de facto MIPS Linux userspace ABI requires that
> the userspace thread have an executable stack.  It is de facto,
> because it is not written anywhere that this must be the case, but it
> is never the less a requirement.
> 
> Problem:
> 
> How do we get MIPS Linux to use a non-executable stack in the face of
> the FPU emulation problem?
> 
> Since userspace desires to change the ABI, put some of the onus on the
> userspace code.  Any userspace thread desiring a non-executable stack,
> must allocate a 4-byte aligned area at least 8 bytes long with that
> has read/write/execute permissions and pass the address of that area
> to the kernel with the new sys_set_fpuemul_xol_area system call.
> 
> This is similar to how we require userspace to notify the kernel of
> the value of the thread local pointer.

Userspace should play no part in this; requiring userspace to help
make special accomodations for fpu emulation largely defeats the
purpose of fpu emulation. The kernel is perfectly capable of mapping
an appropriate page. The mapping should happen at exec time, and at
clone time with CLONE_VM unless the kernel is going to handle mutual
exclusion so that only one thread can be using the page at a time.
(Using one page for the whole process, and excluding simultaneous
execution of fpu emulation in multiple threads, may be the more
practical approach.)

As an alternative, if the space of possible instruction with a delay
slot is sufficiently small, all such instructions could be mapped as
immutable code in a shared mapping, each at a fixed offset in the
mapping. I suspect this would be borderline-impractical (multiple
megabytes?), but it is the cleanest solution otherwise.

Rich
