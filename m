Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2014 16:04:21 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:62768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816383AbaDCOES1cckM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Apr 2014 16:04:18 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s33E4EXG029929
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 3 Apr 2014 10:04:14 -0400
Received: from flatline.rdu.redhat.com (flatline.rdu.redhat.com [10.13.136.20])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s33E4DWk014024;
        Thu, 3 Apr 2014 10:04:13 -0400
Message-ID: <1396533853.24733.33.camel@flatline.rdu.redhat.com>
Subject: Re: [RESEND PATCH 1/2] MIPS syscall auditing patches
From:   Eric Paris <eparis@redhat.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     linux-audit@redhat.com, Steve Grubb <sgrubb@redhat.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Date:   Thu, 03 Apr 2014 10:04:13 -0400
In-Reply-To: <1396433596-612624-2-git-send-email-manuel.lauss@gmail.com>
References: <1396433596-612624-1-git-send-email-manuel.lauss@gmail.com>
         <1396433596-612624-2-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <eparis@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eparis@redhat.com
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

On Wed, 2014-04-02 at 12:13 +0200, Manuel Lauss wrote:
> From: Ralf Baechle <ralf@linux-mips.org>
> 
> this is the first cut of the MIPS auditing patches.  MIPS doesn't quite
> fit into the existing pattern of other architectures and I'd appreciate
> your comments and maybe even an Acked-by.
> 
>  - MIPS syscalls return a success / error flag in register $7.  If the
>    flag is set then the return value in $2 is a *positive* error value.
>    This means the existing AUDITSC_RESULT() macro does not work on
>    MIPS and thus ptrace.c defines it's own version MIPS_AUDITSC_RESULT().

This is not needed (and not used by your patch).  The kernel uses a
combination of is_syscall_success(), regs_return_value(), and
syscall_get_arch().  The first 2 look good, the third looks like it
needs to be reworked a little....

>  - Linux on MIPS extends the traditional syscall table used by older UNIX
>    implementations.  This is why 32-bit Linux syscalls are starting from
>    4000; the native 64-bit syscalls start from 5000 and the N32 compat ABI
>    from 6000.  The existing syscall bitmap is only large enough for at most
>    2048 syscalls, so I had to increase AUDIT_BITMASK_SIZE to 256 which
>    provides enough space for 8192 syscalls.  Because include/linux/audit.h
>    and AUDIT_BITMASK_SIZE are exported to userspace I've used an #ifdef
>    __mips__ for this.

Seems like we have little/no other choice.

>  - I've introduced a flag __AUDIT_ARCH_ALT to indicate an alternative ABI.
>    The name of the flag is intentionally very generic to make the name
>    hopefully fit other architectures' eventual need as well.  On MIPS it
>    indicates the 3rd ABI known as N32.

Sounds about as good as we can do.

>  - To make matters worse, most MIPS processors can be configured to be
>    big or little endian.  Traditionally the the 64-bit little endian
>    configuration is named mips64el, so I've changed references to MIPSEL64
>    in audit.h to MIPS64EL.

Feel free to change it.  We can put the old name back if someone was
potentially using it...

>  - The code treats the little endian MIPS architecture as separate from
>    big endian.  Combined with the 3 ABIs that's 6 combinations.  I tried
>    to sort of follow the example set by ARM which explicitly lists the
>    (rare) big endian architecture variant - but it doesn't seem to very
>    useful so I wonder if this could be squashed to just the three ABIs
>    without consideration of endianess?

Yes, squash.  Assuming the syscall table is the exact same, we don't
actually care.  We send info to userspace in string order, not
endianness order, so it doesn't matter...

>  - Talking about flags; I've defined the the N32 architecture flags were defined
> 
>     #define AUDIT_ARCH_MIPS64_N32  (EM_MIPS|__AUDIT_ARCH_ALT)
>     #define AUDIT_ARCH_MIPS64EL_N32 (EM_MIPS|__AUDIT_ARCH_ALT|__AUDIT_ARCH_LE
> 
>     N32 is a 32-bit ABI but one that only runs on 64-bit processors as it
>     uses 64-bit registers for 64-bit integers.  So I'm uncertain if the
>     __AUDIT_ARCH_64BIT flags should be set or not.

As long as AUDIT_ARCH_MIPS64EL_N32 is uniquely identifiable you are
fine.  I'm assuming the syscall arguments are 64bit long.  So lets just
call it a 64BIT arch...
