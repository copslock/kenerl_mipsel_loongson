Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2017 20:50:11 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38240 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993893AbdCUTuDvNhEa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Mar 2017 20:50:03 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2LJo25p009764;
        Tue, 21 Mar 2017 20:50:02 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2LJo2KB009763;
        Tue, 21 Mar 2017 20:50:02 +0100
Date:   Tue, 21 Mar 2017 20:50:02 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "# 3 . 10 . x-" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] KVM: MIPS/Emulate: Fix TLBWR with wired for T&E
Message-ID: <20170321195002.GA9697@linux-mips.org>
References: <cover.57583f73c169e83d499329fbda19909b816c0024.1489510483.git-series.james.hogan@imgtec.com>
 <8083c96f7d942288a45a5f23d7bfd39bfceb273e.1489510483.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8083c96f7d942288a45a5f23d7bfd39bfceb273e.1489510483.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57406
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

On Tue, Mar 14, 2017 at 05:00:07PM +0000, James Hogan wrote:

> The implementation of the TLBWR instruction for Trap & Emulate does not
> take the CP0_Wired register into account, allowing the guest's wired
> entries to be easily overwritten during normal guest TLB refill
> operation.
> 
> Offset the random TLB index by CP0_Wired and keep it in the range of
> valid non-wired entries with a modulo operation instead of a mask. This
> allows wired TLB entries to be properly preserved.
> 
> Fixes: e685c689f3a8 ("KVM/MIPS32: Privileged instruction/target ...")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> Cc: <stable@vger.kernel.org> # 3.10.x-
> ---
>  arch/mips/kvm/emulate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> index 4833ebad89d9..dd47f2bda01b 100644
> --- a/arch/mips/kvm/emulate.c
> +++ b/arch/mips/kvm/emulate.c
> @@ -1094,10 +1094,12 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
>  	struct mips_coproc *cop0 = vcpu->arch.cop0;
>  	struct kvm_mips_tlb *tlb = NULL;
>  	unsigned long pc = vcpu->arch.pc;
> +	unsigned int wired;
>  	int index;
>  
>  	get_random_bytes(&index, sizeof(index));
> -	index &= (KVM_MIPS_GUEST_TLB_SIZE - 1);
> +	wired = kvm_read_c0_guest_wired(cop0) & (KVM_MIPS_GUEST_TLB_SIZE - 1);
> +	index = wired + index % (KVM_MIPS_GUEST_TLB_SIZE - wired);

FWIW, the "random" register is just a counter on all MIPS CPUs which will
wrap around to the value of the wired register rsp. 8 on some R3000-class
CPUs once it reaches the number of TLB entries, so get_random_bytes isn't
strictly correct.  I however can't see any problem with this implementatio
other than get_random_bytes might be a a bit heavier than necessary.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
