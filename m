Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Oct 2010 16:23:30 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52834 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491082Ab0JMOX1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Oct 2010 16:23:27 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9DENOCH010636;
        Wed, 13 Oct 2010 15:23:24 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9DENNEw010634;
        Wed, 13 Oct 2010 15:23:23 +0100
Date:   Wed, 13 Oct 2010 15:23:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Make TASK_SIZE reflect proper size for both 32 and
 64 bit processes.
Message-ID: <20101013142323.GE29127@linux-mips.org>
References: <1286917316-15849-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1286917316-15849-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 12, 2010 at 02:01:56PM -0700, David Daney wrote:

> The TASK_SIZE macro should reflect the size of a user process virtual
> address space.  Previously for 64-bit kernels, this was not the case.
> The immediate cause of pain was in
> hugetlbfs/inode.c:hugetlb_get_unmapped_area() where 32-bit processes
> trying to mmap a huge page would be served a page with an address
> outside of the 32-bit address range.  But there are other uses of
> TASK_SIZE in the kernel as well that would like an accurate value.
> 
> The new definition is nice because it now makes TASK_SIZE and
> TASK_SIZE_OF() yield the same value for any given process.
> 
> For 32-bit kernels there should be no change, although I did factor
> out some code in asm/processor.h that became identical for the 32-bit and
> 64-bit cases.
> 
> Another, perhaps non-obvious, change is that in 64-bit kernels, the
> get_fs() value (A.K.A current_thread_info()->addr_limit) will now vary
> depending on the address space size of the process.  This is a change,
> as previously even 32-bit processes would have an addr_limit
> appropriate for a 64-bit process.  This will change the behavior of
> access_ok(), but I think the new behavior is desirable.
> 
> Before the patch it may have been possible for a user space process to
> pass a pointer to the kernel that would pass the access_ok() check,
> but be outside of the 32-bit address space.

That was intensional.  The sole purpose of the access_ok check is to prevent
users from passing kernel addresses to syscalls.  Beyond that we absolutely
don't care.  The creation of mappings above 0x7fff8000 is prevented in the
syscalls themselves but even if that's mechanism should have a hole that
is not a problem for uaccess.h - the protection of the kernel will hold.

  Ralf
