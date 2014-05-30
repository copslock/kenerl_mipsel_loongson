Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 13:07:24 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:56330 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822107AbaE3LHV0J23t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 May 2014 13:07:21 +0200
Received: by mail-wi0-f177.google.com with SMTP id f8so906024wiw.4
        for <multiple recipients>; Fri, 30 May 2014 04:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AsGl3b+hLPSlWc7PGS0+Y+Sy+EV3BNm12yt0jgUWZzA=;
        b=oO3xKIJSKgU84cZ3LN9ZAYcOMm+T1P8kPu1I8Mxt14r8iTcydi8b/ChTLAOsucgzg6
         wO9QGNhgeC8IckazTUEQApKCH2t1mCjxM/pCh3Q8hVFSnqyReC5NuqiFFxLWUPUQop8J
         D356bzLvOXIPhoNuPWgCUd3zLJPJd4drNLO/OseebkmnQVtFvZV8PX7kElLmrhF5rOap
         HgpfzotMDFCChGMKbccOdqQv6fZ00ex70es8D+IuzQpuKHzZ+PirDddIGG5Ny/okNHJY
         gE4pETsvHnq2+gdQUk3E+wz0CD1ikE6DsJlo0m5SvieKNPA8ue7bkXfWt3ZLSkgjRCzE
         HPrg==
X-Received: by 10.194.84.101 with SMTP id x5mr20806916wjy.52.1401448036078;
        Fri, 30 May 2014 04:07:16 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-117-132-7.cust.vodafonedsl.it. [37.117.132.7])
        by mx.google.com with ESMTPSA id vc2sm9316226wjc.2.2014.05.30.04.07.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 May 2014 04:07:15 -0700 (PDT)
Message-ID: <53886661.80602@redhat.com>
Date:   Fri, 30 May 2014 13:07:13 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH v2 00/23] MIPS: KVM: Fixes and guest timer rewrite
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

