Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2014 11:33:07 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51049 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6816676AbaDCJdFia-e7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Apr 2014 11:33:05 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s339X0MZ006460;
        Thu, 3 Apr 2014 11:33:00 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s339Wvv9006451;
        Thu, 3 Apr 2014 11:32:57 +0200
Date:   Thu, 3 Apr 2014 11:32:57 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Richard Guy Briggs <rgb@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>, linux-audit@redhat.com,
        Steve Grubb <sgrubb@redhat.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [RESEND PATCH 1/2] MIPS syscall auditing patches
Message-ID: <20140403093257.GO17197@linux-mips.org>
References: <1396433596-612624-1-git-send-email-manuel.lauss@gmail.com>
 <1396433596-612624-2-git-send-email-manuel.lauss@gmail.com>
 <20140402155519.GA749@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140402155519.GA749@madcap2.tricolour.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Apr 02, 2014 at 11:56:23AM -0400, Richard Guy Briggs wrote:

(Adding dwmw2 who might give some insight on the purpose of __AUDIT_ARCH_LE
to cc.)

> > this is the first cut of the MIPS auditing patches.  MIPS doesn't quite
> > fit into the existing pattern of other architectures and I'd appreciate
> > your comments and maybe even an Acked-by.
> > 
> >  - MIPS syscalls return a success / error flag in register $7.  If the
> >    flag is set then the return value in $2 is a *positive* error value.
> >    This means the existing AUDITSC_RESULT() macro does not work on
> >    MIPS and thus ptrace.c defines it's own version MIPS_AUDITSC_RESULT().
> > 
> >  - Linux on MIPS extends the traditional syscall table used by older UNIX
> >    implementations.  This is why 32-bit Linux syscalls are starting from
> >    4000; the native 64-bit syscalls start from 5000 and the N32 compat ABI
> >    from 6000.  The existing syscall bitmap is only large enough for at most
> >    2048 syscalls, so I had to increase AUDIT_BITMASK_SIZE to 256 which
> >    provides enough space for 8192 syscalls.  Because include/linux/audit.h
> >    and AUDIT_BITMASK_SIZE are exported to userspace I've used an #ifdef
> >    __mips__ for this.
> 
> Is this really necessary?  I don't have any background on the choice of
> syscall numbers on MIPS.
> 
> Instead of 4000, 5000, and 6000, could it not have used 500, 1000, 1500
> as base numbers given that there are 350 syscalls?

And when those numbers were chosen Linux had half as many syscalls!

The choice is due to RISC/os which used the same values for it's 4 ABIs.
Linux reserved those 4 × 1000 syscall slots to allow a compatibility mode
to be implemented (which never happened) and extended the scheme with
native 32 bit calls starting at 4000 and a few years later native 64 bit
calls at 5000 and N32 calls at 6000.

If it was me I'd have offset the syscalls by 1024 which would have sped
up and simplified a few things.  Or totally different - but for a long
time risc/OS rsp. IRIX were the de facto standards being followed for such
kernel interface details.

> >  - I've introduced a flag __AUDIT_ARCH_ALT to indicate an alternative ABI.
> >    The name of the flag is intentionally very generic to make the name
> >    hopefully fit other architectures' eventual need as well.  On MIPS it
> >    indicates the 3rd ABI known as N32.
> 
> Is N32 sufficiently different from the concept of "compat" that that
> could not be used?  Does the behaviour of 64-bit integers prevent this?

N32 is a 32 bit ABI - but one that requires a 64 bit processor as it
uses 64 bit integer registers.  So in that aspect it's a 64 bit ABI.
However N32's address space is still 32 bit only that is for exapmle all
structures that contain addresses are using the 32 bit definition; also
its pointeger and long integers are 32 bit.  That also means that not
even all the syscalls are identical to either O32 or N64.

> >  - To make matters worse, most MIPS processors can be configured to be
> >    big or little endian.  Traditionally the the 64-bit little endian
> >    configuration is named mips64el, so I've changed references to MIPSEL64
> >    in audit.h to MIPS64EL.
> > 
> >  - The code treats the little endian MIPS architecture as separate from
> >    big endian.  Combined with the 3 ABIs that's 6 combinations.  I tried
> >    to sort of follow the example set by ARM which explicitly lists the
> >    (rare) big endian architecture variant - but it doesn't seem to very
> >    useful so I wonder if this could be squashed to just the three ABIs
> >    without consideration of endianess?
> 
> In ARM's case, endian-ness doesn't affect the ABI, from what I
> understand.

There's probably the odd bitfield or similar where it might matter?  I
did dig a bit in the history of the auditing code and found no code that
uses __AUDIT_ARCH_LE other than setting that flag.

David - you introduced __AUDIT_ARCH_LE in kernel commit 2fd6f58ba6e
"[AUDIT] Don't allow ptrace to fool auditing, log arch of audited syscalls."
on April 29 2005.  Do you still recall the purpose of this flag?

> >  - Talking about flags; I've defined the the N32 architecture flags were defined
> > 
> >     #define AUDIT_ARCH_MIPS64_N32  (EM_MIPS|__AUDIT_ARCH_ALT)
> >     #define AUDIT_ARCH_MIPS64EL_N32 (EM_MIPS|__AUDIT_ARCH_ALT|__AUDIT_ARCH_LE
> > 
> >     N32 is a 32-bit ABI but one that only runs on 64-bit processors as it
> >     uses 64-bit registers for 64-bit integers.  So I'm uncertain if the
> >     __AUDIT_ARCH_64BIT flags should be set or not.
> 
> I would guess it should, but I am no expert.

Steve?

  Ralf
