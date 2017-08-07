Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 11:41:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45308 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991087AbdHGJld4oWRn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Aug 2017 11:41:33 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v779fX5b023753;
        Mon, 7 Aug 2017 11:41:33 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v779fXpb023752;
        Mon, 7 Aug 2017 11:41:33 +0200
Date:   Mon, 7 Aug 2017 11:41:32 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, "Maciej W . Rozycki" <macro@imgtec.com>
Subject: Re: [PATCH v2 5/5] MIPS: Allow floating point support to be disabled
Message-ID: <20170807094132.GA23183@linux-mips.org>
References: <alpine.DEB.2.00.1706162029030.23046@tp.orcam.me.uk>
 <20170616202120.18435-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170616202120.18435-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59388
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

On Fri, Jun 16, 2017 at 01:21:20PM -0700, Paul Burton wrote:

> Floating point support has up until now always been included in all MIPS
> kernels. On systems that will run exclusively soft-float code this means
> the kernel includes a considerable amount of code which will never be
> executed.
> 
> This patch introduces a Kconfig option to disable floating point support
> in the kernel. Doing so will result in a kernel that never enables an
> FPU for userland, and that always responds to use of floating point
> instructions with SIGILL. With a maltasmvp_defconfig kernel this shaves
> ~65KiB from the size of the kernel binary.
> 
> Further optimisations would be possible, for example removing the FP &
> MSA vector context from struct thread_struct when FP support is
> disabled, and compiling out the code that provides access to that
> through ptrace. Such changes are more invasive than those in this patch
> however, so they're left as potential later work.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> 
> ---
> 
> Changes in v2:
> - Have ptrace return -EIO for access to FP context.
> - Avoid cpu_set_fpu_opts(), fixing boot of a CONFIG_FP_SUPPORT=n kernel on a system that actually does have an FPU.
> 
>  arch/mips/Kconfig                    | 26 +++++++++++++++++++++++---
>  arch/mips/Makefile                   |  2 +-
>  arch/mips/include/asm/cpu-features.h | 11 ++++++++---
>  arch/mips/include/asm/dsemul.h       | 34 ++++++++++++++++++++++++++++++++++
>  arch/mips/include/asm/fpu.h          |  3 +++
>  arch/mips/include/asm/fpu_emulator.h | 16 ++++++++++++++++
>  arch/mips/kernel/Makefile            |  3 +--
>  arch/mips/kernel/cpu-probe.c         |  2 +-
>  arch/mips/kernel/process.c           |  8 ++++++++
>  arch/mips/kernel/ptrace.c            | 33 +++++++++++++++++++++++++++++++++
>  arch/mips/kernel/ptrace32.c          | 20 ++++++++++++++++++++
>  11 files changed, 148 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 20958af88522..c6255acd6d99 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2227,9 +2227,29 @@ config CPU_GENERIC_DUMP_TLB
>  	bool
>  	default y if !(CPU_R3000 || CPU_R8000 || CPU_TX39XX)
>  
> +config FP_SUPPORT
> +	bool "Floating Point Support"
> +	default y
> +	help
> +	  Select this to enable support for programs which make use of floating
> +	  point instructions. This allows the kernel to support initialising, context
> +	  switching & emulating the Floating Point Unit (FPU) in order to allow such
> +	  programs to execute correctly.
> +
> +	  If you disable this then any program which attempts to execute a floating
> +	  point instruction will receive a SIGILL signal & is likely to fail.
> +
> +	  If in doubt, say Y.

In the dark past FP support was optional and people with FPUs were
machinegunning theselves into both feet resulting in an endless stream
of bug reports for years and no amount of documentation was able to solve
that issue.

I've applied the other parts of your series but please change this one
so platforms use a "select FP_SUPPORT" to non-interactively enable FPU
support then throw in a bunch of these selects to cover all CPUs from
the SYS_HAS_CPU_* statements and platforms.  R2000 and R3000 I think were
always used together with the R2010/R3010 FPUs, most later R-series CPUs
had FPUs.  The MTI synthesizable cores starting from 4K and 5k are more
complicated because for most of them FP was an optional feature, so
the SOC and platform config statements can drive that.

Or we simply make the kernel panic when it detects an FPU but has no
FPU support?

  Ralf
