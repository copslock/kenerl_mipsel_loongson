Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2015 22:44:52 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011357AbbGUUotx8LIF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jul 2015 22:44:49 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 284B740F;
        Tue, 21 Jul 2015 20:44:42 +0000 (UTC)
Date:   Tue, 21 Jul 2015 13:44:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Michal Hocko <mhocko@suse.cz>, Vlastimil Babka <vbabka@suse.cz>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and
 munlockall system calls
Message-Id: <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org>
In-Reply-To: <1437508781-28655-3-git-send-email-emunson@akamai.com>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
        <1437508781-28655-3-git-send-email-emunson@akamai.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Tue, 21 Jul 2015 15:59:37 -0400 Eric B Munson <emunson@akamai.com> wrote:

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

This is hard.  Maybe we shouldn't have wired up anything other than
x86.  That's what we usually do with new syscalls.

You appear to have missed
mm-mlock-add-new-mlock-munlock-and-munlockall-system-calls-fix.patch:

--- a/arch/arm64/include/asm/unistd.h~mm-mlock-add-new-mlock-munlock-and-munlockall-system-calls-fix
+++ a/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE+2)
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE+5)
 
-#define __NR_compat_syscalls		388
+#define __NR_compat_syscalls		391
 #endif
 
 #define __ARCH_WANT_SYS_CLONE


And mm-mlock-add-new-mlock-munlock-and-munlockall-system-calls-fix-2.patch:


From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: mm-mlock-add-new-mlock-munlock-and-munlockall-system-calls-fix-2

can we just remove the s390 bits which cause the breakage?
I will wire up the syscalls as soon as the patch set gets merged.

Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Eric B Munson <emunson@akamai.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/s390/kernel/syscalls.S |    3 ---
 1 file changed, 3 deletions(-)

diff -puN arch/s390/kernel/syscalls.S~mm-mlock-add-new-mlock-munlock-and-munlockall-system-calls-fix-2 arch/s390/kernel/syscalls.S
--- a/arch/s390/kernel/syscalls.S~mm-mlock-add-new-mlock-munlock-and-munlockall-system-calls-fix-2
+++ a/arch/s390/kernel/syscalls.S
@@ -363,6 +363,3 @@ SYSCALL(sys_bpf,compat_sys_bpf)
 SYSCALL(sys_s390_pci_mmio_write,compat_sys_s390_pci_mmio_write)
 SYSCALL(sys_s390_pci_mmio_read,compat_sys_s390_pci_mmio_read)
 SYSCALL(sys_execveat,compat_sys_execveat)
-SYSCALL(sys_mlock2,compat_sys_mlock2)			/* 355 */
-SYSCALL(sys_munlock2,compat_sys_munlock2)
-SYSCALL(sys_munlockall2,compat_sys_munlockall2)
