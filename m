Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 16:23:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44308 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860046AbaF0OXBD6pDT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2014 16:23:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 643FCEC1D3839;
        Fri, 27 Jun 2014 15:22:50 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.10.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 27 Jun
 2014 15:22:53 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.10.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 27 Jun 2014 15:22:52 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 27 Jun
 2014 15:22:52 +0100
Message-ID: <53AD7E3C.3040901@imgtec.com>
Date:   Fri, 27 Jun 2014 15:22:52 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>, <pbonzini@redhat.com>
CC:     <gleb@kernel.org>, <kvm@vger.kernel.org>, <sanjayl@kymasys.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v4 0/7] MIPS: KVM: Bugfixes and cleanups
References: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 26/06/14 20:11, Deng-Cheng Zhu wrote:
> The patches are pretty straightforward.
> 
> Changes:
> v4 - v3:
> o In patch #1, align elements in debugfs_entries[].
> o In patch #1, indentation and comment style changes.
> o In patch #2, use kvm_debug instead of kvm_err in kvm_mips_check_privilege().
> o Drop off the original patch #6 (MIPS: KVM: Restore correct value for WIRED at
>   TLB uninit).
> o Drop off the original patch #7 (MIPS: KVM: Fix memory leak on VCPU), because
>   it has been queued.
> o Change authorship of the original patch #9 (MIPS: KVM: Remove dead code of TLB
>   index error in kvm_mips_emul_tlbwr()), add Reported-by.

Thanks. The remaining changes look good to me.

Patches 1, 2, and 7:
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

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
> Deng-Cheng Zhu (7):
>   MIPS: KVM: Reformat code and comments
>   MIPS: KVM: Use KVM internal logger
>   MIPS: KVM: Simplify functions by removing redundancy
>   MIPS: KVM: Remove unneeded volatile
>   MIPS: KVM: Rename files to remove the prefix "kvm_" and "kvm_mips_"
>   MIPS: KVM: Skip memory cleaning in kvm_mips_commpage_init()
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
>  arch/mips/kvm/{kvm_mips.c => mips.c}              | 224 +++++----
>  arch/mips/kvm/opcode.h                            |  22 +
>  arch/mips/kvm/{kvm_mips_stats.c => stats.c}       |  28 +-
>  arch/mips/kvm/{kvm_tlb.c => tlb.c}                | 258 +++++------
>  arch/mips/kvm/trace.h                             |  18 +-
>  arch/mips/kvm/{kvm_trap_emul.c => trap_emul.c}    | 112 +++--
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
>  rename arch/mips/kvm/{kvm_mips.c => mips.c} (84%)
>  create mode 100644 arch/mips/kvm/opcode.h
>  rename arch/mips/kvm/{kvm_mips_stats.c => stats.c} (63%)
>  rename arch/mips/kvm/{kvm_tlb.c => tlb.c} (78%)
>  rename arch/mips/kvm/{kvm_trap_emul.c => trap_emul.c} (83%)
> 
