Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 00:34:44 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38745 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007349AbbBZXemOly2Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 00:34:42 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9E872B0B;
        Thu, 26 Feb 2015 23:34:35 +0000 (UTC)
Date:   Thu, 26 Feb 2015 15:34:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Hector Marco Gisbert <hecmargi@upv.es>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ismael Ripoll <iripoll@upv.es>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org\" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linuxppc-dev@lists.ozlabs.org"@localhost.localdomain
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
Message-Id: <20150226153435.df670671fb10eb9efa0fa845@linux-foundation.org>
In-Reply-To: <20150227102136.17ef1fe6@canb.auug.org.au>
References: <54EB735F.5030207@upv.es>
        <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
        <20150223205436.15133mg1kpyojyik@webmail.upv.es>
        <20150224073906.GA16422@gmail.com>
        <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
        <20150227102136.17ef1fe6@canb.auug.org.au>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46019
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

On Fri, 27 Feb 2015 10:21:36 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > +/* Not all architectures implement mmap_rnd() */
> > +unsigned long __weak mmap_rnd(void)
> > +{
> > +}
> > +
> > +/*
> > + * Not all architectures use randomize_et_dyn(), so use __weak to let the
> > + * linker omit it from vmlinux
> > + */
> > +unsigned long __weak randomize_et_dyn(unsigned long base)
> > +{
> > +	unsigned long ret;
> > +
> > +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> > +		!(current->flags & PF_RANDOMIZE))
> > +		return base;
> > +	ret = base + mmap_rnd();
> > +	return max(ret, base);
> > +}
> > +
> 
> Didn't we have some trouble with some compilers when the weak function
> (mmap_rnd) was defined and used in the same file i.e. the wrong one was
> used?

I have vague memories, but I forget the details.

This sucks anyway - let's do it properly.

I'm just flinging together trollpatches here.  Someone please review,
test and fix this stuff.  Kees?

diff -puN arch/arm/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2 arch/arm/Kconfig
--- a/arch/arm/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2
+++ a/arch/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAVE_ELF_ASLR
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_USE_BUILTIN_BSWAP
diff -puN arch/arm64/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2 arch/arm64/Kconfig
--- a/arch/arm64/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2
+++ a/arch/arm64/Kconfig
@@ -9,6 +9,7 @@ config ARM64
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_HAVE_ELF_ASLR
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
 	select ARM_GIC
diff -puN arch/mips/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2 arch/mips/Kconfig
--- a/arch/mips/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2
+++ a/arch/mips/Kconfig
@@ -39,6 +39,7 @@ config MIPS
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select ARCH_DISCARD_MEMBLOCK
+	select ARCH_HAVE_ELF_ASLR
 	select GENERIC_SMP_IDLE_THREAD
 	select BUILDTIME_EXTABLE_SORT
 	select GENERIC_CLOCKEVENTS
diff -puN arch/powerpc/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2 arch/powerpc/Kconfig
--- a/arch/powerpc/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2
+++ a/arch/powerpc/Kconfig
@@ -97,6 +97,7 @@ config PPC
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select SYSCTL_EXCEPTION_TRACE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARCH_HAVE_ELF_ASLR
 	select VIRT_TO_BUS if !PPC64
 	select HAVE_IDE
 	select HAVE_IOREMAP_PROT
diff -puN arch/x86/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2 arch/x86/Kconfig
--- a/arch/x86/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2
+++ a/arch/x86/Kconfig
@@ -28,6 +28,7 @@ config X86
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_HAVE_ELF_ASLR
 	select HAVE_AOUT if X86_32
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select ARCH_SUPPORTS_NUMA_BALANCING if X86_64
diff -puN fs/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2 fs/Kconfig
--- a/fs/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2
+++ a/fs/Kconfig
@@ -50,6 +50,9 @@ config FS_DAX
 
 endif # BLOCK
 
+config ARCH_HAVE_ELF_ASLR
+	bool
+
 # Posix ACL utility routines
 #
 # Note: Posix ACLs can be implemented without these helpers.  Never use
diff -puN fs/binfmt_elf.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2 fs/binfmt_elf.c
--- a/fs/binfmt_elf.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix-fix-2
+++ a/fs/binfmt_elf.c
@@ -2301,15 +2301,7 @@ out:
 
 #endif		/* CONFIG_ELF_CORE */
 
-/* Not all architectures implement mmap_rnd() */
-unsigned long __weak mmap_rnd(void)
-{
-}
-
-/*
- * Not all architectures use randomize_et_dyn(), but there doesn't seem to be
- * a compile-time way of avoiding its generation.
- */
+#ifdef ARCH_HAVE_ELF_ASLR
 unsigned long randomize_et_dyn(unsigned long base)
 {
 	unsigned long ret;
@@ -2320,6 +2312,7 @@ unsigned long randomize_et_dyn(unsigned
 	ret = base + mmap_rnd();
 	return max(ret, base);
 }
+#endif
 
 static int __init init_elf_binfmt(void)
 {
_
