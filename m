Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 14:18:50 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:65522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6854767AbaFYMSpiTW-f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jun 2014 14:18:45 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5PCIWBc010285
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jun 2014 08:18:32 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5PCIRBD021091;
        Wed, 25 Jun 2014 08:18:28 -0400
Message-ID: <53AABE12.5080001@redhat.com>
Date:   Wed, 25 Jun 2014 14:18:26 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
CC:     gleb@kernel.org, kvm@vger.kernel.org, sanjayl@kymasys.com,
        james.hogan@imgtec.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 0/9] MIPS: KVM: Bugfixes and cleanups
References: <1403631071-6012-1-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1403631071-6012-1-git-send-email-dengcheng.zhu@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40804
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

Il 24/06/2014 19:31, Deng-Cheng Zhu ha scritto:
> The patches are pretty straightforward.
>
> Changes:
> v3 - v2:
> o In patch #2, change the use of kvm_[err|info|debug].
> o In patch #3, add err removal in kvm_arch_commit_memory_region().
> o In patch #3, revert the changes to kvm_arch_vm_ioctl().
> o In patch #7, drop the merge of kvm_arch_vcpu_free() and pointer nullification.
> o Add patch #9.
> v2 - v1:
> o In patch #1, don't change the opening comment mark for kernel-doc comments.
> o In patch #1, to make long lines more readable, use local variables / macros.
> o In patch #1, slight format adjustments are made.
> o Use -M flag to generate patches (detect renames).
> o Add patch #8.
>
> Deng-Cheng Zhu (8):
>   MIPS: KVM: Reformat code and comments
>   MIPS: KVM: Use KVM internal logger
>   MIPS: KVM: Simplify functions by removing redundancy
>   MIPS: KVM: Remove unneeded volatile
>   MIPS: KVM: Rename files to remove the prefix "kvm_" and "kvm_mips_"
>   MIPS: KVM: Restore correct value for WIRED at TLB uninit
>   MIPS: KVM: Fix memory leak on VCPU
>   MIPS: KVM: Skip memory cleaning in kvm_mips_commpage_init()
>
> James Hogan (1):
>   MIPS: KVM: Remove dead code of TLB index error in
>     kvm_mips_emul_tlbwr()
>
>  arch/mips/include/asm/kvm_host.h                  |  12 +-
>  arch/mips/include/asm/r4kcache.h                  |   3 +
>  arch/mips/kvm/Makefile                            |   8 +-
>  arch/mips/kvm/{kvm_cb.c => callback.c}            |   0
>  arch/mips/kvm/commpage.c                          |  33 ++
>  arch/mips/kvm/commpage.h                          |  24 +
>  arch/mips/kvm/{kvm_mips_dyntrans.c => dyntrans.c} |  40 +-
>  arch/mips/kvm/{kvm_mips_emul.c => emulate.c}      | 539 +++++++++++-----------
>  arch/mips/kvm/{kvm_mips_int.c => interrupt.c}     |  47 +-
>  arch/mips/kvm/{kvm_mips_int.h => interrupt.h}     |  22 +-
>  arch/mips/kvm/kvm_mips_comm.h                     |  23 -
>  arch/mips/kvm/kvm_mips_commpage.c                 |  37 --
>  arch/mips/kvm/kvm_mips_opcode.h                   |  24 -
>  arch/mips/kvm/{kvm_locore.S => locore.S}          |  55 ++-
>  arch/mips/kvm/{kvm_mips.c => mips.c}              | 227 +++++----
>  arch/mips/kvm/opcode.h                            |  22 +
>  arch/mips/kvm/{kvm_mips_stats.c => stats.c}       |  28 +-
>  arch/mips/kvm/{kvm_tlb.c => tlb.c}                | 258 +++++------
>  arch/mips/kvm/trace.h                             |  18 +-
>  arch/mips/kvm/{kvm_trap_emul.c => trap_emul.c}    | 109 +++--
>  20 files changed, 750 insertions(+), 779 deletions(-)
>  rename arch/mips/kvm/{kvm_cb.c => callback.c} (100%)
>  create mode 100644 arch/mips/kvm/commpage.c
>  create mode 100644 arch/mips/kvm/commpage.h
>  rename arch/mips/kvm/{kvm_mips_dyntrans.c => dyntrans.c} (79%)
>  rename arch/mips/kvm/{kvm_mips_emul.c => emulate.c} (83%)
>  rename arch/mips/kvm/{kvm_mips_int.c => interrupt.c} (85%)
>  rename arch/mips/kvm/{kvm_mips_int.h => interrupt.h} (74%)
>  delete mode 100644 arch/mips/kvm/kvm_mips_comm.h
>  delete mode 100644 arch/mips/kvm/kvm_mips_commpage.c
>  delete mode 100644 arch/mips/kvm/kvm_mips_opcode.h
>  rename arch/mips/kvm/{kvm_locore.S => locore.S} (93%)
>  rename arch/mips/kvm/{kvm_mips.c => mips.c} (83%)
>  create mode 100644 arch/mips/kvm/opcode.h
>  rename arch/mips/kvm/{kvm_mips_stats.c => stats.c} (63%)
>  rename arch/mips/kvm/{kvm_tlb.c => tlb.c} (78%)
>  rename arch/mips/kvm/{kvm_trap_emul.c => trap_emul.c} (83%)
>

I'll wait for v4 of these patches since James still had a few comments.

Paolo