Il 29/05/2014 11:16, James Hogan ha scritto:
> Here are a range of MIPS KVM T&E fixes, preferably for v3.16 but I know
> it's probably a bit late now. Changes are pretty minimal though since
> v1 so please consider. They can also be found on my kvm_mips_queue
> branch (and the kvm_mips_timer_v2 tag) here:
> git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git
>
> They originally served to allow it to work better on Ingenic XBurst
> cores which have some peculiarities which break non-portable assumptions
> in the MIPS KVM implementation (patches 1-4, 13).
>
> Fixing guest CP0_Count emulation to work without a running host
> CP0_Count (patch 13) however required a rewrite of the timer emulation
> code to use the kernel monotonic time instead, which needed doing anyway
> since basing it directly off the host CP0_Count was broken. Various bugs
> were fixed in the process (patches 10-12) and improvements made thanks to
> valuable feedback from Paolo Bonzini for the last QEMU MIPS/KVM patchset
> (patches 5-7, 15-16).
>
> Finally there are some misc cleanups which I did along the way (patches
> 17-23).
>
> Only the first patch (fixes MIPS KVM with 4K pages) is marked for
> stable. For KVM to work on XBurst it needs the timer rework which is a
> fairly complex change, so there's little point marking any of the XBurst
> specific changes for stable.
>
> All feedback welcome!
>
> Patches 1-4:
> 	Fix KVM/MIPS with 4K pages, missing RDHWR SYNCI (XBurst),
> 	unmoving CP0_Random (XBurst).
> Patches 5-9:
> 	Add EPC, Count, Compare, UserLocal, HWREna guest CP0 registers
> 	to KVM register ioctl interface.
> Patches 10-12:
> 	Fix a few potential races relating to timers.
> Patches 13-14:
> 	Rewrite guest timer emulation to use ktime_get().
> Patches 15-16:
> 	Add KVM virtual registers for controlling guest timer, including
> 	master timer disable, and timer frequency.
> Patches 17-23:
> 	Cleanups.
>
> Changes in v2 (tag:kvm_mips_timer_v2):
>  Patchset:
>  - Drop patch 4 "MIPS: KVM: Fix CP0_EBASE KVM register id" (David
>    Daney).
>  - Drop patch 14 "MIPS: KVM: Add nanosecond count bias KVM register".
>    The COUNT_CTL and COUNT_RESUME API is clean and sufficient.
>  - Add missing access to UserLocal and HWREna guest CP0 registers
>    (patches 15 and 16).
>  - Add export of local_flush_icache_range (patch 2).
>  Patch 12 MIPS: KVM: Migrate hrtimer to follow VCPU
>  - Move kvm_mips_migrate_count() into kvm_tlb.c to fix a link error when
>    KVM is built as a module, since kvm_tlb.c is built statically and
>    cannot reference symbols in kvm_mips_emul.c.
>  Patch 15 MIPS: KVM: Add master disable count interface
>  - Make KVM_REG_MIPS_COUNT_RESUME writable too so that userland can
>    control timer using master DC and without bias register. New values
>    are rejected if they refer to a monotonic time in the future.
>  - Expand on description of KVM_REG_MIPS_COUNT_RESUME about the effects
>    of the register and that it can be written.
>
> v1 (tag:kvm_mips_timer_v1):
>  see http://marc.info/?l=kvm&m=139843936102657&w=2
>
> James Hogan (23):
>   MIPS: KVM: Allocate at least 16KB for exception handlers
>   MIPS: Export local_flush_icache_range for KVM
>   MIPS: KVM: Use local_flush_icache_range to fix RI on XBurst
>   MIPS: KVM: Use tlb_write_random
>   MIPS: KVM: Add CP0_EPC KVM register access
>   MIPS: KVM: Move KVM_{GET,SET}_ONE_REG definitions into kvm_host.h
>   MIPS: KVM: Add CP0_Count/Compare KVM register access
>   MIPS: KVM: Add CP0_UserLocal KVM register access
>   MIPS: KVM: Add CP0_HWREna KVM register access
>   MIPS: KVM: Deliver guest interrupts after local_irq_disable()
>   MIPS: KVM: Fix timer race modifying guest CP0_Cause
>   MIPS: KVM: Migrate hrtimer to follow VCPU
>   MIPS: KVM: Rewrite count/compare timer emulation
>   MIPS: KVM: Override guest kernel timer frequency directly
>   MIPS: KVM: Add master disable count interface
>   MIPS: KVM: Add count frequency KVM register
>   MIPS: KVM: Make kvm_mips_comparecount_{func,wakeup} static
>   MIPS: KVM: Whitespace fixes in kvm_mips_callbacks
>   MIPS: KVM: Fix kvm_debug bit-rottage
>   MIPS: KVM: Remove ifdef DEBUG around kvm_debug
>   MIPS: KVM: Quieten kvm_info() logging
>   MIPS: KVM: Remove redundant NULL checks before kfree()
>   MIPS: KVM: Remove redundant semicolon
>
>  arch/mips/Kconfig                 |  12 +-
>  arch/mips/include/asm/kvm_host.h  | 183 ++++++++++---
>  arch/mips/include/uapi/asm/kvm.h  |  35 +++
>  arch/mips/kvm/kvm_locore.S        |  32 ---
>  arch/mips/kvm/kvm_mips.c          | 140 +++++-----
>  arch/mips/kvm/kvm_mips_dyntrans.c |  15 +-
>  arch/mips/kvm/kvm_mips_emul.c     | 557 ++++++++++++++++++++++++++++++++++++--
>  arch/mips/kvm/kvm_tlb.c           |  77 +++---
>  arch/mips/kvm/kvm_trap_emul.c     |  86 +++++-
>  arch/mips/mm/cache.c              |   1 +
>  arch/mips/mti-malta/malta-time.c  |  14 +-
>  11 files changed, 920 insertions(+), 232 deletions(-)
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: kvm@vger.kernel.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: David Daney <david.daney@cavium.com>
> Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> Cc: Sanjay Lal <sanjayl@kymasys.com>
>

Applied, thanks.  I hope you'll get the QEMU patches ready in time for 
2.1! :)

Paolo
