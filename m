Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2014 14:02:30 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:10421 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822188AbaD1MC1EF98G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Apr 2014 14:02:27 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3SC24YX026449
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Apr 2014 08:02:04 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s3SC20FO029130;
        Mon, 28 Apr 2014 08:02:01 -0400
Message-ID: <535E4338.9010801@redhat.com>
Date:   Mon, 28 Apr 2014 14:02:00 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 00/21] MIPS: KVM: Fixes and guest timer rewrite
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39962
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

Il 25/04/2014 17:19, James Hogan ha scritto:
> Here are a range of MIPS KVM T&E fixes for v3.16. They can also be found
> on my kvm_mips_queue branch here:
> git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git
>
> They originally served to allow it to work better on Ingenic XBurst
> cores which have some peculiarities which break non-portable assumptions
> in the MIPS KVM implementation (patches 1-3, 11).
>
> Fixing guest CP0_Count emulation to work without a running host
> CP0_Count (patch 11) however required a rewrite of the timer emulation
> code to use the kernel monotonic time instead, which needed doing anyway
> since basing it directly off the host CP0_Count was broken. Various bugs
> were fixed in the process (patches 8-10) and improvements made thanks to
> valuable feedback from Paolo Bonzini for the last QEMU MIPS/KVM patchset
> (patches 4-7, 13-15).
>
> Finally there are some misc cleanups which I did along the way (patches
> 16-21).
>
> Only the first patch (fixes MIPS KVM with 4K pages) is marked for
> stable. For KVM to work on XBurst it needs the timer rework which is a
> fairly complex change, so there's little point marking any of the XBurst
> specific changes for stable.
>
> All feedback welcome!
>
> Patches 1-3:
> 	Fix KVM/MIPS with 4K pages, missing RDHWR SYNCI (XBurst),
> 	unmoving CP0_Random (XBurst).
> Patches 4-7:
> 	Add EPC, Count, Compare guest CP0 registers to KVM register
> 	ioctl interface.
> Patches 8-10:
> 	Fix a few potential races relating to timers.
> Patches 11-12:
> 	Rewrite guest timer emulation to use ktime_get().
> Patches 13-15:
> 	Add KVM virtual registers for controlling guest timer, including
> 	master timer disable, nanosecond bias, and timer frequency.
> Patches 16-21:
> 	Cleanups.
>
> James Hogan (21):
>   MIPS: KVM: Allocate at least 16KB for exception handlers
>   MIPS: KVM: Use local_flush_icache_range to fix RI on XBurst
>   MIPS: KVM: Use tlb_write_random
>   MIPS: KVM: Fix CP0_EBASE KVM register id
>   MIPS: KVM: Add CP0_EPC KVM register access
>   MIPS: KVM: Move KVM_{GET,SET}_ONE_REG definitions into kvm_host.h
>   MIPS: KVM: Add CP0_Count/Compare KVM register access
>   MIPS: KVM: Deliver guest interrupts after local_irq_disable()
>   MIPS: KVM: Fix timer race modifying guest CP0_Cause
>   MIPS: KVM: Migrate hrtimer to follow VCPU
>   MIPS: KVM: Rewrite count/compare timer emulation
>   MIPS: KVM: Override guest kernel timer frequency directly
>   MIPS: KVM: Add master disable count interface
>   MIPS: KVM: Add nanosecond count bias KVM register
>   MIPS: KVM: Add count frequency KVM register
>   MIPS: KVM: Make kvm_mips_comparecount_{func,wakeup} static
>   MIPS: KVM: Whitespace fixes in kvm_mips_callbacks
>   MIPS: KVM: Fix kvm_debug bit-rottage
>   MIPS: KVM: Remove ifdef DEBUG around kvm_debug
>   MIPS: KVM: Quieten kvm_info() logging
>   MIPS: KVM: Remove redundant NULL checks before kfree()
>
>  arch/mips/Kconfig                 |  12 +-
>  arch/mips/include/asm/kvm_host.h  | 185 +++++++++---
>  arch/mips/include/uapi/asm/kvm.h  |  40 +++
>  arch/mips/kvm/kvm_locore.S        |  32 --
>  arch/mips/kvm/kvm_mips.c          | 127 ++++----
>  arch/mips/kvm/kvm_mips_dyntrans.c |  15 +-
>  arch/mips/kvm/kvm_mips_emul.c     | 608 ++++++++++++++++++++++++++++++++++++--
>  arch/mips/kvm/kvm_tlb.c           |  60 ++--
>  arch/mips/kvm/kvm_trap_emul.c     |  89 +++++-
>  arch/mips/mti-malta/malta-time.c  |  14 +-
>  10 files changed, 951 insertions(+), 231 deletions(-)
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: kvm@vger.kernel.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: David Daney <david.daney@cavium.com>
> Cc: Sanjay Lal <sanjayl@kymasys.com>
>

There weren't too many comments on this series, and it would be really 
nice to have it in 3.16.

Thanks,

Paolo
