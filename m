Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:16:24 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:9597 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827335AbaAOKQVDS-6j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:16:21 +0100
Message-ID: <52D65FEE.2080303@imgtec.com>
Date:   Wed, 15 Jan 2014 10:16:14 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Gleb Natapov <gleb@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 1/2] MIPS: KVM: use common EHINV aware UNIQUE_ENTRYHI
References: <1389780682-32638-1-git-send-email-james.hogan@imgtec.com> <1389780682-32638-2-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1389780682-32638-2-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_16_14
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 01/15/2014 10:11 AM, James Hogan wrote:
> When KVM is enabled and TLB invalidation is supported,
> kvm_mips_flush_host_tlb() can cause a machine check exception due to
> multiple matching TLB entries. This can occur on shutdown even when KVM
> hasn't been actively used.
>
> Commit adb78de9eae8 (MIPS: mm: Move UNIQUE_ENTRYHI macro to a header
> file) created a common UNIQUE_ENTRYHI in asm/tlb.h but it didn't update
> the copy of UNIQUE_ENTRYHI in kvm_tlb.c to use it.
>
> Commit 36b175451399 (MIPS: tlb: Set the EHINV bit for TLBINVF cores when
> invalidating the TLB) later added TLB invalidation (EHINV) support to
> the common UNIQUE_ENTRYHI.
>
> Therefore make kvm_tlb.c use the EHINV aware UNIQUE_ENTRYHI
> implementation in asm/tlb.h too.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: Gleb Natapov <gleb@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: Sanjay Lal <sanjayl@kymasys.com>
> ---
> This is based on John Crispin's mips-next-3.14 branch.
>
> I do not object to it being squashed into commit adb78de9eae8 (MIPS: mm:
> Move UNIQUE_ENTRYHI macro to a header file) since that commit hasn't
> reached mainline yet.
> ---
>   arch/mips/kvm/kvm_tlb.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
> index c777dd36d4a8..52083ea7fddd 100644
> --- a/arch/mips/kvm/kvm_tlb.c
> +++ b/arch/mips/kvm/kvm_tlb.c
> @@ -25,6 +25,7 @@
>   #include <asm/mmu_context.h>
>   #include <asm/pgtable.h>
>   #include <asm/cacheflush.h>
> +#include <asm/tlb.h>
>
>   #undef CONFIG_MIPS_MT
>   #include <asm/r4kcache.h>
> @@ -35,9 +36,6 @@
>
>   #define PRIx64 "llx"
>
> -/* Use VZ EntryHi.EHINV to invalidate TLB entries */
> -#define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
> -
>   atomic_t kvm_mips_instance;
>   EXPORT_SYMBOL(kvm_mips_instance);
>
>

Thanks. That looks good to me.

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>

-- 
markos
