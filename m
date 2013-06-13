Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 11:00:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55741 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827526Ab3FMJAMvU00p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Jun 2013 11:00:12 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5D907mf008989;
        Thu, 13 Jun 2013 11:00:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5D903VH008987;
        Thu, 13 Jun 2013 11:00:03 +0200
Date:   Thu, 13 Jun 2013 11:00:02 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org, sanjayl@kymasys.com,
        kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: Commit f9afbd45b0d0 broke mips r4k.
Message-ID: <20130613090002.GD7422@linux-mips.org>
References: <1371090916.2776.104@driftwood>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371090916.2776.104@driftwood>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36847
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

On Wed, Jun 12, 2013 at 09:35:16PM -0500, Rob Landley wrote:

> My aboriginal linux project builds tiny linux systems to run under
> qemu, producing as close to the same system as possible across a
> bunch of different architectures. The above change broke the mips
> r4k build I've been running under qemu.
> 
> Here's a toolchain and reproduction sequence:
> 
>   wget http://landley.net/aboriginal/bin/cross-compiler-mips.tar.bz2
>   tar xvjf cross-compiler-mips.tar.bz2
>   export PATH=$PWD/cross-compiler-mips/bin:$PATH
>   make ARCH=mips allnoconfig KCONFIG_ALLCONFIG=miniconfig.mips
>   make CROSS_COMPILE=mips- ARCH=mips
> 
> (The file miniconfig.mips is attached.)
> 
> It ends:
> 
>   CC      init/version.o
>   LD      init/built-in.o
> arch/mips/built-in.o: In function `local_r4k_flush_cache_page':
> c-r4k.c:(.text+0xe278): undefined reference to `kvm_local_flush_tlb_all'
> c-r4k.c:(.text+0xe278): relocation truncated to fit: R_MIPS_26
> against `kvm_local_flush_tlb_all'
> arch/mips/built-in.o: In function `local_flush_tlb_range':
> (.text+0xe938): undefined reference to `kvm_local_flush_tlb_all'
> arch/mips/built-in.o: In function `local_flush_tlb_range':
> (.text+0xe938): relocation truncated to fit: R_MIPS_26 against
> `kvm_local_flush_tlb_all'
> arch/mips/built-in.o: In function `local_flush_tlb_mm':
> (.text+0xed38): undefined reference to `kvm_local_flush_tlb_all'
> arch/mips/built-in.o: In function `local_flush_tlb_mm':
> (.text+0xed38): relocation truncated to fit: R_MIPS_26 against
> `kvm_local_flush_tlb_all'
> kernel/built-in.o: In function `__schedule':
> core.c:(.sched.text+0x16a0): undefined reference to
> `kvm_local_flush_tlb_all'
> core.c:(.sched.text+0x16a0): relocation truncated to fit: R_MIPS_26
> against `kvm_local_flush_tlb_all'
> mm/built-in.o: In function `use_mm':
> (.text+0x182c8): undefined reference to `kvm_local_flush_tlb_all'
> mm/built-in.o: In function `use_mm':
> (.text+0x182c8): relocation truncated to fit: R_MIPS_26 against
> `kvm_local_flush_tlb_all'
> fs/built-in.o:(.text+0x7b50): more undefined references to
> `kvm_local_flush_tlb_all' follow
> fs/built-in.o: In function `flush_old_exec':
> (.text+0x7b50): relocation truncated to fit: R_MIPS_26 against
> `kvm_local_flush_tlb_all'
> 
> Revert the above commit and it builds to the end.

Commit d414976d1ca721456f7b7c603a8699d117c2ec07 [MIPS: include:
mmu_context.h: Replace VIRTUALIZATION with KVM] fixes the issue and
was pulled by Linus only yesterday.  I cannot reproduce the error
following your receipe using the latest Linux/MIPS tree.

  Ralf
