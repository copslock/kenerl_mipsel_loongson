Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2007 09:08:11 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:33425 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021637AbXKIJIJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Nov 2007 09:08:09 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA9988cB013181;
	Fri, 9 Nov 2007 09:08:08 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA997v3b013180;
	Fri, 9 Nov 2007 09:07:57 GMT
Date:	Fri, 9 Nov 2007 09:07:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Sharp <andy.sharp@onstor.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: gdb chokes on core from 64-bit kernel (patch)
Message-ID: <20071109090757.GA12469@linux-mips.org>
References: <20071108140322.7bf03aa9@ripper.onstor.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071108140322.7bf03aa9@ripper.onstor.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 08, 2007 at 02:03:22PM -0800, Andrew Sharp wrote:

> The gdb from debian etch (6.4.90-debian) doesn't like core files
> produced by 64-bit kernel it seems.  I've got this patch which seems
> to do the job, but I'm unclear on what other implications it might have,
> if any.

> diff --git a/arch/mips/kernel/binfmt_elfo32.c b/arch/mips/kernel/binfmt_elfo32.c
> index 993f7ec..58533dc 100644
> --- a/arch/mips/kernel/binfmt_elfo32.c
> +++ b/arch/mips/kernel/binfmt_elfo32.c
> @@ -54,9 +54,13 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
>  
>  #include <asm/processor.h>
>  #include <linux/module.h>
> -#include <linux/elfcore.h>
>  #include <linux/compat.h>
>  
> +void elf32_core_copy_regs(elf_gregset_t grp, struct pt_regs *regs);
> +#undef ELF_CORE_COPY_REGS
> +#define ELF_CORE_COPY_REGS(_dest,_regs) elf32_core_copy_regs(_dest,_regs);
> +#include <linux/elfcore.h>
> +
>  #define elf_prstatus elf_prstatus32
>  struct elf_prstatus32
>  {
> @@ -109,9 +113,6 @@ jiffies_to_compat_timeval(unsigned long jiffies, struct comp
>         value->tv_usec = rem / NSEC_PER_USEC;
>  }
>  
> -#undef ELF_CORE_COPY_REGS
> -#define ELF_CORE_COPY_REGS(_dest,_regs) elf32_core_copy_regs(_dest,_regs);
> -
>  void elf32_core_copy_regs(elf_gregset_t grp, struct pt_regs *regs)
>  {
>         int i;

Looks like it's a larger change than needed.

> diff --git a/include/asm-mips/reg.h b/include/asm-mips/reg.h
> index 634b55d..b44b308 100644
> --- a/include/asm-mips/reg.h
> +++ b/include/asm-mips/reg.h
> @@ -12,7 +12,7 @@
>  #ifndef __ASM_MIPS_REG_H
>  #define __ASM_MIPS_REG_H
>  
> -
> +#define WANT_COMPAT_REG_H
>  #if defined(CONFIG_32BIT) || defined(WANT_COMPAT_REG_H)
>  
>  #define EF_R0                  6
> @@ -69,7 +69,7 @@
>  
>  #endif
>  
> -#ifdef CONFIG_64BIT
> +#if defined(CONFIG_64BIT) && !defined(WANT_COMPAT_REG_H)
>  
>  #define EF_R0                   0
>  #define EF_R1                   1

This change breaks the native 64-bit and N32 ptrace and core dumpers.

I suggest something more minimal like the below patch.  Does that one do
the trick for you?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/kernel/ptrace32.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index 76818be..44109fb 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -14,6 +14,9 @@
  * At this time Linux/MIPS64 only supports syscall tracing, even for 32-bit
  * binaries.
  */
+
+#define WANT_COMPAT_REG_H
+
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
