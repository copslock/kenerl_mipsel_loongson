Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 12:12:50 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:56450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991867AbdDTKMnAzEOD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Apr 2017 12:12:43 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 482BD80D;
        Thu, 20 Apr 2017 03:12:36 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 854EF3F41F;
        Thu, 20 Apr 2017 03:12:34 -0700 (PDT)
Subject: Re: next/master build: 206 builds: 2 failed, 204 passed, 9 errors, 10
 warnings (next-20170420)
To:     Arnd Bergmann <arnd@arndb.de>,
        "kernelci.org bot" <bot@kernelci.org>
References: <58f869bd.84a0df0a.dc1f9.4547@mx.google.com>
 <CAK8P3a2uZFGXhNq+nwDQmgzNL5WH0VejQmotUZp3=0fKwsU1=w@mail.gmail.com>
Cc:     kernel-build-reports@lists.linaro.org,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <4708d991-c04c-a049-6c84-c6d8c4688412@arm.com>
Date:   Thu, 20 Apr 2017 11:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2uZFGXhNq+nwDQmgzNL5WH0VejQmotUZp3=0fKwsU1=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On 20/04/17 10:23, Arnd Bergmann wrote:
> On Thu, Apr 20, 2017 at 9:56 AM, kernelci.org bot <bot@kernelci.org> wrote:

[...]

>> multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y+CONFIG_ARM_MODULE_PLTS=y (arm) —
>> FAIL, 1 error, 0 warnings, 0 section mismatches
>>
>> Errors:
>> arch/arm/kernel/hyp-stub.S:128: Error: invalid immediate for address
>> calculation (value = 0x00000004)
> 
> I have not seen this one so far, need to investigate more. A quick look points
> to this line
> 
>         adr     r7, __hyp_stub_vectors
> 
> and the symbol it refers to was recently changed in
> 
> commit bc845e4fbbbbe97bab3f1bcf688be0b5da420717
> Author: Marc Zyngier <marc.zyngier@arm.com>
> Date:   Mon Apr 3 19:37:53 2017 +0100
> 
>     ARM: KVM: Implement HVC_RESET_VECTORS stub hypercall in the init code
> 
>     In order to restore HYP mode to its original condition, KVM currently
>     implements __kvm_hyp_reset(). As we're moving towards a hyp-stub
>     defined API, it becomes necessary to implement HVC_RESET_VECTORS.
> 
>     This patch adds the HVC_RESET_VECTORS hypercall to the KVM init
>     code, which so far lacked any form of hypercall support.
> 
>     Tested-by: Keerthy <j-keerthy@ti.com>
>     Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
>     Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>     Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>     Signed-off-by: Christoffer Dall <cdall@linaro.org>
> 
> diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
> index e637854335aa..675c50f5cb5c 100644
> --- a/arch/arm/kernel/hyp-stub.S
> +++ b/arch/arm/kernel/hyp-stub.S
> @@ -280,7 +280,7 @@ ENDPROC(__hyp_reset_vectors)
>  #endif
> 
>  .align 5
> -__hyp_stub_vectors:
> +ENTRY(__hyp_stub_vectors)
>  __hyp_stub_reset:      W(b)    .
>  __hyp_stub_und:                W(b)    .
>  __hyp_stub_svc:                W(b)    .
> 
> but I don't see why that would cause the build error.

Ah, my bad. With Thumb-2, ADR defaults to being the short (16 bit) form,
which cannot encode the displacement (and __hyp_stub_vectors now being
exported, it probably lives further away than it used to). We need the
32 bit version.

The fix is to write the faulting line as:

	W(adr)	r7, __hyp_stub_vectors

I'll post a proper patch in a minute.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
