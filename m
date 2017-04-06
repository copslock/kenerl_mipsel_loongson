Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 19:38:53 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:47714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993411AbdDFRiq4mTOm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Apr 2017 19:38:46 +0200
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65A2DC04BD3F;
        Thu,  6 Apr 2017 17:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 65A2DC04BD3F
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=rkrcmar@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 65A2DC04BD3F
Received: from potion (dhcp-1-208.brq.redhat.com [10.34.1.208])
        by smtp.corp.redhat.com (Postfix) with SMTP id 32F295C884;
        Thu,  6 Apr 2017 17:38:35 +0000 (UTC)
Received: by potion (sSMTP sendmail emulation); Thu, 06 Apr 2017 19:38:34 +0200
Date:   Thu, 6 Apr 2017 19:38:34 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [GIT PULL] KVM: MIPS: VZ support, Octeon III, and TLBR
Message-ID: <20170406173833.GB23559@potion>
References: <20170406082754.GP31606@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406082754.GP31606@jhogan-linux.le.imgtec.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 06 Apr 2017 17:38:39 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

2017-04-06 09:27+0100, James Hogan:
> Hi Paolo, Radim,
> 
> Here are the main KVM MIPS changes for 4.12, mainly to add VZ support.
> Please consider pulling.

Pulled, thanks.  The capability numbers 137-139 are now set in stone.

> Thanks
> James
> 
> The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:
> 
>   Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git tags/kvm_mips_4.12_1
> 
> for you to fetch changes up to dc44abd6aad22411f7f9890e39fd4753dabf0d03:
> 
>   KVM: MIPS/Emulate: Properly implement TLBR for T&E (2017-03-28 16:31:37 +0100)
> 
> ----------------------------------------------------------------
> KVM: MIPS: VZ support, Octeon III, and TLBR
> 
> Add basic support for the MIPS Virtualization Module (generally known as
> MIPS VZ) in KVM. We primarily support the ImgTec P5600, P6600, I6400,
> and Cavium Octeon III cores so far. Support is included for the
> following VZ / guest hardware features:
> - MIPS32 and MIPS64, r5 (VZ requires r5 or later) and r6
> - TLBs with GuestID (IMG cores) or Root ASID Dealias (Octeon III)
> - Shared physical root/guest TLB (IMG cores)
> - FPU / MSA
> - Cop0 timer (up to 1GHz for now due to soft timer limit)
> - Segmentation control (EVA)
> - Hardware page table walker (HTW) both for root and guest TLB
> 
> Also included is a proper implementation of the TLBR instruction for the
> trap & emulate MIPS KVM implementation.
> 
> Preliminary MIPS architecture changes are applied directly with Ralf's
> ack.
> 
> ----------------------------------------------------------------
> James Hogan (42):
>       MIPS: Add defs & probing of UFR
>       MIPS: Separate MAAR V bit into VL and VH for XPA
>       MIPS: Probe guest CP0_UserLocal
>       MIPS: Probe guest MVH
>       MIPS: Add some missing guest CP0 accessors & defs
>       MIPS: asm/tlb.h: Add UNIQUE_GUEST_ENTRYHI() macro
>       KVM: MIPS: Implement HYPCALL emulation
>       KVM: MIPS/Emulate: De-duplicate MMIO emulation
>       KVM: MIPS/Emulate: Implement 64-bit MMIO emulation
>       KVM: MIPS: Update kvm_lose_fpu() for VZ
>       KVM: MIPS: Extend counters & events for VZ GExcCodes
>       KVM: MIPS: Add VZ & TE capabilities
>       KVM: MIPS: Add 64BIT capability
>       KVM: MIPS: Init timer frequency from callback
>       KVM: MIPS: Add callback to check extension
>       KVM: MIPS: Add hardware_{enable,disable} callback
>       KVM: MIPS: Add guest exit exception callback
>       KVM: MIPS: Abstract guest CP0 register access for VZ
>       KVM: MIPS/Entry: Update entry code to support VZ
>       KVM: MIPS/TLB: Add VZ TLB management
>       KVM: MIPS/Emulate: Update CP0_Compare emulation for VZ
>       KVM: MIPS/Emulate: Drop CACHE emulation for VZ
>       KVM: MIPS: Update exit handler for VZ
>       KVM: MIPS: Implement VZ support
>       KVM: MIPS: Add VZ support to build system
>       KVM: MIPS/VZ: Support guest CP0_BadInstr[P]
>       KVM: MIPS/VZ: Support guest CP0_[X]ContextConfig
>       KVM: MIPS/VZ: Support guest segmentation control
>       KVM: MIPS/VZ: Support guest hardware page table walker
>       KVM: MIPS/VZ: Support guest load-linked bit
>       KVM: MIPS/VZ: Emulate MAARs when necessary
>       KVM: MIPS/VZ: Support hardware guest timer
>       KVM: MIPS/VZ: Trace guest mode changes
>       MIPS: Add Octeon III register accessors & definitions
>       KVM: MIPS/Emulate: Adapt T&E CACHE emulation for Octeon
>       KVM: MIPS/TLB: Handle virtually tagged icaches
>       KVM: MIPS/T&E: Report correct dcache line size
>       KVM: MIPS/VZ: VZ hardware setup for Octeon III
>       KVM: MIPS/VZ: Emulate hit CACHE ops for Octeon III
>       KVM: MIPS/VZ: Handle Octeon III guest.PRid register
>       MIPS: Allow KVM to be enabled on Octeon CPUs
>       KVM: MIPS/Emulate: Properly implement TLBR for T&E
> 
>  Documentation/virtual/kvm/api.txt        |   90 +-
>  Documentation/virtual/kvm/hypercalls.txt |    5 +
>  arch/mips/Kconfig                        |    1 +
>  arch/mips/include/asm/cpu-features.h     |   10 +
>  arch/mips/include/asm/cpu-info.h         |    2 +
>  arch/mips/include/asm/cpu.h              |    1 +
>  arch/mips/include/asm/kvm_host.h         |  467 ++++-
>  arch/mips/include/asm/maar.h             |   10 +-
>  arch/mips/include/asm/mipsregs.h         |   62 +-
>  arch/mips/include/asm/tlb.h              |    6 +-
>  arch/mips/include/uapi/asm/inst.h        |    2 +-
>  arch/mips/include/uapi/asm/kvm.h         |   20 +-
>  arch/mips/kernel/cpu-probe.c             |   13 +-
>  arch/mips/kernel/time.c                  |    1 +
>  arch/mips/kvm/Kconfig                    |   27 +-
>  arch/mips/kvm/Makefile                   |    9 +-
>  arch/mips/kvm/emulate.c                  |  500 +++--
>  arch/mips/kvm/entry.c                    |  132 +-
>  arch/mips/kvm/hypcall.c                  |   53 +
>  arch/mips/kvm/interrupt.h                |    5 +
>  arch/mips/kvm/mips.c                     |  120 +-
>  arch/mips/kvm/mmu.c                      |   20 +
>  arch/mips/kvm/tlb.c                      |  441 ++++
>  arch/mips/kvm/trace.h                    |   74 +-
>  arch/mips/kvm/trap_emul.c                |   73 +-
>  arch/mips/kvm/vz.c                       | 3223 ++++++++++++++++++++++++++++++
>  arch/mips/mm/cache.c                     |    1 +
>  arch/mips/mm/init.c                      |    2 +-
>  include/uapi/linux/kvm.h                 |    7 +
>  29 files changed, 5010 insertions(+), 367 deletions(-)
>  create mode 100644 arch/mips/kvm/hypcall.c
>  create mode 100644 arch/mips/kvm/vz.c
