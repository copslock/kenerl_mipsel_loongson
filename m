Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 08:46:19 +0200 (CEST)
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:56646 "EHLO
        e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009059AbbGHGqQrJFjL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2015 08:46:16 +0200
Received: from /spool/local
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <heiko.carstens@de.ibm.com>;
        Wed, 8 Jul 2015 07:46:11 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp13.uk.ibm.com (192.168.101.143) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 8 Jul 2015 07:46:09 +0100
X-Helo: d06dlp03.portsmouth.uk.ibm.com
X-MailFrom: heiko.carstens@de.ibm.com
X-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 90EEC1B0806E
        for <linux-mips@linux-mips.org>; Wed,  8 Jul 2015 07:47:19 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t686k8sn24510646
        for <linux-mips@linux-mips.org>; Wed, 8 Jul 2015 06:46:08 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t686k7Mx011517
        for <linux-mips@linux-mips.org>; Wed, 8 Jul 2015 00:46:08 -0600
Received: from localhost (dyn-9-152-212-54.boeblingen.de.ibm.com [9.152.212.54])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t686k7Et011514;
        Wed, 8 Jul 2015 00:46:07 -0600
Date:   Wed, 8 Jul 2015 08:46:07 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V3 2/5] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
Message-ID: <20150708064607.GB7079@osiris>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
 <1436288623-13007-3-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1436288623-13007-3-git-send-email-emunson@akamai.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15070806-0013-0000-0000-0000049D734A
Return-Path: <heiko.carstens@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko.carstens@de.ibm.com
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

On Tue, Jul 07, 2015 at 01:03:40PM -0400, Eric B Munson wrote:
> With the refactored mlock code, introduce new system calls for mlock,
> munlock, and munlockall.  The new calls will allow the user to specify
> what lock states are being added or cleared.  mlock2 and munlock2 are
> trivial at the moment, but a follow on patch will add a new mlock state
> making them useful.
> 
> munlock2 addresses a limitation of the current implementation.  If a
> user calls mlockall(MCL_CURRENT | MCL_FUTURE) and then later decides
> that MCL_FUTURE should be removed, they would have to call munlockall()
> followed by mlockall(MCL_CURRENT) which could potentially be very
> expensive.  The new munlockall2 system call allows a user to simply
> clear the MCL_FUTURE flag.
> 
> Signed-off-by: Eric B Munson <emunson@akamai.com>

...

> diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
> index 1acad02..f6d81d6 100644
> --- a/arch/s390/kernel/syscalls.S
> +++ b/arch/s390/kernel/syscalls.S
> @@ -363,3 +363,6 @@ SYSCALL(sys_bpf,compat_sys_bpf)
>  SYSCALL(sys_s390_pci_mmio_write,compat_sys_s390_pci_mmio_write)
>  SYSCALL(sys_s390_pci_mmio_read,compat_sys_s390_pci_mmio_read)
>  SYSCALL(sys_execveat,compat_sys_execveat)
> +SYSCALL(sys_mlock2,compat_sys_mlock2)			/* 355 */
> +SYSCALL(sys_munlock2,compat_sys_munlock2)
> +SYSCALL(sys_munlockall2,compat_sys_munlockall2)

FWIW, you would also need to add matching lines to the two files

arch/s390/include/uapi/asm/unistd.h
arch/s390/kernel/compat_wrapper.c

so that the system call would be wired up on s390.
